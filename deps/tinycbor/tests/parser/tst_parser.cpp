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

#define _XOPEN_SOURCE 700
#define  _DARWIN_C_SOURCE 1         /* need MAP_ANON */
#include <QtTest>
#include "cbor.h"
#include <stdio.h>
#include <stdarg.h>

#if defined(Q_OS_UNIX)
#  include <sys/mman.h>
#  include <unistd.h>
#elif defined(Q_OS_WIN)
#  define WIN32_LEAN_AND_MEAN 1
#  define NOMINMAX 1
#  include <windows.h>
#endif

#ifndef CBOR_PARSER_MAX_RECURSIONS
#  define CBOR_PARSER_MAX_RECURSIONS 1024
#endif

#ifndef QCOMPARE_EQ
// added for Qt 6.4
#  define QCOMPARE_EQ QCOMPARE
#endif

namespace QTest {
template<> char *toString<CborError>(const CborError &err)
{
    return qstrdup(cbor_error_string(err));
}
}

class tst_Parser : public QObject
{
    Q_OBJECT
private slots:
    void initParserEmpty();

    // parsing API
    void integers_data();
    void integers();
    void halfFloat_data();
    void halfFloat();
    void floatingPoint_data();
    void floatingPoint();
    void fixed_data();
    void fixed();
    void strings_data();
    void strings() { fixed(); }
    void tags_data();
    void tags() { fixed(); }
    void tagTags_data() { tags_data(); }
    void tagTags();
    void emptyContainers_data();
    void emptyContainers();
    void arrays_data();
    void arrays();
    void undefLengthArrays_data() { arrays_data(); }
    void undefLengthArrays();
    void nestedArrays_data() { arrays_data(); }
    void nestedArrays();
    void maps_data();
    void maps();
    void undefLengthMaps_data() { maps_data(); }
    void undefLengthMaps();
    void nestedMaps_data() { maps_data(); }
    void nestedMaps();
    void mapMixed_data();
    void mapMixed() { arrays(); }
    void mapsAndArrays_data() { arrays_data(); }
    void mapsAndArrays();

    void readerApi_data() { arrays_data(); }
    void readerApi();
    void reparse_data();
    void reparse();

    // chunked string API
    void chunkedString_data();
    void chunkedString();
    void chunkedStringInUndefArray_data() { chunkedString_data(); }
    void chunkedStringInUndefArray();

    // convenience API
    void stringLength_data();
    void stringLength();
    void stringCompare_data();
    void stringCompare();
    void mapFind_data();
    void mapFind();

    // validation & errors
    void checkedIntegers_data();
    void checkedIntegers();
    void validationValid_data() { arrays_data(); }
    void validationValid();
    void validation_data();
    void validation();
    void strictValidation_data();
    void strictValidation();
    void incompleteData_data();
    void incompleteData();
    void endPointer_data();
    void endPointer();
    void recursionLimit_data();
    void recursionLimit();
};

struct ParserWrapper
{
    void *realdata = nullptr;
    uint8_t *data;
    size_t len;
    CborParser parser;
    CborValue first;

    ~ParserWrapper() { freeMemory(); }

    CborError init(const QByteArray &ba, uint32_t flags = 0)
    {
        return init(ba.constData(), ba.size(), flags);
    }
    CborError init(const char *ptr, int n, uint32_t flags = 0)
    {
        freeMemory();
        data = allocateMemory(n);
        memcpy(data, ptr, len);
        return cbor_parser_init(data, len, flags, &parser, &first);
    }
    uint8_t *begin() { return data; }
    uint8_t *end()   { return data + len; }

    uint8_t *allocateMemory(size_t);
    void freeMemory();

    static const size_t PageSize = 4096;
    static inline size_t mmapAllocation(size_t n)
    {
        // round up and add one page
        return (n + 2*PageSize) & ~(PageSize - 1);
    }
    static bool shouldUseMmap();
};

bool ParserWrapper::shouldUseMmap()
{
    static int v = qEnvironmentVariableIntValue("PARSER_NO_MMAP");
    return !v;
}

uint8_t *ParserWrapper::allocateMemory(size_t n)
{
    len = n;
    if (shouldUseMmap()) {
        size_t alloc = mmapAllocation(n);
#if defined(Q_OS_UNIX)
        realdata = mmap(nullptr, alloc, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANON, -1, 0);
        Q_ASSERT_X(realdata != MAP_FAILED, "allocateMemory", "mmap failed!");

        // mark last page inaccessible
        uint8_t *ptr = static_cast<uint8_t *>(realdata);
        ptr += alloc - PageSize;
        mprotect(ptr, PageSize, PROT_NONE);

        ptr -= n;
        return ptr;
#elif defined(Q_OS_WIN)
        DWORD flAllocationType = MEM_COMMIT | MEM_RESERVE;
        DWORD flProtect = PAGE_READWRITE;
        realdata = VirtualAlloc(nullptr, alloc, flAllocationType, flProtect);
        Q_ASSERT_X(realdata, "allocateMemory", "VirtualAlloc failed!");

        // mark last page inaccessible
        uint8_t *ptr = static_cast<uint8_t *>(realdata);
        ptr += alloc - PageSize;
        VirtualProtect(ptr, PageSize, PAGE_NOACCESS, nullptr);

        ptr -= n;
        return ptr;
#endif
    }
    realdata = malloc(n);
    return static_cast<uint8_t *>(realdata);
}

void ParserWrapper::freeMemory()
{
    if (shouldUseMmap()) {
        if (realdata) {
#if defined(Q_OS_UNIX)
            size_t alloc = mmapAllocation(len);
            munmap(realdata, alloc);
#elif defined(Q_OS_WIN)
            VirtualFree(realdata, 0, MEM_RELEASE);
#endif
        }
        return;
    }

    free(realdata);
}

static CborError qstring_printf(void *out, const char *fmt, ...)
{
    auto str = static_cast<QString *>(out);
    va_list va;
    va_start(va, fmt);
    *str += QString::vasprintf(fmt, va);
    va_end(va);
    return CborNoError;
};

CborError parseOne(CborValue *it, QString *parsed)
{
    int flags = CborPrettyShowStringFragments | CborPrettyIndicateIndeterminateLength |
                CborPrettyIndicateOverlongNumbers;

    parsed->clear();
    return cbor_value_to_pretty_stream(qstring_printf, parsed, it, flags);
}

CborError parseOneChunk(CborValue *it, QString *parsed)
{
    CborError err;
    CborType ourType = cbor_value_get_type(it);
    if (ourType == CborByteStringType) {
        const uint8_t *bytes;
        size_t len;
        err = cbor_value_get_byte_string_chunk(it, &bytes, &len, it);
        if (err)
            return err;

        if (bytes)
            *parsed = QString::fromLatin1("h'" +
                                          QByteArray::fromRawData(reinterpret_cast<const char *>(bytes), len).toHex() +
                                          '\'');
    } else if (ourType == CborTextStringType) {
        const char *text;
        size_t len;
        err = cbor_value_get_text_string_chunk(it, &text, &len, it);
        if (err)
            return err;

        if (text)
            *parsed = '"' + QString::fromUtf8(text, len) + '"';
    } else {
        Q_UNREACHABLE();
    }
    return err;
}

void tst_Parser::initParserEmpty()
{
    CborParser parser;
    CborValue first;
    CborError err = cbor_parser_init((const quint8 *)"", 0, 0, &parser, &first);
    QCOMPARE(err, CborErrorUnexpectedEOF);
}

bool compareFailed = true;
void compareOne_real(const QByteArray &data, const QString &expected, int line, int n = -1)
{
    compareFailed = true;
    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray::number(line) + ": Got error \"" + cbor_error_string(err) + "\"");

    if (cbor_value_get_type(&w.first) == CborArrayType) {
        size_t len;
        if (n >= 0) {
            QVERIFY(cbor_value_is_length_known(&w.first));
            QCOMPARE(cbor_value_get_array_length(&w.first, &len), CborNoError);
            QCOMPARE(len, size_t(len));
        } else {
            QVERIFY(!cbor_value_is_length_known(&w.first));
            QCOMPARE(cbor_value_get_array_length(&w.first, &len), CborErrorUnknownLength);
        }
    } else if (cbor_value_get_type(&w.first) == CborMapType) {
        size_t len;
        if (n >= 0) {
            QVERIFY(cbor_value_is_length_known(&w.first));
            QCOMPARE(cbor_value_get_map_length(&w.first, &len), CborNoError);
            QCOMPARE(len, size_t(len));
        } else {
            QVERIFY(!cbor_value_is_length_known(&w.first));
            QCOMPARE(cbor_value_get_map_length(&w.first, &len), CborErrorUnknownLength);
        }
    } else if (cbor_value_is_text_string(&w.first) || cbor_value_is_byte_string(&w.first)) {
        size_t len;
        QCOMPARE(cbor_value_calculate_string_length(&w.first, &len), CborNoError);
        if (cbor_value_is_length_known(&w.first)) {
            size_t len2;
            QCOMPARE(cbor_value_get_string_length(&w.first, &len2), CborNoError);
            QCOMPARE(len2, len);
        } else {
            QCOMPARE(cbor_value_get_string_length(&w.first, &len), CborErrorUnknownLength);
        }
    }

    CborError err2 = cbor_value_validate_basic(&w.first);

    QString decoded;
    err = parseOne(&w.first, &decoded);
    QVERIFY2(!err, QByteArray::number(line) + ": Got error \"" + cbor_error_string(err) +
                   "\"; decoded stream:\n" + decoded.toLatin1());
    QCOMPARE(decoded, expected);

    // check that the errors are the same
    QCOMPARE(err2, err);

    // check that we consumed everything
    QCOMPARE((void*)cbor_value_get_next_byte(&w.first), (void*)w.end());

    compareFailed = false;
}
#define compareOne(data, expected) compareOne_real(data, expected, __LINE__)
#define compareOneSize(n, data, expected) compareOne_real(data, expected, __LINE__, n)

#include "data.cpp"

void tst_Parser::integers_data()
{
    addIntegers();
}

void tst_Parser::integers()
{
    QFETCH(QByteArray, data);
    QFETCH(bool, isNegative);
    QFETCH(quint64, expectedRaw);
    QFETCH(qint64, expectedValue);
    QFETCH(bool, inInt64Range);

    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QVERIFY(cbor_value_is_integer(&w.first));

    uint64_t raw;
    cbor_value_get_raw_integer(&w.first, &raw);
    QCOMPARE(quint64(raw), expectedRaw);

    if (isNegative) {
        QVERIFY(cbor_value_is_negative_integer(&w.first));
        QVERIFY(!cbor_value_is_unsigned_integer(&w.first));
    } else {
        QVERIFY(!cbor_value_is_negative_integer(&w.first));
        QVERIFY(cbor_value_is_unsigned_integer(&w.first));
    }

    int64_t value;
    if (inInt64Range) {
        cbor_value_get_int64(&w.first, &value);
        QCOMPARE(qint64(value), expectedValue);
    }

    err = cbor_value_get_int64_checked(&w.first, &value);
    QCOMPARE(err, inInt64Range ? CborNoError : CborErrorDataTooLarge);

    int ivalue;
    bool inIntRange = inInt64Range && (expectedValue == int(expectedValue));
    err = cbor_value_get_int_checked(&w.first, &ivalue);
    QCOMPARE(err, inIntRange ? CborNoError : CborErrorDataTooLarge);
}

