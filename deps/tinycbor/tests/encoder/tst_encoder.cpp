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
#include "cbor.h"

#if QT_VERSION >= QT_VERSION_CHECK(5, 9, 0)
#include <qfloat16.h>
#endif

#include <utility>
namespace t17 {
#ifdef __cpp_lib_as_const
    using std::as_const;
#else
    template <typename T>
    constexpr typename std::add_const<T>::type &as_const(T &t) noexcept { return t; }
    // prevent rvalue arguments:
    template <typename T>
    void as_const(const T &&) = delete;
#endif // __cpp_lib_as_const
} // namespace t17

Q_DECLARE_METATYPE(CborError)
namespace QTest {
template<> char *toString<CborError>(const CborError &err)
{
    return qstrdup(cbor_error_string(err));
}
}

class tst_Encoder : public QObject
{
    Q_OBJECT
private slots:
    void floatAsHalfFloat_data();
    void floatAsHalfFloat();
    void halfFloat_data();
    void halfFloat();
    void floatAsHalfFloatCloseToZero_data();
    void floatAsHalfFloatCloseToZero();
    void floatAsHalfFloatNaN();
    void fixed_data();
    void fixed();
    void strings_data();
    void strings() { fixed(); }
    void arraysAndMaps_data();
    void arraysAndMaps() { fixed(); }
    void tags_data();
    void tags();
    void arrays_data() { tags_data(); }
    void arrays();
    void maps_data() { tags_data(); }
    void maps();

    void writerApi_data() { tags_data(); }
    void writerApi();
    void writerApiFail_data() { tags_data(); }
    void writerApiFail();
    void shortBuffer_data() { tags_data(); }
    void shortBuffer();
    void tooShortArrays_data() { tags_data(); }
    void tooShortArrays();
    void tooShortMaps_data() { tags_data(); }
    void tooShortMaps();
    void tooBigArrays_data() { tags_data(); }
    void tooBigArrays();
    void tooBigMaps_data() { tags_data(); }
    void tooBigMaps();
    void illegalSimpleType_data();
    void illegalSimpleType();

    void encodeRaw_data() { tags_data(); }
    void encodeRaw();
};

#include "tst_encoder.moc"
#include "data.cpp"

static inline bool isOomError(CborError err)
{
    return err == CborErrorOutOfMemory;
}

