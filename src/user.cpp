#include "user.hpp"
#include "qsqlerror.h"


User::User(QObject* parent) {}

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
    isLoggedIn = checkCredentials();
    if(isLoggedIn) emit changeLoginError("User successfully logged in!");
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
    }

    else{
        QString fullErrorMsg = query.lastError().text();
        emit changeLoginError(extractError(fullErrorMsg));
        qWarning() << QString("Failed to execute %1: %2").arg(Q_FUNC_INFO, fullErrorMsg);    
    }

    return isValid;
}

void User::registerUser(const QString& confirmPassword){

    bool credValid = true;
    QString guiMessage{}, color{"red"};

    if(confirmPassword != password){
        guiMessage = "Passwords do not match!";
        credValid = false;
    }

    if(password.size() > MAX_PASSWORD_LENGTH){
        guiMessage = "Password length is too big!";
        credValid = false;
    }

    if(login.size() > MAX_LOGIN_LENGTH){
        guiMessage = "Login length is too big!";
        credValid = false;
    }

    if(credValid == false){
        emit changeRegisterError(guiMessage);
        return;
    }

    QSqlQuery query{};

    //insert_user(IN in_login VARCHAR(20), IN in_password VARCHAR(20))
    query.prepare("CALL insert_user(?, ?)");

    query.addBindValue(login);
    query.addBindValue(password);

    if(query.exec()){
        guiMessage = "User registered successfully!";
        color = "green";
    }

    else{
        QString fullErrorMsg = query.lastError().text();

        guiMessage = extractError(fullErrorMsg);

        qWarning() << QString("Failed to execute %1: %2").arg(Q_FUNC_INFO, fullErrorMsg);
    }

    emit changeRegisterError(guiMessage, color);
}


