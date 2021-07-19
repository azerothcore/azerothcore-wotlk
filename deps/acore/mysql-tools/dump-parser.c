/* gcc -O2 -Wall -pedantic dump-parser.c -o dump-parser
 Usage: cat dump.sql | dump-parser
   Or : dump-parser dump.sql
 bugs :
 * the parser will fail if the 10001st character of a line is an escaped quote, it will see it as an unescaped quote.
*/
 
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
 
#define BUFFER 100000
 
bool is_escaped(char* string, int offset) {
    if (offset == 0) {
        return false;
    } else if (string[offset - 1] == '\\') {
        return !is_escaped(string, offset - 1);
    } else {
        return false;
    }
}
 
bool is_commented(char* string) {
    char buffer[4];
 
    sprintf(buffer, "%.3s", string);
 
    return strcmp(buffer, "-- ") == 0;
}
 
int main(int argc, char *argv[])
{
    FILE* file = argc > 1 ? fopen(argv[1], "r") : stdin;
 
    char buffer[BUFFER];
    char* line;
    int pos;
    int parenthesis = 0;
    bool quote = false;
    bool escape = false;
    bool comment = false;
 
    while (fgets(buffer, BUFFER, file) != NULL) {
        line = buffer;
 
        /* skip commented */
        if (comment || is_commented(line)) {
            comment = line[strlen(line) - 1] != '\n';
            fputs(line, stdout);
        } else {
            pos = 0;
 
            nullchar:
            while (line[pos] != '\0') {
                /* if we are still in escape state, we need to check first char. */
                if (!escape) {
                     /* find any character in ()' */
                    pos = strcspn(line, "()'\\");
                }
 
                if (pos > 0) {
                    /* print before match */
                    printf("%.*s", pos, line);
                }
 
                switch (line[pos]) {
                    case '(':
                        if (!quote) {
                            if (parenthesis == 0) {
                                putchar('\n');
                            }
                            parenthesis++;
                        }
                        if (escape) {
                            escape = false;
                        }
                        break;
 
                    case ')':
                        if (!quote) {
                            if (parenthesis > 0) {
                                parenthesis--;
                            } else {
                                /* whoops */
                                puts("\n");
                                fputs(line, stdout);
                                fputs("Found closing parenthesis without opening one.\n", stderr);
                                exit(1);
                            }
                        }
                        if (escape) {
                            escape = false;
                        }
                        break;
 
                    case '\\':
                        escape = !escape;
                        break;
 
                    case '\'':
                        if (escape) {
                            escape = false;
                        } else {
                            quote = !quote;
                        }
                        break;
 
                    case '\0':
                        goto nullchar;
 
                    default:
                        if (escape) {
                            escape = false;
                        }
                        break;
                }
 
                /* print char then skip it (to make sure we don’t double match) */
                putchar(line[pos]);
                line = line + pos + 1;
                pos = 0;
            }
        }
    }
 
    return 0;
}