CborError encodeVariant(CborEncoder *encoder, const QVariant &v)
{
    int type = v.userType();
    switch (type) {
    case QMetaType::Int:
    case QMetaType::LongLong:
        return cbor_encode_int(encoder, v.toLongLong());

    case QMetaType::UInt:
    case QMetaType::ULongLong:
        return cbor_encode_uint(encoder, v.toULongLong());

    case QMetaType::Bool:
        return cbor_encode_boolean(encoder, v.toBool());

    case QMetaType::UnknownType:
        return cbor_encode_undefined(encoder);

    case QMetaType::VoidStar:
        return cbor_encode_null(encoder);

    case QMetaType::Double:
        return cbor_encode_double(encoder, v.toDouble());

    case QMetaType::Float:
        return cbor_encode_float(encoder, v.toFloat());

    case QMetaType::QString: {
        QByteArray string = v.toString().toUtf8();
        return cbor_encode_text_string(encoder, string.constData(), string.length());
    }

    case QMetaType::QByteArray: {
        QByteArray string = v.toByteArray();
        return cbor_encode_byte_string(encoder, reinterpret_cast<const quint8 *>(string.constData()), string.length());
    }

    default:
        if (type == qMetaTypeId<NegativeInteger>())
            return cbor_encode_negative_int(encoder, v.value<NegativeInteger>().abs);
        if (type == qMetaTypeId<SimpleType>())
            return cbor_encode_simple_value(encoder, v.value<SimpleType>().type);
#if QT_VERSION < QT_VERSION_CHECK(5, 9, 0)
        if (type == qMetaTypeId<Float16Standin>())
            return cbor_encode_half_float(encoder, v.constData());
#else
        if (type == qMetaTypeId<qfloat16>())
            return cbor_encode_half_float(encoder, v.constData());
#endif
        if (type == qMetaTypeId<Tag>()) {
            CborError err = cbor_encode_tag(encoder, v.value<Tag>().tag);
            if (err && !isOomError(err))
                return err;
            return static_cast<CborError>(err | encodeVariant(encoder, v.value<Tag>().tagged));
        }
        if (type == QMetaType::QVariantList || type == qMetaTypeId<IndeterminateLengthArray>()) {
            CborEncoder sub;
            QVariantList list = v.toList();
            size_t len = list.length();
            if (type == qMetaTypeId<IndeterminateLengthArray>()) {
                len = CborIndefiniteLength;
                list = v.value<IndeterminateLengthArray>();
            }
            CborError err = cbor_encoder_create_array(encoder, &sub, len);
            if (err && !isOomError(err))
                return err;
            for (const QVariant &v2 : t17::as_const(list)) {
                err = static_cast<CborError>(err | encodeVariant(&sub, v2));
                if (err && !isOomError(err))
                    return err;
            }
            return cbor_encoder_close_container_checked(encoder, &sub);
        }
        if (type == qMetaTypeId<Map>() || type == qMetaTypeId<IndeterminateLengthMap>()) {
            CborEncoder sub;
            Map map = v.value<Map>();
            size_t len = map.length();
            if (type == qMetaTypeId<IndeterminateLengthMap>()) {
                len = CborIndefiniteLength;
                map = v.value<IndeterminateLengthMap>();
            }
            CborError err = cbor_encoder_create_map(encoder, &sub, len);
            if (err && !isOomError(err))
                return err;
            for (auto pair : map) {
                err = static_cast<CborError>(err | encodeVariant(&sub, pair.first));
                if (err && !isOomError(err))
                    return err;
                err = static_cast<CborError>(err | encodeVariant(&sub, pair.second));
                if (err && !isOomError(err))
                    return err;
            }
            return cbor_encoder_close_container_checked(encoder, &sub);
        }
    }
    return CborErrorUnknownType;
}

template <typename Input, typename FnUnderTest>
void encodeOne(Input input, FnUnderTest fn_under_test, QByteArray &buffer, CborError &error)
{
    uint8_t *bufptr = reinterpret_cast<quint8 *>(buffer.data());
    CborEncoder encoder;
    cbor_encoder_init(&encoder, bufptr, buffer.length(), 0);

    error = fn_under_test(&encoder, input);

    if (error == CborNoError) {
        QCOMPARE(encoder.remaining, size_t(1));
        QCOMPARE(cbor_encoder_get_extra_bytes_needed(&encoder), size_t(0));

        buffer.resize(int(cbor_encoder_get_buffer_size(&encoder, bufptr)));
    }
}

template <typename Input, typename FnUnderTest>
void compare(Input input, FnUnderTest fn_under_test, const QByteArray &output)
{
    QByteArray buffer(output.length(), Qt::Uninitialized);
    CborError error;

    encodeOne(input, fn_under_test, buffer, error);
    if (QTest::currentTestFailed())
        return;

    QCOMPARE(error, CborNoError);
    QCOMPARE(buffer, output);
}

void compare(const QVariant &input, const QByteArray &output)
{
    compare(input, encodeVariant, output);
}

void tst_Encoder::floatAsHalfFloat_data()
{
    addHalfFloat();
}

void tst_Encoder::floatAsHalfFloat()
{
    QFETCH(unsigned, rawInput);
    QFETCH(double, floatInput);
    QFETCH(QByteArray, output);

    if (rawInput == 0U || rawInput == 0x8000U)
        QSKIP("zero values are out of scope of this test case", QTest::SkipSingle);

    if (qIsNaN(floatInput))
        QSKIP("NaN values are out of scope of this test case", QTest::SkipSingle);

    output.prepend('\xf9');

    compare((float)floatInput, cbor_encode_float_as_half_float, output);
}

void tst_Encoder::halfFloat_data()
{
    addHalfFloat();
}

void tst_Encoder::halfFloat()
{
    QFETCH(unsigned, rawInput);
    QFETCH(QByteArray, output);

    uint16_t v = (uint16_t)rawInput;
    output.prepend('\xf9');

    compare(&v, cbor_encode_half_float, output);
}

