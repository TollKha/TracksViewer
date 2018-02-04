import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import com.anatoliy.track_type 1.0
import com.anatoliy.track 1.0

ApplicationWindow {
    function randomNumber() {
        return Math.random() * 100
    }

    function getTitle(type, title) {
        return (type === TrackType.USB ? "USB Track - " : "BTA Track - ") +  title
    }

    visible: true
    width: 640
    height: 480
    title: qsTr("Track viewer")
    id: mainWindow

    property var playingIndex : -1

    Component.onCompleted: {
        for(var i = 0; i < 15; ++i)
        {
            var type = randomNumber() <= 50 ? TrackType.USB : TrackType.BTA
            tracksListModel.append({"title" : i, "type" : type, "isPlaying" : false})
        }
    }

    Component {
        id: trackDelegate

        Rectangle {
            width: parent.width
            height: 78
            color: "grey"
            radius: 5

            border.width: 1
            border.color: mainWindow.color

            id: trackBackground

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                propagateComposedEvents: true

                function selectItem() {
                    parent.color = "grey"

                    if (playingIndex != -1) {
                        tracksListModel.setProperty(playingIndex, "isPlaying", false)
                    }
                    tracksListModel.setProperty(index, "isPlaying", true)
                    playingIndex = index
                    tracksListView.currentIndex = index

                    trackCpp.play(getTitle(type, title), index)
                }

                onPressed: {
                    parent.color = "darkgrey"
                }
                onReleased: {
                    if (containsMouse)
                        selectItem()
                }
                onExited: {
                    parent.color = "grey"
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
                    text: getTitle(type, title)
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
                Track {
                    id: trackCpp
                }
            }
        }
    }

    ListModel {
        id: tracksListModel
    }

    ListView {
        anchors.fill: parent
        id: tracksListView
        model: tracksListModel
        width: parent.width
        delegate: trackDelegate

        focus: true
        clip: true
        ScrollBar.vertical: ScrollBar {
            id: scrollBar
        }

        Keys.onUpPressed: scrollBar.decrease()
        Keys.onDownPressed: scrollBar.increase()
    }
}
