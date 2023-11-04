import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "SearchComponents"

Page {
    title: qsTr("Search")

    Connections{
        target: recipeFetcher

        function onTitleSearchFinished(success, error) {
            biTitle.running = false;

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
            text: qsTr("Search by title")
        }

        InputSearch {
            id: titleText
        }

        SubmitButton {

            id: searchTitleButton

            onClicked:{
                biTitle.running = true;
                recipeFetcher.searchByTitle(titleText.text);
            }

            SearchIndicator{
                id: biTitle
            }
        }

        SearchTextRow {
            Layout.topMargin: root.height / 20
            text: qsTr("Search by ingredients")
        }

        IngredientsRow {
            id: ingredientsRow
        }


        SubmitButton {
            id: searchIngredientsButton

            onClicked:{
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
                text: qsTr("Sort by Instructions length");
                id: sortByIngredients
            }
        }


        SearchErrorRow{
            id: searchError;
        }
    }






}
