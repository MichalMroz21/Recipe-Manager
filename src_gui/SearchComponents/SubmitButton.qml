import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3
import Qt5Compat.GraphicalEffects

RoundButton {
    scale: Math.min(root.width * 0.002, root.height * 0.002)
    Layout.alignment: Qt.AlignCenter

    contentItem: Text {
        text: "Submit"
        color: hovered ? "darkred" : "black"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        opacity: 1
        border.color: "orange"
        radius: parent.radius
        color: "orange"

        layer.enabled: parent.hovered

        layer.effect: DropShadow {
            transparentBorder: true
            color: "orange"
            samples: 40
        }
    }
}