static void addHalfFloat()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<unsigned>("expectedRaw");
    QTest::addColumn<double>("expectedValue");

    QTest::newRow("+0") << raw("\x00\x00") << 0U << 0.0;
    QTest::newRow("-0") << raw("\x80\x00") << 0x8000U << 0.0;

    QTest::newRow("min.denorm") << raw("\x00\x01") << 1U << ldexp(1.0, -14) * ldexp(1.0, -10);
    QTest::newRow("-min.denorm") << raw("\x80\x01") << 0x8001U << ldexp(-1.0, -14) * ldexp(1.0, -10);

    QTest::newRow("max.denorm") << raw("\x03\xff") << 0x03ffU << ldexp(1.0, -14) * (1.0 - ldexp(1.0, -10));
    QTest::newRow("-max.denorm") << raw("\x83\xff") << 0x83ffU << ldexp(-1.0, -14) * (1.0 - ldexp(1.0, -10));

    QTest::newRow("min.norm") << raw("\x04\x00") << 0x0400U << ldexp(1.0, -14);
    QTest::newRow("-min.norm") << raw("\x84\x00") << 0x8400U << ldexp(-1.0, -14);

    QTest::newRow("1.0") << raw("\x3c\x00") << 0x3c00U << 1.0;
    QTest::newRow("-1.0") << raw("\xbc\x00") << 0xbc00U << -1.0;

    QTest::newRow("1.5") << raw("\x3e\x00") << 0x3e00U << 1.5;
    QTest::newRow("-1.5") << raw("\xbe\x00") << 0xbe00U << -1.5;

    QTest::newRow("max") << raw("\x7b\xff") << 0x7bffU << ldexp(1.0, 15) * (2.0 - ldexp(1.0, -10));
    QTest::newRow("-max") << raw("\xfb\xff") << 0xfbffU << ldexp(-1.0, 15) * (2.0 - ldexp(1.0, -10));

    QTest::newRow("inf") << raw("\x7c\x00") << 0x7c00U << double(INFINITY);
    QTest::newRow("-inf") << raw("\xfc\x00") << 0xfc00U << double(-INFINITY);

    QTest::newRow("nan") << raw("\x7c\x01") << 0x7c01U << double(NAN);
    QTest::newRow("nan2") << raw("\xfc\x01") << 0xfc01U << double(NAN);
    QTest::newRow("nan3") << raw("\x7e\x00") << 0x7e00U << double(NAN);
    QTest::newRow("nan4") << raw("\xfe\x00") << 0xfe00U << double(NAN);
}

void tst_Parser::halfFloat_data()
{
    addHalfFloat();
}

void tst_Parser::halfFloat()
{
    QFETCH(QByteArray, data);
    QFETCH(unsigned, expectedRaw);
    QFETCH(double, expectedValue);

    CborParser parser;
    CborValue first;

    data.prepend('\xf9');

    CborError err = cbor_parser_init(reinterpret_cast<const quint8 *>(data.constData()), data.length(), 0, &parser, &first);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QVERIFY(cbor_value_is_half_float(&first));

    uint16_t raw;
    cbor_value_get_half_float(&first, &raw);
    QCOMPARE(raw, uint16_t(expectedRaw));

    float value;
    cbor_value_get_half_float_as_float(&first, &value);

    const double epsilon = ldexp(1.0, -25);

    if (qIsNaN(expectedValue)) {
        QVERIFY(qIsNaN(value));
    } else if (qIsInf(expectedValue)) {
        QVERIFY(value == (float)expectedValue);
    } else {
        QVERIFY(qAbs(value - (float)expectedValue) < epsilon);
    }
}

void tst_Parser::floatingPoint_data()
{
    addFloatingPoint();
}

void tst_Parser::floatingPoint()
{
    QFETCH(QByteArray, data);
    QFETCH(CborType, expectedType);
    QFETCH(double, expectedValue);
    bool isNaN = std::isnan(expectedValue);

    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QCOMPARE(cbor_value_get_type(&w.first), expectedType);

    float f;
    double d;
    if (expectedType == CborHalfFloatType) {
        QVERIFY(cbor_value_is_half_float(&w.first));
        QCOMPARE(cbor_value_get_half_float_as_float(&w.first, &f), CborNoError);
    }
    if (expectedType == CborFloatType) {
        QVERIFY(cbor_value_is_float(&w.first));
        QCOMPARE(cbor_value_get_float(&w.first, &f), CborNoError);
    }
    if (expectedType == CborDoubleType) {
        QVERIFY(cbor_value_is_double(&w.first));
        QCOMPARE(cbor_value_get_double(&w.first, &d), CborNoError);
    } else {
        d = f;
    }
    QCOMPARE(std::isnan(d), isNaN);
    if (!isNaN)
        QCOMPARE_EQ(d, expectedValue);
}

void tst_Parser::fixed_data()
{
    addColumns();
    addFixedData();
}

void tst_Parser::fixed()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne(data, expected);
}

void tst_Parser::strings_data()
{
    addColumns();
    addStringsData();
}

void tst_Parser::tags_data()
{
    addColumns();
    addTagsData();
}

void tst_Parser::tagTags()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne("\xd9\xd9\xf7" + data, "55799(" + expected + ')');
    if (!compareFailed)
        compareOne("\xd9\xd9\xf7" "\xd9\xd9\xf7" + data, "55799(55799(" + expected + "))");
}

void tst_Parser::emptyContainers_data()
{
    addColumns();
    addEmptyContainersData();
}

void tst_Parser::emptyContainers()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);
    QFETCH(int, n);

    compareOneSize(n, data, expected);
}

void tst_Parser::arrays_data()
{
    addColumns();
    addFixedData();
    addStringsData();
    addTagsData();
}

void tst_Parser::arrays()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOneSize(1, "\x81" + data, '[' + expected + ']');
    if (compareFailed) return;

    compareOneSize(2, "\x82" + data + data, '[' + expected + ", " + expected + ']');
    if (compareFailed) return;

    // overlong length
    compareOneSize(1, "\x98\1" + data, "[_0 " + expected + ']');
    if (compareFailed) return;
    compareOneSize(1, raw("\x99\0\1") + data, "[_1 " + expected + ']');
    if (compareFailed) return;
    compareOneSize(1, raw("\x9a\0\0\0\1") + data, "[_2 " + expected + ']');
    if (compareFailed) return;
    compareOneSize(1, raw("\x9b\0\0\0\0\0\0\0\1") + data, "[_3 " + expected + ']');
    if (compareFailed) return;

    // medium-sized array: 32 elements (1 << 5)
    expected += ", ";
    for (int i = 0; i < 5; ++i) {
        data += data;
        expected += expected;
    }
    expected.chop(2);   // remove the last ", "
    compareOneSize(32, "\x98\x20" + data, '[' + expected + ']');
    if (compareFailed) return;

    // large array: 256 elements (32 << 3)
    expected += ", ";
    for (int i = 0; i < 3; ++i) {
        data += data;
        expected += expected;
    }
    expected.chop(2);   // remove the last ", "
    compareOneSize(256, raw("\x99\1\0") + data, '[' + expected + ']');
    if (compareFailed) return;
}

void tst_Parser::undefLengthArrays()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne("\x9f" + data + "\xff", "[_ " + expected + ']');
    if (compareFailed) return;

    compareOne("\x9f" + data + data + "\xff", "[_ " + expected + ", " + expected + ']');
}

void tst_Parser::nestedArrays()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOneSize(1, "\x81\x81" + data, "[[" + expected + "]]");
    if (compareFailed) return;

    compareOneSize(1, "\x81\x81\x81" + data, "[[[" + expected + "]]]");
    if (compareFailed) return;

    compareOneSize(1, "\x81\x82" + data + data, "[[" + expected + ", " + expected + "]]");
    if (compareFailed) return;

    compareOneSize(2, "\x82\x81" + data + data, "[[" + expected + "], " + expected + "]");
    if (compareFailed) return;

    compareOneSize(2, "\x82\x81" + data + '\x81' + data, "[[" + expected + "], [" + expected + "]]");
    if (compareFailed) return;

    // undefined length
    compareOneSize(-1, "\x9f\x9f" + data + data + "\xff\xff", "[_ [_ " + expected + ", " + expected + "]]");
    if (compareFailed) return;

    compareOneSize(-1, "\x9f\x9f" + data + "\xff\x9f" + data + "\xff\xff", "[_ [_ " + expected + "], [_ " + expected + "]]");
    if (compareFailed) return;

    compareOneSize(-1, "\x9f\x9f" + data + data + "\xff\x9f" + data + "\xff\xff",
               "[_ [_ " + expected + ", " + expected + "], [_ " + expected + "]]");
    if (compareFailed) return;

    // mix them
    compareOneSize(1, "\x81\x9f" + data + "\xff", "[[_ " + expected + "]]");
    if (compareFailed) return;

    compareOneSize(-1, "\x9f\x81" + data + "\xff", "[_ [" + expected + "]]");
}

void tst_Parser::maps_data()
{
    arrays_data();
}

void tst_Parser::maps()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    // integer key
    compareOneSize(1, "\xa1\1" + data, "{1: " + expected + '}');
    if (compareFailed) return;

    // string key
    compareOneSize(1, "\xa1\x65" "Hello" + data, "{\"Hello\": " + expected + '}');
    if (compareFailed) return;

    // map to self
    compareOneSize(1, "\xa1" + data + data, '{' + expected + ": " + expected + '}');
    if (compareFailed) return;

    // two integer keys
    compareOneSize(2, "\xa2\1" + data + "\2" + data, "{1: " + expected + ", 2: " + expected + '}');
    if (compareFailed) return;

    // OneSize integer and OneSize string key
    compareOneSize(2, "\xa2\1" + data + "\x65" "Hello" + data, "{1: " + expected + ", \"Hello\": " + expected + '}');
    if (compareFailed) return;
}

