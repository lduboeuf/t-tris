#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("ttris.lduboeuf");
        //app.setOrganizationDomain("ttbn.lduboeuf");
    app.setApplicationName("ttris.lduboeuf");

    QQmlApplicationEngine engine;
    engine.addImportPath("qrc:/qml/");
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
