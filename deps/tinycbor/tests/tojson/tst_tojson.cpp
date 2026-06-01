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

#define __STDC_WANT_IEC_60559_TYPES_EXT__
#include <QtTest>
#include "cbor.h"
#include "cborinternal_p.h"
#include "cborjson.h"
#include <locale.h>

extern "C" FILE *open_memstream(char **bufptr, size_t *sizeptr);

class tst_ToJson : public QObject
{
    Q_OBJECT
private slots:
    void initTestCase();

    void fixed_data();
    void fixed();
    void textstrings_data();
    void textstrings() { fixed(); }
    void nonjson_data();
    void nonjson() { fixed(); }
    void bytestrings_data();
    void bytestrings() { fixed(); }
    void emptyContainers_data();
    void emptyContainers() { fixed(); }
    void arrays_data();
    void arrays();
    void nestedArrays_data() { arrays_data(); }
    void nestedArrays();
    void maps_data() { arrays_data(); }
    void maps();
    void nestedMaps_data() { maps_data(); }
    void nestedMaps();
    void nonStringKeyMaps_data();
    void nonStringKeyMaps();

    void tagsToObjects_data();
    void tagsToObjects();
    void taggedByteStringsToBase16_data();
    void taggedByteStringsToBase16();
    void taggedByteStringsToBase64_data() { taggedByteStringsToBase16_data(); }
    void taggedByteStringsToBase64();
    void taggedByteStringsToBase64url_data() { taggedByteStringsToBase16_data(); }
    void taggedByteStringsToBase64url();
    void taggedByteStringsToBigNum_data()  { taggedByteStringsToBase16_data(); }
    void taggedByteStringsToBigNum();
    void otherTags_data();
    void otherTags();

    void metaData_data();
    void metaData();
    void metaDataAndTagsToObjects_data() { tagsToObjects_data(); }
    void metaDataAndTagsToObjects();
    void metaDataForKeys_data();
    void metaDataForKeys();

    void recursionLimit_data();
    void recursionLimit();
};
#include "tst_tojson.moc"

template <size_t N> QByteArray raw(const char (&data)[N])
{
    return QByteArray::fromRawData(data, N - 1);
}

void addColumns()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<QString>("expected");
}

void addFixedData()
{
    // unsigned integers
    QTest::newRow("0") << raw("\x00") << "0";
    QTest::newRow("1") << raw("\x01") << "1";
    QTest::newRow("2^53-1") << raw("\x1b\0\x1f\xff\xff""\xff\xff\xff\xff") << "9007199254740991";
    QTest::newRow("2^53+1") << raw("\x1b\0\x20\0\0""\0\0\0\1") << "9007199254740993";
    QTest::newRow("2^63-1") << raw("\x1b\x7f\xff\xff\xff""\xff\xff\xff\xff") << "9223372036854775807";
    QTest::newRow("2^64-1") << raw("\x1b\xff\xff\xff\xff""\xff\xff\xff\xff") << "18446744073709551615";

    // negative integers
    QTest::newRow("-1") << raw("\x20") << "-1";
    QTest::newRow("-2") << raw("\x21") << "-2";
    QTest::newRow("-2^53+1") << raw("\x3b\0\x1f\xff\xff""\xff\xff\xff\xfe") << "-9007199254740991";
    QTest::newRow("-2^53-1") << raw("\x3b\0\x20\0\0""\0\0\0\0") << "-9007199254740993";
    QTest::newRow("-2^63+1") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xfe") << "-9223372036854775807";
    QTest::newRow("-2^63") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xff") << "-9223372036854775808";
    QTest::newRow("-2^63-1") << raw("\x3b\x80\0\0\0""\0\0\0\0") << "-9223372036854775809";
    QTest::newRow("-2^64+1") << raw("\x3b\xff\xff\xff\xff""\xff\xff\xff\xfe") << "-18446744073709551615";
    QTest::newRow("-2^64") << raw("\x3b\xff\xff\xff\xff""\xff\xff\xff\xff") << "-18446744073709551616";

    QTest::newRow("false") << raw("\xf4") << "false";
    QTest::newRow("true") << raw("\xf5") << "true";
    QTest::newRow("null") << raw("\xf6") << "null";

    QTest::newRow("0.f16") << raw("\xf9\0\0") << "0";
    QTest::newRow("0.f") << raw("\xfa\0\0\0\0") << "0";
    QTest::newRow("0.")  << raw("\xfb\0\0\0\0\0\0\0\0") << "0";
    QTest::newRow("-1.f16") << raw("\xf9\xbc\x00") << "-1";
    QTest::newRow("-1.f") << raw("\xfa\xbf\x80\0\0") << "-1";
    QTest::newRow("-1.") << raw("\xfb\xbf\xf0\0\0\0\0\0\0") << "-1";
    QTest::newRow("16777215.f") << raw("\xfa\x4b\x7f\xff\xff") << "16777215";
    QTest::newRow("16777215.") << raw("\xfb\x41\x6f\xff\xff\xe0\0\0\0") << "16777215";
    QTest::newRow("-16777215.f") << raw("\xfa\xcb\x7f\xff\xff") << "-16777215";
    QTest::newRow("-16777215.") << raw("\xfb\xc1\x6f\xff\xff\xe0\0\0\0") << "-16777215";

    QTest::newRow("0.5f16") << raw("\xf9\x38\0") << "0.5";
    QTest::newRow("0.5f") << raw("\xfa\x3f\0\0\0") << "0.5";
    QTest::newRow("0.5") << raw("\xfb\x3f\xe0\0\0\0\0\0\0") << "0.5";
    QTest::newRow("2.f^24-1") << raw("\xfa\x4b\x7f\xff\xff") << "16777215";
    QTest::newRow("2.^53-1") << raw("\xfb\x43\x3f\xff\xff""\xff\xff\xff\xff") << "9007199254740991";
    QTest::newRow("2.f^64-epsilon") << raw("\xfa\x5f\x7f\xff\xff") << "18446742974197923840";
    QTest::newRow("2.^64-epsilon") << raw("\xfb\x43\xef\xff\xff""\xff\xff\xff\xff") << "18446744073709549568";
    QTest::newRow("2.f^64") << raw("\xfa\x5f\x80\0\0") << "1.8446744073709552e+19";
    QTest::newRow("2.^64") << raw("\xfb\x43\xf0\0\0\0\0\0\0") << "1.8446744073709552e+19";

    // infinities and NaN are not supported in JSON, they convert to null
    QTest::newRow("nan_f16") << raw("\xf9\x7e\x00") << "null";
    QTest::newRow("nan_f") << raw("\xfa\x7f\xc0\0\0") << "null";
    QTest::newRow("nan") << raw("\xfb\x7f\xf8\0\0\0\0\0\0") << "null";
    QTest::newRow("-inf_f") << raw("\xfa\xff\x80\0\0") << "null";
    QTest::newRow("-inf_f16") << raw("\xf9\xfc\x00") << "null";
    QTest::newRow("-inf") << raw("\xfb\xff\xf0\0\0\0\0\0\0") << "null";
    QTest::newRow("+inf_f") << raw("\xfa\x7f\x80\0\0") << "null";
    QTest::newRow("+inf_f16") << raw("\xf9\x7c\x00") << "null";
    QTest::newRow("+inf") << raw("\xfb\x7f\xf0\0\0\0\0\0\0") << "null";
}

