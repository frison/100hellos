#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <ctype.h>

#ifdef __GNUC__
__attribute__((noreturn))
#elif defined(_MSC_VER)
__declspec(noreturn)
#endif
void panic(char *fmt, ...) {
	va_list args;
	va_start(args, fmt);
	vfprintf(stderr, fmt, args);
	va_end(args);
	exit(EXIT_FAILURE);
}

typedef struct expr expr;
typedef struct fun fun;
typedef struct cont cont;
typedef struct anything anything;

static int current_character = EOF;

/* A "function": i or .x or `sk or something like that. */
struct fun {
	int refcount;
	enum { KAY, KAY1, ESS, ESS1, ESS2, EYE, VEE, DEE, DEE1, DOT, SEE, CONT, EE, AT, QUESTION, PIPE } type;
	union {
		fun *onefunc; /* for KAY1 and ESS1: `k(onefunc) or `s(onefunc) */
		struct { fun *f1, *f2; } twofunc; /* for ESS2: ``s(f1)(f2) */
		expr *expr; /* for DEE1: `d(expr) */
		char ch; /* for DOT and QUESTION: .(ch) or ?(ch) */
		cont *cont;
	} v;
};

/* An "expression": either a function or an application of one function to another. */
struct expr {
	int refcount;
	enum { FUNCTION, APPLICATION } type;
	union {
		fun *func;
		struct { expr *func, *arg; } ap;
	} v;
};

/* A "continuation": what to do next. You'll toss it a fun*.
   EVAL_APPLY: get "func", eval "e", apply "func" to "e", next()
   APPLY: get "arg", apply "f" to "arg", next()
   APPLY_DEE: get "func", apply "func" to "f", next()
   TERM: terminate execution */
struct cont {
	int refcount;
	enum { EVAL_APPLY, APPLY, APPLY_DEE, TERM } type;
	union {
		expr *e;
		fun *f;
	} v;
	cont *next;
};

/* Anything: used for memory allocation. */
struct anything {
	union {
		anything *next;
		fun dummy_f;
		expr dummy_expr;
		cont dummy_cont;
	};
};

static anything *mempool = NULL;
static size_t size_to_malloc = 1024;
void *get_something() {
	anything *ret = mempool;
	if (mempool == NULL) {
		size_t i;
		ret = mempool = malloc(size_to_malloc * sizeof(*mempool));
		if (mempool == NULL) panic("Out of memory\n");
		for (i = 0; i < size_to_malloc - 1; ++i) {
			mempool[i].next = &mempool[i + 1];
		}
		mempool[size_to_malloc - 1].next = NULL;
		size_to_malloc += size_to_malloc / 2 + 64;
		/* If you carefully study this program, you'll see that we never free anything. Yep, we'll leak this and
		   that's okay - we probably wouldn't free it until the very end of the program anyway.
		   If we allocate a bunch of objects and then free them and then keep running for a long time we'll waste
		   memory, but that isn't a popular usage pattern for Unlambda programs. */
	}
	mempool = mempool->next;
	return ret;
}
void free_something(void *thing) {
	((anything*)thing)->next = mempool;
	mempool = thing;
}


void fun_decref(fun *f);
void expr_decref(expr *e);
void cont_decref(cont *c);

#define IS_STATIC_FUN_TYPE(type) ((type) == KAY || (type) == ESS || (type) == EYE || (type) == VEE || (type) == DEE || (type) == SEE || (type) == EE || (type) == AT || (type) == PIPE)
fun *make_fun() {
	fun *ret = get_something();
	ret->refcount = 1;
	return ret;
}
fun *fun_addref(fun *f) {
	if (!IS_STATIC_FUN_TYPE(f->type))
		f->refcount++;
	return f;
}
void fun_decref(fun *f) {
	/* These are static and shared. Ignore them. */
	if (IS_STATIC_FUN_TYPE(f->type)) return;
	f->refcount--;
	if (f->refcount == 0) {
		switch (f->type) {
		case KAY1:
		case ESS1:
			fun_decref(f->v.onefunc);
			break;
		case ESS2:
			fun_decref(f->v.twofunc.f1);
			fun_decref(f->v.twofunc.f2);
			break;
		case DEE1:
			expr_decref(f->v.expr);
			break;
		case DOT:
		case QUESTION:
			break;
		case CONT:
			cont_decref(f->v.cont);
			break;
		default:
			fprintf(stderr, "Memory corruption at %d\n", __LINE__);
			return;
		}
		free_something(f);
	}
}

