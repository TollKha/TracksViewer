import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")
    id: parentWindow

    Component {
        id: trackDelegate

        Rectangle {
            width: parent.width
            height: 78
            color: "grey"
            radius: 5

            border.width: 1
            border.color: parentWindow.color

            id: trackBackground

            Row {
                spacing: 2
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 7

                id: trackRow

//                Rectangle { color: "red"; width: 50; height: 50 }
//                Rectangle { color: "green"; width: 20; height: 50 }
//                Rectangle { color: "blue"; width: 50; height: 20 }

                Image {
                    id: trackIcon
                    //anchors.left: parent.left;
                    anchors.verticalCenter: parent.verticalCenter
                    source: "bta.png"
                }

                Text {
                    id: trackTitle
                    text: title
                    color: "black"
                    anchors.verticalCenter: parent.verticalCenter
                    width: trackBackground.width - (trackIcon.width + playMark.width + 20)
                }

                AnimatedImage {
                    source: "playing_mark.gif"
                    id: playMark
//                    anchors.right: parent.right
                }
            }
        }

    }

    ListModel {
        id: tracksListModel
        ListElement {
            title: "USB Track - Fade to Black"
        }
        ListElement {
            title: "BTA Track - 2"
        }
    }

    ScrollView {
        anchors.fill: parent

        ListView {
            model: tracksListModel
            width: parent.width
            delegate: trackDelegate
        }
    }
}
