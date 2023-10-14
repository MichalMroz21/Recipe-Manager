import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3


Page {
    antialiasing: true
    title: qsTr("User")

    ColumnLayout{
        antialiasing: true
        anchors.centerIn: parent
        spacing: 0.065 * root.height

        Label {
            Layout.alignment: Qt.AlignCenter
            id: label
            text: qsTr("Log in")
            font.bold: true
            font.pointSize: 13
            scale: Math.min(root.width * 0.003, root.height * 0.003)
            color: "#00bfff";
        }

        TextField {
            Layout.alignment: Qt.AlignCenter
            background: Item {
                implicitWidth: 0.4 * root.width
                implicitHeight: 0.09 * root.height

                Rectangle {
                    color: "gray"
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                }
            }

            id: login
            font.pointSize: 0.01 * (root.width + root.height)
            placeholderText: {
                qsTr("Login")
            }

        }

        TextField {
            Layout.alignment: Qt.AlignCenter
            background: Item {
                implicitWidth: 0.4 * root.width
                implicitHeight: 0.09 * root.height

                Rectangle {
                    color: "gray"
                    height: 1
                    width: parent.width
                    anchors.bottom: parent.bottom
                }
            }
            echoMode: TextInput.Password
            id: password
            font.pointSize: 0.01 * (root.width + root.height)
            placeholderText: qsTr("Password")
        }

        Button {
            scale: Math.min(root.width * 0.002, root.height * 0.002)
            Layout.alignment: Qt.AlignCenter
            id: button

            text: qsTr("Log In")
        }
    }


}


