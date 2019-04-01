QT += quick quickcontrols2 svg
CONFIG += c++11
unix {
    #PKG_CONFIG = PKG_CONFIG_PATH=/usr/local/ssl/lib/pkgconfig/
    #PKG_CONFIG = PKG_CONFIG = PKG_CONFIG_PATH=/usr/local/ssl/lib/pkgconfig/
   ## LIBS += -LC:/home/lionel/dev/tools/openssl/openssl-1.0.2k -lssl -lcrypto
    #LIBS += -LC:/usr/include/openssl/
    #CONFIG += link_pkgconfig
    #PKGCONFIG += openssl
}
#LIBS += -LC:/home/lionel/dev/tools/openssl/openssl-1.0.2k -lssl -lcrypto

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += \
     main.cpp

RESOURCES += qml.qrc \
    assets/assets.qrc \
    js/js.qrc


#Translation
TRANSLATIONS = i18n/base_fr.ts i18n/base_de.ts i18n/base_es.ts

lupdate_only{
    SOURCES = *.qml
}

# Installation path
# target.path =
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    qml/qmldir \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    qml/Model/qmldir

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}

