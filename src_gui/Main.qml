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
            font.pixelSize: getDrawerEntrySize(root.width, root.height);
            onClicked: drawer.open();
        }
    }

    RotationAnimator {
        id: rotationAnimator
        from: 0;
        to: 360;
        duration: 1000
        loops: Animation.Infinite
    }

    ScaleAnimator {
        id: scaleAnimator
        from: 1
        to: 1.15
        duration: 450
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
                        id: menuImage
                        source: getImagePath(model.index)
                        fillMode: Image.PreserveAspectFit

                        anchors.leftMargin: parent.width * 0.1
                        anchors.rightMargin: parent.width * 0.1
                        anchors.topMargin: parent.height * 0.1
                        anchors.bottomMargin: parent.height * 0.1

                        anchors.fill: parent
                        smooth: true
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

                        onEntered: {
                            rect_butt.layer.enabled = true;
                            handleAnimation(model.index, menuImage, true)
                        }

                        onExited: {
                            rect_butt.layer.enabled = false;
                            handleAnimation(model.index, menuImage, false)
                        }

                        onClicked: {
                            handleAnimation(model.index, menuImage, false)
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
       initialItem: "User.qml"
       anchors.fill: parent
    }

    function isOptions(text){
        return text === "Options";
    }

    function handleAnimation(index, image, turnOn){
        switch(index){
            case 0:
            case 1:
            case 2:
            case 3: {
                scaleAnimator.target = image;
                scaleAnimator.running = turnOn;
                if(turnOn === false) image.scale = 1;
                break;
            }
            case 4: {
                rotationAnimator.target = image;
                rotationAnimator.running = turnOn;
                break;
            }
        }
    }

    function getImagePath(index){
        switch (index) {
            case 0: return "../assets/user.png";
            case 1: return "../assets/recipe.png";
            case 2: return "../assets/search.png";
            case 3: return "../assets/plan.png";
            case 4: return "../assets/options.png";
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
            case 0: pageSelected = "User.qml"; break;
            case 1: pageSelected = "Recipes.qml"; break;
            case 2: pageSelected = "Search.qml"; break;
            case 3: pageSelected = "Plan.qml"; break;
            case 4: pageSelected = "Options.qml"; break;
        }
        stackView.push(pageSelected);
    }

    function getDrawerEntrySize(width, height){
        return (width + height) * 0.02;
    }

    function getFontSize(width, height){
        return (width + height) * 0.1;
    }
}
