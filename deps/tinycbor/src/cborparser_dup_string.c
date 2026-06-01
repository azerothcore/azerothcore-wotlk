/****************************************************************************
**
** Copyright (C) 2016 Intel Corporation
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

#include "cborinternalmacros_p.h"

#include "cbor.h"
#include "compilersupport_p.h"
#include "memory.h"


/**
 * \fn CborError cbor_value_dup_text_string(const CborValue *value, char **buffer, size_t *buflen, CborValue *next)
 *
 * Allocates memory for the string pointed by \a value and copies it into this
 * buffer. The pointer to the buffer is stored in \a buffer and the number of
 * bytes copied is stored in \a buflen (those variables must not be NULL).
 *
 * If the iterator \a value does not point to a text string, the behaviour is
 * undefined, so checking with \ref cbor_value_get_type or \ref
 * cbor_value_is_text_string is recommended.
 *
 * On success, \c *buffer will contain a valid pointer that must be freed by
 * calling \c free(). This is the case even for zero-length strings. The \a
 * next pointer, if not null, will be updated to point to the next item after
 * this string. If \a value points to the last item, then \a next will be
 * invalid.
 *
 * If \c malloc returns a NULL pointer, this function will return error
 * condition \ref CborErrorOutOfMemory. In this case, \c *buflen should contain
 * the number of bytes necessary to copy this string and \a value will be
 * updated to point to the next element. On all other failure cases, the values
 * contained in \c *buffer, \c *buflen and \a next are undefined and mustn't be
 * used (for example, calling \c{free()}).
 *
 * This function may not run in constant time (it will run in O(n) time on the
 * number of chunks). It requires constant memory (O(1)) in addition to the
 * malloc'ed block.
 *
 * \note This function does not perform UTF-8 validation on the incoming text
 * string.
 *
 * \sa cbor_value_get_text_string_chunk(), cbor_value_copy_text_string(), cbor_value_dup_byte_string()
 */

/**
 * \fn CborError cbor_value_dup_byte_string(const CborValue *value, uint8_t **buffer, size_t *buflen, CborValue *next)
 *
 * Allocates memory for the string pointed by \a value and copies it into this
 * buffer. The pointer to the buffer is stored in \a buffer and the number of
 * bytes copied is stored in \a buflen (those variables must not be NULL).
 *
 * If the iterator \a value does not point to a byte string, the behaviour is
 * undefined, so checking with \ref cbor_value_get_type or \ref
 * cbor_value_is_byte_string is recommended.
 *
 * On success, \c *buffer will contain a valid pointer that must be freed by
 * calling \c free(). This is the case even for zero-length strings. The \a
 * next pointer, if not null, will be updated to point to the next item after
 * this string. If \a value points to the last item, then \a next will be
 * invalid.
 *
 * If \c malloc returns a NULL pointer, this function will return error
 * condition \ref CborErrorOutOfMemory. In this case, \c *buflen should contain
 * the number of bytes necessary to copy this string and \a value will be
 * updated to point to the next element. On all other failure cases, the values
 * contained in \c *buffer, \c *buflen and \a next are undefined and mustn't be
 * used (for example, calling \c{free()}).
 *
 * This function may not run in constant time (it will run in O(n) time on the
 * number of chunks). It requires constant memory (O(1)) in addition to the
 * malloc'ed block.
 *
 * \sa cbor_value_get_text_string_chunk(), cbor_value_copy_byte_string(), cbor_value_dup_text_string()
 */
CborError _cbor_value_dup_string(const CborValue *value, void **buffer, size_t *buflen, CborValue *next)
{
    const CborValue it = *value;    // often value == next
    CborError err;
    void *tmpbuf;
    cbor_assert(buffer);
    cbor_assert(buflen);
    *buflen = SIZE_MAX;
    err = _cbor_value_copy_string(&it, NULL, buflen, next);
    if (err)
        return err;

    ++*buflen;
    tmpbuf = cbor_malloc(*buflen);
    if (!tmpbuf) {
        /* out of memory */
        return CborErrorOutOfMemory;
    }
    err = _cbor_value_copy_string(&it, tmpbuf, buflen, next);
    if (err) {
        /* This shouldn't have happened! We've iterated once. */
        cbor_free(tmpbuf);
        return err;
    }
    *buffer = tmpbuf;
    return CborNoError;
}
