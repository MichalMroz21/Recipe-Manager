import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import Qt5Compat.GraphicalEffects

Window {

    id: root
    title: qsTr("Recipe Manager")
    width: 640
    height: 480
    visible: true

    ToolBar {
        contentHeight: 40
        z: 1

        background: Rectangle {
            color: "transparent"
        }

        ToolButton {
            text: "☰"
            onClicked: drawer.open();
        }
    }


    Drawer {
        id: drawer
        width: parent.width * 0.1
        height: parent.height

        ListView {
            id: listView
            anchors.fill: parent
            model:
                ListModel {
                    ListElement {}
                    ListElement {}
                    ListElement {}
                    ListElement {}
                    ListElement { text: "Options"; }
                }

            delegate: Item {

                width: parent.width
                height: width * 0.5

                Rectangle {

                    id: rect_butt

                    width: parent.width
                    height: parent.height

                    y: isOptions(model.text) ? listView.height - height * listView.model.count : Number.NaN;

                    color: getColor(model.index)

                    layer.enabled: false

                    layer.effect: DropShadow {
                        transparentBorder: true
                        color: getShadowColor(model.index)
                        samples: 40
                    }

                    Image {
                        source: getImagePath(model.index)
                        fillMode: Image.PreserveAspectFit

                        anchors.leftMargin: parent.width * 0.1
                        anchors.rightMargin: parent.width * 0.1
                        anchors.topMargin: parent.height * 0.1
                        anchors.bottomMargin: parent.height * 0.1

                        anchors.fill: parent
                    }

                    Text {
                        anchors.centerIn: parent
                        text: model.text
                        font.pixelSize: getFontSize(parent.width, parent.height);
                        opacity: 0
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: rect_butt.layer.enabled = true;
                        onExited: rect_butt.layer.enabled = false;

                        onClicked: {
                            switchPage(model.index);
                            drawer.close();
                        }
                    }
                }

            }
        }
    }

    StackView{
       id: stackView
       initialItem: "HomeForm.qml"
       anchors.fill: parent
    }

    function isOptions(text){
        return text === "Options";
    }

    function getImagePath(index){
        switch (index) {
            case 0: return ROOT_PATH;
            case 1: return ROOT_PATH;
            case 2: return ROOT_PATH;
            case 3: return ROOT_PATH;
            case 4: return "../assets/options.png";
            default: return ROOT_PATH;
        }
    }

    function getColor(index) {
        switch (index) {
            case 0: return "lightblue";
            case 1: return "lightgreen";
            case 2: return "lightyellow";
            case 3: return "deeppink";
            case 4: return "lightgray";
            default: return "lightgray";
        }
    }

    function getShadowColor(index) {
        switch (index) {
            case 0: return "blue";
            case 1: return "green";
            case 2: return "yellow";
            case 3: return "red";
            case 4: return "gray";
            default: return "lightgray";
        }
    }

    function switchPage(index) {
        var pageSelected;
        switch (index) {
            case 0: pageSelected = "HomeForm.qml"; break;
            case 1: pageSelected = "Page1.qml"; break;
            case 2: pageSelected = "Page2.qml"; break;
            case 3: pageSelected = "Page3.qml"; break;
            case 4: pageSelected = "Options.qml"; break;
        }
        stackView.push(pageSelected);
    }

    function getFontSize(width, height){
        return (width + height) * 0.1;
    }
}
