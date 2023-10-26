#include "user.hpp"
#include "qsqlerror.h"

User::User(QObject *parent) : QObject{parent}{}

bool User::getIsLoggedIn() const{
    return isLoggedIn;
}

void User::setIsLoggedIn(bool newIsLoggedIn){
    isLoggedIn = newIsLoggedIn;
}

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

void User::loginUser(){
    bool isValid = checkCredentials();

    isLoggedIn = isValid;

    if(isLoggedIn) qInfo() << "User successfully logged in!";
    else qWarning() << "User failed to log in!";
}

QString User::extractError(const QString& errorMsg){
    return errorMsg.left(errorMsg.lastIndexOf('.'));
}

bool User::checkCredentials(){

    QSqlQuery query{};

    bool isValid{false};

    //validate_credentials(in_login VARCHAR(20), in_password VARCHAR(20)) RETURNS BOOLEAN
    query.prepare("SELECT validate_credentials(?, ?)");

    query.bindValue(0, login);
    query.bindValue(1, password);

    if(query.exec()){

        if(query.next()){
            isValid = query.value(0).toBool();
        }
        else {
            qWarning() << "No result from the function validate_credentials";
        }

        qInfo() << isValid;
    }

    else{
        QString fullErrorMsg = query.lastError().text(),
                guiMessage = extractError(fullErrorMsg);

        qWarning() << QString("Failed to execute %1: %2").arg(Q_FUNC_INFO, fullErrorMsg);
    }

    return isValid;
}

void User::registerUser(const QString& confirmPassword){

    if(confirmPassword != password){
        qWarning() << "Passwords do not match!";
        return;
    }

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
        QString fullErrorMsg = query.lastError().text(),
            guiMessage = extractError(fullErrorMsg);

        qWarning() << QString("Failed to execute %1: %2").arg(Q_FUNC_INFO, fullErrorMsg);
    }
}