void addTextStringsData()
{
    QTest::newRow("emptytextstring") << raw("\x60") << "\"\"";
    QTest::newRow("textstring1") << raw("\x61 ") << "\" \"";
    QTest::newRow("textstring5") << raw("\x65Hello") << "\"Hello\"";
    QTest::newRow("textstring24") << raw("\x78\x18""123456789012345678901234")
                                  << "\"123456789012345678901234\"";
    QTest::newRow("textstring256") << raw("\x79\1\0") + QByteArray(256, '3')
                                   << '"' + QString(256, '3') + '"';

    // strings with undefined length
    QTest::newRow("_emptytextstring") << raw("\x7f\xff") << "\"\"";
    QTest::newRow("_emptytextstring2") << raw("\x7f\x60\xff") << "\"\"";
    QTest::newRow("_emptytextstring3") << raw("\x7f\x60\x60\xff") << "\"\"";
    QTest::newRow("_textstring5*2") << raw("\x7f\x63Hel\x62lo\xff") << "\"Hello\"";
    QTest::newRow("_textstring5*5") << raw("\x7f\x61H\x61""e\x61l\x61l\x61o\xff") << "\"Hello\"";
    QTest::newRow("_textstring5*6") << raw("\x7f\x61H\x61""e\x61l\x60\x61l\x61o\xff") << "\"Hello\"";

    // strings containing characters that are escaped in JSON
    QTest::newRow("null") << raw("\x61\0") << R"("\u0000")";
    QTest::newRow("bell") << raw("\x61\7") << R"("\u0007")";    // not \\a
    QTest::newRow("backspace") << raw("\x61\b") << R"("\b")";
    QTest::newRow("tab") << raw("\x61\t") << R"("\t")";
    QTest::newRow("carriage-return") << raw("\x61\r") << R"("\r")";
    QTest::newRow("line-feed") << raw("\x61\n") << R"("\n")";
    QTest::newRow("form-feed") << raw("\x61\f") << R"("\f")";
    QTest::newRow("esc") << raw("\x61\x1f") << R"("\u001f")";
    QTest::newRow("quote") << raw("\x61\"") << R"("\"")";
    QTest::newRow("backslash") << raw("\x61\\") << R"("\\")";
}

void addNonJsonData()
{
    QTest::newRow("undefined") << raw("\xf7") << "\"undefined\"";
    QTest::newRow("simple0") << raw("\xe0") << "\"simple(0)\"";
    QTest::newRow("simple19") << raw("\xf3") << "\"simple(19)\"";
    QTest::newRow("simple32") << raw("\xf8\x20") << "\"simple(32)\"";
    QTest::newRow("simple255") << raw("\xf8\xff") << "\"simple(255)\"";
}

