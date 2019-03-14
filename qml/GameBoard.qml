import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import QtQuick.Particles 2.0
import QtQuick.LocalStorage 2.0

import "../js/Configuration.js" as Config;

import "../js/Tetris.js" as Tetris
import "../js/Storage.js" as Storage


Page {
    id: boardGame

    focus: true    // important when set onKey

    property color textColor: "white"

    property int blockSize: width / Config.MAX_CELL;
    property int cellSize: width < height ? blockSize : height / Config.MAX_CELL
    //state : Tetris.gameState
    signal btnBackClick();

    property int level: 1
    property int score: 0


    Component.onCompleted: {
        Tetris.initGame(boardGame, gameCanvas, nextFigureBoard)
       // boardGame.state= Config.STATE_START
    }

    onLevelChanged: {
        boardGame.state = Config.STATE_NEW_LEVEL
        boardGame.state = Config.STATE_PLAY
    }

    onStateChanged: {
        console.log("state:"+state)

    }

    Binding { target: boardGame; property: "state"; value: Tetris.gameState }



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
                        Tetris.onKeyHandler(Config.KEY_LEFT)
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
                        Tetris.onKeyHandler(Config.KEY_UP)
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
                        Tetris.onKeyHandler(Config.KEY_RIGHT)
                }

                ColorOverlay {
                    anchors.fill: imgRight
                    source: imgRight
                    color: boardGame.textColor
                }

            }
        }



    }



//    DialogS7 {
//        id: dialog
//        anchors.centerIn: parent
//    }

    PauseOverlay{
        id: pauseOverlay
        anchors.centerIn: parent
        onResumeClicked: {
            boardGame.state = Config.STATE_RESUMED
        }
    }

    GameOver{
        id: gameOverOverlay
        anchors.centerIn: parent

//        onVisibleChanged: {
//            if (visible) playGameOverSound.play()
//        }

        onRestartClicked: {
            Tetris.initGame(boardGame, gameCanvas, nextFigureBoard)
        }

    }


    SoundEffect {
        id: soundMoving
        muted: settings.soundOff
        source: "/sound/moving.wav"
    }
    SoundEffect {
        id: soundClearRow
        muted: settings.soundOff
        source: "/sound/remove_row.wav"


    }
    SoundEffect {
        id: soundGameOver
        muted: settings.soundOff
        source: "/sound/game_over.wav"
    }
    SoundEffect {
        id: soundStart
        muted: settings.soundOff
        source: "/sound/start.wav"
    }


    SoundEffect {
        id: soundNextLevel
        muted: settings.soundOff
        source: "/sound/cymbals.wav"
    }

    SoundEffect {
        id: soundBombFired
        muted: settings.soundOff
        source: "/sound/bomb_fire.wav"
    }




    Timer {
        id: timer
        interval: Config.TIMER_INTERVAL
        repeat: true
        onTriggered: Tetris.nextStep()

    }

    Keys.onLeftPressed: {
         Tetris.onKeyHandler(Config.KEY_LEFT)
    }

    Keys.onRightPressed: {
       Tetris.onKeyHandler(Config.KEY_RIGHT)
    }
    Keys.onUpPressed: {
       Tetris.onKeyHandler(Config.KEY_UP)
    }
    Keys.onDownPressed: {
        Tetris.onKeyHandler(Config.KEY_DOWN)
    }
    Keys.onCallPressed:  {
        Tetris.onKeyHandler(Config.KEY_PAUSE)
    }


    states: [
        State {
            name: Config.STATE_START
            PropertyChanges { target: boardGame; Keys.enabled: true }
            PropertyChanges { target: mouseArea; enabled: true }

            StateChangeScript { script: {
                    console.log("hello start")
                    boardGame.level = 1
                    boardGame.score = 0
                    soundStart.play()
                    timer.interval = Config.TIMER_INTERVAL
                    timer.start()
                }
            }

        },

        State {
            name: Config.STATE_PAUSED
            PropertyChanges { target: timer; running: false }
            //PropertyChanges { target: dialog; text: qsTr("Paused") }
            PropertyChanges { target: pauseOverlay; visible: true }
            PropertyChanges { target: boardGame; Keys.enabled: false }
            PropertyChanges { target: mouseArea; enabled: false }
            //StateChangeScript { script:{ boardGame.Keys.enabled = false } }

        }
        ,
        State {
            name: Config.STATE_RESUMED
            PropertyChanges { target: timer; running: true }
            //PropertyChanges { target: dialog; text: qsTr("Resumed"); fixed: false }
            PropertyChanges { target: boardGame; Keys.enabled: true }
            PropertyChanges { target: mouseArea; enabled: true }

        },
        State {
            name: Config.STATE_GAMEOVER
            PropertyChanges { target: timer; running:false }
            PropertyChanges { target: boardGame; Keys.enabled: false }
            PropertyChanges { target: gameOverOverlay; visible:true }
            PropertyChanges { target: mouseArea; enabled: false }
            StateChangeScript { script: {
                    Storage.saveHighScore(new Date().toLocaleString(), boardGame.score, boardGame.level)
                    soundGameOver.play()
                }}

        },
        State {
            name: Config.STATE_PENDING_BOMB // ? any way to group properties ( almost same as STATE_PAUSE/GAME_OVER
            PropertyChanges { target: timer; running:false }
            PropertyChanges { target: boardGame; Keys.enabled: false }
            PropertyChanges { target: mouseArea; enabled: false }
        },
        State {
            name: Config.STATE_FIRING_BOMB
            PropertyChanges { target: timer; running:true }
            StateChangeScript { script: {
                    soundBombFired.play()
                }}
            //PropertyChanges { target: boardGame; Keys.enabled: false }
            //PropertyChanges { target: gameOverOverlay; visible:true }
            //PropertyChanges { target: mouseArea; enabled: false }
        },

        State {
            name: Config.STATE_ROW_REMOVED
            StateChangeScript { script:  soundClearRow.play() }
        },

        State {
            name: Config.STATE_NEW_LEVEL
            StateChangeScript {
                script: {
                    timer.interval = timer.interval - Config.REDUCED_TIME
                    soundNextLevel.play()
                }
            }
        }


    ]



}
