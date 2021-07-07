QT += quick quickcontrols2 svg multimedia network sql
CONFIG += c++11

TARGET = ttris


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
TRANSLATIONS = i18n/base_fr.ts i18n/base_de.ts i18n/base_es.ts i18n/base_nl.ts

lupdate_only{
    SOURCES = *.qml
}

# Installation path
# target.path =
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


UBUNTU_TOUCH {
    message("building for Ubuntu Touch")
    target.path = /

    # figure out the current build architecture
    CLICK_ARCH=$$system(dpkg-architecture -qDEB_HOST_ARCH)

    # substitute the architecture in the manifest file
    QMAKE_SUBSTITUTES += $$PWD/manifest.json.in
    manifest.files = manifest.json
    manifest.path = /
    INSTALLS += manifest


    click_files.path = /
    click_files.files = manifest.json ttris.apparmor ttris.desktop

    logo.path = /assets
    logo.files = $$PWD/assets/ttris.png

    INSTALLS+=click_files logo
}


contains(ANDROID_TARGET_ARCH,armeabi-v7a) {

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
    qml/Model/qmldir \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat



    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/android
}

DISTFILES += \
    manifest.json

