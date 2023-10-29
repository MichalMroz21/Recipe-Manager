import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 6.3

Label {
    Layout.alignment: Qt.AlignCenter
    font.bold: true
    font.pointSize: 13
    scale: Math.min(root.width * 0.003, root.height * 0.003)
    color: "orange";
}
