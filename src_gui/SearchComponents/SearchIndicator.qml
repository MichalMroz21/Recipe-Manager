import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

BusyIndicator{
    anchors.left: parent.right
    anchors.bottom: parent.bottom
    anchors.top: parent.top

    anchors.leftMargin: width/10

    running: false
}
