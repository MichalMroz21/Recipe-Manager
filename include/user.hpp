#ifndef USER_HPP
#define USER_HPP

#include <QObject>
#include <QSqlQuery>
#include <QQmlProperty>
#include <QDateTime>

#include <QImage>
#include <QBuffer>

#include "CMakeConfig.hpp"

constexpr int MAX_PASSWORD_LENGTH = MAX_CREDENTIAL_LENGTH,
              MAX_LOGIN_LENGTH = MAX_CREDENTIAL_LENGTH;

class User : public QObject
{
    Q_OBJECT
private:
    QSqlDatabase db{};
    QString password{}, login{}, description{}, joinDate{};
    int id{};
    bool isLoggedIn{};
    QString profileImg{};

public:
    explicit User(QObject *parent = nullptr);

    QString getPassword() const;
    void setPassword(const QString& newPassword);


    void setLogin(const QString& newLogin);

    void setIsLoggedIn(bool newIsLoggedIn);

    QString extractError(const QString& errorMsg);

    void setProfileImg(const QByteArray &newProfileImg);
    void setDescription(const QString &newDescription);

public slots:
    bool checkCredentials();
    void registerUser(const QString& confirmPassword);
    void setPasswordAndLogin(const QString& newLogin, const QString& newPassword);
    void loginUser();
    bool getIsLoggedIn() const;
    void setIdUsingLogin();
    void getUserDataUsingID();

    void sendDBUser(QSqlDatabase db);

    QString getDescription() const;
    QString getProfileImg() const;
    QString getJoinDate() const;
    QString getLogin() const;

    void updateProfileImg(QString fireUrl);

    QByteArray imageToBinary(QString &curr);

signals:
    void changeRegisterError(const QString& text, const QString& color = "red");
    void changeLoginError(const QString& text, const QString& color = "red");
    void userDataObtained(bool success, QString error);
    void profileUpdated(bool success, QString error);
};

#endif // USER_HPP
