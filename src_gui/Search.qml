import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "SearchComponents"

Page {
    title: qsTr("Search")

    Connections{
        target: recipeFetcher

        function onSearchFinished(success, error) {
            biSearch.running = false;

            if(success){
                stackView.push("ViewSearch.qml");
            }
            else{
                searchError.text = error;
            }
        }
    }

    ColumnLayout{

        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        anchors.centerIn: parent
        spacing: 0.02 * (root.width + root.height)

        id: searchLayout

        SearchTextRow {
            text: qsTr("Title keyword")
        }

        InputSearch {
            id: titleText
        }

        SearchTextRow {
            Layout.topMargin: root.height / 20
            text: qsTr("Ingredients")
        }

        IngredientsRow {
            id: ingredientsRow
        }

        SubmitButton {
            id: searchIngredientsButton

            onClicked:{
                recipeFetcher.searchRecipes(titleText.text, ingredientsRow.recipes, sortByTitle.checked, sortIngredients.checked);
                biSearch.running = true;
            }

            SearchIndicator{
                id: biSearch
            }
        }

        RowLayout{

            scale: Math.min(root.width * 0.002, root.height * 0.002)

            Layout.alignment: Qt.AlignHCenter

            SearchCheckbox{

                Layout.alignment: Qt.AlignLeft
                text: qsTr("Sort by Title");
                id: sortByTitle
            }

            SearchCheckbox{

                Layout.alignment: Qt.AlignRight
                text: qsTr("Sort Ingredients");
                id: sortIngredients
            }
        }


        SearchErrorRow{
            id: searchError;
        }
    }






}
