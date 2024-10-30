#include <stdio.h>

/* TBC v1.0
 *   Compiles a Befunge-93 program into an pseudocode ANSI C program.
 *   Copyright (c) 1998 Timothy Howe
 *   Copy and modify it all you want, just keep my name on it.
 *   Portions of this program come from Chris Pressey's Befunge-93
 *     interpreter.
 *
 *   Email me at <timhowe@bigfoot.com>.
 */

/* Screen width and height */
#define SCR_WIDTH 80
#define SCR_HEIGHT 25
#define ON_A_LINE 15

/* Will contain the program */
int pg[SCR_WIDTH * SCR_HEIGHT];

int main(int argc, char **argv) {
  FILE *infile, *corefile;
  int ic;
  int i, x, y;
  int skipmode;				/* If !0, then past end of line.
					   Skip until NL.                  */
  int curr;				/* Current place on output program
					   line.			   */
  
  if (argc < 2) {
    fprintf(stderr, "TBC v1.0\n");
    fprintf(stderr, "Usage: %s infile.bf [> outfile.c]\n", argv[0]);
    exit(1);
  }

  if (!(infile = fopen(argv[1], "r"))) {
    fprintf(stderr, "%s: can't open input file %s\n", argv[0], argv[1]);
    exit(2);
  }

  for (i = 0; i < SCR_WIDTH * SCR_HEIGHT; i++) {
    pg[i] = ' ';
  }

  x = 0; y = 0; skipmode = 0;

  while (1) {
    ic = fgetc(infile);
    if (ic == EOF)
      break;
    else if (y >= SCR_HEIGHT) {
      fprintf(stderr, "%s: too many lines in program; truncated.\n", argv[0]);
      break;
    }
    switch (ic) {
      case '\n': y++;
		 x = 0;
		 skipmode = 0;
		 break;

      case '=':  if (x == 0) {		/* Ugly hack to remove directives  */
		   y--;			/* Ugly hack to stay on right line */
		   skipmode = 1;
		 }

      default:   if (x >= SCR_WIDTH && !skipmode) {
		   fprintf(stderr,
		       "%s: warning: line %d too long; truncated.\n", argv[0],
		       y+1);
                   skipmode = 1;
		 } else if (!skipmode)
		   pg[(y * SCR_WIDTH) + x++] = (char) ic;
		 break;
    }
  }

  fclose(infile);
  
  printf("#include <stdio.h>\n\n");
  printf("/* Befunge program, pseudo-compiled with TBC");
  printf(" */\n\n");
  
  printf("int pg[%d * %d] = {\n  ", SCR_WIDTH, SCR_HEIGHT);
  
  curr = 0;
  for (i = 0; i < SCR_WIDTH * SCR_HEIGHT; i++) {
    if (i < (SCR_WIDTH * SCR_HEIGHT) - 1)
      printf("%d, ", pg[i]);
    else
      printf("%d", pg[i]);
    if (++curr >= ON_A_LINE) {
      curr = 0;
      printf("\n  ");
    }
  }

  printf("\n};\n\n");
  
  printf("#define LINEWIDTH %d\n", SCR_WIDTH);
  printf("#define PAGEHEIGHT %d\n", SCR_HEIGHT);
  printf("#define cur pg[(y * %d) + x]\n", SCR_WIDTH);

  /* Insert Befunge interpreter core */
  if (!(corefile = fopen("core.int", "r"))) {
    fprintf(stderr,
	"%s: couldn't open core file %s\n", argv[0], "core.int");
    exit(3);
  }
  while((ic = fgetc(corefile)) != EOF)
    if (ic != '\r')
      putchar(ic);
  fclose(corefile);
}

