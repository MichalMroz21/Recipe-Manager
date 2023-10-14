import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

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

    font.pointSize: 0.01 * (root.width + root.height)
}