void addByteStringsData()
{
    QTest::newRow("emptybytestring") << raw("\x40") << "\"\"";
    QTest::newRow("bytestring1") << raw("\x41 ") << "\"IA\"";
    QTest::newRow("bytestring1-nul") << raw("\x41\0") << "\"AA\"";
    QTest::newRow("bytestring2") << raw("\x42Hi") << "\"SGk\"";
    QTest::newRow("bytestring3") << raw("\x43Hey") << "\"SGV5\"";
    QTest::newRow("bytestring4") << raw("\x44Hola") << "\"SG9sYQ\"";
    QTest::newRow("bytestring5") << raw("\x45Hello") << "\"SGVsbG8\"";
    QTest::newRow("bytestring24") << raw("\x58\x18""123456789012345678901234")
                                  << "\"MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0\"";

    // strings with undefined length
    QTest::newRow("_emptybytestring") << raw("\x5f\xff") << "\"\"";
    QTest::newRow("_emptybytestring2") << raw("\x5f\x40\xff") << "\"\"";
    QTest::newRow("_emptybytestring3") << raw("\x5f\x40\x40\xff") << "\"\"";
    QTest::newRow("_bytestring5*2") << raw("\x5f\x43Hel\x42lo\xff") << "\"SGVsbG8\"";
    QTest::newRow("_bytestring5*5") << raw("\x5f\x41H\x41""e\x41l\x41l\x41o\xff") << "\"SGVsbG8\"";
    QTest::newRow("_bytestring5*6") << raw("\x5f\x41H\x41""e\x40\x41l\x41l\x41o\xff") << "\"SGVsbG8\"";
}

void addEmptyContainersData()
{
    QTest::newRow("emptyarray") << raw("\x80") << "[]";
    QTest::newRow("emptymap") << raw("\xa0") << "{}";
    QTest::newRow("_emptyarray") << raw("\x9f\xff") << "[]";
    QTest::newRow("_emptymap") << raw("\xbf\xff") << "{}";
}

CborError parseOne(CborValue *it, QString *parsed, int flags)
{
    char *buffer;
    size_t size;

    FILE *f = open_memstream(&buffer, &size);
    CborError err = cbor_value_to_json_advance(f, it, flags);
    fclose(f);

    *parsed = QString::fromLatin1(buffer);
    free(buffer);
    return err;
}

bool compareFailed = true;
void compareOne_real(const QByteArray &data, const QString &expected, int flags, int line)
{
    compareFailed = true;
    CborParser parser;
    CborValue first;
    CborError err = cbor_parser_init(reinterpret_cast<const quint8 *>(data.constData()), data.length(), 0, &parser, &first);
    QVERIFY2(!err, QByteArray::number(line) + ": Got error \"" + cbor_error_string(err) + "\"");

    QString decoded;
    err = parseOne(&first, &decoded, flags);
    QVERIFY2(!err, QByteArray::number(line) + ": Got error \"" + cbor_error_string(err) +
                   "\"; decoded stream:\n" + decoded.toLatin1());
    QCOMPARE(decoded, expected);

    // check that we consumed everything
    QCOMPARE((void*)cbor_value_get_next_byte(&first), (void*)data.constEnd());

    compareFailed = false;
}
#define compareOne(data, expected, flags) \
    compareOne_real(data, expected, flags, __LINE__); \
    if (compareFailed) return

void tst_ToJson::initTestCase()
{
    setlocale(LC_ALL, "C");
}

void tst_ToJson::fixed_data()
{
    addColumns();
    addFixedData();
}

void tst_ToJson::fixed()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne(data, expected, 0);
}

void tst_ToJson::textstrings_data()
{
    addColumns();
    addTextStringsData();
}

void tst_ToJson::nonjson_data()
{
    addColumns();
    addNonJsonData();
}

void tst_ToJson::bytestrings_data()
{
    addColumns();
    addByteStringsData();
}

void tst_ToJson::emptyContainers_data()
{
    addColumns();
    addEmptyContainersData();
}

void tst_ToJson::arrays_data()
{
    addColumns();
    addFixedData();
    addTextStringsData();
    addNonJsonData();
    addByteStringsData();
}

void tst_ToJson::arrays()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne("\x81" + data, '[' + expected + ']', 0);
    compareOne("\x82" + data + data, '[' + expected + ',' + expected + ']', 0);
}

void tst_ToJson::nestedArrays()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne("\x81\x81" + data, "[[" + expected + "]]", 0);
    compareOne("\x81\x81\x81" + data, "[[[" + expected + "]]]", 0);
    compareOne("\x81\x82" + data + data, "[[" + expected + ',' + expected + "]]", 0);
    compareOne("\x82\x81" + data + data, "[[" + expected + "]," + expected + "]", 0);
    compareOne("\x82\x81" + data + '\x81' + data, "[[" + expected + "],[" + expected + "]]", 0);
}

void tst_ToJson::maps()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne("\xa1\x65" "Hello" + data, "{\"Hello\":" + expected + '}', 0);
}

void tst_ToJson::nestedMaps()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne("\xa1\x65Hello\xa1\x65World" + data, "{\"Hello\":{\"World\":" + expected + "}}", 0);
//    compareOne("\xa1\x63""foo\xa1\63""bar" + data + "\63""baz\xa1\x64quux" + data,
//               "{\"foo\":{\"bar\":" + expected + "},\"baz\":{\"quux\":" + expected + "}", 0);
}

