TEMPLATE = app

QT += core gui widgets

SOURCES += main.cpp

ANDROID_EXTRA_LIBS = ../../../libgnustl_shared.so

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

OTHER_FILES += \
    android/AndroidManifest.xml
