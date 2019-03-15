import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import QtQuick.LocalStorage 2.0

import "../js/Configuration.js" as Config;

import "../js/Tetris.js" as Tetris
import "../js/Storage.js" as Storage


Page {
    id: boardGame

    focus: true    // important when set onKey
    padding: 2

    property color textColor: "white"

    property int blockSize: width / Config.MAX_CELL;
    property int cellSize: width < height ? blockSize : height / Config.MAX_CELL


    property bool running: false
    property int level: 1
    property int score: 0

    Keys.enabled: running

    function init(){
        Tetris.initGame(boardGame, gameCanvas, nextFigureBoard)
        running = true
        score = 0
        level = 1
    }


    Component.onCompleted: {

        init()
    }

    onStateChanged: {
        console.log("state:"+state)

    }


//    Behavior on score {
////        SequentialAnimation{
////            NumberAnimation {
////                target: txtScore
////                property: "font.weight"
////                from:txtScore.font.weight
////                to:txtScore.font.weight*1.2
////                duration: 400
////                easing.type: Easing.InOutQuad
////            }
////            NumberAnimation {
////                target: txtScore
////                property: "font.weight"
////                //from:stats.font.pixelSize
////                to:txtScore.font.weight
////                duration: 400
////                easing.type: Easing.InOutQuad
////            }
////        }




//        NumberAnimation {
//                    target: scoreAdded
//                    properties: "opacity"
//                    running: boardGame.score > 0
//                    easing.type: Easing.InExpo
//                    //easing: Easing.Linear
//                    from: 1
//                    to:0
//                    duration: 1200
//                }
//        NumberAnimation {
//                    target: scoreAdded
//                    properties: "y"
//                    running: boardGame.score > 0
//                    from: gameCanvas.height / 2
//                    to:boardGame.y - header.height
//                    duration: 1200
//                }
//        NumberAnimation {
//                    target: scoreAdded
//                    properties: "x"
//                    running: boardGame.score > 0
//                    from: gmHeader.txtScoreX// +gmHeader.txtScore.width - scoreAdded.width
//                    to:gmHeader.txtScoreX// +gmHeader.txtScore.width - scoreAdded.width
//                    duration: 1200
//                }
//    }





    Text {
        id: scoreAdded
        y: -100
        text: "+" + Config.SCORE_INCREMENT
        color: boardGame.textColor
        font.bold: true
    }

    NewLevelOverlay{
        id: newLevelOverlay
        anchors.centerIn: parent
        //visible: true


       // NumberAnimation { duration: 500 ;easing.type: Easing.SineCurve}
    }




    header: GameBoardHeader{
        id: gmHeader
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
            enabled: boardGame.running
            anchors.fill: gameCanvas
            anchors.margins: 5

            onSwipe: {
                Tetris.onKeyHandler(action)

            }
    }




    footer: GameBoardFooter{}



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

        onRestartClicked: {
            boardGame.init()
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
        running: boardGame.running
        repeat: true
        onTriggered: {
            Tetris.nextStep()
            //score +=1
        }

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
            //PropertyChanges { target: boardGame; Keys.enabled: true }
//            PropertyChanges { target: boardGame; score: 0 }
//             PropertyChanges { target: boardGame; level: 0 }

            StateChangeScript { script: soundStart.play() }



        },

        State {
            name: Config.STATE_PAUSED
            PropertyChanges { target: boardGame; running: false }
            PropertyChanges { target: pauseOverlay; visible: true }
        }
        ,
        State {
            name: Config.STATE_RESUMED
            PropertyChanges { target: boardGame; running: true }


        },
        State {
            name: Config.STATE_GAMEOVER
            PropertyChanges { target: boardGame; running:false }
            PropertyChanges { target: gameOverOverlay; visible:true }
            //PropertyChanges { target: mouseArea; enabled: false }
            StateChangeScript { script: {
                    Storage.saveHighScore(new Date().toLocaleString(), boardGame.score, boardGame.level)
                    soundGameOver.play()
                }}

        },
        State {
            name: Config.STATE_PENDING_BOMB // ? any way to group properties ( almost same as STATE_PAUSE/GAME_OVER
            PropertyChanges { target: boardGame; running:false }
        },
        State {
            name: Config.STATE_FIRING_BOMB
            StateChangeScript { script:soundBombFired.play()}

        },

        State {
            name: Config.STATE_ROW_REMOVED
            StateChangeScript { script:  soundClearRow.play() }
        },

        State {
            name: Config.STATE_NEW_LEVEL
            PropertyChanges { target: newLevelOverlay; visible:true }
            StateChangeScript {
                script: {
                    timer.interval = timer.interval - Config.REDUCED_TIME
                    soundNextLevel.play()
                }
            }
        }


    ]



}
