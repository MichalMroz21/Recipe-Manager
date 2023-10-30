import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "SearchComponents"

Page {
    title: qsTr("Search")

    Connections{
        target: recipeFetcher

        function onTitleSearchFinished(success) {
            bi.running = false;
        }
    }

    ColumnLayout{
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        anchors.centerIn: parent
        spacing: 0.065 * root.height

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
                bi.running = true;
                recipeFetcher.searchByTitle(titleText.text);
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
            onClicked:{}
        }

        RowLayout{

            SearchCheckbox{
                text: qsTr("Sort by Title");
                id: sortByTitle
            }

            SearchCheckbox{
                text: qsTr("Sort by Instructions length");
                id: sortByIngredients
            }
        }

        BusyIndicator{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            id: bi
            running: false
        }

        SearchErrorRow{
            id: searchError;
        }
    }
}
