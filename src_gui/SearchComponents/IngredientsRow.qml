import QtQuick 2.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

RowLayout {
    property string displayString: "";

    TextField {
        Layout.fillWidth: true
        placeholderText: "Type words and press Enter"
        font.pixelSize: 16

        onAccepted: {
            var inputText = text.trim();

            if(inputText === "clear"){
                displayString = "";
                placeholderText = "Type words and press Enter";
            }

            else if (inputText !== "") {
                displayString += inputText + '\n';
                placeholderText = "Type \"clear\" to clear";
            }

            text = "";
        }
    }

    Popup {
        id: popup
        leftPadding: 10
        rightPadding: 10
        x: hoverLabel.x
        y: hoverLabel.y
        width: contentWidth === 0 ? 0 : contentWidth + leftPadding + rightPadding


        contentItem: Text {
            text: displayString
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

    Label {
        id: hoverLabel
        text: "Hover to view"
        color: "orange"
        font.pixelSize: 16

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                popup.open()
            }

        }
    }
}
