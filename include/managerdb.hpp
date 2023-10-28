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

#include "CMakeConfig.hpp"

class ManagerDB : public QObject
{
    Q_OBJECT

private:
    const bool INSERT_RECIPES_CONST = INSERT_RECIPES;
    const QString PATH_TO_RECIPES_CONST = PATH_TO_RECIPES,
                  PATH_TO_RECIPE_IMAGES_CONST = PATH_TO_RECIPE_IMAGES;

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
