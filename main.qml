import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import com.anatoliy.trackviewer 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Scroll")
    id: mainWindow

    property var playingIndex : -1

    Component {
        id: trackDelegate

        Rectangle {
            //propery bool isPlaying
//            isPlaying : false

            width: parent.width
            height: 78
            color: "grey"
            radius: 5

            border.width: 1
            border.color: mainWindow.color

            id: trackBackground

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    parent.color = "darkgrey"
                }
                onReleased: {
                    parent.color = "grey"
                    //isPlaying = true

                    if (playingIndex != -1) {
                        tracksListModel.setProperty(playingIndex, "isPlaying", false)
                        console.log(JSON.stringify(tracksListModel.get(playingIndex)))
                    }
                    tracksListModel.setProperty(index, "isPlaying", true)
                    playingIndex = index
                }
                onPressedChanged: {

                }
            }

            Row {
                spacing: 2
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 7

                id: trackRow

                Image {
                    id: trackIcon
                    anchors.verticalCenter: parent.verticalCenter
                    source: "bta.png"
                }

                Text {
                    id: trackTitle
                    text: (type == TrackType.USB ? "USB Track - " : "BTA Track - ") +  title
                    color: "black"
                    anchors.verticalCenter: parent.verticalCenter
                    width: trackBackground.width - (trackIcon.width + playMark.width + 20)
                }

                AnimatedImage {
                    source: "playing_mark.gif"
                    id: playMark
                    anchors.verticalCenter: parent.verticalCenter
                    visible: isPlaying
                }
            }
        }
    }

    ListModel {
        id: tracksListModel

        ListElement {
            title: "1"
            isPlaying: false
            type: TrackType.USB
        }
        ListElement {
            title: "2"
            isPlaying: false
            type: TrackType.BTA
        }
        ListElement {
            title: "3"
            isPlaying: false
            type: TrackType.USB
        }
    }

    ScrollView {
        anchors.fill: parent

        ListView {
            id: tracksListView
            model: tracksListModel
            width: parent.width
            delegate: trackDelegate

            focus: true
        }
    }
}