void tst_Encoder::floatAsHalfFloatCloseToZero_data()
{
    QTest::addColumn<double>("floatInput");

    QTest::newRow("+0") << 0.0;
    QTest::newRow("-0") << -0.0;

    QTest::newRow("below min.denorm") << ldexp(1.0, -14) * ldexp(1.0, -11);
    QTest::newRow("above -min.denorm") << ldexp(-1.0, -14) * ldexp(1.0, -11);
}

void tst_Encoder::floatAsHalfFloatCloseToZero()
{
    QFETCH(double, floatInput);

    QByteArray buffer(4, Qt::Uninitialized);
    CborError error;

    encodeOne((float)floatInput, cbor_encode_float_as_half_float, buffer, error);

    QCOMPARE(error, CborNoError);

    QVERIFY2(
        buffer == raw("\xf9\x00\x00") || buffer == raw("\xf9\x80\x00"),
        "Got value " + QByteArray::number(floatInput) + " encoded to: " + buffer);
}

void tst_Encoder::floatAsHalfFloatNaN()
{
    QByteArray buffer(4, Qt::Uninitialized);
    CborError error;

    encodeOne(myNaNf(), cbor_encode_float_as_half_float, buffer, error);

    QCOMPARE(error, CborNoError);
    QCOMPARE(buffer.size(), 3);

    uint8_t ini_byte = (uint8_t)buffer[0],
        exp = (uint8_t)buffer[1] & 0x7cU,
        manth = (uint8_t)buffer[1] & 0x03U,
        mantl = (uint8_t)buffer[2];

    QCOMPARE((unsigned)ini_byte, 0xf9U);
    QCOMPARE((unsigned)exp, 0x7cU);
    QVERIFY((manth | mantl) != 0);
}

void tst_Encoder::fixed_data()
{
    addColumns();
    addFixedData();
}

void tst_Encoder::fixed()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);
    compare(input, output);
}

void tst_Encoder::strings_data()
{
    addColumns();
    addStringsData();
}

void tst_Encoder::arraysAndMaps_data()
{
    addColumns();
    addArraysAndMaps();
}

void tst_Encoder::tags_data()
{
    addColumns();
    addFixedData();
    addStringsData();
    addArraysAndMaps();
}

void tst_Encoder::tags()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);

    compare(QVariant::fromValue(Tag{1, input}), "\xc1" + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{24, input}), "\xd8\x18" + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{255, input}), "\xd8\xff" + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{256, input}), raw("\xd9\1\0") + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{CborSignatureTag, input}), raw("\xd9\xd9\xf7") + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{65535, input}), raw("\xd9\xff\xff") + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{65536, input}), raw("\xda\0\1\0\0") + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{UINT32_MAX, input}), raw("\xda\xff\xff\xff\xff") + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{UINT32_MAX + Q_UINT64_C(1), input}), raw("\xdb\0\0\0\1\0\0\0\0") + output);
    if (QTest::currentTestFailed()) return;

    compare(QVariant::fromValue(Tag{UINT64_MAX, input}), raw("\xdb\xff\xff\xff\xff\xff\xff\xff\xff") + output);
    if (QTest::currentTestFailed()) return;

    // nested tags
    compare(QVariant::fromValue(Tag{1, QVariant::fromValue(Tag{1, input})}), "\xc1\xc1" + output);
}

void tst_Encoder::arrays()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);

    compare(make_list(input), "\x81" + output);
    if (QTest::currentTestFailed()) return;

    compare(make_list(input, input), "\x82" + output + output);
    if (QTest::currentTestFailed()) return;

    {
        QVariantList list{input};
        QByteArray longoutput = output;

        // make a list with 32 elements (1 << 5)
        for (int i = 0; i < 5; ++i) {
            list += list;
            longoutput += longoutput;
        }
        compare(list, "\x98\x20" + longoutput);
        if (QTest::currentTestFailed()) return;

        // now 256 elements (32 << 3)
        for (int i = 0; i < 3; ++i) {
            list += list;
            longoutput += longoutput;
        }
        compare(list, raw("\x99\1\0") + longoutput);
        if (QTest::currentTestFailed()) return;
    }

    // nested lists
    compare(make_list(make_list(input)), "\x81\x81" + output);
    if (QTest::currentTestFailed()) return;

    compare(make_list(make_list(input, input)), "\x81\x82" + output + output);
    if (QTest::currentTestFailed()) return;

    compare(make_list(make_list(input), input), "\x82\x81" + output + output);
    if (QTest::currentTestFailed()) return;

    compare(make_list(make_list(input), make_list(input)), "\x82\x81" + output + "\x81" + output);
}

