import QtQuick
import QtQuick.Controls 6.3
import QtCharts 6.3
import QtQuick.Layouts 6.3

import "SearchComponents"

Page {
    title: qsTr("Search")

    ColumnLayout{
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        anchors.centerIn: parent
        spacing: 0.065 * root.height

        SearchTextRow {
            text: qsTr("Search by title")
        }

        InputSearch {
            id: titleText
        }

        SubmitButton {
            id: searchTitleButton
            onClicked:{}
        }

        SearchTextRow {
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
             Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            SearchCheckbox{
                text: qsTr("Sort by Title");
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                id: sortByTitle
            }
            SearchCheckbox{
                text: qsTr("Sort by Instructions length");
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                id: sortByIngredients
            }
        }

        SearchErrorRow{
            id: searchError;
        }
    }
}
