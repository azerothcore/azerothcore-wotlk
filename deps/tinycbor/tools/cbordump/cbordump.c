/****************************************************************************
**
** Copyright (C) 2021 Intel Corporation
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in
** all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
** THE SOFTWARE.
**
****************************************************************************/

#define _POSIX_C_SOURCE 200809L
#include "cbor.h"
#include "cborjson.h"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void *xrealloc(void *old, size_t size, const char *fname)
{
    old = realloc(old, size);
    if (old == NULL) {
        fprintf(stderr, "%s: %s\n", fname, strerror(errno));
        exit(EXIT_FAILURE);
    }
    return old;
}

void printerror(CborError err, const char *fname)
{
    fprintf(stderr, "%s: %s\n", fname, cbor_error_string(err));
    exit(EXIT_FAILURE);
}

void dumpFile(FILE *in, const char *fname, bool printJson, int flags)
{
    static const size_t chunklen = 16 * 1024;
    static size_t bufsize = 0;
    static uint8_t *buffer = NULL;

    size_t buflen = 0;
    do {
        if (bufsize == buflen)
            buffer = xrealloc(buffer, bufsize += chunklen, fname);

        size_t n = fread(buffer + buflen, 1, bufsize - buflen, in);
        buflen += n;
        if (n == 0) {
            if (!ferror(in))
                continue;
            fprintf(stderr, "%s: %s\n", fname, strerror(errno));
            exit(EXIT_FAILURE);
        }
    } while (!feof(in));

    CborParser parser;
    CborValue value;
    CborError err = cbor_parser_init(buffer, buflen, 0, &parser, &value);
    if (!err) {
        if (printJson)
            err = cbor_value_to_json_advance(stdout, &value, flags);
        else
            err = cbor_value_to_pretty_advance_flags(stdout, &value, flags);
        if (!err)
            puts("");
    }
    if (!err && cbor_value_get_next_byte(&value) != buffer + buflen)
        err = CborErrorGarbageAtEnd;
    if (err)
        printerror(err, fname);
}

int main(int argc, char **argv)
{
    bool printJson = false;
    int json_flags = CborConvertDefaultFlags;
    int cbor_flags = CborPrettyDefaultFlags;
    int c;
    while ((c = getopt(argc, argv, "MOSUcjhfn")) != -1) {
        switch (c) {
        case 'c':
            printJson = false;
            break;
        case 'j':
            printJson = true;
            break;

        case 'f':
            cbor_flags |= CborPrettyShowStringFragments;
            break;
        case 'n':
            cbor_flags |= CborPrettyIndicateIndeterminateLength | CborPrettyNumericEncodingIndicators;
            break;

        case 'M':
            json_flags |= CborConvertAddMetadata;
            break;
        case 'O':
            json_flags |= CborConvertTagsToObjects;
            break;
        case 'S':
            json_flags |= CborConvertStringifyMapKeys;
            break;
        case 'U':
            json_flags |= CborConvertByteStringsToBase64Url;
            break;

        case '?':
            fprintf(stderr, "Unknown option -%c.\n", optopt);
            /* fall through */
        case 'h':
            puts("Usage: cbordump [OPTION]... [FILE]...\n"
                 "Interprets FILEs as CBOR binary data and dumps the content to stdout.\n"
                 "\n"
                 "Options:\n"
                 " -c       Print a CBOR dump (see RFC 7049) (default)\n"
                 " -j       Print a JSON equivalent version\n"
                 " -h       Print this help output and exit\n"
                 "When JSON output is active, the following options are recognized:\n"
                 " -M       Add metadata so converting back to CBOR is possible\n"
                 " -O       Convert CBOR tags to JSON objects\n"
                 " -S       Stringify non-text string map keys\n"
                 " -U       Convert all CBOR byte strings to Base64url regardless of tags\n"
                 "When CBOR dump is active, the following options are recognized:\n"
                 " -f       Show text and byte string fragments\n"
                 " -n       Show overlong encoding of CBOR numbers and length"
                 "");
            return c == '?' ? EXIT_FAILURE : EXIT_SUCCESS;
        }
    }

    char **fname = argv + optind;
    if (!*fname) {
        dumpFile(stdin, "-", printJson, printJson ? json_flags : cbor_flags);
    } else {
        for ( ; *fname; ++fname) {
            FILE *in = fopen(*fname, "rb");
            if (!in) {
                perror("open");
                return EXIT_FAILURE;
            }

            dumpFile(in, *fname, printJson, printJson ? json_flags : cbor_flags);
            fclose(in);
        }
    }

    return EXIT_SUCCESS;
}
