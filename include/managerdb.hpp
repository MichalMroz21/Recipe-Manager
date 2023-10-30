#ifndef MANAGERDB_HPP
#define MANAGERDB_HPP

#include <QObject>

#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlDriver>
#include <QPluginLoader>
#include <QSqlError>

#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>

#include <QImage>
#include <QBuffer>

#include "user.hpp"

class ManagerDB : public QObject
{
    Q_OBJECT
private:
    QSqlDatabase db{};

public:
    explicit ManagerDB(User* user, QObject *parent = nullptr);
    ~ManagerDB();

    void listDrivers();
    void convertFractions(QString& input);

    QByteArray imageToBinary(QString& curr);

public slots:
    void setupDB();
    void insertRecipes(); //Requires connecting as an admin user

    bool loadDriver();
    void makeThreadConnection(QSqlDatabase& dbThread);

signals:
    void sendDBUser(QSqlDatabase db);
};

#endif // MANAGERDB_HPP
