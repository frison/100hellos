# Raku

Raku is a language that evolved out of Larry Wall and co's goal of developing a next generation language to succeed Perl 5.  Originally dubbed Perl 6, the changes from Perl 5 became so significant that the decision was made to rename the language to avoid confusing potential users.  As [noted in Wikipedia](https://en.wikipedia.org/wiki/Raku_(programming_language)):

> An implication of these goals was that Perl 6 would not have backward compatibility with the existing Perl codebase. This meant that some code which was correctly interpreted by a Perl 5 compiler would not be accepted by a Perl 6 compiler. Since backward compatibility is a common goal when enhancing software, the breaking changes in Perl 6 had to be stated explicitly. The distinction between Perl 5 and Perl 6 became so large that eventually Perl 6 was renamed Raku.

Raku's lineage as a Perl successor is made obvious by its use of distinctive language features like sigils, the use of "my" and "sub" for defining local variables and functions, and so forth.  However, the language diverges significantly, including introducing a type system, formal parameter passing lists for functions (in Perl parameters can be passed implicitly through the @_ variable), and an advanced class system supporting multiple dispatch and other features.

Raku also builds on Perl 5's inclusion of regular expressions in the core language by introducing a built-in, full-blown lexing and parsing system referred to as [rules](https://en.wikipedia.org/wiki/Raku_rules), making Raku, like Perl 5 before it, uniquely well suited to text processing.

The included example program demonstrates the definition of a basic class with instance variables, as well as class instantiation, method invocation, parameter passing, and string interpolation.