void tst_ToJson::nonStringKeyMaps_data()
{
    addColumns();

    QTest::newRow("0") << raw("\x00") << "0";
    QTest::newRow("1") << raw("\x01") << "1";
    QTest::newRow("UINT32_MAX") << raw("\x1a\xff\xff\xff\xff") << "4294967295";
    QTest::newRow("UINT32_MAX+1") << raw("\x1b\0\0\0\1\0\0\0\0") << "4294967296";
    QTest::newRow("UINT64_MAX") << raw("\x1b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                << QString::number(std::numeric_limits<uint64_t>::max());

    QTest::newRow("-1") << raw("\x20") << "-1";
    QTest::newRow("-UINT32_MAX") << raw("\x3a\xff\xff\xff\xff") << "-4294967296";
    QTest::newRow("-UINT32_MAX-1") << raw("\x3b\0\0\0\1\0\0\0\0") << "-4294967297";
    QTest::newRow("-UINT64_MAX") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xfe")
                                 << '-' + QString::number(std::numeric_limits<uint64_t>::max());
    QTest::newRow("-UINT64_MAX-1") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                 << "-18446744073709551616";

    QTest::newRow("simple0") << raw("\xe0") << "simple(0)";
    QTest::newRow("simple19") << raw("\xf3") << "simple(19)";
    QTest::newRow("false") << raw("\xf4") << "false";
    QTest::newRow("true") << raw("\xf5") << "true";
    QTest::newRow("null") << raw("\xf6") << "null";
    QTest::newRow("undefined") << raw("\xf7") << "undefined";
    QTest::newRow("simple32") << raw("\xf8\x20") << "simple(32)";
    QTest::newRow("simple255") << raw("\xf8\xff") << "simple(255)";

    QTest::newRow("0.f16") << raw("\xf9\0\0") << "0.f16";
    QTest::newRow("0.f") << raw("\xfa\0\0\0\0") << "0.f";
    QTest::newRow("0.")  << raw("\xfb\0\0\0\0\0\0\0\0") << "0.";
    QTest::newRow("-1.f16") << raw("\xf9\xbc\x00") << "-1.f16";
    QTest::newRow("-1.f") << raw("\xfa\xbf\x80\0\0") << "-1.f";
    QTest::newRow("-1.") << raw("\xfb\xbf\xf0\0\0\0\0\0\0") << "-1.";
    QTest::newRow("65504.f16") << raw("\xf9\x7b\xff") << "65504.f16";
    QTest::newRow("16777215.f") << raw("\xfa\x4b\x7f\xff\xff") << "16777215.f";
    QTest::newRow("16777215.") << raw("\xfb\x41\x6f\xff\xff\xe0\0\0\0") << "16777215.";
    QTest::newRow("-16777215.f") << raw("\xfa\xcb\x7f\xff\xff") << "-16777215.f";
    QTest::newRow("-16777215.") << raw("\xfb\xc1\x6f\xff\xff\xe0\0\0\0") << "-16777215.";

    QTest::newRow("0.5f16") << raw("\xf9\x38\0") << "0.5f16";
    QTest::newRow("0.5f") << raw("\xfa\x3f\0\0\0") << "0.5f";
    QTest::newRow("0.5") << raw("\xfb\x3f\xe0\0\0\0\0\0\0") << "0.5";
    QTest::newRow("2.f16^11-1") << raw("\xf9\x67\xff") << "2047.f16";
    QTest::newRow("2.f^24-1") << raw("\xfa\x4b\x7f\xff\xff") << "16777215.f";
    QTest::newRow("2.^53-1") << raw("\xfb\x43\x3f\xff\xff""\xff\xff\xff\xff") << "9007199254740991.";
    QTest::newRow("2.f^64-epsilon") << raw("\xfa\x5f\x7f\xff\xff") << "18446742974197923840.f";
    QTest::newRow("2.^64-epsilon") << raw("\xfb\x43\xef\xff\xff""\xff\xff\xff\xff") << "18446744073709549568.";
    QTest::newRow("2.f^64") << raw("\xfa\x5f\x80\0\0") << "1.8446744073709552e+19f";
    QTest::newRow("2.^64") << raw("\xfb\x43\xf0\0\0\0\0\0\0") << "1.8446744073709552e+19";

    QTest::newRow("nan_f16") << raw("\xf9\x7e\x00") << "nan";
    QTest::newRow("nan_f") << raw("\xfa\x7f\xc0\0\0") << "nan";
    QTest::newRow("nan") << raw("\xfb\x7f\xf8\0\0\0\0\0\0") << "nan";
    QTest::newRow("-inf_f16") << raw("\xf9\xfc\x00") << "-inf";
    QTest::newRow("-inf_f") << raw("\xfa\xff\x80\0\0") << "-inf";
    QTest::newRow("-inf") << raw("\xfb\xff\xf0\0\0\0\0\0\0") << "-inf";
    QTest::newRow("+inf_f16") << raw("\xf9\x7c\x00") << "inf";
    QTest::newRow("+inf_f") << raw("\xfa\x7f\x80\0\0") << "inf";
    QTest::newRow("+inf") << raw("\xfb\x7f\xf0\0\0\0\0\0\0") << "inf";

    QTest::newRow("emptybytestring") << raw("\x40") << "h''";
    QTest::newRow("bytestring1") << raw("\x41 ") << "h'20'";
    QTest::newRow("bytestring1-nul") << raw("\x41\0") << "h'00'";
    QTest::newRow("bytestring5") << raw("\x45Hello") << "h'48656c6c6f'";
    QTest::newRow("bytestring24") << raw("\x58\x18""123456789012345678901234")
                                  << "h'313233343536373839303132333435363738393031323334'";

    QTest::newRow("tag0") << raw("\xc0\x00") << "0(0)";
    QTest::newRow("tag1") << raw("\xc1\x00") << "1(0)";
    QTest::newRow("tag24") << raw("\xd8\x18\x00") << "24(0)";
    QTest::newRow("tagUINT64_MAX") << raw("\xdb" "\xff\xff\xff\xff" "\xff\xff\xff\xff" "\x00")
                                << QString::number(std::numeric_limits<uint64_t>::max()) + "(0)";

    QTest::newRow("emptyarray") << raw("\x80") << "[]";
    QTest::newRow("emptymap") << raw("\xa0") << "{}";
    QTest::newRow("_emptyarray") << raw("\x9f\xff") << "[_ ]";
    QTest::newRow("_emptymap") << raw("\xbf\xff") << "{_ }";

    QTest::newRow("map-0-24") << raw("\xa1\0\x18\x18") << "{0: 24}";
    QTest::newRow("map-24-0") << raw("\xa1\x18\x18\0") << "{24: 0}";
    QTest::newRow("_map-0-24") << raw("\xbf\0\x18\x18\xff") << "{_ 0: 24}";
    QTest::newRow("_map-24-0") << raw("\xbf\x18\x18\0\xff") << "{_ 24: 0}";

    // nested strings ought to be escaped
    QTest::newRow("array-emptystring") << raw("\x81\x60") << R"([\"\"])";
    QTest::newRow("array-string1") << raw("\x81\x61 ") << R"([\" \"])";

    // and escaped chracters in strings end up doubly escaped
    QTest::newRow("array-string-null") << raw("\x81\x61\0") << R"([\"\\u0000\"])";
    QTest::newRow("array-string-quote") << raw("\x81\x61\"") << R"([\"\\\"\"])";
    QTest::newRow("array-string-backslash") << raw("\x81\x61\\") << R"([\"\\\\\"])";
}

void tst_ToJson::nonStringKeyMaps()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    data = "\xa1" + data + "\1";
    compareOne(data, "{\"" + expected + "\":1}", CborConvertStringifyMapKeys);

    // and verify that they fail if we use CborConvertRequireMapStringKeys
    CborParser parser;
    CborValue first;
    QString decoded;
    cbor_parser_init(reinterpret_cast<const quint8 *>(data.constData()), data.length(), 0, &parser, &first);
    CborError err = parseOne(&first, &decoded, CborConvertRequireMapStringKeys);
    QCOMPARE(err, CborErrorJsonObjectKeyNotString);
}

