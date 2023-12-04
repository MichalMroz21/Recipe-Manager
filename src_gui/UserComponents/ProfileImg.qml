import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 6.3
import Qt5Compat.GraphicalEffects

Image {

    property var prefWidth;
    property var prefHeight;

    property var base64;

    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    source: "data:image/jpg;base64," + base64

    layer.enabled: true
    layer.effect: DropShadow {
        color: "lightgreen"
        radius: 6
    }

    height: prefHeight
    width: prefWidth
}
