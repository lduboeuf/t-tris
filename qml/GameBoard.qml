import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtMultimedia 5.0
import QtQuick.LocalStorage 2.0

import "../js/Configuration.js" as Config;

import "../js/Tetris.js" as Tetris
//import "../js/Storage.js" as Storage


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
        state = Config.STATE_GAMEOVER
    }

    onStateChanged: {
        console.log("state:"+state)

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





    footer: GameBoardFooter{

        onLeftPressed: {
            Tetris.onKeyHandler(Config.KEY_LEFT)
        }

        onRightPressed: {
            Tetris.onKeyHandler(Config.KEY_RIGHT)
        }

        onRotatePressed: {
            Tetris.onKeyHandler(Config.KEY_UP)
        }


    }


    NewLevelOverlay{
        id: newLevelOverlay
        anchors.centerIn: parent
        opacity: 0
        visible: false


       // NumberAnimation { duration: 500 ;easing.type: Easing.SineCurve}
    }



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
        //anchors.horizontalCenter: parent.horizontalCenter
        visible: false

        onRestartClicked: {
            boardGame.init()
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
        muted: settings.soundOff
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

    SoundEffect {
        id: soundBombFired
        source: "/sound/bomb_fire.wav"
    }

    function playSound(soundId){
        if (!settings.soundOff) soundId.play()
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

          //  StateChangeScript { script: soundStart.play() }


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
            StateChangeScript { script: {
                    //Storage.saveHighScore(new Date().toLocaleString(), boardGame.score, boardGame.level)
                }}

        },
        State {
            name: Config.STATE_PENDING_BOMB // ? any way to group properties ( almost same as STATE_PAUSE/GAME_OVER
            PropertyChanges { target: boardGame; running:false }
        },
//        State {
//            name: Config.STATE_FIRING_BOMB
//            StateChangeScript { script:soundBombFired.play()}

//        },

//        State {
//            name: Config.STATE_ROW_REMOVED
//            StateChangeScript { script:  soundClearRow.play() }
//        },

        State {
            name: Config.STATE_NEW_LEVEL
            //PropertyChanges { target: newLevelOverlay; visible:true; explicit:true}
            StateChangeScript {
                script: {
                    timer.interval = timer.interval - Config.REDUCED_TIME
                   // newLevelOverlay.show()
                   // soundNextLevel.play()
                }
            }
        }


    ]

    transitions: [
        Transition{
            to: Config.STATE_ROW_REMOVED
            ScriptAction{ script: playSound(soundClearRow)}
        },
        Transition {
            to: Config.STATE_FIRING_BOMB
            ScriptAction { script:playSound(soundBombFired)}

        },
        Transition {
            to: Config.STATE_NEW_LEVEL
            //NumberAnimation { target: newLevelOverlay; property: "opacity"; from:0; to: 1 ;easing.type: Easing.InOutQuad; duration: 1000  }
            ScriptAction { script: playSound(soundNextLevel)}
            PropertyAction{ target: newLevelOverlay; property: "visible"; value: true}
//            SequentialAnimation  {
//                 PropertyAnimation { target: newLevelOverlay; property: "opacity"; to: 1 }
//                 PropertyAnimation { target: newLevelOverlay; property: "opacity"; to: 0 }
//             }

        },
        Transition {
            to: Config.STATE_GAMEOVER
            ScriptAction { script: playSound(soundGameOver)}

        },
        Transition {
            to: Config.STATE_START
            ScriptAction { script: playSound(soundStart)}

        }

    ]



}