void tst_Parser::undefLengthMaps()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    // integer key
    compareOne("\xbf\1" + data + '\xff', "{_ 1: " + expected + '}');
    if (compareFailed) return;

    compareOne("\xbf\1" + data + '\2' + data + '\xff', "{_ 1: " + expected + ", 2: " + expected + '}');
    if (compareFailed) return;

    compareOne("\xbf\1" + data + "\x65Hello" + data + '\xff', "{_ 1: " + expected + ", \"Hello\": " + expected + '}');
    if (compareFailed) return;

    compareOne("\xbf\x65Hello" + data + '\1' + data + '\xff', "{_ \"Hello\": " + expected + ", 1: " + expected + '}');
}

void tst_Parser::nestedMaps()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    // nested maps as values
    compareOneSize(1, "\xa1\1\xa1\2" + data, "{1: {2: " + expected + "}}");
    if (compareFailed) return;

    compareOneSize(1, "\xa1\x65Hello\xa1\2" + data, "{\"Hello\": {2: " + expected + "}}");
    if (compareFailed) return;

    compareOneSize(1, "\xa1\1\xa2\2" + data + '\x20' + data, "{1: {2: " + expected + ", -1: " + expected + "}}");
    if (compareFailed) return;

    compareOneSize(2, "\xa2\1\xa1\2" + data + "\2\xa1\x20" + data, "{1: {2: " + expected + "}, 2: {-1: " + expected + "}}");
    if (compareFailed) return;

    // nested maps as keys
    compareOneSize(1, "\xa1\xa1\xf4" + data + "\xf5", "{{false: " + expected + "}: true}");
    if (compareFailed) return;

    compareOneSize(1, "\xa1\xa1" + data + data + "\xa1" + data + data,
               "{{" + expected + ": " + expected + "}: {" + expected + ": " + expected + "}}");
    if (compareFailed) return;

    // undefined length
    compareOneSize(-1, "\xbf\1\xbf\2" + data + "\xff\xff", "{_ 1: {_ 2: " + expected + "}}");
    if (compareFailed) return;

    compareOneSize(-1, "\xbf\1\xbf\2" + data + '\x20' + data + "\xff\xff", "{_ 1: {_ 2: " + expected + ", -1: " + expected + "}}");
    if (compareFailed) return;

    compareOneSize(-1, "\xbf\1\xbf\2" + data + "\xff\2\xbf\x20" + data + "\xff\xff",
               "{_ 1: {_ 2: " + expected + "}, 2: {_ -1: " + expected + "}}");
    if (compareFailed) return;

    compareOneSize(-1, "\xbf\xbf" + data + data + "\xff\xbf" + data + data + "\xff\xff",
               "{_ {_ " + expected + ": " + expected + "}: {_ " + expected + ": " + expected + "}}");
    if (compareFailed) return;

    // mix them
    compareOneSize(1, "\xa1\1\xbf\2" + data + "\xff", "{1: {_ 2: " + expected + "}}");
    if (compareFailed) return;

    compareOneSize(-1, "\xbf\1\xa1\2" + data + "\xff", "{_ 1: {2: " + expected + "}}");
    if (compareFailed) return;
}

void tst_Parser::mapMixed_data()
{
    addColumns();
    addMapMixedData();
}

void tst_Parser::mapsAndArrays()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    // arrays of maps
    compareOneSize(1, "\x81\xa1\1" + data, "[{1: " + expected + "}]");
    if (compareFailed) return;

    compareOneSize(2, "\x82\xa1\1" + data + "\xa1\2" + data, "[{1: " + expected + "}, {2: " + expected + "}]");
    if (compareFailed) return;

    compareOneSize(1, "\x81\xa2\1" + data + "\2" + data, "[{1: " + expected + ", 2: " + expected + "}]");
    if (compareFailed) return;

    compareOneSize(-1, "\x9f\xa1\1" + data + "\xff", "[_ {1: " + expected + "}]");
    if (compareFailed) return;

    compareOneSize(1, "\x81\xbf\1" + data + "\xff", "[{_ 1: " + expected + "}]");
    if (compareFailed) return;

    compareOneSize(-1, "\x9f\xbf\1" + data + "\xff\xff", "[_ {_ 1: " + expected + "}]");
    if (compareFailed) return;

    // maps of arrays
    compareOneSize(1, "\xa1\1\x81" + data, "{1: [" + expected + "]}");
    if (compareFailed) return;

    compareOneSize(1, "\xa1\1\x82" + data + data, "{1: [" + expected + ", " + expected + "]}");
    if (compareFailed) return;

    compareOneSize(2, "\xa2\1\x81" + data + "\x65Hello\x81" + data, "{1: [" + expected + "], \"Hello\": [" + expected + "]}");
    if (compareFailed) return;

    compareOneSize(1, "\xa1\1\x9f" + data + "\xff", "{1: [_ " + expected + "]}");
    if (compareFailed) return;

    compareOneSize(1, "\xa1\1\x9f" + data + data + "\xff", "{1: [_ " + expected + ", " + expected + "]}");
    if (compareFailed) return;

    compareOneSize(-1, "\xbf\1\x81" + data + "\xff", "{_ 1: [" + expected + "]}");
    if (compareFailed) return;

    compareOneSize(-1, "\xbf\1\x9f" + data + "\xff\xff", "{_ 1: [_ " + expected + "]}");
    if (compareFailed) return;

    compareOneSize(-1, "\xbf\1\x9f" + data + data + "\xff\xff", "{_ 1: [_ " + expected + ", " + expected + "]}");
    if (compareFailed) return;

    // mixed with indeterminate length strings
    compareOneSize(-1, "\xbf\1\x9f" + data + "\xff\x65Hello\xbf" + data + "\x7f\xff\xff\xff",
                   "{_ 1: [_ " + expected + "], \"Hello\": {_ " + expected + ": (_ )}}");
}

struct Input {
    QByteArray data;
    int consumed;
};

static const CborParserOperations byteArrayOps = {
    /* can_read_bytes = */ [](void *token, size_t len) {
        auto input = static_cast<Input *>(token);
        return input->data.size() - input->consumed >= int(len);
    },
    /* read_bytes = */ [](void *token, void *dst, size_t offset, size_t len) {
        auto input = static_cast<Input *>(token);
        return memcpy(dst, input->data.constData() + input->consumed + offset, len);
    },
    /* advance_bytes = */ [](void *token, size_t len) {
        auto input = static_cast<Input *>(token);
        input->consumed += int(len);
    },
    /* transfer_string = */ [](void *token, const void **userptr, size_t offset, size_t len) {
        // ###
        auto input = static_cast<Input *>(token);
        if (input->data.size() - input->consumed < int(len + offset))
            return CborErrorUnexpectedEOF;
        input->consumed += int(offset);
        *userptr = input->data.constData() + input->consumed;
        input->consumed += int(len);
        return CborNoError;
    }
};

void tst_Parser::readerApi()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    Input input = { data, 0 };

    CborParser parser;
    CborValue first;
    CborError err = cbor_parser_init_reader(&byteArrayOps, &parser, &first, &input);
    QCOMPARE(err, CborNoError);

    QString decoded;
    err = parseOne(&first, &decoded);
    QCOMPARE(err, CborNoError);
    QCOMPARE(decoded, expected);

    // check we consumed everything
    QCOMPARE(input.consumed, data.size());
}

void tst_Parser::reparse_data()
{
    // only one-item rows
    addColumns();
    addFixedData();
}

void tst_Parser::reparse()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    Input input = { QByteArray(), 0 };
    CborParser parser;
    CborValue first;
    CborError err = cbor_parser_init_reader(&byteArrayOps, &parser, &first, &input);
    QCOMPARE(err, CborErrorUnexpectedEOF);

    for (int i = 0; i < data.size(); ++i) {
        input.data = data.left(i);
        err = cbor_value_reparse(&first);
        if (err != CborErrorUnexpectedEOF)
            qDebug() << "At" << i;
        QCOMPARE(err, CborErrorUnexpectedEOF);
        QCOMPARE(input.consumed, 0);
    }

    // now it should work
    input.data = data;
    err = cbor_value_reparse(&first);
    QCOMPARE(err, CborNoError);

    QString decoded;
    err = parseOne(&first, &decoded);
    QCOMPARE(err, CborNoError);
    QCOMPARE(decoded, expected);

    // check we consumed everything
    QCOMPARE(input.consumed, data.size());
}

void tst_Parser::chunkedString_data()
{
    addChunkedStringData();
}

static void chunkedStringTest(const QByteArray &data, const QString &concatenated,
                              QStringList &chunks, CborType ourType)
{
    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    CborValue value;
    QVERIFY(cbor_value_is_array(&w.first));
    err = cbor_value_enter_container(&w.first, &value);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QVERIFY(cbor_value_is_byte_string(&value) || cbor_value_is_text_string(&value));

    CborValue copy = value;

    err = cbor_value_begin_string_iteration(&value);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    forever {
        QString decoded;
        err = parseOneChunk(&value, &decoded);
        if (err == CborErrorNoMoreStringChunks)
            break;          // last chunk

        QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

        QVERIFY2(!chunks.isEmpty(), "Too many chunks");
        QString expected = chunks.takeFirst();
        QCOMPARE(decoded, expected);
    }

    err = cbor_value_finish_string_iteration(&value);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QVERIFY2(chunks.isEmpty(), "Too few chunks");

    // compare to the concatenated data
    {
        size_t n;
        err = cbor_value_calculate_string_length(&copy, &n);
        QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

        size_t nn = n;
        QByteArray buffer(n + 1, Qt::Uninitialized);
        QByteArray buffer2(n + 1, Qt::Uninitialized);
        buffer[int(n)] = 0xff;
        buffer2[int(n)] = 0xff;
        QString formatted;
        if (cbor_value_is_byte_string(&copy)) {
            err = cbor_value_copy_byte_string(&copy, (uint8_t *)buffer.data(), &nn, nullptr);
            QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
            QCOMPARE(nn, n);

            formatted = QString::fromLatin1("h'" + QByteArray::fromRawData(buffer.data(), n).toHex() + '\'');

            // repeat by allowing the null termination
            nn = n + 1;
            err = cbor_value_copy_byte_string(&copy, (uint8_t *)buffer2.data(), &nn, nullptr);
        } else {
            err = cbor_value_copy_text_string(&copy, buffer.data(), &n, nullptr);
            QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
            QCOMPARE(nn, n);

            formatted = '"' + QString::fromUtf8(buffer.data(), n) + '"';

            // repeat by allowing the null termination
            nn = n + 1;
            err = cbor_value_copy_text_string(&copy, buffer2.data(), &nn, nullptr);
        }
        QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
        QCOMPARE(formatted, concatenated);

        // verify terminators
        QCOMPARE(buffer.at(n), char(0xff));
        QCOMPARE(buffer2.at(n), '\0');
        QCOMPARE(nn, n);

        buffer.truncate(n);
        buffer2.truncate(n);
        QCOMPARE(buffer2, buffer);
    }

    // confirm that the extra string we appended is still here
    QVERIFY(!cbor_value_at_end(&value));
    QCOMPARE(cbor_value_get_type(&value), ourType);
    size_t len;
    err = cbor_value_get_string_length(&value, &len);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QCOMPARE(len, size_t(0));

    err = cbor_value_advance(&value);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    // confirm EOF
    QVERIFY(cbor_value_at_end(&value));

    err = cbor_value_leave_container(&w.first, &value);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QCOMPARE((void*)cbor_value_get_next_byte(&w.first), (void*)w.end());
}

