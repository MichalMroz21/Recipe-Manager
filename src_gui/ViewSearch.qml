import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 6.3
import Qt5Compat.GraphicalEffects

Page{

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

    ScrollView {

        anchors.fill: parent

        ListView{
            id: listView

            model: ListModel {
                id: recipeModel
            }

            delegate:

                Column {

                    width: parent.width
                    spacing: 10

                    Text {
                        Layout.fillHeight: true
                        width: parent.width - 20
                        wrapMode: Text.WrapAnywhere
                        text: model.titleText
                        color: getRandomColor()
                        horizontalAlignment: Text.AlignHCenter

                        layer.enabled: true
                        layer.effect: DropShadow {
                            verticalOffset: 2
                            color: darkenColor(color, 75)
                            radius: 1
                            samples: 3
                        }
                    }

                    RowLayout{

                        width: parent.width
                        anchors.horizontalCenter: parent.horizontalCenter

                        RowLayout{

                            Layout.alignment: Qt.AlignHCenter
                            spacing: 20

                            Image {
                                id: img
                                fillMode: Image.PreserveAspectFit
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                source: "data:image/jpg;base64," + model.base64
                            }

                            Text {
                                Layout.fillHeight: true
                                width: parent.width - img.width - 20
                                wrapMode: Text.Wrap
                                text: model.ingredientsText
                                color: "orange"
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            }
                        }



                    }

                    Text {
                        Layout.fillHeight: true
                        width: parent.width - 20
                        wrapMode: Text.Wrap
                        text: model.instructionsText
                        color: "blue"
                        horizontalAlignment: Text.AlignHCenter
                    }

                }
        }

        Component.onCompleted: {
            var recipes = recipeFetcher.getRecipesStrings();

            for (var i = 0; i < recipes.length; ++i) {

               var imageBase64 = recipeFetcher.loadImage(i);
               var recipe = recipes[i];
               var ingredientsList = recipe[1].replace(/'/g, '').split(', ');

               recipe[1] = ingredientsList.join("\n").slice(1);
               recipe[1] = recipe[1].replace(/]/g, '');

               recipeModel.append({titleText: recipe[0] + "\n\n", base64: imageBase64, ingredientsText: recipe[1] + "\n\n", instructionsText: recipe[2] + "\n\n"});
           }
        }


    }
}
