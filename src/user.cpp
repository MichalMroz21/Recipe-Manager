#include "user.hpp"
#include "qsqlerror.h"

User::User(QObject *parent) : QObject{parent}{}

QString User::getPassword() const{
    return password;
}

void User::setPassword(const QString& newPassword){
    password = newPassword;
}

QString User::getLogin() const{
    return login;
}

void User::setLogin(const QString& newLogin){
    login = newLogin;
}

void User::setPasswordAndLogin(const QString& newLogin, const QString& newPassword){
    login = newLogin;
    password = newPassword;
}

bool User::checkCredentials(){

    QSqlQuery query{};

    bool isValid{false};

    //validate_credentials(IN in_login VARCHAR(20), IN in_password VARCHAR(20), OUT out_is_valid BOOLEAN)
    query.prepare("CALL validate_credentials(?, ?, ?)");

    query.addBindValue(login);
    query.addBindValue(password);
    query.addBindValue(isValid, QSql::Out);

    if(query.exec()){
        isValid = query.boundValue(2).toBool();
    }

    else{
        qWarning() << "Failed to execute validate_credentials: " << query.lastError().text();
    }

    return isValid;
}

void User::registerUser(){

    if(password.size() > MAX_PASSWORD_LENGTH){
        qWarning() << "Password length is too big!";
        return;
    }

    if(login.size() > MAX_LOGIN_LENGTH){
        qWarning() << "Login length is too big!";
        return;
    }

    QSqlQuery query{};

    //insert_user(IN in_login VARCHAR(20), IN in_password VARCHAR(20))
    query.prepare("CALL insert_user(?, ?)");

    query.addBindValue(login);
    query.addBindValue(password);

    if(query.exec()){
        qInfo() << "User registered successfully!";
    }
    else{
        qWarning() << "Failed to execute registerUser: " << query.lastError().text();
    }
}