void tst_Parser::chunkedString()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, concatenated);
    QFETCH(QStringList, chunks);

    // Make this an array of two entries, with the second an empty byte or text string
    CborType ourType = CborType(data.at(0) & 0xe0);
    data.prepend(char(0x82));
    data.append(ourType);

    chunkedStringTest(data, concatenated, chunks, ourType);
}

void tst_Parser::chunkedStringInUndefArray()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, concatenated);
    QFETCH(QStringList, chunks);

    // Make this an array of undefined length entries, with the second entry an empty byte or text string
    CborType ourType = CborType(data.at(0) & 0xe0);
    data.prepend(char(0x9f));
    data.append(ourType);
    data.append(char(0xff));

    chunkedStringTest(data, concatenated, chunks, ourType);
}

void tst_Parser::stringLength_data()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<int>("expected");

    QTest::newRow("emptybytestring") << raw("\x40") << 0;
    QTest::newRow("bytestring1") << raw("\x41 ") << 1;
    QTest::newRow("bytestring1-nul") << raw("\x41\0") << 1;
    QTest::newRow("bytestring5") << raw("\x45Hello") << 5;
    QTest::newRow("bytestring24") << raw("\x58\x18""123456789012345678901234") << 24;
    QTest::newRow("bytestring256") << raw("\x59\1\0") + QByteArray(256, '3') << 256;

    // text strings
    QTest::newRow("emptytextstring") << raw("\x60") << 0;
    QTest::newRow("textstring1") << raw("\x61 ") << 1;
    QTest::newRow("textstring1-nul") << raw("\x61\0") << 1;
    QTest::newRow("textstring5") << raw("\x65Hello") << 5;
    QTest::newRow("textstring24") << raw("\x78\x18""123456789012345678901234") << 24;
    QTest::newRow("textstring256") << raw("\x79\1\0") + QByteArray(256, '3') << 256;

    // strings with overlong length
    QTest::newRow("emptybytestring*1") << raw("\x58\x00") << 0;
    QTest::newRow("emptytextstring*1") << raw("\x78\x00") << 0;
    QTest::newRow("emptybytestring*2") << raw("\x59\x00\x00") << 0;
    QTest::newRow("emptytextstring*2") << raw("\x79\x00\x00") << 0;
    QTest::newRow("emptybytestring*4") << raw("\x5a\0\0\0\0") << 0;
    QTest::newRow("emptytextstring*4") << raw("\x7a\0\0\0\0") << 0;
    QTest::newRow("emptybytestring*8") << raw("\x5b\0\0\0\0\0\0\0\0") << 0;
    QTest::newRow("emptytextstring*8") << raw("\x7b\0\0\0\0\0\0\0\0") << 0;
    QTest::newRow("bytestring5*1") << raw("\x58\x05Hello") << 5;
    QTest::newRow("textstring5*1") << raw("\x78\x05Hello") << 5;
    QTest::newRow("bytestring5*2") << raw("\x59\0\5Hello") << 5;
    QTest::newRow("textstring5*2") << raw("\x79\0\x05Hello") << 5;
    QTest::newRow("bytestring5*4") << raw("\x5a\0\0\0\5Hello") << 5;
    QTest::newRow("textstring5*4") << raw("\x7a\0\0\0\x05Hello") << 5;
    QTest::newRow("bytestring5*8") << raw("\x5b\0\0\0\0\0\0\0\5Hello") << 5;
    QTest::newRow("textstring5*8") << raw("\x7b\0\0\0\0\0\0\0\x05Hello") << 5;

    // strings with undefined length
    QTest::newRow("_emptybytestring") << raw("\x5f\xff") << 0;
    QTest::newRow("_emptytextstring") << raw("\x7f\xff") << 0;
    QTest::newRow("_emptybytestring2") << raw("\x5f\x40\xff") << 0;
    QTest::newRow("_emptytextstring2") << raw("\x7f\x60\xff") << 0;
    QTest::newRow("_emptybytestring3") << raw("\x5f\x40\x40\xff") << 0;
    QTest::newRow("_emptytextstring3") << raw("\x7f\x60\x60\xff") << 0;
    QTest::newRow("_bytestring5*2") << raw("\x5f\x43Hel\x42lo\xff") << 5;
    QTest::newRow("_textstring5*2") << raw("\x7f\x63Hel\x62lo\xff") << 5;
    QTest::newRow("_bytestring5*5") << raw("\x5f\x41H\x41""e\x41l\x41l\x41o\xff") << 5;
    QTest::newRow("_textstring5*5") << raw("\x7f\x61H\x61""e\x61l\x61l\x61o\xff") << 5;
    QTest::newRow("_bytestring5*6") << raw("\x5f\x41H\x41""e\x40\x41l\x41l\x41o\xff") << 5;
    QTest::newRow("_textstring5*6") << raw("\x7f\x61H\x61""e\x61l\x60\x61l\x61o\xff") << 5;
}

void tst_Parser::stringLength()
{
    QFETCH(QByteArray, data);
    QFETCH(int, expected);

    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    size_t result;
    err = cbor_value_calculate_string_length(&w.first, &result);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QCOMPARE(result, size_t(expected));

    if (cbor_value_is_length_known(&w.first)) {
        QCOMPARE(cbor_value_get_string_length(&w.first, &result), CborNoError);
        QCOMPARE(result, size_t(expected));
    }

}

void tst_Parser::stringCompare_data()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<QString>("string");
    QTest::addColumn<bool>("expected");

    // compare empty to empty
    QTest::newRow("empty-empty") << raw("\x60") << QString() << true;
    QTest::newRow("_empty-empty") << raw("\x7f\xff") << QString() << true;
    QTest::newRow("_empty*1-empty") << raw("\x7f\x60\xff") << QString() << true;
    QTest::newRow("_empty*2-empty") << raw("\x7f\x60\x60\xff") << QString() << true;

    // compare empty to non-empty
    QTest::newRow("empty-nonempty") << raw("\x60") << "Hello" << false;
    QTest::newRow("_empty-nonempty") << raw("\x7f\xff") << "Hello" << false;
    QTest::newRow("_empty*1-nonempty") << raw("\x7f\x60\xff") << "Hello" << false;
    QTest::newRow("_empty*2-nonempty") << raw("\x7f\x60\x60\xff") << "Hello" << false;

    // compare same strings
    QTest::newRow("same-short-short") << raw("\x65Hello") << "Hello" << true;
    QTest::newRow("same-_short*1-short") << raw("\x7f\x65Hello\xff") << "Hello" << true;
    QTest::newRow("same-_short*2-short") << raw("\x7f\x63Hel\x62lo\xff") << "Hello" << true;
    QTest::newRow("same-_short*5-short") << raw("\x7f\x61H\x61""e\x61l\x61l\x61o\xff") << "Hello" << true;
    QTest::newRow("same-_short*8-short") << raw("\x7f\x61H\x60\x61""e\x60\x61l\x61l\x60\x61o\xff") << "Hello" << true;
    QTest::newRow("same-long-long") << raw("\x78\x2aGood morning, good afternoon and goodnight")
                                    << "Good morning, good afternoon and goodnight" << true;
    QTest::newRow("same-_long*1-long") << raw("\x7f\x78\x2aGood morning, good afternoon and goodnight\xff")
                                       << "Good morning, good afternoon and goodnight" << true;
    QTest::newRow("same-_long*2-long") << raw("\x7f\x78\x1cGood morning, good afternoon\x6e and goodnight\xff")
                                       << "Good morning, good afternoon and goodnight" << true;

    // compare different strings (same length)
    QTest::newRow("diff-same-length-short-short") << raw("\x65Hello") << "World" << false;
    QTest::newRow("diff-same-length-_short*1-short") << raw("\x7f\x65Hello\xff") << "World" << false;
    QTest::newRow("diff-same-length-_short*2-short") << raw("\x7f\x63Hel\x62lo\xff") << "World" << false;
    QTest::newRow("diff-same-length-_short*5-short") << raw("\x7f\x61H\x61""e\x61l\x61l\x61o\xff") << "World" << false;
    QTest::newRow("diff-same-length-_short*8-short") << raw("\x7f\x61H\x60\x61""e\x60\x61l\x61l\x60\x61o\xff") << "World" << false;
    QTest::newRow("diff-same-length-long-long") << raw("\x78\x2aGood morning, good afternoon and goodnight")
                                                << "Good morning, good afternoon and goodnight, world" << false;
    QTest::newRow("diff-same-length-_long*1-long") << raw("\x7f\x78\x2aGood morning, good afternoon and goodnight\xff")
                                                   << "Good morning, good afternoon and goodnight, world" << false;
    QTest::newRow("diff-same-length-_long*2-long") << raw("\x7f\x78\x1cGood morning, good afternoon\x6e and goodnight\xff")
                                                   << "Good morning, good afternoon and goodnight, world" << false;

    // compare different strings (different length)
    QTest::newRow("diff-diff-length-short-short") << raw("\x65Hello") << "Hello World" << false;
    QTest::newRow("diff-diff-length-_short*1-short") << raw("\x7f\x65Hello\xff") << "Hello World" << false;
    QTest::newRow("diff-diff-length-_short*2-short") << raw("\x7f\x63Hel\x62lo\xff") << "Hello World" << false;
    QTest::newRow("diff-diff-length-_short*5-short") << raw("\x7f\x61H\x61""e\x61l\x61l\x61o\xff") << "Hello World" << false;
    QTest::newRow("diff-diff-length-_short*8-short") << raw("\x7f\x61H\x60\x61""e\x60\x61l\x61l\x60\x61o\xff") << "Hello World" << false;
    QTest::newRow("diff-diff-length-long-long") << raw("\x78\x2aGood morning, good afternoon and goodnight")
                                                << "Good morning, good afternoon and goodnight World" << false;
    QTest::newRow("diff-diff-length-_long*1-long") << raw("\x7f\x78\x2aGood morning, good afternoon and goodnight\xff")
                                                   << "Good morning, good afternoon and goodnight World" << false;
    QTest::newRow("diff-diff-length-_long*2-long") << raw("\x7f\x78\x1cGood morning, good afternoon\x6e and goodnight\xff")
                                                   << "Good morning, good afternoon and goodnight World" << false;

    // compare against non-strings
    QTest::newRow("unsigned") << raw("\0") << "0" << false;
    QTest::newRow("negative") << raw("\x20") << "-1" << false;
    QTest::newRow("emptybytestring") << raw("\x40") << "" << false;
    QTest::newRow("_emptybytestring") << raw("\x5f\xff") << "" << false;
    QTest::newRow("shortbytestring") << raw("\x45Hello") << "Hello" << false;
    QTest::newRow("longbytestring") << raw("\x58\x2aGood morning, good afternoon and goodnight")
                                    << "Good morning, good afternoon and goodnight" << false;
    QTest::newRow("emptyarray") << raw("\x80") << "" << false;
    QTest::newRow("emptymap") << raw("\xa0") << "" << false;
    QTest::newRow("array") << raw("\x81\x65Hello") << "Hello" << false;
    QTest::newRow("map") << raw("\xa1\x65Hello\x65World") << "Hello World" << false;
    QTest::newRow("false") << raw("\xf4") << "false" << false;
    QTest::newRow("true") << raw("\xf5") << "true" << false;
    QTest::newRow("null") << raw("\xf6") << "null" << false;
}

