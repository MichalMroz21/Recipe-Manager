#include "user.hpp"
#include "qsqlerror.h"


void User::setProfileImg(const QByteArray &newProfileImg)
{
    profileImg = newProfileImg;
}

QString User::getProfileImg() const
{
    return profileImg;
}

void User::setDescription(const QString &newDescription)
{
    description = newDescription;
}

QString User::getDescription() const
{
    return description;
}

QString User::getJoinDate() const
{
    return joinDate;
}

User::User(QObject* parent) {}

bool User::getIsLoggedIn() const{
    return isLoggedIn;
}

void User::sendDBUser(QSqlDatabase db)
{
    this->db = db;
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

QByteArray User::imageToBinary(QString &curr)
{

    QImage image(curr);

    if (image.isNull()) {
        qWarning() << "Failed to load image.";
        return QByteArray();
    }

    QByteArray byteArray;
    QBuffer buffer(&byteArray);

    buffer.open(QIODevice::WriteOnly);

    if (!image.save(&buffer, "JPG")) {
        qWarning() << "Failed to convert image to binary.";
        return QByteArray();
    }

    return byteArray;
}

void User::updateProfileImg(QString fileUrl)
{
    QSqlQuery query{db};

    QString error{};

    bool success = true;

    fileUrl.replace("file://", "");

    QByteArray imgBin = imageToBinary(fileUrl);

    if(imgBin.size() == 0){
        success = false;
        error = "Invalid selected image!";
    }

    else{
        query.prepare(QString("CALL update_profile_img('%1', '%2', :img_bin)").arg(login, password));
        query.bindValue(":img_bin", imgBin, QSql::Binary);

        //PROCEDURE update_profile_img(IN in_login VARCHAR(20), IN in_password VARCHAR(20), IN in_img LONGBLOB)
        if (!query.exec()){
            error = query.lastError().text();
            success = false;
            qWarning() << "Error executing stored procedure:" << error;
        }
    }

    emit profileUpdated(success, error);
}

void User::setIdUsingLogin()
{
    QSqlQuery query{db};

    //FUNCTION validate_credentials(in_login VARCHAR(20), in_password VARCHAR(20)) RETURNS BOOLEAN
    query.prepare("SELECT get_id_with_login(?)");

    query.bindValue(0, login);

    if(query.exec()){

        if(query.next()){
            id = query.value(0).toInt();
        }
        else{
            qWarning() << "No result from the function get_id_with_login";
        }
    }

    else{
        QString fullErrorMsg = query.lastError().text();
        emit changeLoginError(extractError(fullErrorMsg));
        qWarning() << QString("Failed to execute %1: %2").arg(Q_FUNC_INFO, fullErrorMsg);
    }
}

void User::getUserDataUsingID()
{
    QSqlQuery query{db};

    QString error{};

    bool success = true;

    if (!query.exec(QString("CALL get_user_data('%1', '%2')").arg(login, password))){
        error = query.lastError().text();
        success = false;
        qWarning() << "Error executing stored procedure:" << error;
    }

    while (query.next()) {
        id = query.value(0).toInt();
        profileImg = query.value(3).toByteArray().toBase64();
        joinDate = query.value(4).toString();
        description = query.value(5).toString();
    }

    emit userDataObtained(success, error);
}


void User::loginUser(){
    isLoggedIn = checkCredentials();
    if(isLoggedIn) emit changeLoginError("User successfully logged in!", "green");
}

QString User::extractError(const QString& errorMsg){
    return errorMsg.left(errorMsg.lastIndexOf('.'));
}

bool User::checkCredentials(){

    QSqlQuery query{db};

    bool isValid{false};

    //FUNCTION validate_credentials(in_login VARCHAR(20), in_password VARCHAR(20)) RETURNS BOOLEAN
    query.prepare("SELECT validate_credentials(?, ?)");

    query.bindValue(0, login);
    query.bindValue(1, password);

    if(query.exec()){

        if(query.next()){
            isValid = query.value(0).toBool();
        }
        else{
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

    QSqlQuery query{db};

    //insert_user(IN in_login VARCHAR(20), IN in_password VARCHAR(20))
    query.prepare("CALL insert_user(?, ?, ?)");

    query.addBindValue(login);
    query.addBindValue(password);
    query.addBindValue(QDateTime::currentDateTime().toString("yyyy-MM-dd"));

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


