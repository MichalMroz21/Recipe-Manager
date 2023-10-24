#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "managerdb.hpp"
#include "debug_interceptor.hpp"

#include "CMakeConfig.hpp"

int main(int argc, char *argv[]){

    QGuiApplication app(argc, argv);

    auto debugInterceptor{ Debug_Interceptor::getInstance() };
    auto managerDB{ QSharedPointer<ManagerDB>(new ManagerDB()) };

    QQmlApplicationEngine engine;

    //add objects to Main.qml
    engine.rootContext()->setContextProperty("ROOT_PATH", ROOT_PATH);
    engine.rootContext()->setContextProperty("managerDB", managerDB.data());

    const QUrl url(u"qrc:/RecipeManager/src_gui/Main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    //connect gui signals with some db slots before .exec()

    return app.exec();
}
