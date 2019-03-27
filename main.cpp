#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QTranslator>
#include <QDebug>
#include <QSslSocket>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("ttris.lduboeuf");
        //app.setOrganizationDomain("ttbn.lduboeuf");
    app.setApplicationName("ttris.lduboeuf");
   // app.setApplicationVersion("0.7");

    QTranslator myappTranslator;

    qDebug()<< myappTranslator.load(QLocale(), QLatin1String("base"), QLatin1String("_"), QLatin1String(":/i18n"));
    app.installTranslator(&myappTranslator);

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/qml/");
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    qDebug()<< "Default path >> "+engine.offlineStoragePath();

    qDebug() << QSslSocket::sslLibraryBuildVersionString();

    return app.exec();
}