void compareOneString(const QByteArray &data, const QString &string, bool expected, int line)
{
    compareFailed = true;

    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray::number(line) + ": Got error \"" + cbor_error_string(err) + "\"");

    bool result;
    QByteArray bastring = string.toUtf8();
    err = cbor_value_text_string_equals(&w.first, bastring.constData(), &result);
    QVERIFY2(!err, QByteArray::number(line) + ": Got error \"" + cbor_error_string(err) + "\"");
    QCOMPARE(result, expected);

    if (expected) {
        size_t len;
        cbor_value_skip_tag(&w.first);
        if (cbor_value_is_length_known(&w.first)) {
            QCOMPARE(cbor_value_get_string_length(&w.first, &len), CborNoError);
            QCOMPARE(int(len), bastring.size());
        }
        QCOMPARE(cbor_value_calculate_string_length(&w.first, &len), CborNoError);
        QCOMPARE(int(len), bastring.size());
    }

    compareFailed = false;
}
#define compareOneString(data, string, expected) compareOneString(data, string, expected, __LINE__)

void tst_Parser::stringCompare()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, string);
    QFETCH(bool, expected);

    compareOneString(data, string, expected);
    if (compareFailed) return;

    // tag it
    compareOneString("\xc1" + data, string, expected);
    if (compareFailed) return;

    compareOneString("\xc1\xc2" + data, string, expected);
}

