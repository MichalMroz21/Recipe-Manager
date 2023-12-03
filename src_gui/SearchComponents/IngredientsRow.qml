import QtQuick 2.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

RowLayout {

    property string recipes: "";
    Layout.alignment: Qt.AlignHCenter
    scale: Math.min(root.width * 0.002, root.height * 0.002)

    TextField {

        Layout.alignment: Qt.AlignLeft

        placeholderText: "Type in ingredients"
        font.pixelSize: 12

        onAccepted: {
            var inputText = text.trim();

            if(inputText === "clear"){
                recipes = "";
                placeholderText = "Type in ingredients";
            }

            else if (inputText !== "") {
                recipes += inputText + '\n';
                placeholderText = "Type \"clear\" to clear";
            }

            text = "";
        }
    }

    Label {
        Layout.alignment: Qt.AlignRight
        id: hoverLabel
        text: "Hover to view"
        color: "orange"
        font.pixelSize: 12

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                popup.open()
            }
        }

        Item{
            anchors.fill: parent
        }

        Popup {
            id: popup

            leftPadding: 10
            rightPadding: 10

            width: contentWidth === 0 ? 0 : contentWidth + leftPadding + rightPadding

            contentItem: Text {
                text: recipes
                font.pixelSize: 16
                color: "orange"
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onExited: {
                    popup.close();
                }
            }
        }
    }




}
