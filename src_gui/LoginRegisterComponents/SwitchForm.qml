import QtQuick
import QtQuick.Layouts 6.3

Text {
    Layout.alignment: Qt.AlignCenter
    id: switchText
    color: "lightblue"
    font.bold: true

    font.pointSize: 7
    scale: Math.min(root.width * 0.003, root.height * 0.003)

    MouseArea {
        anchors.fill: parent
        onClicked: {
            layoutSwitch = !layoutSwitch
        }
    }
}
