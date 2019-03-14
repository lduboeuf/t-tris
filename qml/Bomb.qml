import QtQuick 2.0
import "../js/Tetris.js" as Tetris


Cell {
    id:bomb
    particle.source:  "/assets/bomb.png"



//    Image {
//        id: img
//        anchors.fill: parent
//        source: "/assets/bomb.png"
//        opacity: 0.7
//    }

    RotationAnimation {
        target: particle
        loops: Animation.Infinite
        property: "rotation"
        duration: 200
        running: true
        direction: RotationAnimation.Counterclockwise
        from: 0
        to: 240

    }

    Behavior on y{

        SmoothedAnimation{
            from: 0;duration:5000;
            onRunningChanged: {
                if (!running) {
                    Tetris.fireBomb(bomb.column, bomb.row)

                }

            }
        }

   }
}
