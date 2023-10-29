import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 800
    height: 600
    title: "Scrollable Image Gallery"

    ScrollView {
        anchors.fill: parent

        Column {
            spacing: 10

            Repeater {
                model: imageUrls.length

                Image {
                    width: parent.width
                    height: 200
                    source: imageUrls[index]
                }
            }
        }
    }

    property var imageUrls: [
        "image1.jpg",
        "image2.jpg",
    ]
}
