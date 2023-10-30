#include "recipefetcher.hpp"


RecipeFetcher::RecipeFetcher(ManagerDB* man, QObject *parent) : QObject{parent}{
    QObject::connect(this, &RecipeFetcher::makeThreadConnection, man, &ManagerDB::makeThreadConnection, Qt::BlockingQueuedConnection);
}


void RecipeFetcher::searchByTitleAsync(QString title){

    emit makeThreadConnection(db);

    QSqlQuery query{db};

    if (!query.exec(QString("CALL search_by_title('%1')").arg(title))) {
        qWarning() << "Error executing stored procedure:" << query.lastError().text();
        emit titleSearchFinished(false);
    }

    while (query.next()) {

        int id = query.value(0).toInt();

        QString title = query.value(1).toString();
        QString ingredients = query.value(2).toString();
        QString instructions = query.value(3).toString();
        QByteArray imageBin = query.value(4).toByteArray();

        qDebug() << "ID:" << id << " Title:" << title << " Ingredients:" << ingredients << " Instructions:" << instructions;
    }

    emit titleSearchFinished(true);
}



void RecipeFetcher::searchByTitle(QString title)
{
    QtConcurrent::run([=](){
        searchByTitleAsync(title);
    });

}
