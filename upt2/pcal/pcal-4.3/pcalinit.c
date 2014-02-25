/*
 * Create a .h file from a .ps file.  Strips out leading and trailing 
 * whitespace, blank lines, and lines consisting solely of comments,
 * except for the very first block of comments/blanklines, which are
 * turned into C comments at the top of the file.
 * 
 *   14-sep-90  Jamie Zawinski  created.
 *
 * Revision history:
 *
 *	4.3	AWR	10/15/91	minor tweak to avoid redefinition
 *					of PROTOS
 *
 *	4.0	AWR	02/25/91	added optional third argument for
 *					name of array
 *
 *		AWR	02/19/91	added function prototypes; documented
 *
 *		AWR	01/16/91	Escape " and \ in quoted strings;
 *					strip trailing comments; skip FF
 *
 *	2.6	JAB	10/18/90	Add exit(0).
 *
 *	2.3	JWZ	09/14/90	Author
 */

#include <stdio.h>
#include <ctype.h>
#include <string.h>

#if !defined(PROTOS) && (defined(__STDC__) || defined(AMIGA))
#define PROTOS
#endif

#define FALSE	0
#define TRUE	1

#define ARRAY_NAME	"header"	/* default name of array in .h file */

#define IS_WHITESPACE(c) \
	((c) == ' ' || (c) == '\t' || (c) == '\n' || c == '\f')

#define IS_POSTSCRIPT(s)	((s)[0] != '%' && (s)[0] != '\0')


/*
 * strip_white: strip leading and trailing whitespace from 'string'; return
 * pointer to first non-whitespace character
 */
#ifdef PROTOS
char *strip_white (char *string)
#else
char *strip_white (string)
     char *string;
#endif
{
    int n;
    for (; IS_WHITESPACE(*string); string++)
	;
    n = strlen(string)-1;
    for (; IS_WHITESPACE(string[n]); n--)
	string[n] = '\0';
    return string;
}


/*
 * strip_comment: strip comment and any preceding whitespace from 'string';
 * return pointer to 'string'
 */
#ifdef PROTOS
char *strip_comment (char *string)
#else
char *strip_comment (string)
     char *string;
#endif
{
    char *p;
    if ((p = strchr(string, '%')) != NULL) {
	*p = '\0';
	string = strip_white(string);
    }
    return string;
}
 

/*
 * escape: copy string 'in' to string 'out', escaping the characters \ and ";
 * return pointer to 'out'
 */
#ifdef PROTOS
char *escape(char *out, char *in)
#else
char *escape(out, in)
     char *out, *in;
#endif
{
   char c, *sv_out = out;

   for (; c = *in; *out++ = *in++)
       if (c == '\\' || c == '"')
	  *out++ = '\\';

   *out = '\0';
   return sv_out;
}


#ifdef PROTOS
int main(int argc, char *argv[])
#else
int main (argc, argv)
     int argc; char *argv[];
#endif
{
    FILE *in, *out;
    char line[256], line2[512], *L, *array;
    int in_initial_comments = TRUE;

    /* retrieve arguments and attempt to open input and output files */

    if (argc < 3 || argc > 4) {
       fprintf(stderr, "usage: %s <infile>.ps <outfile>.h [<arrayname>]\n",
		argv[0]);
       exit(-1); }
    
    in = fopen(argv[1], "r");
    if (NULL == in) {
       fprintf(stderr, "%s: couldn't open %s\n", argv[0], argv[1]);
       exit(-1); }
    
    out = fopen(argv[2], "w");
    if (NULL == out) {
       fprintf(stderr, "%s: couldn't open %s\n", argv[0], argv[2]);
       exit(-1); }
    
    array = argc == 4 ? argv[3] : ARRAY_NAME;

    /* print topline comment on output file */

    fprintf (out, "/*\n * %s: automatically generated by %s from %s\n",
       argv[2], argv[0], argv[1]);
    fprintf (out, " *\n *\tDO NOT EDIT THIS FILE!\n *\n");

    /* main loop - copy lines from input file, to output file, preserving
     * only initial block of comments and blank lines
     */

    while ( fgets(line, 255, in) != NULL ) {
       L = strip_white(line);			/* strip whitespace */

       if ( IS_POSTSCRIPT(L) ) {		/* PostScript source? */
	  if ( in_initial_comments ) {		/* first PS line? */
	     in_initial_comments = FALSE;
	     fprintf(out, " */\n\nchar *%s[] = {\n", array);
	  }
	  L = strip_comment(L);			/* copy string to output */
	  L = escape(line2, L);
	  fprintf(out, "  \"%s\",\n", L);
       } else					/* blank or comment line */
	  if ( in_initial_comments )		/* copy only initial block */
	     fprintf(out, " * %s\n", L);
    }

    fprintf(out, "  (char *)0,\n};\n");		/* terminate array decl */

    fclose(out);    		/* close files and exit */
    fclose(in);
    exit (0);
}
