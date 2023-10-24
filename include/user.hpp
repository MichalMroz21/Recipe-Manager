#ifndef USER_HPP
#define USER_HPP

#include <QObject>
#include <QSqlQuery>

constexpr int MAX_PASSWORD_LENGTH = 20,
              MAX_LOGIN_LENGTH = 20;

class User : public QObject
{
    Q_OBJECT
private:
    QString password{}, login{};

public:
    explicit User(QObject *parent = nullptr);

    QString getPassword() const;
    void setPassword(const QString& newPassword);

    QString getLogin() const;
    void setLogin(const QString& newLogin);

    void setPasswordAndLogin(const QString& newLogin, const QString& newPassword);

public slots:
    bool checkCredentials();
    void registerUser();

signals:

};

#endif // USER_HPP
