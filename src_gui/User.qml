import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "LoginRegisterComponents"

Page {
    property bool layoutSwitch: true

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

            SubmitButton {
                id: registerButton
                text: qsTr("Register")
            }

            SwitchForm{
                text: "Go back to login";
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
            }

            SwitchForm{
                text: "New? Register!";
            }
        }
    }
}


