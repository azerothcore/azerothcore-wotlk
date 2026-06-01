/****************************************************************************
**
** Copyright (C) 2019 S.Phirsov
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

#include "cborinternal_p.h"

#ifndef CBOR_NO_HALF_FLOAT_TYPE
/**
 * Retrieves the CBOR half-precision floating point (16-bit) value that \a
 * value points to, converts it to the float and store it in \a result.
 * If the iterator \a value does not point to a half-precision floating
 * point value, the behavior is undefined, so checking with \ref
 * cbor_value_get_type or with \ref cbor_value_is_half_float is recommended.
 * \sa cbor_value_get_type(), cbor_value_is_valid(), cbor_value_is_half_float(), cbor_value_get_half_float(), cbor_value_get_float()
 */
CborError cbor_value_get_half_float_as_float(const CborValue *value, float *result)
{
    uint16_t v;
    CborError err = cbor_value_get_half_float(value, &v);
    cbor_assert(err == CborNoError);

    *result = (float)decode_half((unsigned short)v);

    return CborNoError;
}
#endif
