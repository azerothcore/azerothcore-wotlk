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

#include <QtTest>
#include <limits>
#include <cbor.h>

Q_DECLARE_METATYPE(CborError)
Q_DECLARE_METATYPE(CborType)

namespace {

template <size_t N> QByteArray raw(const char (&data)[N])
{
    return QByteArray::fromRawData(data, N - 1);
}

void addIntegers()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<quint64>("expectedRaw");
    QTest::addColumn<qint64>("expectedValue");
    QTest::addColumn<bool>("isNegative");
    QTest::addColumn<bool>("inInt64Range");

    // unsigned integers
    QTest::newRow("0") << raw("\x00") << Q_UINT64_C(0) << Q_INT64_C(0) << false << true;
    QTest::newRow("1") << raw("\x01") << Q_UINT64_C(1) << Q_INT64_C(1) << false << true;
    QTest::newRow("10") << raw("\x0a") << Q_UINT64_C(10) << Q_INT64_C(10) << false << true;
    QTest::newRow("23") << raw("\x17") << Q_UINT64_C(23) << Q_INT64_C(23) << false << true;
    QTest::newRow("24") << raw("\x18\x18") << Q_UINT64_C(24) << Q_INT64_C(24) << false << true;
    QTest::newRow("UINT8_MAX") << raw("\x18\xff") << Q_UINT64_C(255) << Q_INT64_C(255) << false << true;
    QTest::newRow("UINT8_MAX+1") << raw("\x19\x01\x00") << Q_UINT64_C(256) << Q_INT64_C(256) << false << true;
    QTest::newRow("UINT16_MAX") << raw("\x19\xff\xff") << Q_UINT64_C(65535) << Q_INT64_C(65535) << false << true;
    QTest::newRow("UINT16_MAX+1") << raw("\x1a\0\1\x00\x00") << Q_UINT64_C(65536) << Q_INT64_C(65536) << false << true;
    QTest::newRow("UINT32_MAX") << raw("\x1a\xff\xff\xff\xff") << Q_UINT64_C(4294967295) << Q_INT64_C(4294967295) << false << true;
    QTest::newRow("UINT32_MAX+1") << raw("\x1b\0\0\0\1\0\0\0\0") << Q_UINT64_C(4294967296) << Q_INT64_C(4294967296) << false << true;
    QTest::newRow("INT64_MAX") << raw("\x1b" "\x7f\xff\xff\xff" "\xff\xff\xff\xff")
                                << quint64(std::numeric_limits<qint64>::max())
                                << std::numeric_limits<qint64>::max() << false << true;
    QTest::newRow("UINT64_MAX") << raw("\x1b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                << std::numeric_limits<quint64>::max() << qint64(-123456) << false << false;

    // negative integers
    QTest::newRow("-1") << raw("\x20") << Q_UINT64_C(0) << Q_INT64_C(-1) << true << true;
    QTest::newRow("-2") << raw("\x21") << Q_UINT64_C(1) << Q_INT64_C(-2) << true << true;
    QTest::newRow("-24") << raw("\x37") << Q_UINT64_C(23) << Q_INT64_C(-24) << true << true;
    QTest::newRow("-25") << raw("\x38\x18") << Q_UINT64_C(24) << Q_INT64_C(-25) << true << true;
    QTest::newRow("-UINT8_MAX") << raw("\x38\xff") << Q_UINT64_C(255) << Q_INT64_C(-256) << true << true;
    QTest::newRow("-UINT8_MAX-1") << raw("\x39\x01\x00") << Q_UINT64_C(256) << Q_INT64_C(-257) << true << true;
    QTest::newRow("-UINT16_MAX") << raw("\x39\xff\xff") << Q_UINT64_C(65535) << Q_INT64_C(-65536) << true << true;
    QTest::newRow("-UINT16_MAX-1") << raw("\x3a\0\1\x00\x00") << Q_UINT64_C(65536) << Q_INT64_C(-65537) << true << true;
    QTest::newRow("-UINT32_MAX") << raw("\x3a\xff\xff\xff\xff") << Q_UINT64_C(4294967295) << Q_INT64_C(-4294967296) << true << true;
    QTest::newRow("-UINT32_MAX-1") << raw("\x3b\0\0\0\1\0\0\0\0") << Q_UINT64_C(4294967296) << Q_INT64_C(-4294967297) << true << true;
    QTest::newRow("INT64_MIN+1") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xfe")
                               << quint64(std::numeric_limits<qint64>::max() - 1)
                               << (std::numeric_limits<qint64>::min() + 1)
                               << true << true;
    QTest::newRow("INT64_MIN") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xff")
                               << quint64(std::numeric_limits<qint64>::max())
                               << std::numeric_limits<qint64>::min()
                               << true << true;
    QTest::newRow("INT64_MIN-1") << raw("\x3b\x80\0\0\0""\0\0\0\0") << Q_UINT64_C(9223372036854775808) << qint64(-123456) << true << false;
    QTest::newRow("-UINT64_MAX") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xfe")
                                 << (std::numeric_limits<quint64>::max() - 1) << qint64(-123456) << true << false;
    QTest::newRow("-UINT64_MAX+1") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                   << std::numeric_limits<quint64>::max() << qint64(-123456) << true << false;
}

[[maybe_unused]] void addFloatingPoint()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<double>("expectedValue");
    QTest::addColumn<CborType>("expectedType");

