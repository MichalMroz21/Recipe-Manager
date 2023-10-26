#ifndef USER_HPP
#define USER_HPP

#include <QObject>
#include <QSqlQuery>
#include <QQmlProperty>

#include "CMakeConfig.hpp"

constexpr int MAX_PASSWORD_LENGTH = MAX_CREDENTIAL_LENGTH,
              MAX_LOGIN_LENGTH = MAX_CREDENTIAL_LENGTH;

class User : public QObject
{
    Q_OBJECT
private:
    QString password{}, login{};
    bool isLoggedIn{};

public:
    explicit User(QObject *parent = nullptr);

    QString getPassword() const;
    void setPassword(const QString& newPassword);

    QString getLogin() const;
    void setLogin(const QString& newLogin);

    bool getIsLoggedIn() const;
    void setIsLoggedIn(bool newIsLoggedIn);

    QString extractError(const QString& errorMsg);

public slots:
    bool checkCredentials();
    void registerUser(const QString& confirmPassword);
    void setPasswordAndLogin(const QString& newLogin, const QString& newPassword);
    void loginUser();

signals:
    void changeRegisterError(const QString& text);
    void changeLoginError(const QString& text);

};

#endif // USER_HPP
