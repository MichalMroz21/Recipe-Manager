import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 6.3
import Qt5Compat.GraphicalEffects

Page{

    Connections{
        target: recipeFetcher
    }

    function getRandomColor() {
      const minBrightness = 150;

      let red, green, blue;

      do {
        red = Math.floor(Math.random() * 256);
        green = Math.floor(Math.random() * 256);
        blue = Math.floor(Math.random() * 256);
      } while ((red + green + blue) / 3 < minBrightness);

      const hexRed = red.toString(16).padStart(2, '0');
      const hexGreen = green.toString(16).padStart(2, '0');
      const hexBlue = blue.toString(16).padStart(2, '0');

      const colorCode = `#${hexRed}${hexGreen}${hexBlue}`;

      return colorCode;
    }

    function darkenColor(hexColor, darkness) {

        const red = parseInt(hexColor.substring(1, 3), 16);
        const green = parseInt(hexColor.substring(3, 5), 16);
        const blue = parseInt(hexColor.substring(5, 7), 16);

        const darkerRed = Math.max(0, red - darkness);
        const darkerGreen = Math.max(0, green - darkness);
        const darkerBlue = Math.max(0, blue - darkness);

        const darkerHexColor =
            "#" +
            Math.round(darkerRed).toString(16).padStart(2, "0") +
            Math.round(darkerGreen).toString(16).padStart(2, "0") +
            Math.round(darkerBlue).toString(16).padStart(2, "0");

        return darkerHexColor;
    }

    function wrapText(text, maxWordsPerLine) {

        if(text.includes('•')) maxWordsPerLine -= 1;

        var ingredients = text.split("\n");
        var result = "";

        for(var i = 0; i < ingredients.length; i++){
            var words = ingredients[i].split(" ");

            var ingredient = "";

            for(var j = 0; j < words.length; j++){
                ingredient += words[j];
                ingredient += ' ';
                if((j + 1) % maxWordsPerLine == 0 && j + 1 !== words.length) ingredient += '\n';
            }

            result += ingredient;
            result += '\n';
        }

        return result;
    }

    ScrollView {

        anchors.fill: parent

        ListView{
            id: listView

            model: ListModel {
                id: recipeModel
            }

            delegate:

                Column {

                    bottomPadding: 100
                    width: parent.width
                    spacing: 10

                    Text {

                        property var textColor : model.titleText === "No Results" ? "red" : getRandomColor()

                        id: title

                        topPadding: 20

                        Layout.fillHeight: true
                        width: parent.width - 20
                        wrapMode: Text.WrapAnywhere
                        text: model.titleText
                        color: textColor
                        horizontalAlignment: Text.AlignHCenter

                        font.pixelSize: 20

                        layer.enabled: true
                        layer.effect: DropShadow {
                            color: darkenColor(title.textColor, 75)
                            radius: 6
                        }
                    }

                    RowLayout{

                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter

                        RowLayout{

                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            property var randColor : getRandomColor()

                            Image {
                                id: img
                                fillMode: Image.PreserveAspectFit
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                source: "data:image/jpg;base64," + model.base64

                                layer.enabled: true
                                layer.effect: DropShadow {
                                    color: darkenColor(parent.randColor, 75)
                                    radius: 6
                                }

                                Layout.preferredWidth: 274
                                Layout.preferredHeight: 169
                            }

                            ColumnLayout{

                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                property var textColor : parent.randColor

                                Text{
                                    text: model.titleText === "No Results" ? "" : "Ingredients"
                                    font.pixelSize: 22
                                    color: parent.textColor

                                    id: ingrTitle

                                    layer.enabled: true
                                    layer.effect: DropShadow {
                                        color: darkenColor(parent.textColor, 75)
                                        radius: 7
                                    }
                                }

                                Text {
                                    Layout.fillHeight: true
                                    wrapMode: Text.WordWrap
                                    text: wrapText(model.ingredientsText, 14)
                                    color: parent.textColor
                                }
                            }
                        }
                    }

                    property var textColor : getRandomColor()

                    Text{
                        text: model.titleText === "No Results" ? "" : "Instructions"
                        font.pixelSize: 22
                        color: parent.textColor

                        topPadding: 20

                        layer.enabled: true
                        layer.effect: DropShadow {
                            color: darkenColor(parent.textColor, 75)
                            radius: 7
                        }

                        anchors.horizontalCenter: parent.horizontalCenter

                    }

                    Text {
                        Layout.fillHeight: true
                        width: parent.width - 20
                        wrapMode: Text.WordWrap
                        text: wrapText(model.instructionsText, 30)
                        color: parent.textColor
                        horizontalAlignment: Text.AlignHCenter
                    }

                }
        }

        Component.onCompleted: {
            var recipes = recipeFetcher.getRecipesStrings();

            if(recipes.length === 0){
                recipeModel.append({titleText: "No Results"});
            }

            for (var i = 0; i < recipes.length; i++) {

               var imageBase64 = recipeFetcher.loadImage(i);
               var recipe = recipes[i];

               var extractedContent = recipe[1].slice(1, -1);

               var formattedString = "";
               var inSingleQuote = false;

               for (var j = 0; j < extractedContent.length; j++) {
                   var currentChar = extractedContent[j];

                   if (currentChar === "'" || currentChar === '"') {
                       if(inSingleQuote){
                           if(j + 1 !== extractedContent.length && extractedContent[j + 1] !== ',') continue;
                           formattedString += '\n';
                       }
                       else{
                           formattedString += "• ";
                       }

                       inSingleQuote = !inSingleQuote;
                   }
                   else if(inSingleQuote){
                       formattedString += currentChar;
                   }
               }

               recipe[1] = formattedString;

               recipeModel.append({titleText: recipe[0] + "\n\n", base64: imageBase64, ingredientsText: recipe[1] + "\n\n", instructionsText: recipe[2] + "\n\n"});
           }
        }


    }
}
