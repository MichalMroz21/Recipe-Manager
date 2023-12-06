import QtQuick
import QtQuick.Controls 6.3
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts 6.3
import QtQuick3D

Page {

    title: qsTr("User Page")

    property real imgWidth : (root.width + root.height)/10
    property real imgHeight : imgWidth

    property var userJoinDate;

    Connections{
        target: user

        function onUserDataObtained(success, error){

            if(success){
                var profileImg = user.getProfileImg();
                var component;

                if(profileImg.length === 0){
                    component = Qt.createComponent("UserComponents/ImgEmpty.qml");
                    component.createObject(imgBase);
                }
                else{
                    component = Qt.createComponent("UserComponents/ProfileImg.qml");
                    component.createObject(imgBase, {base64: profileImg, prefWidth: imgWidth, prefHeight: imgHeight});
                }

                userJoinDate = user.getJoinDate();
                description.text = user.getDescription();
                saveButton.visible = false;
            }
        }

        function onProfileUpdated(success, error){
            if(success){
                stackView.push("User.qml");
            }
        }
    }

    ColumnLayout{

        anchors.horizontalCenter: parent.horizontalCenter

        RowLayout{

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: (root.width + root.height) / 40
            Layout.topMargin: root.height / 20

            Rectangle {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                id: imgBase

                property var shadowEnabled : false;

                height: imgWidth
                width: imgHeight
                color: "gray"
                border.color: "gray"
                border.width: 6
                radius: 6

                layer.enabled: shadowEnabled
                layer.effect: DropShadow {
                    color: "yellow"
                    radius: 6
                }

                MouseArea {
                    anchors.fill: parent

                    hoverEnabled: true

                    onEntered:{
                        parent.shadowEnabled = true;
                    }

                    onExited:{
                        parent.shadowEnabled = false;
                    }

                    onClicked: fileDialog.open()
                }

                FileDialog {
                    id: fileDialog
                    title: "Select an Image"
                    nameFilters: ["Images (*.png *.jpg *.bmp *.gif)"]

                    onAccepted: {
                        user.updateProfileImg(fileDialog.selectedFile);
                    }
                }
            }

            ColumnLayout{

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                Text{
                    id: userText

                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    text: user.getLogin();
                    color: "green"
                    font.pixelSize: 24
                }

                Text{

                    id: joinText

                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    text: "joined in " + userJoinDate;
                    color: "lightgreen"
                    font.italic: true
                    font.pixelSize: 12
                }
            }

        }

        RowLayout{

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Text{

                Layout.topMargin: root.height / 20

                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                text: "Description"
                color: "lightblue"
                font.pixelSize: 20
            }

            Button {

                id: saveButton

                background: Rectangle {
                    color: parent.hovered ? "lightgreen" : "green"
                    radius: 10
                }

                Layout.topMargin: root.height / 20
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                text: "Save"
                onClicked: {
                    user.updateProfileDescription(description.text);
                }

                visible: false
            }
        }



        Rectangle {

               Layout.topMargin: root.height / 80

               Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

               width: (root.width + root.height) / 3
               height: width / 2
               color: "gray"
               border.color: "black"
               radius: 10

               TextInput {
                   id: description

                   anchors.fill: parent
                   font.pixelSize: 16

                   anchors.margins: 5
                   wrapMode: Text.Wrap
                   onTextChanged: {
                       if (description.text.length > 250) {
                           description.text = description.text.substring(0, 250);
                        }

                       saveButton.visible = true;
                   }
                }
           }

    }

    Component.onCompleted: {
        user.getUserDataUsingID();
    }
}
