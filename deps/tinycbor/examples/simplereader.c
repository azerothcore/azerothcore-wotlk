#include "../src/cbor.h"

#include <sys/stat.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

static uint8_t *readfile(const char *fname, size_t *size)
{
    struct stat st;
    FILE *f = fopen(fname, "rb");
    if (!f)
        return NULL;
    if (fstat(fileno(f), &st) == -1)
        return NULL;
    uint8_t *buf = malloc(st.st_size);
    if (buf == NULL)
        return NULL;
    *size = fread(buf, st.st_size, 1, f) == 1 ? st.st_size : 0;
    fclose(f);
    return buf;
}

static void indent(int nestingLevel)
{
    while (nestingLevel--)
        printf("  ");
}

static void dumpbytes(const uint8_t *buf, size_t len)
{
    printf("\"");
    while (len--)
        printf("\\x%02X", *buf++);
    printf("\"");
}

static CborError dumprecursive(CborValue *it, int nestingLevel)
{
    while (!cbor_value_at_end(it)) {
        CborError err;
        CborType type = cbor_value_get_type(it);

        indent(nestingLevel);
        switch (type) {
        case CborArrayType:
        case CborMapType: {
            // recursive type
            CborValue recursed;
            assert(cbor_value_is_container(it));
            puts(type == CborArrayType ? "Array[" : "Map[");
            err = cbor_value_enter_container(it, &recursed);
            if (err)
                return err;       // parse error
            err = dumprecursive(&recursed, nestingLevel + 1);
            if (err)
                return err;       // parse error
            err = cbor_value_leave_container(it, &recursed);
            if (err)
                return err;       // parse error
            indent(nestingLevel);
            puts("]");
            continue;
        }

        case CborIntegerType: {
            int64_t val;
            cbor_value_get_int64(it, &val);     // can't fail
            printf("%lld\n", (long long)val);
            break;
        }

        case CborByteStringType: {
            uint8_t *buf;
            size_t n;
            err = cbor_value_dup_byte_string(it, &buf, &n, it);
            if (err)
                return err;     // parse error
            dumpbytes(buf, n);
            puts("");
            free(buf);
            continue;
        }

        case CborTextStringType: {
            char *buf;
            size_t n;
            err = cbor_value_dup_text_string(it, &buf, &n, it);
            if (err)
                return err;     // parse error
            printf("\"%s\"\n", buf);
            free(buf);
            continue;
        }

        case CborTagType: {
            CborTag tag;
            cbor_value_get_tag(it, &tag);       // can't fail
            printf("Tag(%lld)\n", (long long)tag);
            break;
        }

        case CborSimpleType: {
            uint8_t type;
            cbor_value_get_simple_type(it, &type);  // can't fail
            printf("simple(%u)\n", type);
            break;
        }

        case CborNullType:
            puts("null");
            break;

        case CborUndefinedType:
            puts("undefined");
            break;

        case CborBooleanType: {
            bool val;
            cbor_value_get_boolean(it, &val);       // can't fail
            puts(val ? "true" : "false");
            break;
        }

        case CborDoubleType: {
            double val;
            if (false) {
                float f;
        case CborFloatType:
                cbor_value_get_float(it, &f);
                val = f;
            } else {
                cbor_value_get_double(it, &val);
            }
            printf("%g\n", val);
            break;
        }
        case CborHalfFloatType: {
            uint16_t val;
            cbor_value_get_half_float(it, &val);
            printf("__f16(%04x)\n", val);
            break;
        }

        case CborInvalidType:
            assert(false);      // can't happen
            break;
        }

        err = cbor_value_advance_fixed(it);
        if (err)
            return err;
    }
    return CborNoError;
}

int main(int argc, char **argv)
{
    if (argc != 2) {
        puts("simplereader <filename>");
        return 1;
    }

    size_t length;
    uint8_t *buf = readfile(argv[1], &length);
    if (!buf) {
        perror("readfile");
        return 1;
    }

    CborParser parser;
    CborValue it;
    CborError err = cbor_parser_init(buf, length, 0, &parser, &it);
    if (!err)
        err = dumprecursive(&it, 0);

    if (err) {
        fprintf(stderr, "CBOR parsing failure at offset %ld: %s\n",
                cbor_value_get_next_byte(&it) - buf, cbor_error_string(err));
        free(buf);
        return 1;
    }
    free(buf);
    return 0;
}