    QTest::newRow("0.f16") << raw("\xf9\0\0") << 0. << CborHalfFloatType;
    QTest::newRow("0.f") << raw("\xfa\0\0\0\0") << 0. << CborFloatType;
    QTest::newRow("0.")  << raw("\xfb\0\0\0\0\0\0\0\0") << 0. << CborDoubleType;
    QTest::newRow("-1.f16") << raw("\xf9\xbc\x00") << -1. << CborHalfFloatType;
    QTest::newRow("-1.f") << raw("\xfa\xbf\x80\0\0") << -1. << CborFloatType;
    QTest::newRow("-1.") << raw("\xfb\xbf\xf0\0\0\0\0\0\0") << -1. << CborDoubleType;
    QTest::newRow("65504.f16") << raw("\xf9\x7b\xff") << 65504. << CborHalfFloatType;
    QTest::newRow("16777215.f") << raw("\xfa\x4b\x7f\xff\xff") << 16777215. << CborFloatType;
    QTest::newRow("16777215.") << raw("\xfb\x41\x6f\xff\xff\xe0\0\0\0") << 16777215. << CborDoubleType;
    QTest::newRow("-16777215.f") << raw("\xfa\xcb\x7f\xff\xff") << -16777215. << CborFloatType;
    QTest::newRow("-16777215.") << raw("\xfb\xc1\x6f\xff\xff\xe0\0\0\0") << -16777215. << CborDoubleType;

    QTest::newRow("0.5f16") << raw("\xf9\x38\0") << 0.5 << CborHalfFloatType;
    QTest::newRow("0.5f") << raw("\xfa\x3f\0\0\0") << 0.5 << CborFloatType;
    QTest::newRow("0.5") << raw("\xfb\x3f\xe0\0\0\0\0\0\0") << 0.5 << CborDoubleType;
    QTest::newRow("2.f16^11-1") << raw("\xf9\x67\xff") << 2047. << CborHalfFloatType;
    QTest::newRow("2.f^24-1") << raw("\xfa\x4b\x7f\xff\xff") << 16777215. << CborFloatType;
    QTest::newRow("2.^53-1") << raw("\xfb\x43\x3f\xff\xff""\xff\xff\xff\xff") << double(Q_INT64_C(1) << 53) - 1 << CborDoubleType;
    QTest::newRow("2.f^64-epsilon") << raw("\xfa\x5f\x7f\xff\xff") << 0x1.fffffep+63 << CborFloatType;
    QTest::newRow("2.^64-epsilon") << raw("\xfb\x43\xef\xff\xff""\xff\xff\xff\xff") << 0x1.fffffffffffffp+63 << CborDoubleType;
    QTest::newRow("2.f^64") << raw("\xfa\x5f\x80\0\0") << 0x1p64 << CborFloatType;
    QTest::newRow("2.^64") << raw("\xfb\x43\xf0\0\0\0\0\0\0") << 0x1p64 << CborDoubleType;

    QTest::newRow("nan_f16") << raw("\xf9\x7e\x00") << qQNaN() << CborHalfFloatType;
    QTest::newRow("nan_f") << raw("\xfa\x7f\xc0\0\0") << qQNaN() << CborFloatType;
    QTest::newRow("nan") << raw("\xfb\x7f\xf8\0\0\0\0\0\0") << qQNaN() << CborDoubleType;
    QTest::newRow("-inf_f16") << raw("\xf9\xfc\x00") << -qInf() << CborHalfFloatType;
    QTest::newRow("-inf_f") << raw("\xfa\xff\x80\0\0") << -qInf() << CborFloatType;
    QTest::newRow("-inf") << raw("\xfb\xff\xf0\0\0\0\0\0\0") << -qInf() << CborDoubleType;
    QTest::newRow("+inf_f16") << raw("\xf9\x7c\x00") << qInf() << CborHalfFloatType;
    QTest::newRow("+inf_f") << raw("\xfa\x7f\x80\0\0") << qInf() << CborFloatType;
    QTest::newRow("+inf") << raw("\xfb\x7f\xf0\0\0\0\0\0\0") << qInf() << CborDoubleType;
}

void addColumns()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<QString>("expected");
    QTest::addColumn<int>("n");         // some aux integer, not added in all columns
}

