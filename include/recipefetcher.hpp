#ifndef RECIPEFETCHER_HPP
#define RECIPEFETCHER_HPP

#include <QObject>

#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlDriver>
#include <QPluginLoader>
#include <QSqlError>

#include <QTimer>
#include <QtConcurrent>
#include <QSqlQuery>

#include "managerdb.hpp"

class RecipeFetcher : public QObject
{
    Q_OBJECT
public:
    explicit RecipeFetcher(ManagerDB* man, QObject *parent = nullptr);

    QSqlDatabase db{};

public slots:
    void searchByTitle(QString title);
    void searchByTitleAsync(QString title);

signals:
    void titleSearchFinished(bool success);
    void makeThreadConnection(QSqlDatabase& db);

};

#endif // RECIPEFETCHER_HPP