expr *make_expr() {
	expr *ret = get_something();
	ret->refcount = 1;
	return ret;
}
expr *expr_addref(expr *e) {
	e->refcount++;
	return e;
}
void expr_decref(expr *e) {
	e->refcount--;
	if (e->refcount == 0) {
		switch (e->type) {
		case FUNCTION:
			fun_decref(e->v.func);
			break;
		case APPLICATION:
			expr_decref(e->v.ap.func);
			expr_decref(e->v.ap.arg);
			break;
		default:
			fprintf(stderr, "Memory corruption at %d\n", __LINE__);
			return;
		}
		free_something(e);
	}
}

#define IS_STATIC_CONT_TYPE(type) ((type) == TERM)
cont *make_cont(cont *next) {
	cont *ret = get_something();
	ret->refcount = 1;
	ret->next = next;
	return ret;
}
cont *cont_addref(cont *c) {
	if (!IS_STATIC_CONT_TYPE(c->type)) {
		c->refcount++;
	}
	return c;
}
void cont_decref(cont *c) {
	if (IS_STATIC_CONT_TYPE(c->type)) return;
	c->refcount--;
	if (c->refcount == 0) {
		switch (c->type) {
		case EVAL_APPLY:
			expr_decref(c->v.e);
			break;
		case APPLY:
		case APPLY_DEE:
			fun_decref(c->v.f);
			break;
		default:
			fprintf(stderr, "Memory corruption at %d\n", __LINE__);
			return;
		}
		cont_decref(c->next);
		free_something(c);
	}
}


fun s_fun    = { 1, ESS  };
fun k_fun    = { 1, KAY  };
fun i_fun    = { 1, EYE  };
fun v_fun    = { 1, VEE  };
fun d_fun    = { 1, DEE  };
fun c_fun    = { 1, SEE  };
fun e_fun    = { 1, EE   };
fun at_fun   = { 1, AT   };
fun pipe_fun = { 1, PIPE };

cont term_c = { 1, TERM };

expr* parse() {
	int ch;
	expr *ret = make_expr();
	for (;;) {
		ch = getchar();
		if (ch == EOF) panic("Error: unexpected EOF.\n");
		if (isspace(ch)) continue;
		if (ch == '#') {
			while ((ch = getchar()) != EOF && ch != '\n');
			continue;
		}
		break;
	}
	switch (ch) {
	case '`':
		ret->type = APPLICATION;
		ret->v.ap.func = parse();
		ret->v.ap.arg = parse();
		return ret;
	case 's':
	case 'S':
		ret->type = FUNCTION;
		ret->v.func = &s_fun;
		return ret;
	case 'k':
	case 'K':
		ret->type = FUNCTION;
		ret->v.func = &k_fun;
		return ret;
	case 'i':
	case 'I':
		ret->type = FUNCTION;
		ret->v.func = &i_fun;
		return ret;
	case 'v':
	case 'V':
		ret->type = FUNCTION;
		ret->v.func = &v_fun;
		return ret;
	case '.':
		ch = getchar();
		if (ch == EOF) panic("Expected character for '.'\n");
		ret->type = FUNCTION;
		ret->v.func = make_fun();
		ret->v.func->type = DOT;
		ret->v.func->v.ch = ch;
		return ret;
	case 'r':
	case 'R':
		ret->type = FUNCTION;
		ret->v.func = make_fun();
		ret->v.func->type = DOT;
		ret->v.func->v.ch = '\n';
		return ret;
	case 'd':
	case 'D':
		ret->type = FUNCTION;
		ret->v.func = &d_fun;
		return ret;
	case 'c':
	case 'C':
		ret->type = FUNCTION;
		ret->v.func = &c_fun;
		return ret;
	case 'e':
	case 'E':
		ret->type = FUNCTION;
		ret->v.func = &e_fun;
		return ret;
	case '@':
		ret->type = FUNCTION;
		ret->v.func = &at_fun;
		return ret;
	case '?':
		ch = getchar();
		if (ch == EOF) panic("Expected character for '?'\n");
		ret->type = FUNCTION;
		ret->v.func = make_fun();
		ret->v.func->type = QUESTION;
		ret->v.func->v.ch = ch;
		return ret;
	case '|':
		ret->type = FUNCTION;
		ret->v.func = &pipe_fun;
		return ret;
	default:
		panic("Parse error: unexpected %c (0x%02x).\n", ch, ch);
	}
}

void print_fun(fun *func);
void print_expr(expr *prog);

