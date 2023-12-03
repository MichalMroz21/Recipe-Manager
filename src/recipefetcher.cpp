#include "recipefetcher.hpp"


QList<QList<QString> > RecipeFetcher::getRecipesStrings(){
    return recipesStrings;
}

void RecipeFetcher::setRecipesStrings(const QList<QList<QString> > &newRecipesStrings){
    recipesStrings = newRecipesStrings;
}

QList<QByteArray> RecipeFetcher::getRecipesImages(){
    return recipesImages;
}

QString RecipeFetcher::loadImage(int index)
{
    return recipesImages[index].toBase64();
}

void RecipeFetcher::setRecipesImages(const QList<QByteArray> &newRecipesImages){
    recipesImages = newRecipesImages;
}

RecipeFetcher::RecipeFetcher(ManagerDB* man, QObject *parent) : QObject{parent}{
    QObject::connect(this, &RecipeFetcher::makeThreadConnection, man, &ManagerDB::makeThreadConnection, Qt::BlockingQueuedConnection);
}

RecipeFetcher::~RecipeFetcher(){
    if(db.isOpen()) db.close();
}

void RecipeFetcher::clearRecipes()
{
    foreach(QList<QString> recipe, recipesStrings){
        recipe.clear();
    }

    recipesImages.clear();
    recipesStrings.clear();
}

void RecipeFetcher::searchRecipesAsync(QString title, QString ingredients, bool sortByTitle, bool sortByIngredients){

    emit makeThreadConnection(db);

    QSqlQuery query{db};

    QString error{};

    bool success = true;

    if (!query.exec(QString("CALL search_recipes('%1', '%2', %3, %4)").arg(title, ingredients, sortByTitle ? "true" : "false", sortByIngredients ? "true" : "false"))) {
        error = query.lastError().text();
        success = false;
        qWarning() << "Error executing stored procedure:" << error;
    }

    while (query.next()) {

        QString title = query.value(1).toString();
        QString ingredients = query.value(2).toString();
        QString instructions = query.value(3).toString();
        QByteArray imageBin = query.value(4).toByteArray();

        recipesStrings.append(QList<QString>{title, ingredients, instructions});
        recipesImages.append(imageBin);
    }

    emit searchFinished(success, error);
}

void RecipeFetcher::searchRecipes(QString title, QString ingredients, bool sortByTitle, bool sortByIngredients)
{
    clearRecipes();

    static_cast<void>(QtConcurrent::run([=](){
        searchRecipesAsync(title, ingredients, sortByTitle, sortByIngredients);
    }));
}
