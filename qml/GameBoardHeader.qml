import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../js/Configuration.js" as Config;
import "components"


ToolBar {
    id:toolBar
    readonly property int txtScoreX: stats.x + stats.width

    height: contentHeight * 1.4

    background: Rectangle{
        anchors.fill: toolBar
        color:"white"
        opacity: 0.2
    }

    RowLayout {
        anchors.fill: parent

        MToolButton {
            id: toolButtonLeft
            imageSrc: "/assets/back.svg"
            onClicked: {
                timer.stop();
                pageStack.pop()

            }
        }

        Row {
            id: stats
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            //anchors { horizontalCenter: parent.horizontalCenter;  verticalCenter: parent.verticalCenter;}
            Text {
                id: txtLevel
                color: boardGame.textColor
                //horizontalAlignment: Qt.AlignHCenter
                //verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                text: qsTr("Level: ") + boardGame.level + " | " + qsTr("Score: ")
            }
            Score{
                anchors.left: txtLevel.right
            }

        }

        Row {
            Layout.alignment: Qt.AlignRight
            //Layout.alignment: parent.right
            //anchors.right: parent.right
            MToolButton {
                id: toolButtonSound
                enabled: running
                imageSrc: settings.soundOff ?  "/assets/audio-volume-off.svg" : "/assets/audio-volume-on.svg"

                onClicked: {
                    settings.soundOff = !settings.soundOff
                }

            }
            MToolButton {
                id: toolButtonRight
                imageSrc: boardGame.state === Config.STATE_PAUSED ? "/assets/play.svg" : "/assets/pause.svg"

                onClicked: {

                    if (boardGame.state===Config.STATE_PAUSED){
                        boardGame.state = Config.STATE_RESUMED
                    }else{
                        boardGame.state = Config.STATE_PAUSED
                    }

                }

            }
        }


    }
}