void print_fun(fun *func) {
	switch (func->type) {
	case KAY:
		putchar('k');
		break;
	case KAY1:
		printf("`k");
		print_fun(func->v.onefunc);
		break;
	case ESS:
		putchar('s');
		break;
	case ESS1:
		printf("`s");
		print_fun(func->v.onefunc);
		break;
	case ESS2:
		printf("``s");
		print_fun(func->v.twofunc.f1);
		print_fun(func->v.twofunc.f2);
		break;
	case EYE:
		putchar('i');
		break;
	case VEE:
		putchar('v');
		break;
	case DEE:
		putchar('d');
		break;
	case DEE1:
		printf("`d");
		print_expr(func->v.expr);
		break;
	case DOT:
		if (func->v.ch == '\n') {
			putchar('r');
		} else {
			printf(".%c", func->v.ch);
		}
		break;
	case SEE:
		putchar('c');
		break;
	case CONT:
		printf("<cont>");
		break;
	case EE:
		putchar('e');
		break;
	case AT:
		putchar('@');
		break;
	case QUESTION:
		printf("?%c", func->v.ch);
		break;
	case PIPE:
		putchar('|');
		break;
	default:
		printf("(corrupted memory)");
		break;
	}
}

void print_expr(expr *prog) {
	switch (prog->type) {
	case FUNCTION:
		print_fun(prog->v.func);
		break;
	case APPLICATION:
		putchar('`');
		print_expr(prog->v.ap.func);
		print_expr(prog->v.ap.arg);
		break;
	default:
		printf("(corrupted memory)");
		break;
	}
}


/* An "action": which function to call next.
   This is used entirely to remove stack overflows. */
struct action {
	enum { ACT_TOSS, ACT_APPLY, ACT_EVAL, ACT_END } type;
	cont *c;
	union {
		fun *to;
		struct { fun *f1, *f2; } ap;
		expr *ev;
	} v;
} current_action;

/* These are super gross macros, but they are only supposed to be used in tail-call position.
   Unfortunately I can't do return void_returning_fn(); or I would do that. */
#define return_toss(ctn, arg)         \
	current_action.type = ACT_TOSS;   \
	current_action.c = (ctn);         \
	current_action.v.to = (arg);      \
	return
#define return_apply(func, arg, ctn)  \
	current_action.type = ACT_APPLY;  \
	current_action.c = (ctn);         \
	current_action.v.ap.f1 = (func);  \
	current_action.v.ap.f2 = (arg);   \
	return
#define return_eval(e, ctn)           \
	current_action.type = ACT_EVAL;   \
	current_action.c = (ctn);         \
	current_action.v.ev = (e);        \
	return
#define return_end(result)            \
	current_action.type = ACT_END;    \
	current_action.v.to = (result);   \
	return


/* Toss val to the continuation c */
void toss(cont *c, fun *val) {
	switch (c->type) {
	case EVAL_APPLY:
		if (val->type == DEE) {
			cont *next = cont_addref(c->next);
			fun *f = make_fun();
			f->type = DEE1;
			f->v.expr = expr_addref(c->v.e);
			cont_decref(c);
			/* no fun_decref(arg) because it's builtin */
			return_toss(next, f);
		} else {
			cont *next = make_cont(cont_addref(c->next));
			expr *e = expr_addref(c->v.e);
			next->type = APPLY;
			next->v.f = val; /* no addref because we're about to decref it anyway */
			cont_decref(c);
			return_eval(e, next);
		}
	case APPLY:
	{
		cont *next = cont_addref(c->next);
		fun *func = fun_addref(c->v.f);
		cont_decref(c);
		return_apply(func, val, next);
	}
	case APPLY_DEE:
	{
		cont *next = cont_addref(c->next);
		fun *arg = fun_addref(c->v.f);
		cont_decref(c);
		return_apply(val, arg, next);
	}
	case TERM:
		return_end(val);
	default:
		panic("Memory corruption decoding continuation type = %d\n", c->type);
	}
}

