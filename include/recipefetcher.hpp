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

#include <QPixmap>

#include "managerdb.hpp"

class RecipeFetcher : public QObject
{
    Q_OBJECT
private:
    QList<QList<QString>> recipesStrings{};
    QList<QByteArray> recipesImages{};

public:
    explicit RecipeFetcher(ManagerDB* man, QObject *parent = nullptr);
    ~RecipeFetcher();

    QSqlDatabase db{};

    void clearRecipes();

    void setRecipesStrings(const QList<QList<QString> > &newRecipesStrings);
    void setRecipesImages(const QList<QByteArray> &newRecipesImages);

public slots:
    QList<QList<QString> > getRecipesStrings();
    QList<QByteArray> getRecipesImages();

    QString loadImage(int index);

    void searchByTitle(QString title);
    void searchByTitleAsync(QString title);

signals:
    void titleSearchFinished(bool success, QString error);
    void makeThreadConnection(QSqlDatabase& db);

};

#endif // RECIPEFETCHER_HPP