void tst_Parser::mapFind_data()
{
    // Rules:
    //  we are searching for string "needle"
    //  if present, the value should be the string "haystack" (with tag 42)

    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<bool>("expected");

    QTest::newRow("emptymap") << raw("\xa0") << false;
    QTest::newRow("_emptymap") << raw("\xbf\xff") << false;

    // maps not containing our items
    QTest::newRow("absent-unsigned-unsigned") << raw("\xa1\0\0") << false;
    QTest::newRow("absent-taggedunsigned-unsigned") << raw("\xa1\xc0\0\0") << false;
    QTest::newRow("absent-unsigned-taggedunsigned") << raw("\xa1\0\xc0\0") << false;
    QTest::newRow("absent-taggedunsigned-taggedunsigned") << raw("\xa1\xc0\0\xc0\0") << false;
    QTest::newRow("absent-string-unsigned") << raw("\xa1\x68haystack\0") << false;
    QTest::newRow("absent-taggedstring-unsigned") << raw("\xa1\xc0\x68haystack\0") << false;
    QTest::newRow("absent-string-taggedunsigned") << raw("\xa1\x68haystack\xc0\0") << false;
    QTest::newRow("absent-taggedstring-taggedunsigned") << raw("\xa1\xc0\x68haystack\xc0\0") << false;
    QTest::newRow("absent-string-string") << raw("\xa1\x68haystack\x66needle") << false;
    QTest::newRow("absent-string-taggedstring") << raw("\xa1\x68haystack\xc0\x66needle") << false;
    QTest::newRow("absent-taggedstring-string") << raw("\xa1\xc0\x68haystack\x66needle") << false;
    QTest::newRow("absent-string-taggedstring") << raw("\xa1\xc0\x68haystack\xc0\x66needle") << false;

    QTest::newRow("absent-string-emptyarray") << raw("\xa1\x68haystack\x80") << false;
    QTest::newRow("absent-string-_emptyarray") << raw("\xa1\x68haystack\x9f\xff") << false;
    QTest::newRow("absent-string-array1") << raw("\xa1\x68haystack\x81\0") << false;
    QTest::newRow("absent-string-array2") << raw("\xa1\x68haystack\x85\0\1\2\3\4") << false;
    QTest::newRow("absent-string-array3") << raw("\xa1\x68haystack\x85\x63one\x63two\x65three\x64""four\x64""five") << false;

    QTest::newRow("absent-string-emptymap") << raw("\xa1\x68haystack\xa0") << false;
    QTest::newRow("absent-string-_emptymap") << raw("\xa1\x68haystack\xbf\xff") << false;
    QTest::newRow("absent-string-map") << raw("\xa1\x68haystack\xa1\x68haystack\x66needle") << false;
    QTest::newRow("absent-string-map2") << raw("\xa1\x68haystack\xa1\x68haystack\x66needle\61z\62yx") << false;

    // maps containing our items
    QTest::newRow("alone") << raw("\xa1\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("tagged") << raw("\xa1\xc1\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("doubletagged") << raw("\xa1\xc1\xc2\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("chunked") << raw("\xa1\x7f\x66needle\xff\xd8\x2a\x68haystack") << true;
    QTest::newRow("chunked*2") << raw("\xa1\x7f\x60\x66needle\xff\xd8\x2a\x68haystack") << true;
    QTest::newRow("chunked*2bis") << raw("\xa1\x7f\x66needle\x60\xff\xd8\x2a\x68haystack") << true;
    QTest::newRow("chunked*3") << raw("\xa1\x7f\x62ne\x62""ed\x62le\xff\xd8\x2a\x68haystack") << true;
    QTest::newRow("chunked*8") << raw("\xa1\x7f\x61n\x61""e\x60\x61""e\x61""d\x60\x62le\x60\xff\xd8\x2a\x68haystack") << true;

    QTest::newRow("1before") << raw("\xa2\x68haystack\x66needle\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("tagged-1before") << raw("\xa2\xc1\x68haystack\x66needle\xc1\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("doubletagged-1before2") << raw("\xa2\xc1\xc2\x68haystack\x66needle\xc1\xc2\x66needle\xd8\x2a\x68haystack") << true;

    QTest::newRow("arraybefore") << raw("\xa2\x61z\x80\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("nestedarraybefore") << raw("\xa2\x61z\x81\x81\0\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("arrayarraybefore") << raw("\xa2\x82\1\2\x80\x66needle\xd8\x2a\x68haystack") << true;

    QTest::newRow("mapbefore") << raw("\xa2\x61z\xa0\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("nestedmapbefore") << raw("\xa2\x61z\xa1\0\x81\0\x66needle\xd8\x2a\x68haystack") << true;
    QTest::newRow("mapmapbefore") << raw("\xa2\xa1\1\2\xa0\x66needle\xd8\x2a\x68haystack") << true;
}

void tst_Parser::mapFind()
{
    QFETCH(QByteArray, data);
    QFETCH(bool, expected);

    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    CborValue element;
    err = cbor_value_map_find_value(&w.first, "needle", &element);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    if (expected) {
        QCOMPARE(int(element.type), int(CborTagType));

        CborTag tag;
        err = cbor_value_get_tag(&element, &tag);
        QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
        QCOMPARE(int(tag), 42);

        bool equals;
        err = cbor_value_text_string_equals(&element, "haystack", &equals);
        QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
        QVERIFY(equals);
    } else {
        QCOMPARE(int(element.type), int(CborInvalidType));
    }
}

void tst_Parser::checkedIntegers_data()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<QVariant>("result");       // QVariant so we can note numbers out of int64_t range

    QTest::newRow("0") << raw("\x00") << QVariant(Q_INT64_C(0));
    QTest::newRow("1") << raw("\x01") << QVariant(Q_INT64_C(1));
    QTest::newRow("10") << raw("\x0a") << QVariant(Q_INT64_C(10));
    QTest::newRow("23") << raw("\x17") << QVariant(Q_INT64_C(23));
    QTest::newRow("24") << raw("\x18\x18") << QVariant(Q_INT64_C(24));
    QTest::newRow("UINT8_MAX") << raw("\x18\xff") << QVariant(Q_INT64_C(255));
    QTest::newRow("UINT8_MAX+1") << raw("\x19\x01\x00") << QVariant(Q_INT64_C(256));
    QTest::newRow("UINT16_MAX") << raw("\x19\xff\xff") << QVariant(Q_INT64_C(65535));
    QTest::newRow("UINT16_MAX+1") << raw("\x1a\0\1\x00\x00") << QVariant(Q_INT64_C(65536));
    QTest::newRow("INT32_MAX") << raw("\x1a\x7f\xff\xff\xff") << QVariant(Q_INT64_C(2147483647));
    QTest::newRow("INT32_MAX+1") << raw("\x1a\x80\x00\x00\x00") << QVariant(Q_INT64_C(2147483648));
    QTest::newRow("UINT32_MAX") << raw("\x1a\xff\xff\xff\xff") << QVariant(Q_INT64_C(4294967295));
    QTest::newRow("UINT32_MAX+1") << raw("\x1b\0\0\0\1\0\0\0\0") << QVariant(Q_INT64_C(4294967296));
    QTest::newRow("UINT64_MAX") << raw("\x1b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                << QVariant();  // out of range

    // negative integers
    QTest::newRow("-1") << raw("\x20") << QVariant(Q_INT64_C(-1));
    QTest::newRow("-2") << raw("\x21") << QVariant(Q_INT64_C(-2));
    QTest::newRow("-24") << raw("\x37") << QVariant(Q_INT64_C(-24));
    QTest::newRow("-25") << raw("\x38\x18") << QVariant(Q_INT64_C(-25));
    QTest::newRow("-UINT8_MAX") << raw("\x38\xff") << QVariant(Q_INT64_C(-256));
    QTest::newRow("-UINT8_MAX-1") << raw("\x39\x01\x00") << QVariant(Q_INT64_C(-257));
    QTest::newRow("-UINT16_MAX") << raw("\x39\xff\xff") << QVariant(Q_INT64_C(-65536));
    QTest::newRow("-UINT16_MAX-1") << raw("\x3a\0\1\x00\x00") << QVariant(Q_INT64_C(-65537));
    QTest::newRow("INT32_MIN") << raw("\x3a\x7f\xff\xff\xff") << QVariant(Q_INT64_C(-2147483648));
    QTest::newRow("INT32_MIN-1") << raw("\x3a\x80\x00\x00\x00") << QVariant(Q_INT64_C(-2147483649));
    QTest::newRow("-UINT32_MAX") << raw("\x3a\xff\xff\xff\xff") << QVariant(Q_INT64_C(-4294967296));
    QTest::newRow("-UINT32_MAX-1") << raw("\x3b\0\0\0\1\0\0\0\0") << QVariant(Q_INT64_C(-4294967297));
    QTest::newRow("INT64_MIN+1") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xfe")
                               << QVariant(std::numeric_limits<qint64>::min() + 1);
    QTest::newRow("INT64_MIN") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xff")
                               << QVariant(std::numeric_limits<qint64>::min());
    QTest::newRow("INT64_MIN-1") << raw("\x3b\x80\0\0\0""\0\0\0\0") << QVariant();  // out of range
    QTest::newRow("-UINT64_MAX") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xfe")
                                   << QVariant();   // out of range
    QTest::newRow("-UINT64_MAX+1") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                   << QVariant();   // out of range
}

void tst_Parser::checkedIntegers()
{
    QFETCH(QByteArray, data);
    QFETCH(QVariant, result);
    int64_t expected = result.toLongLong();

    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    int64_t v;
    err = cbor_value_get_int64_checked(&w.first, &v);
    if (result.isNull()) {
        QCOMPARE(err, CborErrorDataTooLarge);
    } else {
        QCOMPARE(v, expected);
    }

    int v2;
    err = cbor_value_get_int_checked(&w.first, &v2);
    if (result.isNull() || expected < std::numeric_limits<int>::min() || expected > std::numeric_limits<int>::max()) {
        QCOMPARE(err, CborErrorDataTooLarge);
    } else {
        QCOMPARE(int64_t(v2), expected);
    }
}

void tst_Parser::validationValid()
{
    // verify that all valid data validate properly
    QFETCH(QByteArray, data);

    QString decoded;
    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    QCOMPARE(cbor_value_validate_basic(&w.first), CborNoError);
    QCOMPARE(cbor_value_validate(&w.first, CborValidateBasic), CborNoError);
    QCOMPARE(cbor_value_validate(&w.first, CborValidateCompleteData), CborNoError);
}

void tst_Parser::validation_data()
{
    addValidationColumns();
    addValidationData();
}

void tst_Parser::validation()
{
    QFETCH(QByteArray, data);
    QFETCH(int, flags);
    QFETCH(CborError, expectedError);

    QString decoded;
    ParserWrapper w;
    CborError err = w.init(data, uint32_t(flags));
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    CborError err2 = cbor_value_validate_basic(&w.first);
    CborError err3 = cbor_value_validate(&w.first, CborValidateBasic);
    err = parseOne(&w.first, &decoded);
    QCOMPARE(err, expectedError);
    if (!QByteArray(QTest::currentDataTag()).contains("utf8")) {
        QCOMPARE(err2, expectedError);
        QCOMPARE(err3, expectedError);
    }

    // see if we've got a map
    if (QByteArray(QTest::currentDataTag()).startsWith("map")) {
        w.init(data, uint32_t(flags));      // reinit
        QVERIFY(cbor_value_is_array(&w.first));

        CborValue map;
        CborError err = cbor_value_enter_container(&w.first, &map);
        if (err == CborNoError) {
            QVERIFY(cbor_value_is_map(&map));
            CborValue element;
            err = cbor_value_map_find_value(&map, "foobar", &element);
            if (err == CborNoError)
                QVERIFY(!cbor_value_is_valid(&element));
        }

        QCOMPARE(err, expectedError);
    }
}

void tst_Parser::strictValidation_data()
{
    addValidationColumns();

    // Canonical validation - fixed types
    QTest::newRow("unsigned-0") << raw("\x00") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("unsigned-24") << raw("\x18\x18") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("unsigned-256") << raw("\x19\1\0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("unsigned-65536") << raw("\x1a\0\1\0\0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("unsigned-4294967296") << raw("\x1b\0\0\0\1\0\0\0\0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("overlong-unsigned-0*1") << raw("\x18\x00") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-0*2") << raw("\x19\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-0*4") << raw("\x1a\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-0*8") << raw("\x1b\0\0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-24*2") << raw("\x19\0\x18") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-24*4") << raw("\x1a\0\0\0\x18") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-24*8") << raw("\x1b\0\0\0\0\0\0\0\x18") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-256*4") << raw("\x1a\0\0\1\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-256*8") << raw("\x1b\0\0\0\0\0\0\1\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-unsigned-65536*8") << raw("\x1b\0\0\0\0\0\1\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("negative-1") << raw("\x20") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("negative-25") << raw("\x38\x38") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("negative-257") << raw("\x39\1\0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("negative-65537") << raw("\x3a\0\1\0\0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("negative-4294967297") << raw("\x3b\0\0\0\1\0\0\0\0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("overlong-negative-1*1") << raw("\x38\x00") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-1*2") << raw("\x39\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-1*4") << raw("\x3a\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-1*8") << raw("\x3b\0\0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-25*2") << raw("\x39\0\x18") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-25*4") << raw("\x3a\0\0\0\x18") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-25*8") << raw("\x3b\0\0\0\0\0\0\0\x18") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-257*4") << raw("\x3a\0\0\1\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-257*8") << raw("\x3b\0\0\0\0\0\0\1\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-negative-65537*8") << raw("\x3b\0\0\0\0\0\1\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("simple-0") << raw("\xe0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("false") << raw("\xf4") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("true") << raw("\xf5") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("null") << raw("\xf6") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("undefined") << raw("\xf7") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("simple-32") << raw("\xf8\x20") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("fp-nan") << raw("\xf9\x7e\00") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("fp--inf") << raw("\xf9\xfc\00") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("fp-+inf") << raw("\xf9\x7c\00") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("overlong-fp-nan_f") << raw("\xfa\x7f\xc0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-fp--inf_f") << raw("\xfa\xff\x80\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-fp-+inf_f") << raw("\xfa\x7f\x80\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-fp-nan") << raw("\xfb\x7f\xf8\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-fp--inf") << raw("\xfb\xff\xf0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-fp-+inf") << raw("\xfb\x7f\xf0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;

    // canonical - lengths
    QByteArray data24(24, 0x20);    // also decodes as -1
    QByteArray data256(256, 0x40);  // also decodes as h''
    QByteArray data65536(65536, 0x60);// also decodes as ""
    QTest::newRow("bytearray-0") << raw("\x40") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("bytearray-24") << (raw("\x58\x18") + data24) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("bytearray-256") << (raw("\x59\1\0") + data256) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("bytearray-65536") << (raw("\x5a\0\1\0\0") + data65536) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("_bytearray-0") << raw("\x5f\xff") << int(CborValidateCanonicalFormat) << CborErrorUnknownLength;
    QTest::newRow("overlong-bytearray-0*1") << raw("\x58\x00") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-0*2") << raw("\x59\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-0*4") << raw("\x5a\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-0*8") << raw("\x5b\0\0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-24*2") << (raw("\x59\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-24*4") << (raw("\x5a\0\0\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-24*8") << (raw("\x5b\0\0\0\0\0\0\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-256*4") << (raw("\x5a\0\0\1\0") + data256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-256*8") << (raw("\x5b\0\0\0\0\0\0\1\0") + data256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-bytearray-65536*8") << (raw("\x5b\0\0\0\0\0\1\0\0") + data65536) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("string-0") << raw("\x60") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("string-24") << (raw("\x78\x18") + data24) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("string-256") << (raw("\x79\1\0") + data256) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("string-65536") << (raw("\x7a\0\1\0\0") + data65536) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("_string-0") << raw("\x7f\xff") << int(CborValidateCanonicalFormat) << CborErrorUnknownLength;
    QTest::newRow("overlong-string-0*1") << raw("\x78\x00") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-0*2") << raw("\x79\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-0*4") << raw("\x7a\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-0*8") << raw("\x7b\0\0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-24*2") << (raw("\x79\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-24*4") << (raw("\x7a\0\0\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-24*8") << (raw("\x7b\0\0\0\0\0\0\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-256*4") << (raw("\x7a\0\0\1\0") + data256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-256*8") << (raw("\x7b\0\0\0\0\0\0\1\0") + data256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-string-65536*8") << (raw("\x7b\0\0\0\0\0\1\0\0") + data65536) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("array-0") << raw("\x80") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("array-24") << (raw("\x98\x18") + data24) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("array-256") << (raw("\x99\1\0") + data256) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("array-65536") << (raw("\x9a\0\1\0\0") + data65536) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("_array-0") << raw("\x9f\xff") << int(CborValidateCanonicalFormat) << CborErrorUnknownLength;
    QTest::newRow("overlong-array-0*1") << raw("\x98\x00") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-0*2") << raw("\x99\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-0*4") << raw("\x9a\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-0*8") << raw("\x9b\0\0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-24*2") << (raw("\x99\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-24*4") << (raw("\x9a\0\0\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-24*8") << (raw("\x9b\0\0\0\0\0\0\0\x18") + data24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-256*4") << (raw("\x9a\0\0\1\0") + data256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-256*8") << (raw("\x9b\0\0\0\0\0\0\1\0") + data256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-array-65536*8") << (raw("\x9b\0\0\0\0\0\1\0\0") + data65536) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;

    // we need unique, sorted, string keys for map
    // we'll make all key-value pairs a total of 4 bytes
    char mapentry[] = { 0x62, 0, 0, 0x20 };
    QByteArray mapdata24(24 * sizeof(mapentry), Qt::Uninitialized);
    QByteArray mapdata256(256 * sizeof(mapentry), Qt::Uninitialized);
    char *mapdata24ptr = mapdata24.data();
    char *mapdata256ptr = mapdata256.data();
    for (int i = 0; i < 256; ++i) {
        mapentry[1] = 'A' + (i >> 4);
        mapentry[2] = 'a' + (i & 0xf);
        memcpy(mapdata256ptr + i * sizeof(mapentry), mapentry, sizeof(mapentry));
        if (i < 24)
            memcpy(mapdata24ptr + i * sizeof(mapentry), mapentry, sizeof(mapentry));
    }
    QTest::newRow("map-0") << raw("\xa0") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("map-24") << (raw("\xb8\x18") + mapdata24) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("map-256") << (raw("\xb9\1\0") + mapdata256) << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("_map-0") << raw("\xbf\xff") << int(CborValidateCanonicalFormat) << CborErrorUnknownLength;
    QTest::newRow("overlong-map-0*1") << raw("\xb8\x00") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-0*2") << raw("\xb9\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-0*4") << raw("\xba\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-0*8") << raw("\xbb\0\0\0\0\0\0\0\0") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-24*2") << (raw("\xb9\0\x18") + mapdata24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-24*4") << (raw("\xba\0\0\0\x18") + mapdata24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-24*8") << (raw("\xbb\0\0\0\0\0\0\0\x18") + mapdata24) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-256*4") << (raw("\xba\0\0\1\0") + mapdata256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-map-256*8") << (raw("\xbb\0\0\0\0\0\0\1\0") + mapdata256) << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("unsorted-length-map-UU") << raw("\xa2\1\1\0\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;
    QTest::newRow("unsorted-length-map-UUU") << raw("\xa3\1\1\1\1\0\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;
    QTest::newRow("unsorted-length-map-SS") << raw("\xa2\x61z\1\x60\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;
    QTest::newRow("unsorted-length-map-SSS") << raw("\xa3\x61z\1\x61z\2\x60\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;
    QTest::newRow("unsorted-length-map-SB") << raw("\xa2\x61z\1\x40\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;
    QTest::newRow("unsorted-length-map-AS") << raw("\xa2\x83\0\x20\x45Hello\1\x60\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;
    QTest::newRow("unsorted-content-map-SS") << raw("\xa2\x61z\1\x61y\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;
    QTest::newRow("unsorted-content-map-AS") << raw("\xa2\x81\x21\1\x61\x21\0") << int(CborValidateCanonicalFormat) << CborErrorMapNotSorted;

    QTest::newRow("tag-0") << raw("\xc0\x60") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("tag-24") << raw("\xd8\x18\x40") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("tag-65536") << raw("\xda\0\1\0\0\x60") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("tag-4294967296") << raw("\xdb\0\0\0\1\0\0\0\0\x60") << int(CborValidateCanonicalFormat) << CborNoError;
    QTest::newRow("overlong-tag-0*1") << raw("\xd8\x00\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-0*2") << raw("\xd9\0\0\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-0*4") << raw("\xda\0\0\0\0\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-0*8") << raw("\xdb\0\0\0\0\0\0\0\0\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-24*2") << raw("\xd9\0\x18\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-24*4") << raw("\xda\0\0\0\x18\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-24*8") << raw("\xdb\0\0\0\0\0\0\0\x18\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-256*4") << raw("\xda\0\0\1\0\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-256*8") << raw("\xdb\0\0\0\0\0\0\1\0\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-tag-65536*8") << raw("\xdb\0\0\0\0\0\1\0\0\x60") << int(CborValidateCanonicalFormat) << CborErrorOverlongEncoding;

    // non-canonical: string length in chunked transfer
    QTest::newRow("overlong-_bytearray-0*1") << raw("\x5f\x58\x00\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-0*2") << raw("\x5f\x59\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-0*4") << raw("\x5f\x5a\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-0*8") << raw("\x5f\x5b\0\0\0\0\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-24*2") << (raw("\x5f\x59\0\x18") + data24 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-24*4") << (raw("\x5f\x5a\0\0\0\x18") + data24 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-24*8") << (raw("\x5f\x5b\0\0\0\0\0\0\0\x18") + data24 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-256*4") << (raw("\x5f\x5a\0\0\1\0") + data256 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-256*8") << (raw("\x5f\x5b\0\0\0\0\0\0\1\0") + data256 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearray-65536*8") << (raw("\x5f\x5b\0\0\0\0\0\1\0\0") + data65536 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearrayx2-0*1") << raw("\x5f\x40\x58\x00\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearrayx2-0*2") << raw("\x5f\x40\x59\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearrayx2-0*4") << raw("\x5f\x40\x5a\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_bytearrayx2-0*8") << raw("\x5f\x40\x5b\0\0\0\0\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-0*1") << raw("\x7f\x78\x00\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-0*2") << raw("\x7f\x79\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-0*4") << raw("\x7f\x7a\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-0*8") << raw("\x7f\x7b\0\0\0\0\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-24*2") << (raw("\x7f\x79\0\x18") + data24 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-24*4") << (raw("\x7f\x7a\0\0\0\x18") + data24 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-24*8") << (raw("\x7f\x7b\0\0\0\0\0\0\0\x18") + data24 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-256*4") << (raw("\x7f\x7a\0\0\1\0") + data256 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-256*8") << (raw("\x7f\x7b\0\0\0\0\0\0\1\0") + data256 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_string-65536*8") << (raw("\x7f\x7b\0\0\0\0\0\1\0\0") + data65536 + '\xff') << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_stringx2-0*1") << raw("\x7f\x60\x78\x00\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_stringx2-0*2") << raw("\x7f\x60\x79\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_stringx2-0*4") << raw("\x7f\x60\x7a\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;
    QTest::newRow("overlong-_stringx2-0*8") << raw("\x7f\x60\x7b\0\0\0\0\0\0\0\0\xff") << int(CborValidateShortestNumbers) << CborErrorOverlongEncoding;

    // strict mode
    // UTF-8 sequences with invalid continuation bytes
    QTest::newRow("invalid-utf8-bad-continuation-1char") << raw("\x61\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-2chars-1") << raw("\x62\xc2\xc0") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-2chars-2") << raw("\x62\xc3\xdf") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-2chars-3") << raw("\x62\xc7\xf0") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-3chars-1") << raw("\x63\xe0\xa0\xc0") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-3chars-2") << raw("\x63\xe0\xc0\xa0") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-4chars-1") << raw("\x64\xf0\x90\x80\xc0") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-4chars-2") << raw("\x64\xf0\x90\xc0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-bad-continuation-4chars-3") << raw("\x64\xf0\xc0\x80\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    // Too short UTF-8 sequences (in an array so there's a byte after that would make it valid UTF-8 if it were part of the string)
    QTest::newRow("invalid-utf8-too-short-2chars") << raw("\x82\x61\xc2\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-too-short-3chars-1") << raw("\x82\x61\xe0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-too-short-3chars-2") << raw("\x82\x62\xe0\xa0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-too-short-4chars-1") << raw("\x82\x61\xf0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-too-short-4chars-2") << raw("\x82\x62\xf0\x90\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-too-short-4chars-3") << raw("\x82\x63\xf0\x90\x80\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    // UTF-16 surrogages encoded in UTF-8
    QTest::newRow("invalid-utf8-hi-surrogate") << raw("\x63\xed\xa0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-lo-surrogate") << raw("\x63\xed\xb0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-surrogate-pair") << raw("\x66\xed\xa0\x80\xed\xb0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    // Non-Unicode UTF-8 sequences
    QTest::newRow("invalid-utf8-non-unicode-1") << raw("\x64\xf4\x90\x80\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-non-unicode-2") << raw("\x65\xf8\x88\x80\x80\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-non-unicode-3") << raw("\x66\xfc\x84\x80\x80\x80\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-non-unicode-4") << raw("\x66\xfd\xbf\xbf\xbf\xbf\xbf") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    // invalid bytes in UTF-8
    QTest::newRow("invalid-utf8-fe") << raw("\x61\xfe") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-ff") << raw("\x61\xff") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    // Overlong sequences
    QTest::newRow("invalid-utf8-overlong-1-2") << raw("\x62\xc1\x81") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-1-3") << raw("\x63\xe0\x81\x81") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-1-4") << raw("\x64\xf0\x80\x81\x81") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-1-5") << raw("\x65\xf8\x80\x80\x81\x81") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-1-6") << raw("\x66\xfc\x80\x80\x80\x81\x81") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-2-3") << raw("\x63\xe0\x82\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-2-4") << raw("\x64\xf0\x80\x82\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-2-5") << raw("\x65\xf8\x80\x80\x82\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-2-6") << raw("\x66\xfc\x80\x80\x80\x82\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-3-4") << raw("\x64\xf0\x80\xa0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-3-5") << raw("\x65\xf8\x80\x80\xa0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-3-6") << raw("\x66\xfc\x80\x80\x80\xa0\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-4-5") << raw("\x65\xf8\x80\x84\x80\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;
    QTest::newRow("invalid-utf8-overlong-4-6") << raw("\x66\xfc\x80\x80\x84\x80\x80") << int(CborValidateStrictMode) << CborErrorInvalidUtf8TextString;

    QTest::newRow("nonunique-content-map-UU") << raw("\xa2\0\1\0\2") << int(CborValidateStrictMode) << CborErrorMapKeysNotUnique;
    QTest::newRow("nonunique-content-map-SS") << raw("\xa2\x61z\1\x61z\2") << int(CborValidateStrictMode) << CborErrorMapKeysNotUnique;
    QTest::newRow("nonunique-content-map-AA") << raw("\xa2\x81\x65Hello\1\x81\x65Hello\2") << int(CborValidateStrictMode) << CborErrorMapKeysNotUnique;

    QTest::newRow("tag-0-unsigned") << raw("\xc0\x00") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-0-bytearray") << raw("\xc0\x40") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-0-string") << raw("\xc0\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-0-tag-0-string") << raw("\xc0\xc0\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-1-unsigned") << raw("\xc1\x00") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-1-negative") << raw("\xc1\x20") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-1-bytearray") << raw("\xc1\x40") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-2-bytearray") << raw("\xc2\x40") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-2-string") << raw("\xc2\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-3-bytearray") << raw("\xc3\x40") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-3-string") << raw("\xc3\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-4-string") << raw("\xc4\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-4-array") << raw("\xc4\x82\0\1") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-5-string") << raw("\xc5\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-5-array") << raw("\xc5\x82\0\1") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-21-bytearray") << raw("\xd5\x40") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-21-string") << raw("\xd5\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-21-array") << raw("\xd5\x80") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-21-map") << raw("\xd5\xa0") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-22-bytearray") << raw("\xd6\x40") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-22-string") << raw("\xd6\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-22-array") << raw("\xd6\x80") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-22-map") << raw("\xd6\xa0") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-23-bytearray") << raw("\xd7\x40") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-23-string") << raw("\xd7\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-23-array") << raw("\xd7\x80") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-23-map") << raw("\xd7\xa0") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-24-bytearray") << raw("\xd8\x18\x40") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-24-string") << raw("\xd8\x18\x60") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-32-bytearray") << raw("\xd8\x20\x40") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-32-string") << raw("\xd8\x20\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-33-bytearray") << raw("\xd8\x21\x40") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-33-string") << raw("\xd8\x21\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-34-bytearray") << raw("\xd8\x22\x40") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-34-string") << raw("\xd8\x22\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-35-bytearray") << raw("\xd8\x23\x40") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-35-string") << raw("\xd8\x23\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-36-bytearray") << raw("\xd8\x24\x40") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-36-string") << raw("\xd8\x24\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-unsigned") << raw("\xd9\xd9\xf7\x00") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-negative") << raw("\xd9\xd9\xf7\x20") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-bytearray") << raw("\xd9\xd9\xf7\x40") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-string") << raw("\xd9\xd9\xf7\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-array") << raw("\xd9\xd9\xf7\x80") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-map") << raw("\xd9\xd9\xf7\xa0") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-tag-0-unsigned") << raw("\xd9\xd9\xf7\xc0\x00") << int(CborValidateStrictMode) << CborErrorInappropriateTagForType;
    QTest::newRow("tag-55799-tag-0-string") << raw("\xd9\xd9\xf7\xc0\x60") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-simple0") << raw("\xd9\xd9\xf7\xe0") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-false") << raw("\xd9\xd9\xf7\xf4") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-true") << raw("\xd9\xd9\xf7\xf5") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-null") << raw("\xd9\xd9\xf7\xf6") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-undefined") << raw("\xd9\xd9\xf7\xf7") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-simple32") << raw("\xd9\xd9\xf7\xf8\x20") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-half") << raw("\xd9\xd9\xf7\xf9\0\0") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-float") << raw("\xd9\xd9\xf7\xfa\0\0\0\0") << int(CborValidateStrictMode) << CborNoError;
    QTest::newRow("tag-55799-double") << raw("\xd9\xd9\xf7\xfb\0\0\0\0\0\0\0\0") << int(CborValidateStrictMode) << CborNoError;

    // excluded non-finite
    QTest::newRow("excluded-fp-nan") << raw("\xfb\x7f\xf8\0\0\0\0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-nan_f") << raw("\xfa\x7f\xc0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp--inf_f") << raw("\xfa\xff\x80\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp--inf") << raw("\xfb\xff\xf0\0\0\0\0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-+inf_f") << raw("\xfa\x7f\x80\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-+inf") << raw("\xfb\x7f\xf0\0\0\0\0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;

    // excluded undefined
    QTest::newRow("no-undefined") << raw("\xf7") << int(CborValidateNoUndefined) << CborErrorExcludedType;

    // exclude non-finite
    QTest::newRow("excluded-fp-nan_f16") << raw("\xf9\x7e\00") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp--inf_f16") << raw("\xf9\xfc\00") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-+inf_f16") << raw("\xf9\x7c\00") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-nan_f") << raw("\xfa\x7f\xc0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp--inf_f") << raw("\xfa\xff\x80\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-+inf_f") << raw("\xfa\x7f\x80\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-nan") << raw("\xfb\x7f\xf8\0\0\0\0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp--inf") << raw("\xfb\xff\xf0\0\0\0\0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;
    QTest::newRow("excluded-fp-+inf") << raw("\xfb\x7f\xf0\0\0\0\0\0\0") << int(CborValidateFiniteFloatingPoint) << CborErrorExcludedValue;

    // exclude non-string keys in maps
    QTest::newRow("excluded-map-unsigned") << raw("\xa1\x00\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-negative") << raw("\xa1\x20\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-bytearray") << raw("\xa1\x40\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("map-string") << raw("\xa1\x60\1") << int(CborValidateMapKeysAreString) << CborNoError;
    QTest::newRow("map-tag-0-string") << raw("\xa1\xc0\x60\1") << int(CborValidateMapKeysAreString) << CborNoError;
    QTest::newRow("excluded-map-array") << raw("\xa1\x80\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-map") << raw("\xa1\xa0\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-simple-0") << raw("\xa1\xe0\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-false") << raw("\xa1\xf4\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-true") << raw("\xa1\xf5\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-null") << raw("\xa1\xf6\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-undefined") << raw("\xa1\xf7\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-half") << raw("\xa1\xf9\0\0\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-float") << raw("\xa1\xfa\0\0\0\0\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;
    QTest::newRow("excluded-map-double") << raw("\xa1\xfb\0\0\0\0\0\0\0\0\1") << int(CborValidateMapKeysAreString) << CborErrorMapKeyNotString;

    // unknown simple types
    QTest::newRow("unknown-simple-type-0") << raw("\xe0") << int(CborValidateNoUnknownSimpleTypes) << CborErrorUnknownSimpleType;
    QTest::newRow("unknown-simple-type-32") << raw("\xf8\x20") << int(CborValidateNoUnknownSimpleTypes) << CborErrorUnknownSimpleType;
    QTest::newRow("allowed-simple-type-32") << raw("\xf8\x20") << int(CborValidateNoUnknownSimpleTypesSA) << CborNoError;

    // unknown tags
    QTest::newRow("unknown-tag-6") << raw("\xc6\x60") << int(CborValidateNoUnknownTags) << CborErrorUnknownTag;
    QTest::newRow("unknown-tag-31") << raw("\xd8\x1f\x60") << int(CborValidateNoUnknownTags) << CborErrorUnknownTag;
    QTest::newRow("unknown-tag-256") << raw("\xd9\1\0\x60") << int(CborValidateNoUnknownTags) << CborErrorUnknownTag;
    QTest::newRow("unknown-tag-65536") << raw("\xda\0\1\0\0\x60") << int(CborValidateNoUnknownTags) << CborErrorUnknownTag;
    QTest::newRow("unknown-tag-4294967296") << raw("\xdb\0\0\0\1\0\0\0\0\x60") << int(CborValidateNoUnknownTags) << CborErrorUnknownTag;
    QTest::newRow("allowed-tag-31") << raw("\xd8\x1f\x60") << int(CborValidateNoUnknownTagsSA) << CborNoError;
    QTest::newRow("allowed-tag-256") << raw("\xd9\1\0\x60") << int(CborValidateNoUnknownTagsSR) << CborNoError;

    // excluded tags
    QTest::newRow("excluded-tag-0") << raw("\xc0\x60") << int(CborValidateNoTags) << CborErrorExcludedType;
    QTest::newRow("excluded-tag-24") << raw("\xd8\x18\x40") << int(CborValidateNoTags) << CborErrorExcludedType;
    QTest::newRow("excluded-tag-55799") << raw("\xd9\xd9\xf7\x60") << int(CborValidateNoTags) << CborErrorExcludedType;

    // complete data
    QTest::newRow("garbage-data-0") << raw("\0\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-1") << raw("\x20\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-2") << raw("\x40\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-3") << raw("\x60\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-4") << raw("\x80\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-5") << raw("\xa0\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-6") << raw("\xc0\x60\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-7") << raw("\xf4\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-f16") << raw("\xf9\0\0\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-f32") << raw("\xfa\0\0\0\0\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
    QTest::newRow("garbage-data-f64") << raw("\xfb\0\0\0\0\0\0\0\0\1") << int(CborValidateCompleteData) << CborErrorGarbageAtEnd;
}

void tst_Parser::strictValidation()
{
    QFETCH(QByteArray, data);
    QFETCH(int, flags);
    QFETCH(CborError, expectedError);

    QString decoded;
    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    err = cbor_value_validate(&w.first, flags);
    QCOMPARE(err, expectedError);
}

void tst_Parser::incompleteData_data()
{
    addColumns();
    addFixedData();
    addStringsData();
    addTagsData();
    addMapMixedData();
}

void tst_Parser::incompleteData()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    for (int len = 0; len < data.length() - 1; ++len) {
        ParserWrapper w;
        CborError err = w.init(data.constData(), len);
        if (!err) {
            QString decoded;
            err = parseOne(&w.first, &decoded);
        }
        if (err != CborErrorUnexpectedEOF)
            qDebug() << "Length is" << len;
        QCOMPARE(err, CborErrorUnexpectedEOF);
    }
}

void tst_Parser::endPointer_data()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<int>("offset");

    QTest::newRow("number1") << raw("\x81\x01\x01") << 2;
    QTest::newRow("number24") << raw("\x81\x18\x18\x01") << 3;
    QTest::newRow("string") << raw("\x81\x61Z\x01") << 3;
    QTest::newRow("indefinite-string") << raw("\x81\x7f\x61Z\xff\x01") << 5;
    QTest::newRow("array") << raw("\x81\x02\x01") << 2;
    QTest::newRow("indefinite-array") << raw("\x81\x9f\x02\xff\x01") << 4;
    QTest::newRow("object") << raw("\x81\xa1\x03\x02\x01") << 4;
    QTest::newRow("indefinite-object") << raw("\x81\xbf\x03\x02\xff\x01") << 5;
}

