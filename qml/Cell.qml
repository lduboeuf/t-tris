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
     //property alias state: img.state

     property int column:0
     property int row:0
     property int size:0
     property var oldValues: { "x":0, "y":0, "size":0}
     property bool moved: false

     width: size
     height: size

     x:size*column
     y:size*row



     Behavior on width {
         NumberAnimation{ target:block; property: "opacity" ;from: 0;to:1}
     }

//     Rectangle {
//         id: particle
//         anchors.fill: parent
//         color:cellColor
//         border.color: "grey"

//         opacity: 0.5
////         gradient: Gradient {
////             GradientStop { position: 0.0; color: cellColor }
////             GradientStop { position: 1.0; color: "white" }
////         }
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



         State {
             name: "DeathState"; when: dying == true
             StateChangeScript { script: particles.burst(20); }
             PropertyChanges { target: img; opacity: 0 }
             StateChangeScript { script: block.destroy(1000); }
         }

     ]







 }


