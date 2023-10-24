#ifndef MANAGERDB_HPP
#define MANAGERDB_HPP

#include <QObject>

#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlDriver>
#include <QPluginLoader>
#include <QSqlError>

class ManagerDB : public QObject
{
    Q_OBJECT
public:
    explicit ManagerDB(QObject *parent = nullptr);
    void listDrivers();

public slots:
    void connectToDB();
    bool loadDriver();

signals:

};

#endif // MANAGERDB_HPP