void tst_Parser::endPointer()
{
    QFETCH(QByteArray, data);
    QFETCH(int, offset);

    QString decoded;
    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    err = parseOne(&w.first, &decoded);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    QCOMPARE(int(cbor_value_get_next_byte(&w.first) - w.begin()), offset);
}

void tst_Parser::recursionLimit_data()
{
    static const int recursions = CBOR_PARSER_MAX_RECURSIONS + 2;
    QTest::addColumn<QByteArray>("data");

    QTest::newRow("array") << QByteArray(recursions, '\x81') + '\x20';
    QTest::newRow("_array") << QByteArray(recursions, '\x9f') + '\x20' + QByteArray(recursions, '\xff');

    QByteArray data;
    for (int i = 0; i < recursions; ++i)
        data += "\xa1\x65Hello";
    data += '\2';
    QTest::newRow("map-recursive-values") << data;

    data.clear();
    for (int i = 0; i < recursions; ++i)
        data += "\xbf\x65World";
    data += '\2';
    for (int i = 0; i < recursions; ++i)
        data += "\xff";
    QTest::newRow("_map-recursive-values") << data;

    data = QByteArray(recursions, '\xa1');
    data += '\2';
    for (int i = 0; i < recursions; ++i)
        data += "\x7f\x64quux\xff";
    QTest::newRow("map-recursive-keys") << data;

    data = QByteArray(recursions, '\xbf');
    data += '\2';
    for (int i = 0; i < recursions; ++i)
        data += "\1\xff";
    QTest::newRow("_map-recursive-keys") << data;

    data.clear();
    for (int i = 0; i < recursions / 2; ++i)
        data += "\x81\xa1\1";
    data += '\2';
    QTest::newRow("mixed") << data;
}

void tst_Parser::recursionLimit()
{
    QFETCH(QByteArray, data);

    ParserWrapper w;
    CborError err = w.init(data);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    // check that it is valid:
    CborValue it = w.first;
    {
        QString dummy;
        err = parseOne(&it, &dummy);
        QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");
    }

    it = w.first;
    err = cbor_value_advance(&it);
    QCOMPARE(err, CborErrorNestingTooDeep);

    it = w.first;
    if (cbor_value_is_map(&it)) {
        CborValue dummy;
        err = cbor_value_map_find_value(&it, "foo", &dummy);
        QCOMPARE(err, CborErrorNestingTooDeep);
    }
}

QTEST_MAIN(tst_Parser)
#include "tst_parser.moc"
