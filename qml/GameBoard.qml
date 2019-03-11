import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import QtQuick.Particles 2.0
import QtQuick.LocalStorage 2.0


import "Configurations.js" as Config;
import "Constant.js" as Constant

import "Tetris.js" as Tetris
import "Storage.js" as Storage


Page {
    id: boardGame

    focus: true    // important when set onKey

    property color textColor: "white"

    property int blockSize: width / Config.MAX_CELL;
    property int cellSize: width < height ? blockSize : height / Config.MAX_CELL
    signal btnBackClick();

    property int level: 1
    property int score: 0


    Component.onCompleted: {
        Tetris.initGame()
       // boardGame.state= Constant.STATE_START
    }

    onLevelChanged: {
        boardGame.state = Constant.STATE_NEW_LEVEL
        boardGame.state = Constant.STATE_PLAY
    }

    onStateChanged: {
        console.log(state)

    }



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
                    color: boardGame.textColor
                }
            }

            Text {
                id: score
                anchors { horizontalCenter: parent.horizontalCenter;  verticalCenter: parent.verticalCenter;}
                color: boardGame.textColor
                text: qsTr("Level: ") + boardGame.level + " | " + qsTr("Score: ")  + boardGame.score


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
                    source: boardGame.state === Constant.STATE_PAUSED ? "/assets/play.svg" : "/assets/pause.svg"
                }
                onClicked: {

                    if (boardGame.state===Constant.STATE_PAUSED){
                        boardGame.state = Constant.STATE_RESUMED
                    }else{
                        boardGame.state = Constant.STATE_PAUSED
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

    background: Image {
        id: background
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Item {
        id: nextFigureBoard
        anchors {top: parent.top; left: parent.left}
    }



    Item {
        id: gameCanvas
        anchors.fill: parent

    }


    SwipeArea {
            id: mouseArea
            anchors.fill: gameCanvas
            anchors.margins: 5

            onSwipe: {
                Tetris.onKeyHandler(action)

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

        RowLayout{
            anchors.fill: parent

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
                    color: boardGame.textColor
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
                    color: boardGame.textColor
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
                    color: boardGame.textColor
                }

            }
        }



    }



    DialogS7 {
        id: dialog
        anchors.centerIn: parent
    }

    GameOver{
        id: gameOverOverlay
        anchors.centerIn: parent

//        onVisibleChanged: {
//            if (visible) playGameOverSound.play()
//        }

        onRestartClicked: {
            Tetris.initGame()
        }

    }


    SoundEffect {
        id: soundMoving
        source: "/sound/moving.wav"
    }
    SoundEffect {
        id: soundClearRow
        source: "/sound/remove_row.wav"
    }
    SoundEffect {
        id: soundGameOver
        source: "/sound/game_over.wav"
    }
    SoundEffect {
        id: soundStart
        source: "/sound/start.wav"
    }


    SoundEffect {
        id: soundNextLevel
        source: "/sound/cymbals.wav"
    }





    Timer {
        id: timer
        interval: Config.TIMER_INTERVAL
        repeat: true
        onTriggered: Tetris.nextStep()
//        onIntervalChanged: {
//            console.log("interval changed")
//            boardGame.state = Constant.STATE_PLAY //to reset state after STATE_NEW_LEVEL
//        }
    }

    Keys.onLeftPressed: {
         Tetris.onKeyHandler(Constant.KEY_LEFT)
    }

    Keys.onRightPressed: {
       Tetris.onKeyHandler(Constant.KEY_RIGHT)
    }
    Keys.onUpPressed: {
       Tetris.onKeyHandler(Constant.KEY_UP)
    }
    Keys.onDownPressed: {
        Tetris.onKeyHandler(Constant.KEY_DOWN)
    }
    Keys.onCallPressed:  {
        Tetris.onKeyHandler(Constant.KEY_PAUSE)
    }


    states: [
        State {
            name: Constant.STATE_START
            PropertyChanges { target: boardGame; Keys.enabled: true }
            PropertyChanges { target: mouseArea; enabled: true }

            StateChangeScript { script: {
                    boardGame.level = 1
                    boardGame.score = 0
                    soundStart.play()
                    timer.start()
                }
            }

        },

        State {
            name: Constant.STATE_PAUSED
            PropertyChanges { target: timer; running: false }
            PropertyChanges { target: dialog; text: qsTr("Paused") }
            PropertyChanges { target: boardGame; Keys.enabled: false }
            PropertyChanges { target: mouseArea; enabled: false }
            //StateChangeScript { script:{ boardGame.Keys.enabled = false } }

        }
        ,
        State {
            name: Constant.STATE_RESUMED
            PropertyChanges { target: timer; running: true }
            PropertyChanges { target: dialog; text: qsTr("Resumed"); fixed: false }
            PropertyChanges { target: boardGame; Keys.enabled: true }
            PropertyChanges { target: mouseArea; enabled: true }

        },
        State {
            name: Constant.STATE_GAMEOVER
            PropertyChanges { target: timer; running:false }
            PropertyChanges { target: gameOverOverlay; visible:true }
            StateChangeScript { script: soundGameOver.play() }
        },

        State {
            name: Constant.STATE_ROW_REMOVED
            StateChangeScript { script: soundClearRow.play() }
        },

        State {
            name: Constant.STATE_NEW_LEVEL
            StateChangeScript {
                script: {
                    timer.interval = timer.interval - Config.REDUCED_TIME
                    soundNextLevel.play()
                }
            }
        }


    ]



}
