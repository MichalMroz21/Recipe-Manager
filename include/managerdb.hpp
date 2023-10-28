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


class ManagerDB : public QObject
{
    Q_OBJECT
public:
    explicit ManagerDB(QObject *parent = nullptr);

    void listDrivers();
    void convertFractions(QString& input);

    QByteArray imageToBinary(QString& curr);

public slots:
    void setupDB();
    void insertRecipes(); //Requires connecting as an admin user

    bool loadDriver();

signals:

};

#endif // MANAGERDB_HPP
