#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "managerdb.hpp"
#include "debug_interceptor.hpp"

int main(int argc, char *argv[]){

    QGuiApplication app(argc, argv);

    QSharedPointer<Debug_Interceptor> debugInterceptor{ Debug_Interceptor::getInstance() };

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/RecipeManager/src_gui/Main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    QSharedPointer<ManagerDB> managerDB{ QSharedPointer<ManagerDB>(new ManagerDB()) };

    managerDB->loadDriver();
    managerDB->connectDB();

    return app.exec();
}
