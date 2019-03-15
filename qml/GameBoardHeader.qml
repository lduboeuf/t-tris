import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../js/Configuration.js" as Config;


ToolBar {
        id:toolBar


        readonly property int txtScoreX: stats.x + stats.width


        background: Rectangle{
            anchors.fill: toolBar
            color:"white"
            opacity: 0.2
        }

        RowLayout {



            anchors.fill: parent
            ToolButton {
                id: toolButtonLeft
                contentItem: Image {
                    id:navImage
                    fillMode: Image.Pad
                    sourceSize.width: toolButtonLeft.height  * 0.4
                    sourceSize.height: toolButtonLeft.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "/assets/back.svg"
                }
                onClicked: {
                    timer.stop();
                    pageStack.pop()
                }

                ColorOverlay {
                    id: overlay
                    anchors.fill: navImage
                    source: navImage
                    color: boardGame.textColor
                }
            }

            Row {
                id: stats
                anchors { horizontalCenter: parent.horizontalCenter;  verticalCenter: parent.verticalCenter;}
                Text {
                    id: txtLevel
                    color: boardGame.textColor
                    text: qsTr("Level: ") + boardGame.level + " | " + qsTr("Score: ")
                }
                Score{
                    anchors.left: txtLevel.right

                }
//                Text {
//                    id:txtScore
//                    color: boardGame.textColor
//                    text:  qsTr("Score: ")  + boardGame.score
//                }

            }

            Row {
                anchors.right: parent.right
                ToolButton {
                    id: toolButtonSound

                    contentItem: Image {
                        id:soundImg
                        fillMode: Image.Pad
                        sourceSize.width: toolButtonLeft.height  * 0.4
                        sourceSize.height: toolButtonLeft.height  * 0.4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: settings.soundOff ?  "/assets/audio-volume-off.svg" : "/assets/audio-volume-on.svg"
                    }
                    onClicked: {

                       settings.soundOff = !settings.soundOff


                    }

                    ColorOverlay {
                        anchors.fill: soundImg
                        source: soundImg
                        color: boardGame.textColor
                    }
                }
                ToolButton {
                    id: toolButtonRight
                    contentItem: Image {
                        id:playPauseImg
                        fillMode: Image.Pad
                        sourceSize.width: toolButtonLeft.height  * 0.4
                        sourceSize.height: toolButtonLeft.height  * 0.4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: boardGame.state === Config.STATE_PAUSED ? "/assets/play.svg" : "/assets/pause.svg"
                    }
                    onClicked: {

                        if (boardGame.state===Config.STATE_PAUSED){
                            boardGame.state = Config.STATE_RESUMED
                        }else{
                            boardGame.state = Config.STATE_PAUSED
                        }


                    }

                    ColorOverlay {
                        anchors.fill: playPauseImg
                        source: playPauseImg
                        color: boardGame.textColor
                    }
                }
            }


        }
    }