void tst_ToJson::tagsToObjects_data()
{
    addColumns();
    QTest::newRow("0(0)") << raw("\xc0\0") << "{\"tag0\":0}";
    QTest::newRow("0(-1)") << raw("\xc0\x20") << "{\"tag0\":-1}";
    QTest::newRow("0(\"hello\")") << raw("\xc0\x65hello") << "{\"tag0\":\"hello\"}";
    QTest::newRow("22(h'48656c6c6f')") << raw("\xd6\x45Hello") << "{\"tag22\":\"SGVsbG8\"}";
    QTest::newRow("0([1,2,3])") << raw("\xc0\x83\1\2\3") << "{\"tag0\":[1,2,3]}";
    QTest::newRow("0({\"z\":true,\"y\":1})") << raw("\xc0\xa2\x61z\xf5\x61y\1") << "{\"tag0\":{\"z\":true,\"y\":1}}";

    // large tags
    QTest::newRow("55799(0)") << raw("\xd9\xd9\xf7\0") << "{\"tag55799\":0}";
    QTest::newRow("4294967295") << raw("\xda\xff\xff\xff\xff\0") << "{\"tag4294967295\":0}";
    QTest::newRow("18446744073709551615(0)") << raw("\xdb\xff\xff\xff\xff""\xff\xff\xff\xff\0")
                                             << "{\"tag18446744073709551615\":0}";

    // nested tags
    QTest::newRow("0(1(2))") << raw("\xc0\xc1\2") << "{\"tag0\":{\"tag1\":2}}";
    QTest::newRow("0({\"z\":1(2)})") << raw("\xc0\xa1\x61z\xc1\2") << "{\"tag0\":{\"z\":{\"tag1\":2}}}";
}

void tst_ToJson::tagsToObjects()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    compareOne(data, expected, CborConvertTagsToObjects);
}