void tst_Encoder::maps()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);

    compare(make_map({{1, input}}), "\xa1\1" + output);
    if (QTest::currentTestFailed()) return;

    compare(make_map({{1, input}, {input, 24}}), "\xa2\1" + output + output + "\x18\x18");
    if (QTest::currentTestFailed()) return;

    compare(make_map({{input, input}}), "\xa1" + output + output);
    if (QTest::currentTestFailed()) return;

    {
        Map map{{1, input}};
        QByteArray longoutput = "\1" + output;

        // make a map with 32 elements (1 << 5)
        for (int i = 0; i < 5; ++i) {
            map += map;
            longoutput += longoutput;
        }
        compare(QVariant::fromValue(map), "\xb8\x20" + longoutput);
        if (QTest::currentTestFailed()) return;

        // now 256 elements (32 << 3)
        for (int i = 0; i < 3; ++i) {
            map += map;
            longoutput += longoutput;
        }
        compare(QVariant::fromValue(map), raw("\xb9\1\0") + longoutput);
        if (QTest::currentTestFailed()) return;
    }

    // nested maps
    compare(make_map({{1, make_map({{2, input}})}}), "\xa1\1\xa1\2" + output);
    if (QTest::currentTestFailed()) return;

    compare(make_map({{1, make_map({{2, input}, {input, false}})}}), "\xa1\1\xa2\2" + output + output + "\xf4");
    if (QTest::currentTestFailed()) return;

    compare(make_map({{1, make_map({{2, input}})}, {input, false}}), "\xa2\1\xa1\2" + output + output + "\xf4");
    if (QTest::currentTestFailed()) return;
}

void tst_Encoder::writerApi()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);

    // instead of writing to a QByteArray like all other tests, write to a QBuffer
    QBuffer buffer;
    buffer.open(QIODevice::ReadWrite);
    auto callback = [](void *token, const void *data, size_t len, CborEncoderAppendType) {
        auto buffer = static_cast<QBuffer *>(token);
        buffer->write(static_cast<const char *>(data), len);
        return CborNoError;
    };

    CborEncoder encoder;
    cbor_encoder_init_writer(&encoder, callback, &buffer);
    QCOMPARE(encodeVariant(&encoder, input), CborNoError);

    buffer.reset();
    QCOMPARE(buffer.readAll(), output);
}

void tst_Encoder::writerApiFail()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);

    // same as above, but we'll produce an error during writing and we expect
    // it to be returned
    int callCount = 0;
    auto callback = [](void *token, const void *, size_t, CborEncoderAppendType) {
        ++*static_cast<int *>(token);
        return CborErrorIO;
    };

    CborEncoder encoder;
    cbor_encoder_init_writer(&encoder, callback, &callCount);
    QCOMPARE(encodeVariant(&encoder, input), CborErrorIO);
    QCOMPARE(callCount, 1);
}

void tst_Encoder::shortBuffer()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);
    QByteArray buffer(output.length(), Qt::Uninitialized);

    for (int len = 0; len < output.length(); ++len) {
        CborEncoder encoder;
        cbor_encoder_init(&encoder, reinterpret_cast<quint8 *>(buffer.data()), len, 0);
        QCOMPARE(encodeVariant(&encoder, input), CborErrorOutOfMemory);
        QVERIFY(cbor_encoder_get_extra_bytes_needed(&encoder) != 0);
        QCOMPARE(len + cbor_encoder_get_extra_bytes_needed(&encoder), size_t(output.length()));
    }
}

