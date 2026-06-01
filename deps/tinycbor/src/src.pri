SOURCES += \
    $$PWD/cborencoder.c \
    $$PWD/cborencoder_close_container_checked.c \
    $$PWD/cborencoder_float.c \
    $$PWD/cborerrorstrings.c \
    $$PWD/cborparser.c \
    $$PWD/cborparser_dup_string.c \
    $$PWD/cborparser_float.c \
    $$PWD/cborpretty.c \
    $$PWD/cborpretty_stdio.c \
    $$PWD/cbortojson.c \
    $$PWD/cborvalidation.c \

HEADERS += \
    $$PWD/cbor.h \
    $$PWD/cborinternal_p.h \
    $$PWD/cborjson.h \
    $$PWD/compilersupport_p.h \
    $$PWD/tinycbor-version.h \
    $$PWD/utf8_p.h \


QMAKE_CFLAGS *= $$QMAKE_CFLAGS_SPLIT_SECTIONS
QMAKE_LFLAGS *= $$QMAKE_LFLAGS_GCSECTIONS
INCLUDEPATH += $$PWD
CONFIG(release, debug|release): DEFINES += NDEBUG