void tst_ToJson::taggedByteStringsToBase16_data()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<QString>("base64url");
    QTest::addColumn<QString>("base64");
    QTest::addColumn<QString>("base16");

    QTest::newRow("emptybytestring") << raw("\x40") << "" << "" << "";
    QTest::newRow("bytestring1") << raw("\x41 ") << "IA" << "IA==" << "20";
    QTest::newRow("bytestring1-nul") << raw("\x41\0") << "AA" << "AA==" << "00";
    QTest::newRow("bytestring1-ff") << raw("\x41\xff") << "_w" << "/w==" << "ff";
    QTest::newRow("bytestring2") << raw("\x42Hi") << "SGk" << "SGk=" << "4869";
    QTest::newRow("bytestring3") << raw("\x43Hey") << "SGV5" << "SGV5" << "486579";
    QTest::newRow("bytestring4") << raw("\x44Hola") << "SG9sYQ" << "SG9sYQ==" << "486f6c61";
    QTest::newRow("bytestring5") << raw("\x45Hello") << "SGVsbG8" << "SGVsbG8=" << "48656c6c6f";
    QTest::newRow("bytestring24") << raw("\x58\x18""123456789012345678901234")
                                  << "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0"
                                  << "MTIzNDU2Nzg5MDEyMzQ1Njc4OTAxMjM0"
                                  << "313233343536373839303132333435363738393031323334";

    // strings with undefined length
    QTest::newRow("_emptybytestring") << raw("\x5f\xff") << "" << "" << "";
    QTest::newRow("_emptybytestring2") << raw("\x5f\x40\xff") << "" << "" << "";
    QTest::newRow("_emptybytestring3") << raw("\x5f\x40\x40\xff") << "" << "" << "";
    QTest::newRow("_bytestring5*2") << raw("\x5f\x43Hel\x42lo\xff") << "SGVsbG8" << "SGVsbG8=" << "48656c6c6f";
    QTest::newRow("_bytestring5*5") << raw("\x5f\x41H\x41""e\x41l\x41l\x41o\xff")
                                    << "SGVsbG8" << "SGVsbG8=" << "48656c6c6f";
    QTest::newRow("_bytestring5*6") << raw("\x5f\x41H\x41""e\x40\x41l\x41l\x41o\xff")
                                    << "SGVsbG8" << "SGVsbG8=" << "48656c6c6f";
}

void tst_ToJson::taggedByteStringsToBase16()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, base16);

    compareOne('\xd7' + data, '"' + base16 + '"', 0);
}

void tst_ToJson::taggedByteStringsToBase64()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, base64);

    compareOne('\xd6' + data, '"' + base64 + '"', 0);
}

void tst_ToJson::taggedByteStringsToBase64url()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, base64url);

    compareOne('\xd5' + data, '"' + base64url + '"', 0);
}

void tst_ToJson::taggedByteStringsToBigNum()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, base64url);

    compareOne('\xc3' + data, "\"~" + base64url + '"', 0);
}

void tst_ToJson::otherTags_data()
{
    addColumns();
    addFixedData();
    addTextStringsData();
    addNonJsonData();
    addByteStringsData();
    addEmptyContainersData();
}

void tst_ToJson::otherTags()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);

    // other tags produce no change in output
    compareOne("\xc0" + data, expected, 0);
    compareOne("\xc1" + data, expected, 0);
    compareOne("\xc2" + data, expected, 0);
    compareOne("\xc4" + data, expected, 0);
    compareOne("\xc5" + data, expected, 0);
    compareOne("\xd8\x20" + data, expected, 0);
    compareOne("\xd8\x21" + data, expected, 0);
    compareOne("\xd8\x22" + data, expected, 0);
    compareOne("\xd8\x23" + data, expected, 0);
    compareOne("\xd8\x24" + data, expected, 0);
    compareOne("\xd9\xd9\xf7" + data, expected, 0);
}

