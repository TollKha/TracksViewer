#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "track.h"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<Track>("com.anatoliy.track_type", 1, 0, "TrackType");
    qmlRegisterType<Track>("com.anatoliy.track", 1, 0, "Track");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