void tst_Encoder::tooShortArrays()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);
    QByteArray buffer(output.length() + 1, Qt::Uninitialized);

    CborEncoder encoder, container;
    cbor_encoder_init(&encoder, reinterpret_cast<quint8 *>(buffer.data()), buffer.length(), 0);
    QCOMPARE(cbor_encoder_create_array(&encoder, &container, 2), CborNoError);
    QCOMPARE(encodeVariant(&container, input), CborNoError);
    QCOMPARE(container.remaining, size_t(2));
    QCOMPARE(cbor_encoder_close_container_checked(&encoder, &container), CborErrorTooFewItems);
}

void tst_Encoder::tooShortMaps()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);
    QByteArray buffer(output.length() + 1, Qt::Uninitialized);

    CborEncoder encoder, container;
    cbor_encoder_init(&encoder, reinterpret_cast<quint8 *>(buffer.data()), buffer.length(), 0);
    QCOMPARE(cbor_encoder_create_map(&encoder, &container, 2), CborNoError);
    QCOMPARE(encodeVariant(&container, input), CborNoError);
    QCOMPARE(container.remaining, size_t(4));
    QCOMPARE(cbor_encoder_close_container_checked(&encoder, &container), CborErrorTooFewItems);
}

void tst_Encoder::tooBigArrays()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);
    QByteArray buffer(output.length() * 2 + 1, Qt::Uninitialized);

    CborEncoder encoder, container;
    cbor_encoder_init(&encoder, reinterpret_cast<quint8 *>(buffer.data()), buffer.length(), 0);
    QCOMPARE(cbor_encoder_create_array(&encoder, &container, 1), CborNoError);
    QCOMPARE(encodeVariant(&container, input), CborNoError);
    QCOMPARE(encodeVariant(&container, input), CborNoError);
    QCOMPARE(container.remaining, size_t(0));
    QCOMPARE(cbor_encoder_close_container_checked(&encoder, &container), CborErrorTooManyItems);
}

void tst_Encoder::tooBigMaps()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);
    QByteArray buffer(output.length() * 3 + 1, Qt::Uninitialized);

    CborEncoder encoder, container;
    cbor_encoder_init(&encoder, reinterpret_cast<quint8 *>(buffer.data()), buffer.length(), 0);
    QCOMPARE(cbor_encoder_create_map(&encoder, &container, 1), CborNoError);
    QCOMPARE(encodeVariant(&container, input), CborNoError);
    QCOMPARE(encodeVariant(&container, input), CborNoError);
    QCOMPARE(encodeVariant(&container, input), CborNoError);
    QCOMPARE(container.remaining, size_t(0));
    QCOMPARE(cbor_encoder_close_container_checked(&encoder, &container), CborErrorTooManyItems);
}

void tst_Encoder::illegalSimpleType_data()
{
    QTest::addColumn<int>("type");
    QTest::newRow("half-float") << 25;
    QTest::newRow("float") << 26;
    QTest::newRow("double") << 27;
    QTest::newRow("28") << 28;
    QTest::newRow("29") << 29;
    QTest::newRow("30") << 30;
    QTest::newRow("31") << 31;
}

void tst_Encoder::illegalSimpleType()
{
    QFETCH(int, type);

    quint8 buf[2];
    CborEncoder encoder;
    cbor_encoder_init(&encoder, buf, sizeof(buf), 0);
    QCOMPARE(cbor_encode_simple_value(&encoder, type), CborErrorIllegalSimpleType);
}

void tst_Encoder::encodeRaw()
{
    QFETCH(QVariant, input);
    QFETCH(QByteArray, output);

    // just confirm it copies the data
    QByteArray buffer(output.length(), Qt::Uninitialized);

    uint8_t *bufptr = reinterpret_cast<quint8 *>(buffer.data());
    CborEncoder encoder;
    cbor_encoder_init(&encoder, bufptr, buffer.length(), 0);

    CborError error = cbor_encode_raw(&encoder, reinterpret_cast<quint8 *>(output.data()),
                                      output.size());
    QCOMPARE(error, CborNoError);
    QCOMPARE(buffer, output);
}

QTEST_MAIN(tst_Encoder)
