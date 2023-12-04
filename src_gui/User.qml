import QtQuick
import QtQuick.Controls 6.3
import QtQuick.Dialogs
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts 6.3

Page {

    title: qsTr("User Page")

    property real imgWidth : (root.width + root.height)/10
    property real imgHeight : imgHeight

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
                    component.createObject(imgBase, {base64: profileImg, prefWidth: (root.width + root.height)/10, prefHeight: (root.width + root.height)/10});
                }

                userJoinDate = user.getJoinDate();
            }
        }

        function onProfileUpdated(success, error){
            if(success){
                stackView.push("User.qml");
            }
        }
    }

    RowLayout{

        anchors.horizontalCenter: parent.horizontalCenter

        RowLayout{

            Layout.alignment: Qt.AlignHCenter
            spacing: (root.width + root.height) / 40

            Rectangle {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                id: imgBase

                property var shadowEnabled : false;

                width: imgWidth
                height: imgHeight
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
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    text: user.getLogin();
                    color: "green"
                    font.pixelSize: 24
                }

                Text{
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    text: "joined in " + userJoinDate;
                    color: "lightgreen"
                    font.italic: true
                    font.pixelSize: 12
                }
            }

        }

    }



    Component.onCompleted: {
        user.getUserDataUsingID();
    }
}
