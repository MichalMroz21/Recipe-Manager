import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "LoginRegisterComponents"

Page {
    property bool layoutSwitch: true

    Connections{
        target: user
    }

    Loader{
        id: layoutLoader
        sourceComponent: layoutSwitch === true ? loginForm : registerForm
        anchors.centerIn: parent
    }

    Component{
        id: registerForm

        ColumnLayout{
            spacing: 0.065 * root.height

            TextRow {
                text: qsTr("Register")
            }

            InputRow {
                id: registerLogin
                placeholderText: qsTr("Login")
            }

            InputRow {
                id: registerPassword
                placeholderText: qsTr("Password")
                echoMode: TextInput.Password
            }

            InputRow {
                id: registerConfirmPassword
                placeholderText: qsTr("Confirm Password")
                echoMode: TextInput.Password
            }

            SubmitButton {
                id: registerButton
                text: qsTr("Register")
                onClicked:{
                    user.setPasswordAndLogin(registerLogin.text, registerPassword.text);
                    user.registerUser(registerConfirmPassword.text);
                }
            }

            SwitchForm{
                text: "Go back to login";
            }

            ErrorRow{

                Connections{
                    target: user

                    function onChangeRegisterError(text, color = "red"){
                        registerError.text = text;
                        registerError.color = color;
                    }
                }

                id: registerError;
            }
        }
    }


    Component{
        id: loginForm

        ColumnLayout{
            spacing: 0.065 * root.height

            TextRow {
                text: qsTr("Log in")
            }

            InputRow {
                id: login
                placeholderText: qsTr("Login")
            }

            InputRow {
                id: password
                placeholderText: qsTr("Password")
                echoMode: TextInput.Password
            }

            SubmitButton {
                id: loginButton
                text: qsTr("Log In")
                onClicked:{
                    user.setPasswordAndLogin(login.text, password.text);
                    user.loginUser();
                }
            }

            SwitchForm{
                text: "New? Register!";
            }

            ErrorRow{
                Connections{
                    target: user

                    function onChangeLoginError(text, color = "red"){
                        loginError.text = text;
                        loginError.color = color;

                        if(color === "green"){
                            stackView.push(hiddenWindow);
                        }
                    }
                }

                id: loginError;
            }
        }
    }
}



