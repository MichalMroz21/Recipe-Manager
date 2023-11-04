import QtQuick 2.15
import QtQuick.Controls 2.5

Page{

    Connections{
        target: recipeFetcher
    }

    ListView {

        width: parent.width
        height: parent.height

        model: ListModel {
            //Will be populated dynamically
            id: recipeModel
        }

        delegate: Rectangle {
            width: parent.width
            color: "orange"

            Text {
                anchors.centerIn: parent
                text: model.text
                wrapMode: Text.WrapAnywhere
                width: root.width
                padding: (parent.width + parent.height) / 15

                onContentSizeChanged: {
                   parent.height = contentHeight
               }

                color: "darkgreen"
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
            //var recipes = recipeFetcher.getRecipesStrings();

            //for (var i = 0; i < recipes.length; ++i) {
               // var recipe = recipes[i];
               // recipeModel.append({text: recipe.join(", ")});
           // }

            recipeModel.append({text: "Combine sage, rosemary, and 6 Tbsp. melted butter in a large bowl; pour half of mixture over squash on baking sheet. Sprinkle squash with allspice, red pepper flakes, and ½ tsp. salt and season with black pepper; toss to coat.
Add bread, apples, oil, and ¼ tsp. salt to remaining herb butter in bowl; season with black pepper and toss to combine. Set aside.
Place onion and vinegar in a small bowl; season with salt and toss to coat. Let sit, tossing occasionally, until ready to serve.
Place a rack in middle and lower third of oven; preheat to 425°F. Mix miso and 3 Tbsp. room-temperature butter in a small bowl until smooth. Pat chicken dry with paper towels, then rub or brush all over with miso butter. Place chicken in a large cast-iron skillet and roast on middle rack until an instant-read thermometer inserted into the thickest part of breast registers 155°F, 50–60 minutes. (Temperature will climb to 165°F while chicken rests.) Let chicken rest in skillet at least 5 minutes, then transfer to a plate; reserve skillet.
Meanwhile, roast squash on lower rack until mostly tender, about 25 minutes. Remove from oven and scatter reserved bread mixture over, spreading into as even a layer as you can manage. Return to oven and roast until bread is golden brown and crisp and apples are tender, about 15 minutes. Remove from oven, drain pickled onions, and toss to combine. Transfer to a serving dish.
Using your fingers, mash flour and butter in a small bowl to combine.
Set reserved skillet with chicken drippings over medium heat. You should have about ¼ cup, but a little over or under is all good. (If you have significantly more, drain off and set excess aside.) Add wine and cook, stirring often and scraping up any browned bits with a wooden spoon, until bits are loosened and wine is reduced by about half (you should be able to smell the wine), about 2 minutes. Add butter mixture; cook, stirring often, until a smooth paste forms, about 2 minutes. Add broth and any reserved drippings and cook, stirring constantly, until combined and thickened, 6–8 minutes. Remove from heat and stir in miso. Taste and season with salt and black pepper."});
        }
    }

}