void addFixedData()
{
    // unsigned integers
    QTest::newRow("0") << raw("\x00") << "0";
    QTest::newRow("1") << raw("\x01") << "1";
    QTest::newRow("10") << raw("\x0a") << "10";
    QTest::newRow("23") << raw("\x17") << "23";
    QTest::newRow("24") << raw("\x18\x18") << "24";
    QTest::newRow("UINT8_MAX") << raw("\x18\xff") << "255";
    QTest::newRow("UINT8_MAX+1") << raw("\x19\x01\x00") << "256";
    QTest::newRow("UINT16_MAX") << raw("\x19\xff\xff") << "65535";
    QTest::newRow("UINT16_MAX+1") << raw("\x1a\0\1\x00\x00") << "65536";
    QTest::newRow("UINT32_MAX") << raw("\x1a\xff\xff\xff\xff") << "4294967295";
    QTest::newRow("UINT32_MAX+1") << raw("\x1b\0\0\0\1\0\0\0\0") << "4294967296";
    QTest::newRow("UINT64_MAX") << raw("\x1b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                << QString::number(std::numeric_limits<uint64_t>::max());

    // negative integers
    QTest::newRow("-1") << raw("\x20") << "-1";
    QTest::newRow("-2") << raw("\x21") << "-2";
    QTest::newRow("-24") << raw("\x37") << "-24";
    QTest::newRow("-25") << raw("\x38\x18") << "-25";
    QTest::newRow("-UINT8_MAX") << raw("\x38\xff") << "-256";
    QTest::newRow("-UINT8_MAX-1") << raw("\x39\x01\x00") << "-257";
    QTest::newRow("-UINT16_MAX") << raw("\x39\xff\xff") << "-65536";
    QTest::newRow("-UINT16_MAX-1") << raw("\x3a\0\1\x00\x00") << "-65537";
    QTest::newRow("-UINT32_MAX") << raw("\x3a\xff\xff\xff\xff") << "-4294967296";
    QTest::newRow("-UINT32_MAX-1") << raw("\x3b\0\0\0\1\0\0\0\0") << "-4294967297";
    QTest::newRow("INT64_MIN+1") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xfe")
                               << QString::number(std::numeric_limits<int64_t>::min() + 1);
    QTest::newRow("INT64_MIN") << raw("\x3b\x7f\xff\xff\xff""\xff\xff\xff\xff")
                               << QString::number(std::numeric_limits<int64_t>::min());
    QTest::newRow("INT64_MIN-1") << raw("\x3b\x80\0\0\0""\0\0\0\0") << "-9223372036854775809";
    QTest::newRow("-UINT64_MAX") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xfe")
                                   << '-' + QString::number(std::numeric_limits<uint64_t>::max());
    QTest::newRow("-UINT64_MAX+1") << raw("\x3b" "\xff\xff\xff\xff" "\xff\xff\xff\xff")
                                   << "-18446744073709551616";

    // overlongs
    QTest::newRow("0*1") << raw("\x18\x00") << "0_0";
    QTest::newRow("0*2") << raw("\x19\x00\x00") << "0_1";
    QTest::newRow("0*4") << raw("\x1a\0\0\0\0") << "0_2";
    QTest::newRow("0*8") << raw("\x1b\0\0\0\0\0\0\0\0") << "0_3";
    QTest::newRow("-1*1") << raw("\x38\x00") << "-1_0";
    QTest::newRow("-1*2") << raw("\x39\x00\x00") << "-1_1";
    QTest::newRow("-1*4") << raw("\x3a\0\0\0\0") << "-1_2";
    QTest::newRow("-1*8") << raw("\x3b\0\0\0\0\0\0\0\0") << "-1_3";

    QTest::newRow("simple0") << raw("\xe0") << "simple(0)";
    QTest::newRow("simple19") << raw("\xf3") << "simple(19)";
    QTest::newRow("false") << raw("\xf4") << "false";
    QTest::newRow("true") << raw("\xf5") << "true";
    QTest::newRow("null") << raw("\xf6") << "null";
    QTest::newRow("undefined") << raw("\xf7") << "undefined";
    QTest::newRow("simple32") << raw("\xf8\x20") << "simple(32)";
    QTest::newRow("simple255") << raw("\xf8\xff") << "simple(255)";

    // floating point

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

}

void addNonChunkedStringsData()
{
    // byte strings
    QTest::newRow("emptybytestring") << raw("\x40") << "h''";
    QTest::newRow("bytestring1") << raw("\x41 ") << "h'20'";
    QTest::newRow("bytestring1-nul") << raw("\x41\0") << "h'00'";
    QTest::newRow("bytestring5") << raw("\x45Hello") << "h'48656c6c6f'";
    QTest::newRow("bytestring24") << raw("\x58\x18""123456789012345678901234")
                                  << "h'313233343536373839303132333435363738393031323334'";
    QTest::newRow("bytestring256") << raw("\x59\1\0") + QByteArray(256, '3')
                                   << "h'" + QString(256 * 2, '3') + '\'';

    // text strings
    QTest::newRow("emptytextstring") << raw("\x60") << "\"\"";
    QTest::newRow("textstring1") << raw("\x61 ") << "\" \"";
    QTest::newRow("textstring1-nul") << raw("\x61\0") << "\"\\u0000\"";
    QTest::newRow("textstring5") << raw("\x65Hello") << "\"Hello\"";
    QTest::newRow("textstring24") << raw("\x78\x18""123456789012345678901234")
                                  << "\"123456789012345678901234\"";
    QTest::newRow("textstring256") << raw("\x79\1\0") + QByteArray(256, '3')
                                   << '"' + QString(256, '3') + '"';

    // some strings with UTF-8 content
    // we had a bug in the pretty dumper - see issue #54
    QTest::newRow("textstringutf8-2char") << raw("\x62\xc2\xa0") << "\"\\u00A0\"";
    QTest::newRow("textstringutf8-2char2") << raw("\x64\xc2\xa0\xc2\xa9") << "\"\\u00A0\\u00A9\"";
    QTest::newRow("textstringutf8-3char") << raw("\x63\xe2\x88\x80") << "\"\\u2200\"";
    QTest::newRow("textstringutf8-4char") << raw("\x64\xf0\x90\x88\x83") << "\"\\uD800\\uDE03\"";

    // strings with overlong length
    QTest::newRow("emptybytestring*1") << raw("\x58\x00") << "h''_0";
    QTest::newRow("emptytextstring*1") << raw("\x78\x00") << "\"\"_0";
    QTest::newRow("emptybytestring*2") << raw("\x59\x00\x00") << "h''_1";
    QTest::newRow("emptytextstring*2") << raw("\x79\x00\x00") << "\"\"_1";
    QTest::newRow("emptybytestring*4") << raw("\x5a\0\0\0\0") << "h''_2";
    QTest::newRow("emptytextstring*4") << raw("\x7a\0\0\0\0") << "\"\"_2";
    QTest::newRow("emptybytestring*8") << raw("\x5b\0\0\0\0\0\0\0\0") << "h''_3";
    QTest::newRow("emptytextstring*8") << raw("\x7b\0\0\0\0\0\0\0\0") << "\"\"_3";
    QTest::newRow("bytestring5*1") << raw("\x58\x05Hello") << "h'48656c6c6f'_0";
    QTest::newRow("textstring5*1") << raw("\x78\x05Hello") << "\"Hello\"_0";
    QTest::newRow("bytestring5*2") << raw("\x59\0\5Hello") << "h'48656c6c6f'_1";
    QTest::newRow("textstring5*2") << raw("\x79\0\x05Hello") << "\"Hello\"_1";
    QTest::newRow("bytestring5*4") << raw("\x5a\0\0\0\5Hello") << "h'48656c6c6f'_2";
    QTest::newRow("textstring5*4") << raw("\x7a\0\0\0\x05Hello") << "\"Hello\"_2";
    QTest::newRow("bytestring5*8") << raw("\x5b\0\0\0\0\0\0\0\5Hello") << "h'48656c6c6f'_3";
    QTest::newRow("textstring5*8") << raw("\x7b\0\0\0\0\0\0\0\x05Hello") << "\"Hello\"_3";

}

void addStringsData()
{
    addNonChunkedStringsData();

    // strings with undefined length
    QTest::newRow("_emptybytestring") << raw("\x5f\xff") << "(_ )";
    QTest::newRow("_emptytextstring") << raw("\x7f\xff") << "(_ )";
    QTest::newRow("_emptybytestring2") << raw("\x5f\x40\xff") << "(_ h'')";
    QTest::newRow("_emptytextstring2") << raw("\x7f\x60\xff") << "(_ \"\")";
    QTest::newRow("_emptybytestring2*1") << raw("\x5f\x58\x00\xff") << "(_ h''_0)";
    QTest::newRow("_emptytextstring2*1") << raw("\x7f\x78\x00\xff") << "(_ \"\"_0)";
    QTest::newRow("_emptybytestring3") << raw("\x5f\x40\x40\xff") << "(_ h'', h'')";
    QTest::newRow("_emptytextstring3") << raw("\x7f\x60\x60\xff") << "(_ \"\", \"\")";
    QTest::newRow("_emptybytestring3*2") << raw("\x5f\x59\x00\x00\x40\xff") << "(_ h''_1, h'')";
    QTest::newRow("_emptytextstring3*2") << raw("\x7f\x79\x00\x00\x60\xff") << "(_ \"\"_1, \"\")";
    QTest::newRow("_bytestring5x2") << raw("\x5f\x43Hel\x42lo\xff") << "(_ h'48656c', h'6c6f')";
    QTest::newRow("_textstring5x2") << raw("\x7f\x63Hel\x62lo\xff") << "(_ \"Hel\", \"lo\")";
    QTest::newRow("_bytestring5x2*8*4") << raw("\x5f\x5b\0\0\0\0\0\0\0\3Hel\x5a\0\0\0\2lo\xff") << "(_ h'48656c'_3, h'6c6f'_2)";
    QTest::newRow("_textstring5x2*8*4") << raw("\x7f\x7b\0\0\0\0\0\0\0\3Hel\x7a\0\0\0\2lo\xff") << "(_ \"Hel\"_3, \"lo\"_2)";
    QTest::newRow("_bytestring5x5") << raw("\x5f\x41H\x41""e\x41l\x41l\x41o\xff") << "(_ h'48', h'65', h'6c', h'6c', h'6f')";
    QTest::newRow("_textstring5x5") << raw("\x7f\x61H\x61""e\x61l\x61l\x61o\xff") << "(_ \"H\", \"e\", \"l\", \"l\", \"o\")";
    QTest::newRow("_bytestring5x6") << raw("\x5f\x41H\x41""e\x40\x41l\x41l\x41o\xff") << "(_ h'48', h'65', h'', h'6c', h'6c', h'6f')";
    QTest::newRow("_textstring5x6") << raw("\x7f\x61H\x61""e\x61l\x60\x61l\x61o\xff") << "(_ \"H\", \"e\", \"l\", \"\", \"l\", \"o\")";
}

void addTagsData()
{
    // since parseOne() works recursively for tags, we can't test lone tags
    QTest::newRow("tag0") << raw("\xc0\x00") << "0(0)";
    QTest::newRow("tag1") << raw("\xc1\x00") << "1(0)";
    QTest::newRow("tag24") << raw("\xd8\x18\x00") << "24(0)";
    QTest::newRow("tag255") << raw("\xd8\xff\x00") << "255(0)";
    QTest::newRow("tag256") << raw("\xd9\1\0\x00") << "256(0)";
    QTest::newRow("tag65535") << raw("\xd9\xff\xff\x00") << "65535(0)";
    QTest::newRow("tag65536") << raw("\xda\0\1\0\0\x00") << "65536(0)";
    QTest::newRow("tagUINT32_MAX-1") << raw("\xda\xff\xff\xff\xff\x00") << "4294967295(0)";
    QTest::newRow("tagUINT32_MAX") << raw("\xdb\0\0\0\1\0\0\0\0\x00") << "4294967296(0)";
    QTest::newRow("tagUINT64_MAX") << raw("\xdb" "\xff\xff\xff\xff" "\xff\xff\xff\xff" "\x00")
                                << QString::number(std::numeric_limits<uint64_t>::max()) + "(0)";

    // overlong tags
    QTest::newRow("tag0*1") << raw("\xd8\0\x00") << "0_0(0)";
    QTest::newRow("tag0*2") << raw("\xd9\0\0\x00") << "0_1(0)";
    QTest::newRow("tag0*4") << raw("\xda\0\0\0\0\x00") << "0_2(0)";
    QTest::newRow("tag0*8") << raw("\xdb\0\0\0\0\0\0\0\0\x00") << "0_3(0)";

    // tag other things
    QTest::newRow("unixtime") << raw("\xc1\x1a\x55\x4b\xbf\xd3") << "1(1431027667)";
    QTest::newRow("rfc3339date") << raw("\xc0\x78\x19" "2015-05-07 12:41:07-07:00")
                                 << "0(\"2015-05-07 12:41:07-07:00\")";
    QTest::newRow("tag6+false") << raw("\xc6\xf4") << "6(false)";
    QTest::newRow("tag25+true") << raw("\xd8\x19\xf5") << "25(true)";
    QTest::newRow("tag256+null") << raw("\xd9\1\0\xf6") << "256(null)";
    QTest::newRow("tag65536+simple32") << raw("\xda\0\1\0\0\xf8\x20") << "65536(simple(32))";
    QTest::newRow("float+unixtime") << raw("\xc1\xfa\x4e\xaa\x97\x80") << "1(1431027712.f)";
    QTest::newRow("double+unixtime") << raw("\xc1\xfb" "\x41\xd5\x52\xef" "\xf4\xc7\xce\xfe")
                                     << "1(1431027667.1220088)";
}

void addEmptyContainersData()
{
    QTest::newRow("emptyarray") << raw("\x80") << "[]" << 0;
    QTest::newRow("emptymap") << raw("\xa0") << "{}" << 0;
    QTest::newRow("_emptyarray") << raw("\x9f\xff") << "[_ ]" << -1;
    QTest::newRow("_emptymap") << raw("\xbf\xff") << "{_ }" << -1;
}

void addMapMixedData()
{
    QTest::newRow("map-0-24") << raw("\xa1\0\x18\x18") << "{0: 24}" << 1;
    QTest::newRow("map-0*1-24") << raw("\xa1\x18\0\x18\x18") << "{0_0: 24}" << 1;
    QTest::newRow("map-0*1-24*2") << raw("\xa1\x18\0\x19\0\x18") << "{0_0: 24_1}" << 1;
    QTest::newRow("map-0*4-24*2") << raw("\xa1\x1a\0\0\0\0\x19\0\x18") << "{0_2: 24_1}" << 1;
    QTest::newRow("map-24-0") << raw("\xa1\x18\x18\0") << "{24: 0}" << 1;
    QTest::newRow("map-24-0*1") << raw("\xa1\x18\x18\x18\0") << "{24: 0_0}" << 1;
    QTest::newRow("map-255-65535") << raw("\xa1\x18\xff\x19\xff\xff") << "{255: 65535}" << 1;

    QTest::newRow("_map-0-24") << raw("\xbf\0\x18\x18\xff") << "{_ 0: 24}" << 1;
    QTest::newRow("_map-0*1-24") << raw("\xbf\x18\0\x18\x18\xff") << "{_ 0_0: 24}" << 1;
    QTest::newRow("_map-0*1-24*2") << raw("\xbf\x18\0\x19\0\x18\xff") << "{_ 0_0: 24_1}" << 1;
    QTest::newRow("_map-0*4-24*2") << raw("\xbf\x1a\0\0\0\0\x19\0\x18\xff") << "{_ 0_2: 24_1}" << 1;
    QTest::newRow("_map-24-0") << raw("\xbf\x18\x18\0\xff") << "{_ 24: 0}" << 1;
    QTest::newRow("_map-24-0*1") << raw("\xbf\x18\x18\x18\0\xff") << "{_ 24: 0_0}" << 1;
    QTest::newRow("_map-255-65535") << raw("\xbf\x18\xff\x19\xff\xff\xff") << "{_ 255: 65535}" << 1;
}

void addChunkedStringData()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<QString>("concatenated");
    QTest::addColumn<QStringList>("chunks");

    // non-chunked:
    QTest::newRow("emptybytestring") << raw("\x40") << "h''" << QStringList{"h''"};
    QTest::newRow("bytestring1") << raw("\x41 ") << "h'20'" << QStringList{"h'20'"};
    QTest::newRow("emptytextstring") << raw("\x60") << "\"\"" << QStringList{"\"\""};
    QTest::newRow("textstring1") << raw("\x61 ") << "\" \"" << QStringList{"\" \""};

    // empty chunked:
    QTest::newRow("_emptybytestring") << raw("\x5f\xff") << "h''" << QStringList{};
    QTest::newRow("_emptytextstring") << raw("\x7f\xff") << "\"\"" << QStringList{};
    QTest::newRow("_emptybytestring2") << raw("\x5f\x40\xff") << "h''" << QStringList{"h''"};
    QTest::newRow("_emptytextstring2") << raw("\x7f\x60\xff") << "\"\"" << QStringList{"\"\""};
    QTest::newRow("_emptybytestring3") << raw("\x5f\x40\x40\xff") << "h''" << QStringList{"h''", "h''"};
    QTest::newRow("_emptytextstring3") << raw("\x7f\x60\x60\xff") << "\"\"" << QStringList{"\"\"", "\"\""};

    // regular chunks
    QTest::newRow("_bytestring1") << raw("\x5f\x41 \xff") << "h'20'" << QStringList{"h'20'"};
    QTest::newRow("_bytestring2") << raw("\x5f\x41 \x41z\xff") << "h'207a'" << QStringList{"h'20'", "h'7a'"};
    QTest::newRow("_bytestring3") << raw("\x5f\x41 \x58\x18""123456789012345678901234\x41z\xff")
                                  << "h'203132333435363738393031323334353637383930313233347a'"
                                  << QStringList{"h'20'", "h'313233343536373839303132333435363738393031323334'", "h'7a'"};

    QTest::newRow("_textstring1") << raw("\x7f\x61 \xff") << "\" \"" << QStringList{"\" \""};
    QTest::newRow("_textstring2") << raw("\x7f\x61 \x61z\xff") << "\" z\"" << QStringList{"\" \"", "\"z\""};
    QTest::newRow("_textstring3") << raw("\x7f\x61 \x78\x18""123456789012345678901234\x61z\xff")
                                  << "\" 123456789012345678901234z\""
                                  << QStringList{"\" \"", "\"123456789012345678901234\"", "\"z\""};
}