/* apply "func" to "arg", tossing the result to "c" */
void apply(fun *func, fun *arg, cont *c) {
	switch (func->type) {
	case KAY:
	{
		fun *val = make_fun();
		val->type = KAY1;
		val->v.onefunc = arg;
		/* No fun_decref(func) because it's builtin, no fun_decref(arg) because we gave it to val */
		return_toss(c, val);
	}
	case KAY1:
	{
		fun *val = fun_addref(func->v.onefunc);
		fun_decref(func);
		fun_decref(arg);
		return_toss(c, val);
	}
	case ESS:
	{
		fun *val = make_fun();
		val->type = ESS1;
		val->v.onefunc = arg;
		/* No fun_decref(func) because it's builtin, no fun_decref(arg) because we gave it to val */
		return_toss(c, val);
	}
	case ESS1:
	{
		fun *val = make_fun();
		val->type = ESS2;
		val->v.twofunc.f1 = fun_addref(func->v.onefunc);
		val->v.twofunc.f2 = arg;
		fun_decref(func);
		/* No fun_decref(arg) because we gave it to val */
		return_toss(c, val);
	}
	case ESS2:
	{
		/* Because of the possibility of seeing d somewhere, we'll carefully
		   construct expressions to evaluate. */
		expr *ex = make_expr();
		expr *ey = make_expr();
		expr *ez = make_expr();
		expr *es1 = make_expr();
		expr *es2 = make_expr();
		expr *e = make_expr();

		ex->type = FUNCTION;
		ex->v.func = fun_addref(func->v.twofunc.f1);
		ey->type = FUNCTION;
		ey->v.func = fun_addref(func->v.twofunc.f2);
		ez->type = FUNCTION;
		ez->v.func = arg; /* No fun_addref because we're giving it away */

		es1->type = APPLICATION;
		es1->v.ap.func = ex;
		es1->v.ap.arg = expr_addref(ez); /* This one is an extra reference */
		es2->type = APPLICATION;
		es2->v.ap.func = ey;
		es2->v.ap.arg = ez; /* This one we're giving away */

		e->type = APPLICATION;
		e->v.ap.func = es1;
		e->v.ap.arg = es2;

		fun_decref(func);
		/* No fun_decref(arg) because we gave it away */
		return_eval(e, c);
	}
	case DOT:
		putchar(func->v.ch);
		fun_decref(func);
		return_toss(c, arg);
	case DEE:
	{
		expr *e = make_expr();
		fun *val = make_fun();
		e->type = FUNCTION;
		e->v.func = arg;
		val->type = DEE1;
		val->v.expr = e;
		/* No fun_decref(func) because it's builtin, no fun_decref(arg) because we gave it to e */
		return_toss(c, val);
	}
	case EYE:
		return_toss(c, arg);
	case VEE:
		fun_decref(arg);
		return_toss(c, func);
	case DEE1:
	{
		cont *next = make_cont(c);
		expr *e = expr_addref(func->v.expr);
		next->type = APPLY_DEE;
		next->v.f = arg;
		fun_decref(func);
		/* No fun_decref(arg) nor cont_decref(c) because we gave them to next */
		return_eval(e, next);
	}
	case SEE:
	{
		fun *f = make_fun();
		f->type = CONT;
		f->v.cont = cont_addref(c);
		/* No fun_decref(func) because it's builtin, no fun_decref(arg) because we're giving it to apply */
		return_apply(arg, f, c);
	}
	case CONT:
	{
		cont *next = cont_addref(func->v.cont);
		fun_decref(func);
		cont_decref(c);
		return_toss(next, arg);
	}
	case EE:
		cont_decref(c);
		return_end(arg);
	case AT:
		current_character = getchar();
		if (current_character == EOF) {
			return_apply(arg, &v_fun, c);
		} else {
			return_apply(arg, &i_fun, c);
		}
	case QUESTION:
	{
		int ok = func->v.ch == current_character;
		fun_decref(func);
		if (ok) {
			return_apply(arg, &i_fun, c);
		} else {
			return_apply(arg, &v_fun, c);
		}
	}
	case PIPE:
		if (current_character == EOF) {
			return_apply(arg, &v_fun, c);
		} else {
			fun *dot = make_fun();
			dot->type = DOT;
			dot->v.ch = current_character;
			return_apply(arg, dot, c);
		}
	default:
		panic("Memory corruption decoding function type = %d\n", func->type);
	}
}

/* evaluate "e", tossing the result to "c" */
void eval(expr *e, cont *c) {
	if (e->type == FUNCTION) {
		fun *f = fun_addref(e->v.func);
		expr_decref(e);
		return_toss(c, f);
	} else { /* e->type == APPLICATION */
		cont *next = make_cont(c);
		next->type = EVAL_APPLY;
		next->v.e = expr_addref(e->v.ap.arg);
		expr *func = expr_addref(e->v.ap.func);
		expr_decref(e);
		return_eval(func, next);
	}
}

int main() {
	expr *prog = parse();

	current_action.type = ACT_EVAL;
	current_action.c = &term_c;
	current_action.v.ev = prog;

	while (current_action.type != ACT_END) {
		switch (current_action.type) {
		case ACT_TOSS:
			toss(current_action.c, current_action.v.to);
			break;
		case ACT_APPLY:
			apply(current_action.v.ap.f1, current_action.v.ap.f2, current_action.c);
			break;
		case ACT_EVAL:
			eval(current_action.v.ev, current_action.c);
			break;
		default:
			panic("Memory corruption decoding action type = %d\n", current_action.type);
		}
	}

	printf("\nResult: ");
	print_fun(current_action.v.to);
	putchar('\n');

	return 0;
}
