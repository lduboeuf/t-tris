import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Particles 2.0

 Item {
     id: block
     property int type
     property string cellColor: "red"
     property bool dying: false
     property bool spawned: false

     ParticleSystem{
         id:particles
     }

     Image {
         id: img
         anchors.fill: parent
         source: "/assets/" + cellColor +"Stone.png"
         opacity: 0.5
     }


     ImageParticle {
         system: particles

         width: 1; height: 1
         anchors.centerIn: parent

//         emissionRate: 0
//         lifeSpan: 1000; lifeSpanDeviation: 600
        // angle: 0; angleDeviation: 360;
      //   velocity: 100; velocityDeviation: 30
         source: "/assets/redStar.png";

     }

     Emitter{
         id:emitter
         anchors.right: block.right
         anchors.rightMargin: 2
         anchors.verticalCenter: block.verticalCenter
         width: 1
         height: 10
         system: particles
         emitRate: 0
         maximumEmitted:60
         lifeSpan: 1000
         lifeSpanVariation: 600
         size: 5
         endSize: 1
         //速度
         velocity: AngleDirection {
             angle: 0
             angleVariation: 360
             magnitude: 20
             //magnitudeVariation: 10
         }
     }

     states: [
         State {
             name: "AliveState"; when: spawned == true && dying == false
             PropertyChanges { target: img; opacity: 1 }
         },

         State {
             name: "DeathState"; when: dying == true
             StateChangeScript { script: emitter.burst(50); }
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