void tst_ToJson::metaData_data()
{
    addColumns();

    // booleans, null, strings, double precision numbers, regular maps, arrays and integers that
    // didn't get rounded don't have metadata
    QTest::newRow("0") << raw("\x00") << QString();
    QTest::newRow("1") << raw("\x01") << QString();
    QTest::newRow("2^53-1") << raw("\x1b\0\x1f\xff\xff""\xff\xff\xff\xff") << QString();
    QTest::newRow("2^64-epsilon") << raw("\x1b\xff\xff\xff\xff""\xff\xff\xf8\x00") << QString();
    QTest::newRow("-1") << raw("\x20") << QString();
    QTest::newRow("-2") << raw("\x21") << QString();
    QTest::newRow("-2^53+1") << raw("\x3b\0\x1f\xff\xff""\xff\xff\xff\xfe") << QString();
    QTest::newRow("-2^64+epsilon") << raw("\x3b\xff\xff\xff\xff""\xff\xff\xf8\x00") << QString();
    QTest::newRow("emptytextstring") << raw("\x60") << QString();
    QTest::newRow("textstring1") << raw("\x61 ") << QString();
    QTest::newRow("0.5") << raw("\xfb\x3f\xe0\0\0\0\0\0\0") << QString();
    QTest::newRow("2.^64") << raw("\xfb\x43\xf0\0\0\0\0\0\0") << QString();
    QTest::newRow("false") << raw("\xf4") << QString();
    QTest::newRow("true") << raw("\xf5") << QString();
    QTest::newRow("null") << raw("\xf6") << QString();
    QTest::newRow("emptyarray") << raw("\x80") << QString();
    QTest::newRow("emptymap") << raw("\xa0") << QString();
    QTest::newRow("array*1") << raw("\x81\xf6") << QString();
    QTest::newRow("map*1") << raw("\xa1\x61z\xf4") << QString();

    // ---- everything from here on has at least the type ----
    QTest::newRow("emptybytestring") << raw("\x40") << "\"t\":64";
    QTest::newRow("bytestring1") << raw("\x41 ") << "\"t\":64";
    QTest::newRow("undefined") << raw("\xf7") << "\"t\":247";
    QTest::newRow("0.f16") << raw("\xf9\0\0") << "\"t\":249";
    QTest::newRow("-1.f16") << raw("\xf9\xbc\x00") << "\"t\":249";
    QTest::newRow("0.f") << raw("\xfa\0\0\0\0") << "\"t\":250";
    QTest::newRow("-1.f") << raw("\xfa\xbf\x80\0\0") << "\"t\":250";
    QTest::newRow("16777215.f") << raw("\xfa\x4b\x7f\xff\xff") << "\"t\":250";
    QTest::newRow("-16777215.f") << raw("\xfa\xcb\x7f\xff\xff") << "\"t\":250";
    QTest::newRow("0.")  << raw("\xfb\0\0\0\0\0\0\0\0") << "\"t\":251";
    QTest::newRow("-1.") << raw("\xfb\xbf\xf0\0\0\0\0\0\0") << "\"t\":251";
    QTest::newRow("16777215.") << raw("\xfb\x41\x6f\xff\xff\xe0\0\0\0") << "\"t\":251";
    QTest::newRow("-16777215.") << raw("\xfb\xc1\x6f\xff\xff\xe0\0\0\0") << "\"t\":251";
    QTest::newRow("2.^53-1") << raw("\xfb\x43\x3f\xff\xff""\xff\xff\xff\xff") << "\"t\":251";
    QTest::newRow("2.^64-epsilon") << raw("\xfb\x43\xef\xff\xff""\xff\xff\xff\xff") << "\"t\":251";

    // simple values
    QTest::newRow("simple0") << raw("\xe0") << "\"t\":224,\"v\":0";
    QTest::newRow("simple19") << raw("\xf3") << "\"t\":224,\"v\":19";
    QTest::newRow("simple32") << raw("\xf8\x20") << "\"t\":224,\"v\":32";
    QTest::newRow("simple255") << raw("\xf8\xff") << "\"t\":224,\"v\":255";

    // infinities and NaN are not supported in JSON, they convert to null
    QTest::newRow("nan_f16") << raw("\xf9\x7e\x00") << "\"t\":249,\"v\":\"nan\"";
    QTest::newRow("nan_f") << raw("\xfa\x7f\xc0\0\0") << "\"t\":250,\"v\":\"nan\"";
    QTest::newRow("nan") << raw("\xfb\x7f\xf8\0\0\0\0\0\0") << "\"t\":251,\"v\":\"nan\"";
    QTest::newRow("-inf_f16") << raw("\xf9\xfc\x00") << "\"t\":249,\"v\":\"-inf\"";
    QTest::newRow("-inf_f") << raw("\xfa\xff\x80\0\0") << "\"t\":250,\"v\":\"-inf\"";
    QTest::newRow("-inf") << raw("\xfb\xff\xf0\0\0\0\0\0\0") << "\"t\":251,\"v\":\"-inf\"";
    QTest::newRow("+inf_f16") << raw("\xf9\x7c\x00") << "\"t\":249,\"v\":\"inf\"";
    QTest::newRow("+inf_f") << raw("\xfa\x7f\x80\0\0") << "\"t\":250,\"v\":\"inf\"";
    QTest::newRow("+inf") << raw("\xfb\x7f\xf0\0\0\0\0\0\0") << "\"t\":251,\"v\":\"inf\"";

    // tags on native types
    QTest::newRow("tag+0") << raw("\xc0\x00") << "\"tag\":\"0\"";
    QTest::newRow("tag+-2") << raw("\xc0\x21") << "\"tag\":\"0\"";
    QTest::newRow("tag+0.5") << raw("\xc0\xfb\x3f\xe0\0\0\0\0\0\0") << "\"tag\":\"0\"";
    QTest::newRow("tag+emptytextstring") << raw("\xc0\x60") << "\"tag\":\"0\"";
    QTest::newRow("tag+textstring1") << raw("\xc0\x61 ") << "\"tag\":\"0\"";
    QTest::newRow("tag+false") << raw("\xc0\xf4") << "\"tag\":\"0\"";
    QTest::newRow("tag+true") << raw("\xc0\xf5") << "\"tag\":\"0\"";
    QTest::newRow("tag+null") << raw("\xc0\xf6") << "\"tag\":\"0\"";
    QTest::newRow("tag+emptyarray") << raw("\xc0\x80") << "\"tag\":\"0\"";
    QTest::newRow("tag+emptymap") << raw("\xc0\xa0") << "\"tag\":\"0\"";
    QTest::newRow("tag+array*1") << raw("\xc0\x81\xf6") << "\"tag\":\"0\"";
    QTest::newRow("tag+map*1") << raw("\xc0\xa1\x61z\xf4") << "\"tag\":\"0\"";

    // tags on non-native types
    QTest::newRow("tag+emptybytestring") << raw("\xc0\x40") << "\"tag\":\"0\",\"t\":64";
    QTest::newRow("tag+bytestring1") << raw("\xc0\x41 ") << "\"tag\":\"0\",\"t\":64";
    QTest::newRow("tag+undefined") << raw("\xc0\xf7") << "\"tag\":\"0\",\"t\":247";
    QTest::newRow("tag+0.f") << raw("\xc0\xfa\0\0\0\0") << "\"tag\":\"0\",\"t\":250";
    QTest::newRow("tag+-1.f") << raw("\xc0\xfa\xbf\x80\0\0") << "\"tag\":\"0\",\"t\":250";
    QTest::newRow("tag+16777215.f") << raw("\xc0\xfa\x4b\x7f\xff\xff") << "\"tag\":\"0\",\"t\":250";
    QTest::newRow("tag+-16777215.f") << raw("\xc0\xfa\xcb\x7f\xff\xff") << "\"tag\":\"0\",\"t\":250";
    QTest::newRow("tag+0.")  << raw("\xc0\xfb\0\0\0\0\0\0\0\0") << "\"tag\":\"0\",\"t\":251";
    QTest::newRow("tag+-1.") << raw("\xc0\xfb\xbf\xf0\0\0\0\0\0\0") << "\"tag\":\"0\",\"t\":251";
    QTest::newRow("tag+16777215.") << raw("\xc0\xfb\x41\x6f\xff\xff\xe0\0\0\0") << "\"tag\":\"0\",\"t\":251";
    QTest::newRow("tag+-16777215.") << raw("\xc0\xfb\xc1\x6f\xff\xff\xe0\0\0\0") << "\"tag\":\"0\",\"t\":251";

    // big tags (don't fit in JS numbers)
    QTest::newRow("bigtag1") << raw("\xdb\0\x20\0\0""\0\0\0\1\x60") << "\"tag\":\"9007199254740993\"";
    QTest::newRow("bigtag2") << raw("\xdb\xff\xff\xff\xff""\xff\xff\xff\xfe\x60")
                             << "\"tag\":\"18446744073709551614\"";

    // specially-handled tags
    QTest::newRow("negativebignum") << raw("\xc3\x41 ") << "\"tag\":\"3\",\"t\":64";
    QTest::newRow("base64") << raw("\xd6\x41 ") << "\"tag\":\"22\",\"t\":64";
    QTest::newRow("base16") << raw("\xd7\x41 ") << "\"tag\":\"23\",\"t\":64";
}

