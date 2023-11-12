import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 6.3

Page{

    Connections{
        target: recipeFetcher
    }

    ListView {

        width: parent.width
        height: parent.height

        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        clip: true

        id: listView

        model: ListModel {
            //Will be populated dynamically
            id: recipeModel
        }

        delegate: Rectangle {
            width: parent.width
            color: generateRandomColor()

            Column {
                anchors.fill: parent
                spacing: 10

                Image {
                    id: img
                    width: root.width / 3
                    height: width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
                    source: "data:image/png;base64," + model.base64
                    smooth: true
                    antialiasing: true
                }

                Text {
                    Layout.fillHeight: true
                    width: parent.width - 20 // Adjust the width as needed
                    wrapMode: Text.Wrap
                    text: model.titleText
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    Layout.fillHeight: true
                    width: parent.width - 20 // Adjust the width as needed
                    wrapMode: Text.Wrap
                    text: model.ingredientsText
                    color: "orange"
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    Layout.fillHeight: true
                    width: parent.width - 20 // Adjust the width as needed
                    wrapMode: Text.Wrap
                    text: model.instructionsText
                    color: "blue"
                    horizontalAlignment: Text.AlignHCenter
                }
            }

        }

        ScrollBar.vertical: ScrollBar {
            policy: ScrollBar.AlwaysOn
            size: listView.contentHeight / listView.height

            contentItem: Rectangle {
                implicitWidth: 5
                color: "orange"
                radius: width

                SequentialAnimation on color {
                    loops: Animation.Infinite
                    ColorAnimation { from: "orange"; to: "orangered"; duration: 1000 }
                    ColorAnimation { from: "orangered"; to: "orange"; duration: 1000 }
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

               recipeModel.append({titleText: recipe[0] + "\n\n", base64: imageBase64, ingredientsText: recipe[1] + "\n\n", instructionsText: recipe[2] + "\n\n"});
           }

        }
    }


    function generateRandomColor() {
        var red = Math.floor(Math.random() * 256);
        var green = Math.floor(Math.random() * 256);
        var blue = Math.floor(Math.random() * 256);

        return Qt.rgba(red / 255, green / 255, blue / 255, 1);
    }

}
