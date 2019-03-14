import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Particles 2.0

import "../js/Configuration.js" as Config

 Item {
     id: block
     property alias particle: img
     property int type: Config.RUNNING_CELL
     property string cellColor: "red"
     property bool dying: false
    // property point refPoints
     property alias state: img.state

     property int column:0
     property int row:0
     property int size:0

     width: size
     height: size

     x:size*column
     y:size*row


//     onTypeChanged: {
//         if (type === Constant.CLOCKING_CELL){
//             refPoints = Qt.point(0,0) //init points
//         }
//     }




     Image {
         id: img
         anchors.fill: parent
         source: "/assets/" + cellColor +"Stone.png"
         opacity: 0.5
     }

     ParticleSystem{
         id:particleSystem


         ImageParticle {
             width: 1; height: 1
             anchors.centerIn: parent
             source: "/assets/redStar.png";

         }

         Emitter{
             id: particles
             anchors.centerIn: parent
             emitRate: 0
             lifeSpan: 700
             velocity: AngleDirection {angleVariation: 360; magnitude: 80; magnitudeVariation: 40}
             size: 16
         }
     }

     states: [
         State {
             name: "AliveState"; when: spawned == true && dying == false
             PropertyChanges { target: img; opacity: 1 }
         },
//         State {
//             name: "FixedState"; when: type===Constant.CLOCKING_CELL
//             PropertyChanges { target: overlay; color: "blue" }
//         },
         State {
             name: "DeathState"; when: dying == true
             StateChangeScript { script: particles.burst(20); }
             PropertyChanges { target: img; opacity: 0 }
             StateChangeScript { script: block.destroy(1000); }
         }

     ]


 }


//Rectangle {
//    id: block
//    property int type
//    color: "gray"
//    border.width: 1
//}
