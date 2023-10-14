#include "managerdb.hpp"

ManagerDB::ManagerDB(QObject *parent) : QObject{parent}{}

void ManagerDB::connectDB() const{

    qInfo() << "Opening Database";

    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");

    db.setHostName("db4free.net");

    db.setDatabaseName("");
    db.setUserName("");
    db.setPassword("");

    if(!db.open()){
        qCritical() << "Failed to connect!";
        qCritical() << db.lastError().text();
        return;
    }

    qInfo() << "Connected successfully";
    db.close();
}

bool ManagerDB::loadDriver(){

    qInfo() << "Loading driver/plugin";

    QPluginLoader loader("/home/roditu/Qt/6.5.1/gcc_64/plugins/sqldrivers/libqsqlmysql.so");

    qInfo() << loader.metaData();

    if(loader.load()){
        qInfo() << "Loaded the plugin";
        return true;
    }

    qCritical() << loader.errorString();
    return false;
}

void ManagerDB::listDrivers() const {

    qInfo() << "Listing drivers";

    foreach(QString driver, QSqlDatabase::drivers()){
        qInfo() << driver;

        QSqlDatabase db = QSqlDatabase::addDatabase(driver);
        QSqlDriver *obj = db.driver();

        qInfo() << "Transactions: " << obj->hasFeature(QSqlDriver::DriverFeature::Transactions);
        qInfo() << "QuerySize: " << obj->hasFeature(QSqlDriver::DriverFeature::QuerySize);
        qInfo() << "BLOB: " << obj->hasFeature(QSqlDriver::DriverFeature::BLOB);
        qInfo() << "Unicode: " << obj->hasFeature(QSqlDriver::DriverFeature::Unicode);
        qInfo() << "PreparedQueries: " << obj->hasFeature(QSqlDriver::DriverFeature::PreparedQueries);
        qInfo() << "NamedPlaceholders: " << obj->hasFeature(QSqlDriver::DriverFeature::NamedPlaceholders);
        qInfo() << "PositionalPlaceholders: " << obj->hasFeature(QSqlDriver::DriverFeature::PositionalPlaceholders);
        qInfo() << "LastInsertId: " << obj->hasFeature(QSqlDriver::DriverFeature::LastInsertId);
        qInfo() << "BatchOperations: " << obj->hasFeature(QSqlDriver::DriverFeature::BatchOperations);
        qInfo() << "SimpleLocking: " << obj->hasFeature(QSqlDriver::DriverFeature::SimpleLocking);
        qInfo() << "LowPrecisionNumbers: " << obj->hasFeature(QSqlDriver::DriverFeature::LowPrecisionNumbers);
        qInfo() << "EventNotifications: " << obj->hasFeature(QSqlDriver::DriverFeature::EventNotifications);
        qInfo() << "FinishQuery: " << obj->hasFeature(QSqlDriver::DriverFeature::FinishQuery);
        qInfo() << "MultipleResultSets: " << obj->hasFeature(QSqlDriver::DriverFeature::MultipleResultSets);
        qInfo() << "CancelQuery: " << obj->hasFeature(QSqlDriver::DriverFeature::CancelQuery);
    }
}
