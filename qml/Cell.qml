import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0


import "../js/Configuration.js" as Config

 Item {
     id: block
     property alias particle: img
     property int type: Config.RUNNING_CELL
     property int style: Config.CELL_STYLE_CIRCLE
     property string cellColor: "red"
     property bool dying: false
     //property alias state: img.state

     property int column:0
     property int row:0
     property int size:0
     //property var oldValues: { "x":0, "y":0, "size":0}
     //property bool moved: false

     width: size
     height: size

     x:size*column
     y:size*row



     Behavior on width { //fired when changing from minibard to mainboard
         NumberAnimation{ target:block; property: "opacity" ;from: 0;to:1}
     }


     Item {

         id: cell
         opacity: 0.5
         visible: true
         anchors.fill: parent

         Rectangle {
             id: particle
             anchors.fill: parent
             color:cellColor
             //border.color: "grey"
             visible: block.style === Config.CELL_STYLE_SQUARE
             anchors.margins: 2

             LinearGradient {
                 anchors.fill: parent
                 start: Qt.point(0, 0)
                 end: Qt.point(block.size /2 , block.size /2)
                 gradient: Gradient {
                     GradientStop { position: 0.0; color: Qt.lighter(cellColor) }
                     GradientStop { position: 1.0; color: Qt.darker(cellColor) }
                 }
             }
         }

         Image {
             id: img
             visible: block.style === Config.CELL_STYLE_CIRCLE
             anchors.fill: parent
             source: "/assets/" + cellColor +"Stone.png"
         }




     }

//     Image {
//         id: img
//         visible: block.style === Config.CELL_STYLE_CIRCLE
//         anchors.fill: parent
//         source: "/assets/" + cellColor +"Stone.png"
//     }


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
             PropertyChanges { target: cell; opacity: 0 }
             StateChangeScript { script: block.destroy(1000); }
         }

     ]







 }