void compareMetaData(QByteArray data, const QString &expected, int otherFlags = 0)
{
    QString decoded;

    // needs to be in one map, with the entry called "v"
    data = "\xa1\x61v" + data;

    {
        CborParser parser;
        CborValue first;
        CborError err = cbor_parser_init(reinterpret_cast<const quint8 *>(data.constData()), data.length(), 0, &parser, &first);
        QVERIFY2(!err, QByteArrayLiteral(": Got error \"") + cbor_error_string(err) + "\"");

        err = parseOne(&first, &decoded, CborConvertAddMetadata | otherFlags);
        QVERIFY2(!err, QByteArrayLiteral(": Got error \"") + cbor_error_string(err) +
                 "\"; decoded stream:\n" + decoded.toLatin1());

        // check that we consumed everything
        QCOMPARE((void*)cbor_value_get_next_byte(&first), (void*)data.constEnd());
    }

    QVERIFY(decoded.startsWith("{\"v\":"));
    QVERIFY(decoded.endsWith('}'));
//    qDebug() << "was" << decoded;

    // extract just the metadata
    static const char needle[] = "\"v$cbor\":{";
    int pos = decoded.indexOf(needle);
    QCOMPARE(pos == -1, expected.isEmpty());
    if (pos != -1) {
        decoded.chop(2);
        decoded = std::move(decoded).mid(pos + strlen(needle));
        QCOMPARE(decoded, expected);
    }
}

void tst_ToJson::metaData()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);
    compareMetaData(data, expected);
}

void tst_ToJson::metaDataAndTagsToObjects()
{
    QFETCH(QByteArray, data);

    // when a tag is converted to an object, the object gets metadata indicating it was a tag
    compareMetaData(data, "\"t\":192", CborConvertTagsToObjects);
}

void tst_ToJson::metaDataForKeys_data()
{
    nonStringKeyMaps_data();

    // string keys generate no metadata
    QTest::newRow("string") << raw("\x60") << QString();
}

void tst_ToJson::metaDataForKeys()
{
    QFETCH(QByteArray, data);
    QFETCH(QString, expected);
    if (expected.isEmpty())
        expected = "{\"\":false}";
    else
        expected = "{\"" + expected + "\":false,\"" + expected + "$keycbordump\":true}";
    compareOne('\xa1' + data + '\xf4', expected,
               CborConvertAddMetadata | CborConvertStringifyMapKeys);
}

void tst_ToJson::recursionLimit_data()
{
    static const int recursions = CBOR_PARSER_MAX_RECURSIONS + 2;
    QTest::addColumn<QByteArray>("data");

    QTest::newRow("arrays") << QByteArray(recursions, '\x81');
    QTest::newRow("tags") << QByteArray(recursions, '\xc1');

    QByteArray mapData;
    mapData.reserve(2 * recursions);
    for (int i = 0; i < recursions; ++i)
        mapData.append("\xa1\x60", 2);
    QTest::newRow("maps") << mapData;
}

void tst_ToJson::recursionLimit()
{
    QFETCH(QByteArray, data);
    CborParser parser;
    CborValue first;
    CborError err = cbor_parser_init(reinterpret_cast<const quint8 *>(data.constData()), data.length(), 0, &parser, &first);
    QVERIFY2(!err, QByteArray("Got error \"") + cbor_error_string(err) + "\"");

    QString parsed;
    err = parseOne(&first, &parsed, 0);

    QCOMPARE(err, CborErrorNestingTooDeep);
}

QTEST_MAIN(tst_ToJson)
