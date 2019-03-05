import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import QtQuick.Particles 2.0
import QtQuick.LocalStorage 2.0

//import QtQuick.Controls.Styles 1.4



import "Configurations.js" as Config;
import "Constant.js" as Constant


import "Utils.js" as Utils
import "SoundUtils.js" as Sound
import "Tetris.js" as Tetris

import "Figure.js" as FIGURE


Page {
    id: screenGame

    focus: true    // important when set onKey

    property color textColor: "white"
    property int intervalTimer: 500
    property string state: "Play"
    property int cellSize: parent.width < parent.height ? parent.width / Config.MAX_CELL : parent.height / Config.MAX_CELL
    signal btnBackClick();


    StackView.onActivated: {
        Tetris.startNewGame();
    }


    //SystemPalette { id: activePalette }

    header:ToolBar {
        id:toolBar




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
                    color: screenGame.textColor
                }
            }

            Text {
                id: score
                anchors { horizontalCenter: parent.horizontalCenter;  verticalCenter: parent.verticalCenter;}
                color: screenGame.textColor
                text: "Level: " + gameCanvas.level + " | Score: " + gameCanvas.score


            }
            ToolButton {
                id: toolButtonRight
                anchors.right: parent.right
                contentItem: Image {
                    id:playPauseImg
                    fillMode: Image.Pad
                    sourceSize.width: toolButtonLeft.height  * 0.4
                    sourceSize.height: toolButtonLeft.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: screenGame.state === "Play" ? "/assets/pause.svg" :"/assets/play.svg"
                }
                onClicked: {
                    if(timer.running == true){
                        timer.stop();
                        screenGame.state = "Pause"
                        nameInputDialog.show(qsTr("Paused"))
                    }
                    else{
                        timer.start();
                        screenGame.state = "Play"
                        nameInputDialog.show(qsTr("Resumed"), 1000)

                    }
                }

                ColorOverlay {
                    anchors.fill: playPauseImg
                    source: playPauseImg
                    color: screenGame.textColor
                }
            }
        }
    }

    background: Image {
        id: background
        //anchors.fill: parent
        //anchors.top: parent.top
        //anchors.bottom: parent.bottom

        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Item {
        id: nextFigure
        anchors {top: parent.top; left: parent.left}
    }



    Item {
        id: gameCanvas
        property int score: 0
        property int blockSize: parent.width / Config.MAX_CELL;
        property int level: 1

        anchors.fill: parent

        ToolTip.text:""
        ToolTip.visible:ToolTip.text.length > 0
        ToolTip.timeout: 2000


    }

//    MouseArea{
//        anchors.fill: gameCanvas
//        anchors.margins: 5
//        onClicked: {
//            if(timer.running)
//                Tetris.onKeyHandler(Constant.KEY_DOWN)
//        }
//    }

    SwipeArea {
            id: mouse
            anchors.fill: gameCanvas
            anchors.margins: 5



            onSwipe: {
                if(!timer.running) return
                var key
                switch (direction) {
                case "left":
                    key = Constant.KEY_LEFT
                    break
                case "right":
                    key = Constant.KEY_RIGHT
                    break

                case "up":
                    key = Constant.KEY_UP
                    break
                case "down":
                    key = Constant.KEY_DOWN
                    break

                case "none": //like a click
                    key = Constant.KEY_UP
                    break
                }

                Tetris.onKeyHandler(key)


            }

    }






    footer:ToolBar {
        id:toolBarBottom

        background: Rectangle{
            anchors.fill: toolBarBottom
            color: "black";
            opacity: 0.8
            Rectangle{
                width: parent.width
                anchors.top: parent.top
                color:"#9a37a4"
                height: 1
            }
        }

        property int toolBtnWidth: Math.round(screenGame.width / 3)

        RowLayout{
            anchors.fill: parent
            //height: btnLeft.height *2



            ToolButton {
                id: btnLeft
                anchors.left: parent.left
                Layout.fillWidth: true
                contentItem: Image {
                    id:imgLeft
                    fillMode: Image.Pad
                    sourceSize.width: btnLeft.height  * 0.4
                    sourceSize.height: btnLeft.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "/assets/left.svg"
                }
                onClicked: {
                    if(timer.running)
                        Tetris.onKeyHandler(Constant.KEY_LEFT)
                }
                ColorOverlay {
                    anchors.fill: imgLeft
                    source: imgLeft
                    color: screenGame.textColor
                }

            }



            ToolButton {
                id: btnRotate
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillWidth: true

                contentItem: Image {
                    id: imgRotate
                    fillMode: Image.Pad
                    sourceSize.width: btnRotate.height  * 0.4
                    sourceSize.height: btnRotate.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "/assets/rotate.svg"
                }

                onClicked: {
                    if(timer.running)
                        Tetris.onKeyHandler(Constant.KEY_UP)
                }

                ColorOverlay {
                    anchors.fill: imgRotate
                    source: imgRotate
                    color: screenGame.textColor
                }


            }




            ToolButton {
                id: btnRight
                Layout.fillWidth: true
                anchors.right: parent.right
                contentItem: Image {
                    id: imgRight
                    fillMode: Image.Pad
                    sourceSize.width: btnLeft.height  * 0.4
                    sourceSize.height: btnLeft.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "/assets/right.svg"
                }
                onClicked: {
                    if(timer.running)
                        Tetris.onKeyHandler(Constant.KEY_RIGHT)
                }

                ColorOverlay {
                    anchors.fill: imgRight
                    source: imgRight
                    color: screenGame.textColor
                }

            }
        }



    }



    DialogS7 {
        id: nameInputDialog
        anchors.centerIn: parent
        z: 100

        //        onClosed: {
        //            if (nameInputDialog.inputText != "")
        //                SameGame.saveHighScore(nameInputDialog.inputText);
        //        }
    }

//    GameOver{
//        id: gameOverOverlay
//        anchors.centerIn: parent
//        //z: 200

//        onRestart: {
//             Tetris.startNewGame();
//        }

//        Component.onCompleted: {
//            gameOverOverlay.show()
//        }
//    }


    SoundEffect {
        id: playMovingSound
        source: "/sound/moving.wav"
    }
    SoundEffect {
        id: playClearRowSound
        source: "/sound/remove_row.wav"
    }
    SoundEffect {
        id: playGameOverSound
        source: "/sound/game_over.wav"
    }
    SoundEffect {
        id: playOtherSound
        source: "/sound/other.wav"
    }





    Timer {
        id: timer
        interval: intervalTimer
        repeat: true
        onTriggered: Tetris.timerHandler()
    }

    Keys.onLeftPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_LEFT)
    }

    Keys.onRightPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_RIGHT)
    }
    Keys.onUpPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_UP)
    }
    Keys.onDownPressed: {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_DOWN)
    }
    Keys.onCallPressed:  {
        if(timer.running)
            Tetris.onKeyHandler(Constant.KEY_PAUSE)
    }



    //    states: [
    //        State {
    //            name: "LEVEL_1"
    //            when: gameCanvas.score < 500
    //            StateChangeScript { script: Utils.setIntervalTimer(1000)}
    //        },

    //        State {
    //            name: "LEVEL_2"
    //            when: gameCanvas.score >= 500 && gameCanvas.score < 1200
    //            PropertyChanges { target: gameCanvas; level: 2 }
    //            StateChangeScript { script: Utils.setIntervalTimer(700)}
    //        },

    //        State {
    //            name: "LEVEL_3"
    //            when: gameCanvas.score >= 1200 && gameCanvas.score < 2000
    //            PropertyChanges { target: gameCanvas; level: 3 }
    //            StateChangeScript { script: Utils.setIntervalTimer(500)}
    //        },

    //        State {
    //            name: "LEVEL_4"
    //            when: gameCanvas.score >= 2000 && gameCanvas.score < 2500
    //            PropertyChanges { target: gameCanvas; level: 4 }
    //            StateChangeScript { script: Utils.setIntervalTimer(350)}
    //        },

    //        State {
    //            name: "LEVEL_5"
    //            when: gameCanvas.score >= 2500 && gameCanvas.score < 2800
    //            PropertyChanges { target: gameCanvas; level: 5 }
    //            StateChangeScript { script: Utils.setIntervalTimer(180)}
    //        },

    //        State {
    //            name: "HIGHEST_LEVEL"
    //            when: gameCanvas.score >= 2800
    //            PropertyChanges { target: gameCanvas; level: 6 }
    //            StateChangeScript { script: Utils.setIntervalTimer(120)}
    //        }
    //    ]
}
