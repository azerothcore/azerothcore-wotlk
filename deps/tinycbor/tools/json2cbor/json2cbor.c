/****************************************************************************
**
** Copyright (C) 2015 Intel Corporation
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

#define _GNU_SOURCE
#define __STDC_WANT_IEC_60559_TYPES_EXT__
#include "cbor.h"
#include "cborinternal_p.h"
#include "compilersupport_p.h"

#include <cjson/cJSON.h>

#include <errno.h>
#include <math.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static const char meta_data_marker[] = "$cbor";
uint8_t *buffer;
size_t buffersize;
bool usingMetaData = false;

struct MetaData {
    CborTag tag;
    union {
        const char *v;
        uint8_t simpleType;
    };
    CborType t;
    bool tagged;
};

uint8_t *decode_base64_generic(const char *string, size_t *len, const int8_t reverse_alphabet[256])
{
    *len = ((strlen(string) + 3) & ~3) * 3 / 4;
    uint8_t *buffer = malloc(*len);
    if (buffer == NULL)
        return NULL;

    uint8_t *out = buffer;
    const uint8_t *in = (const uint8_t *)string;
    bool done = false;
    while (!done) {
        if (reverse_alphabet[in[0]] < 0 || reverse_alphabet[in[1]] < 0) {
            if (in[0] == '\0')
                done = true;
            break;
        }

        uint32_t val = reverse_alphabet[in[0]] << 18;
        val |= reverse_alphabet[in[1]] << 12;
        if (in[2] == '=' || in[2] == '\0') {
            if (in[2] == '=' && (in[3] != '=' || in[4] != '\0'))
                break;
            val >>= 12;
            done = true;
        } else if (in[3] == '=' || in[3] == '\0') {
            if (in[3] == '=' && in[4] != '\0')
                break;
            val >>= 6;
            val |= reverse_alphabet[in[2]];
            done = true;
        } else {
            val |= reverse_alphabet[in[2]] << 6;
            val |= reverse_alphabet[in[3]];
        }

        *out++ = val >> 16;
        *out++ = val >> 8;
        *out++ = val;
        in += 4;
    }

    if (!done) {
        free(buffer);
        return NULL;
    }
    *len = out - buffer;
    return buffer;
}

uint8_t *decode_base64(const char *string, size_t *len)
{
    static const int8_t reverse_alphabet[256] = {
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
        -1,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1,
        -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
    };
    return decode_base64_generic(string, len, reverse_alphabet);
}

uint8_t *decode_base64url(const char *string, size_t *len)
{
    static const int8_t reverse_alphabet[256] = {
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1,
        -1,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, 63,
        -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
        -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
    };
    return decode_base64_generic(string, len, reverse_alphabet);
}

uint8_t *decode_base16(const char *string, size_t *len)
{
    size_t i;
    *len = strlen(string) / 2;
    uint8_t *buffer = malloc(*len);
    if (buffer == NULL)
        return NULL;

    for (i = 0; i < *len; ++i) {
        char c = string[i * 2];
        if (c >= '0' && c <= '9') {
            buffer[i] = (c - '0') << 4;
        } else if ((c | 0x20) >= 'a' && (c | 0x20) <= 'f') {
            buffer[i] = ((c | 0x20) - 'a' + 10) << 4;
        } else {
            free(buffer);
            return NULL;
        }

        c = string[i * 2 + 1];
        if (c >= '0' && c <= '9') {
            buffer[i] |= (c - '0');
        } else if ((c | 0x20) >= 'a' && (c | 0x20) <= 'f') {
            buffer[i] |= ((c | 0x20) - 'a' + 10);
        } else {
            free(buffer);
            return NULL;
        }
    }

    return buffer;
}

size_t get_cjson_size_limited(cJSON *container)
{
    // cJSON_GetArraySize is O(n), so don't go too far
    unsigned s = 0;
    cJSON *item;
    for (item = container->child; item; item = item->next) {
        if (++s > 255)
            return CborIndefiniteLength;
    }
    return s;
}

cJSON *get_meta_data(cJSON *object, cJSON *item)
{
    cJSON *meta;
    char *metadatakey;

    if (asprintf(&metadatakey, "%s%s", item->string, meta_data_marker) < 0 || metadatakey == NULL)
        return NULL;
    meta = cJSON_GetObjectItem(object, metadatakey);
    free(metadatakey);
    return meta;
}

struct MetaData parse_meta_data(cJSON *md)
{
    struct MetaData result = { 0, {NULL}, CborInvalidType, false };
    if (md == NULL || md->type != cJSON_Object)
        return result;

    for (md = md->child; md; md = md->next) {
        if (strcmp(md->string, "tag") == 0) {
            if (md->type != cJSON_String || sscanf(md->valuestring, "%" PRIu64, &result.tag) < 0)
                fprintf(stderr, "json2cbor: could not parse tag: %s\n", md->valuestring);
            else
                result.tagged = true;
        } else if (strcmp(md->string, "t") == 0) {
            result.t = md->valueint;
        } else if (strcmp(md->string, "v") == 0) {
            if (md->type == cJSON_Number)
                result.simpleType = md->valueint;
            else
                result.v = md->valuestring;
        }
    }
    return result;
}

CborError decode_json(cJSON *json, CborEncoder *encoder);
CborError decode_json_with_metadata(cJSON *item, CborEncoder *encoder, struct MetaData md)
{
    switch (md.t) {
    case CborIntegerType: {
        // integer that has more than 53 bits of precision
        uint64_t v;
        bool positive = *md.v++ == '+';
        if (sscanf(md.v, "%" PRIx64, &v) < 0) {
            fprintf(stderr, "json2cbor: could not parse number: %s\n", md.v);
            break;
        }
        return positive ? cbor_encode_uint(encoder, v) : cbor_encode_negative_int(encoder, v);
    }

    case CborByteStringType: {
        uint8_t *data;
        size_t len;
        if (md.tag == CborExpectedBase64Tag)
            data = decode_base64(item->valuestring, &len);
        else if (md.tag == CborExpectedBase16Tag)
            data = decode_base16(item->valuestring, &len);
        else if (md.tag == CborNegativeBignumTag)
            data = decode_base64url(item->valuestring + 1, &len);
        else
            data = decode_base64url(item->valuestring, &len);

        if (data != NULL) {
            CborError err = cbor_encode_byte_string(encoder, data, len);
            free(data);
            return err;
        }
        fprintf(stderr, "json2cbor: could not decode encoded byte string: %s\n", item->valuestring);
        break;
    }

    case CborSimpleType:
        return cbor_encode_simple_value(encoder, md.simpleType);

    case CborUndefinedType:
        return cbor_encode_undefined(encoder);

    case CborHalfFloatType:
    case CborFloatType:
    case CborDoubleType: {
        unsigned short half;
        double v;
        if (!md.v) {
            v = item->valuedouble;
        } else if (strcmp(md.v, "nan") == 0) {
            v = NAN;
        } else if (strcmp(md.v, "-inf") == 0) {
            v = -INFINITY;
        } else if (strcmp(md.v, "inf") == 0) {
            v = INFINITY;
        } else {
            fprintf(stderr, "json2cbor: invalid floating-point value: %s\n", md.v);
            break;
        }

        // we can't get an OOM here because the metadata makes up for space
        // (the smallest metadata is "$cbor":{"t":250} (17 bytes)
        return (md.t == CborDoubleType) ? cbor_encode_double(encoder, v) :
               (md.t == CborFloatType) ? cbor_encode_float(encoder, v) :
                                         (half = encode_half(v), cbor_encode_half_float(encoder, &half));
    }

    default:
        fprintf(stderr, "json2cbor: invalid CBOR type: %d\n", md.t);
    case CborInvalidType:
        break;
    }

    return decode_json(item, encoder);
}

CborError decode_json(cJSON *json, CborEncoder *encoder)
{
    CborEncoder container;
    CborError err;
    cJSON *item;

    switch (json->type) {
    case cJSON_False:
    case cJSON_True:
        return cbor_encode_boolean(encoder, json->type == cJSON_True);

    case cJSON_NULL:
        return cbor_encode_null(encoder);

    case cJSON_Number:
        if ((double)json->valueint == json->valuedouble)
            return cbor_encode_int(encoder, json->valueint);
encode_double:
        // the only exception that JSON is larger: floating point numbers
        container = *encoder;   // save the state
        err = cbor_encode_double(encoder, json->valuedouble);

        if (err == CborErrorOutOfMemory) {
            ptrdiff_t offset = cbor_encoder_get_buffer_size(&container, buffer);
            size_t newbuffersize = buffersize + 1024;
            uint8_t *newbuffer = realloc(buffer, newbuffersize);
            if (newbuffer == NULL)
                return err;

            *encoder = container;   // restore state
            encoder->data.ptr = newbuffer + offset;
            encoder->end = newbuffer + newbuffersize;
            buffer = newbuffer;
            buffersize = newbuffersize;
            goto encode_double;
        }
        return err;

    case cJSON_String:
        return cbor_encode_text_stringz(encoder, json->valuestring);

    default:
        return CborErrorUnknownType;

    case cJSON_Array:
        err = cbor_encoder_create_array(encoder, &container, get_cjson_size_limited(json));
        if (err)
            return err;
        for (item = json->child; item; item = item->next) {
            err = decode_json(item, &container);
            if (err)
                return err;
        }
        return cbor_encoder_close_container_checked(encoder, &container);

    case cJSON_Object:
        err = cbor_encoder_create_map(encoder, &container,
                                      usingMetaData ? CborIndefiniteLength : get_cjson_size_limited(json));
        if (err)
            return err;

        for (item = json->child ; item; item = item->next) {
            if (usingMetaData && strlen(item->string) > strlen(meta_data_marker)
                    && strcmp(item->string + strlen(item->string) - strlen(meta_data_marker), meta_data_marker) == 0)
                continue;

            err = cbor_encode_text_stringz(&container, item->string);
            if (err)
                return err;

            if (usingMetaData) {
                cJSON *meta = get_meta_data(json, item);
                struct MetaData md = parse_meta_data(meta);
                if (md.tagged) {
                    err = cbor_encode_tag(&container, md.tag);
                    if (err)
                        return err;
                }

                err = decode_json_with_metadata(item, &container, md);
            } else {
                err = decode_json(item, &container);
            }
            if (err)
                return err;
        }

        return cbor_encoder_close_container_checked(encoder, &container);
    }
}

int main(int argc, char **argv)
{
    int c;
    while ((c = getopt(argc, argv, "M")) != -1) {
        switch (c) {
        case 'M':
            usingMetaData = true;
            break;

        case '?':
            fprintf(stderr, "Unknown option -%c.\n", optopt);
            // fall through
        case 'h':
            puts("Usage: json2cbor [OPTION]... [FILE]...\n"
                 "Reads JSON content from FILE and converts to CBOR.\n"
                 "\n"
                 "Options:\n"
                 " -M       Interpret metadata added by cbordump tool\n"
                 "");
            return c == '?' ? EXIT_FAILURE : EXIT_SUCCESS;
        }
    }

    FILE *in;
    const char *fname = argv[optind];
    if (fname && strcmp(fname, "-") != 0) {
        in = fopen(fname, "r");
        if (!in) {
            perror("open");
            return EXIT_FAILURE;
        }
    } else {
        in = stdin;
        fname = "-";
    }

    /* 1. read the file */
    off_t fsize;
    if (fseeko(in, 0, SEEK_END) == 0 && (fsize = ftello(in)) >= 0) {
        buffersize = fsize + 1;
        buffer = malloc(buffersize);
        if (buffer == NULL) {
            perror("malloc");
            return EXIT_FAILURE;
        }

        rewind(in);
        fsize = fread(buffer, 1, fsize, in);
        buffer[fsize] = '\0';
    } else {
        const unsigned chunk = 16384;
        buffersize = 0;
        buffer = NULL;
        do {    // it the hard way
            buffer = realloc(buffer, buffersize + chunk);
            if (buffer == NULL) {
                perror("malloc");
                return EXIT_FAILURE;
            }

            buffersize += fread(buffer + buffersize, 1, chunk, in);
        } while (!feof(in) && !ferror(in));
        buffer[buffersize] = '\0';
    }

    if (ferror(in)) {
        perror("read");
        return EXIT_FAILURE;
    }
    if (in != stdin)
        fclose(in);

    /* 2. parse as JSON */
    cJSON *doc = cJSON_ParseWithOpts((char *)buffer, NULL, true);
    if (doc == NULL) {
        fprintf(stderr, "json2cbor: %s: could not parse.\n", fname);
        return EXIT_FAILURE;
    }

    /* 3. encode as CBOR */
    // We're going to reuse the buffer, as CBOR is usually shorter than the equivalent JSON
    CborEncoder encoder;
    cbor_encoder_init(&encoder, buffer, buffersize, 0);
    CborError err = decode_json(doc, &encoder);

    cJSON_Delete(doc);

    if (err) {
        fprintf(stderr, "json2cbor: %s: error encoding to CBOR: %s\n", fname,
                cbor_error_string(err));
        return EXIT_FAILURE;
    }

    fwrite(buffer, 1, encoder.data.ptr - buffer, stdout);
    free(buffer);
    return EXIT_SUCCESS;
}