void addValidationColumns()
{
    QTest::addColumn<QByteArray>("data");
    QTest::addColumn<int>("flags");     // future
    QTest::addColumn<CborError>("expectedError");
}

void addValidationData(size_t minInvalid = ~size_t(0))
{
    // illegal numbers are future extension points
    QTest::newRow("illegal-number-in-unsigned-1") << raw("\x81\x1c") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-unsigned-2") << raw("\x81\x1d") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-unsigned-3") << raw("\x81\x1e") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-unsigned-4") << raw("\x81\x1f") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-negative-1") << raw("\x81\x3c") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-negative-2") << raw("\x81\x3d") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-negative-3") << raw("\x81\x3e") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-negative-4") << raw("\x81\x3f") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-bytearray-length-1") << raw("\x81\x5c") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-bytearray-length-2") << raw("\x81\x5d") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-bytearray-length-3") << raw("\x81\x5e") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-string-length-1") << raw("\x81\x7c") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-string-length-2") << raw("\x81\x7d") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-string-length-3") << raw("\x81\x7e") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-array-length-1") << raw("\x81\x9c") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-array-length-2") << raw("\x81\x9d") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-array-length-3") << raw("\x81\x9e") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-map-length-1") << raw("\x81\xbc") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-map-length-2") << raw("\x81\xbd") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-map-length-3") << raw("\x81\xbe") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-tag-1") << raw("\x81\xdc") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-tag-2") << raw("\x81\xdd") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-tag-3") << raw("\x81\xde") << 0 << CborErrorIllegalNumber;
    QTest::newRow("illegal-number-in-tag-4") << raw("\x81\xdf") << 0 << CborErrorIllegalNumber;

    QTest::newRow("unsigned-too-short-1-0") << raw("\x81\x18") << 0 << CborErrorUnexpectedEOF;   // requires 1 byte, 0 given
    QTest::newRow("unsigned-too-short-2-0") << raw("\x81\x19") << 0 << CborErrorUnexpectedEOF;   // requires 2 bytes, 0 given
    QTest::newRow("unsigned-too-short-2-1") << raw("\x81\x19\x01") << 0 << CborErrorUnexpectedEOF; // etc
    QTest::newRow("unsigned-too-short-4-0") << raw("\x81\x1a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("unsigned-too-short-4-3") << raw("\x81\x1a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("unsigned-too-short-8-0") << raw("\x81\x1b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("unsigned-too-short-8-7") << raw("\x81\x1b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("negative-length-too-short-1-0") << raw("\x81\x38") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("negative-length-too-short-2-0") << raw("\x81\x39") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("negative-length-too-short-2-1") << raw("\x81\x39\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("negative-length-too-short-4-0") << raw("\x81\x3a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("negative-length-too-short-4-3") << raw("\x81\x3a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("negative-length-too-short-8-0") << raw("\x81\x3b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("negative-length-too-short-8-7") << raw("\x81\x3b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-length-too-short-1-0") << raw("\x81\x58") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-length-too-short-2-0") << raw("\x81\x59") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-length-too-short-2-1") << raw("\x81\x59\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-length-too-short-4-0") << raw("\x81\x5a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-length-too-short-4-3") << raw("\x81\x5a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-length-too-short-8-0") << raw("\x81\x5b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-length-too-short-8-7") << raw("\x81\x5b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-length-too-short-1-0") << raw("\x81\x78") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-length-too-short-2-0") << raw("\x81\x79") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-length-too-short-2-1") << raw("\x81\x79\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-length-too-short-4-0") << raw("\x81\x7a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-length-too-short-4-3") << raw("\x81\x7a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-length-too-short-8-0") << raw("\x81\x7b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-length-too-short-8-7") << raw("\x81\x7b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-length-too-short-1-0") << raw("\x81\x5f\x58") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-length-too-short-2-0") << raw("\x81\x5f\x59") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-length-too-short-2-1") << raw("\x81\x5f\x59\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-length-too-short-4-0") << raw("\x81\x5f\x5a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-length-too-short-4-3") << raw("\x81\x5f\x5a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-length-too-short-8-0") << raw("\x81\x5f\x5b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-length-too-short-8-7") << raw("\x81\x5f\x5b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-length-too-short-1-0") << raw("\x81\x7f\x78") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-length-too-short-2-0") << raw("\x81\x7f\x79") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-length-too-short-2-1") << raw("\x81\x7f\x79\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-length-too-short-4-0") << raw("\x81\x7f\x7a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-length-too-short-4-3") << raw("\x81\x7f\x7a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-length-too-short-8-0") << raw("\x81\x7f\x7b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-length-too-short-8-7") << raw("\x81\x7f\x7b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-2-length-too-short-1-0") << raw("\x81\x5f\x40\x58") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-2-length-too-short-2-0") << raw("\x81\x5f\x40\x59") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-2-length-too-short-2-1") << raw("\x81\x5f\x40\x59\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-2-length-too-short-4-0") << raw("\x81\x5f\x40\x5a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-2-length-too-short-4-3") << raw("\x81\x5f\x40\x5a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-2-length-too-short-8-0") << raw("\x81\x5f\x40\x5b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-2-length-too-short-8-7") << raw("\x81\x5f\x40\x5b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-2-length-too-short-1-0") << raw("\x81\x7f\x60\x78") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-2-length-too-short-2-0") << raw("\x81\x7f\x60\x79") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-2-length-too-short-2-1") << raw("\x81\x7f\x60\x79\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-2-length-too-short-4-0") << raw("\x81\x7f\x60\x7a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-2-length-too-short-4-3") << raw("\x81\x7f\x60\x7a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-2-length-too-short-8-0") << raw("\x81\x7f\x60\x7b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-2-length-too-short-8-7") << raw("\x81\x7f\x60\x7b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-length-too-short-1-0") << raw("\x81\x98") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-length-too-short-2-0") << raw("\x81\x99") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-length-too-short-2-1") << raw("\x81\x99\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-length-too-short-4-0") << raw("\x81\x9a") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-length-too-short-4-3") << raw("\x81\x9a\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-length-too-short-8-0") << raw("\x81\x9b") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-length-too-short-8-7") << raw("\x81\x9b\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-length-too-short-1-0") << raw("\x81\xb8") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-length-too-short-2-0") << raw("\x81\xb9") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-length-too-short-2-1") << raw("\x81\xb9\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-length-too-short-4-0") << raw("\x81\xba") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-length-too-short-4-3") << raw("\x81\xba\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-length-too-short-8-0") << raw("\x81\xbb") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-length-too-short-8-7") << raw("\x81\xbb\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("tag-too-short-1-0") << raw("\x81\xd8") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("tag-too-short-2-0") << raw("\x81\xd9") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("tag-too-short-2-1") << raw("\x81\xd9\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("tag-too-short-4-0") << raw("\x81\xda") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("tag-too-short-4-3") << raw("\x81\xda\x01\x02\x03") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("tag-too-short-8-0") << raw("\x81\xdb") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("tag-too-short-8-7") << raw("\x81\xdb\1\2\3\4\5\6\7") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("fp16-too-short1") << raw("\x81\xf9") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("fp16-too-short2") << raw("\x81\xf9\x00") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("float-too-short1") << raw("\x81\xfa") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("float-too-short2") << raw("\x81\xfa\0\0\0") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("double-too-short1") << raw("\x81\xfb") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("double-too-short2") << raw("\x81\xfb\0\0\0\0\0\0\0") << 0 << CborErrorUnexpectedEOF;

    QTest::newRow("bytearray-too-short1") << raw("\x81\x42z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-too-short2") << raw("\x81\x58\x02z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-too-short3") << raw("\x81\x5a\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-too-short4") << raw("\x81\x5b\0\0\0\0\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-too-short1") << raw("\x81\x62z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-too-short2") << raw("\x81\x78\x02z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-too-short3") << raw("\x81\x7a\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-too-short4") << raw("\x81\x7b\0\0\0\0\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short1") << raw("\x81\x5f\x42z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short2") << raw("\x81\x5f\x58\x02z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short3") << raw("\x81\x5f\x5a\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short4") << raw("\x81\x5f\x5b\0\0\0\0\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short1") << raw("\x81\x7f\x62z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short2") << raw("\x81\x7f\x78\x02z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short3") << raw("\x81\x7f\x7a\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short4") << raw("\x81\x7f\x7b\0\0\0\0\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short1x2") << raw("\x81\x5f\x40\x42z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short2x2") << raw("\x81\x5f\x40\x58\x02z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short3x2") << raw("\x81\x5f\x40\x5a\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-chunked-too-short4x2") << raw("\x81\x5f\x40\x5b\0\0\0\0\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short1x2") << raw("\x81\x7f\x60\x62z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short2x2") << raw("\x81\x7f\x60\x78\x02z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short3x2") << raw("\x81\x7f\x60\x7a\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-chunked-too-short4x2") << raw("\x81\x7f\x60\x7b\0\0\0\0\0\0\0\2z") << 0 << CborErrorUnexpectedEOF;

    QTest::newRow("bytearray-no-break1") << raw("\x81\x5f") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("bytearray-no-break2") << raw("\x81\x5f\x40") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-no-break1") << raw("\x81\x7f") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("string-no-break2") << raw("\x81\x7f\x60") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-no-break1") << raw("\x81\x9f") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("array-no-break2") << raw("\x81\x9f\0") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-no-break1") << raw("\x81\xbf") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-no-break2") << raw("\x81\xbf\0\0") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("map-break-after-key") << raw("\x81\xbf\0\xff") << 0 << CborErrorUnexpectedBreak;
    QTest::newRow("map-break-after-second-key") << raw("\x81\xbf\x64xyzw\x04\x00\xff") << 0 << CborErrorUnexpectedBreak;
    QTest::newRow("map-break-after-value-tag") << raw("\x81\xbf\0\xc0\xff") << 0 << CborErrorUnexpectedBreak;
    QTest::newRow("map-break-after-value-tag2") << raw("\x81\xbf\0\xd8\x20\xff") << 0 << CborErrorUnexpectedBreak;

    // check for pointer additions wrapping over the limit of the address space
    auto wraparoundError = [minInvalid](uint64_t encodedSize) {
        if (encodedSize > minInvalid)
            return CborErrorDataTooLarge;
        return CborErrorUnexpectedEOF;
    };
    constexpr uint64_t FourGB = UINT32_MAX + UINT64_C(1);
    // on 32-bit systems, this is a -1
    QTest::newRow("bytearray-wraparound1") << raw("\x81\x5a\xff\xff\xff\xff") << 0 << wraparoundError(UINT32_MAX);
    QTest::newRow("string-wraparound1") << raw("\x81\x7a\xff\xff\xff\xff") << 0 << wraparoundError(UINT32_MAX);
    // on 32-bit systems, a 4GB addition could be dropped
    QTest::newRow("bytearray-wraparound2") << raw("\x81\x5b\0\0\0\1\0\0\0\0") << 0 << wraparoundError(FourGB);
    QTest::newRow("string-wraparound2") << raw("\x81\x7b\0\0\0\1\0\0\0\0") << 0 << wraparoundError(FourGB);
    // on 64-bit systems, this could be a -1
    QTest::newRow("bytearray-wraparound3") << raw("\x81\x5b\xff\xff\xff\xff\xff\xff\xff\xff") << 0
                                           << wraparoundError(UINT64_MAX);
    QTest::newRow("string-wraparound3") << raw("\x81\x7b\xff\xff\xff\xff\xff\xff\xff\xff") << 0
                                        << wraparoundError(UINT64_MAX);

    // ditto on chunks
    QTest::newRow("bytearray-chunk-wraparound1") << raw("\x81\x5f\x5a\xff\xff\xff\xff") << 0 << wraparoundError(UINT32_MAX);
    QTest::newRow("string-chunk-wraparound1") << raw("\x81\x7f\x7a\xff\xff\xff\xff") << 0 << wraparoundError(UINT32_MAX);
    // on 32-bit systems, a 4GB addition could be dropped
    QTest::newRow("bytearray-chunk-wraparound2") << raw("\x81\x5f\x5b\0\0\0\1\0\0\0\0") << 0 << wraparoundError(FourGB);
    QTest::newRow("string-chunk-wraparound2") << raw("\x81\x7f\x7b\0\0\0\1\0\0\0\0") << 0 << wraparoundError(FourGB);
    // on 64-bit systems, this could be a -1
    QTest::newRow("bytearray-chunk-wraparound3") << raw("\x81\x5f\x5b\xff\xff\xff\xff\xff\xff\xff\xff") << 0
                                                 << wraparoundError(UINT64_MAX);
    QTest::newRow("string-chunk-wraparound3") << raw("\x81\x7f\x7b\xff\xff\xff\xff\xff\xff\xff\xff") << 0
                                              << wraparoundError(UINT64_MAX);

    QTest::newRow("eof-after-array") << raw("\x81") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-array2") << raw("\x81\x78\x20") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-array-element") << raw("\x81\x82\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-object") << raw("\x81\xa1") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-object2") << raw("\x81\xb8\x20") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-object-key") << raw("\x81\xa1\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-object-value") << raw("\x81\xa2\x01\x01") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-tag") << raw("\x81\xc0") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("eof-after-tag2") << raw("\x81\xd8\x20") << 0 << CborErrorUnexpectedEOF;

    // major type 7 has future types
    QTest::newRow("future-type-28") << raw("\x81\xfc") << 0 << CborErrorUnknownType;
    QTest::newRow("future-type-29") << raw("\x81\xfd") << 0 << CborErrorUnknownType;
    QTest::newRow("future-type-30") << raw("\x81\xfe") << 0 << CborErrorUnknownType;
    QTest::newRow("unexpected-break") << raw("\x81\xff") << 0 << CborErrorUnexpectedBreak;
    QTest::newRow("illegal-simple-0") << raw("\x81\xf8\0") << 0 << CborErrorIllegalSimpleType;
    QTest::newRow("illegal-simple-31") << raw("\x81\xf8\x1f") << 0 << CborErrorIllegalSimpleType;

    // not only too big (UINT_MAX or UINT_MAX+1 in size), but also incomplete
    if (sizeof(size_t) < sizeof(uint64_t)) {
        QTest::newRow("bytearray-too-big1") << raw("\x81\x5b\0\0\0\1\0\0\0\0") << 0 << CborErrorDataTooLarge;
        QTest::newRow("string-too-big1") << raw("\x81\x7b\0\0\0\1\0\0\0\0") << 0 << CborErrorDataTooLarge;
    }
    QTest::newRow("array-too-big1") << raw("\x81\x9a\xff\xff\xff\xff\0\0\0\0") << 0 << CborErrorDataTooLarge;
    QTest::newRow("array-too-big2") << raw("\x81\x9b\0\0\0\1\0\0\0\0") << 0 << CborErrorDataTooLarge;
    QTest::newRow("object-too-big1") << raw("\x81\xba\xff\xff\xff\xff\0\0\0\0") << 0 << CborErrorDataTooLarge;
    QTest::newRow("object-too-big2") << raw("\x81\xbb\0\0\0\1\0\0\0\0") << 0 << CborErrorDataTooLarge;

    QTest::newRow("no-break-for-array0") << raw("\x81\x9f") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("no-break-for-array1") << raw("\x81\x9f\x01") << 0 << CborErrorUnexpectedEOF;

    QTest::newRow("no-break-string0") << raw("\x81\x7f") << 0 << CborErrorUnexpectedEOF;
    QTest::newRow("no-break-string1") << raw("\x81\x7f\x61Z") << 0 << CborErrorUnexpectedEOF;

    QTest::newRow("nested-indefinite-length-bytearrays") << raw("\x81\x5f\x5f\xff\xff") << 0 << CborErrorIllegalNumber;
    QTest::newRow("nested-indefinite-length-strings") << raw("\x81\x7f\x7f\xff\xff") << 0 << CborErrorIllegalNumber;

    QTest::newRow("string-chunk-unsigned") << raw("\x81\x7f\0\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-negative") << raw("\x81\x7f\x20\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-bytearray") << raw("\x81\x7f\x40\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-array") << raw("\x81\x7f\x80\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-map") << raw("\x81\x7f\xa0\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-tag") << raw("\x81\x7f\xc0\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-tagged-string") << raw("\x81\x7f\xc0\x60\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-simple0") << raw("\x81\x7f\xe0\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-false") << raw("\x81\x7f\xf4\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-true") << raw("\x81\x7f\xf5\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-null") << raw("\x81\x7f\xf6\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("string-chunk-undefined") << raw("\x81\x7f\xf7\xff") << 0 << CborErrorIllegalType;

    QTest::newRow("bytearray-chunk-string") << raw("\x81\x5f\x60\xff") << 0 << CborErrorIllegalType;
    QTest::newRow("bytearray-chunk-tagged-bytearray") << raw("\x81\x7f\xc0\x40\xff") << 0 << CborErrorIllegalType;

    // RFC 7049 Section 2.2.2 "Indefinite-Length Byte Strings and Text Strings" says
    //    Text strings with indefinite lengths act the same as byte strings
    //    with indefinite lengths, except that all their chunks MUST be
    //    definite-length text strings.  Note that this implies that the bytes
    //    of a single UTF-8 character cannot be spread between chunks: a new
    //    chunk can only be started at a character boundary.
    // This test technically tests the dumper, not the parser.
    QTest::newRow("string-utf8-chunk-split") << raw("\x81\x7f\x61\xc2\x61\xa0\xff") << 0 << CborErrorInvalidUtf8TextString;
}
} // namespace
