import QtQuick
import QtQuick.Controls 6.3


Page {
    title: qsTr("Home")

    Label {
        color: "#f91b02"
        text: qsTr("You are on the home page.")
        font.pointSize: 15
        font.bold: true
        styleColor: "#f95030"
        anchors.centerIn: parent
    }
}


