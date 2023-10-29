import QtQuick 2.15
import QtQuick.Controls 2.15

RowLayout {
    spacing: 5

    TextField {
        id: inputField
        width: 200
        placeholderText: "Type words and press Enter"
        font.pixelSize: 16
        onAccepted: {
            // On Enter pressed
            var inputText = text.trim(); // Remove leading and trailing spaces
            if (inputText !== "") {
                // If the input is not empty, add a space and set it as the text
                text = text.trim() === "" ? inputText : text + " " + inputText;
                inputField.text = ""; // Clear the input field
            }
        }
    }

    Text {
        id: displayText
        text: inputField.text
        font.pixelSize: 16
    }
}
