import QtQuick 2.12
import QtQuick.Controls 2.12


Item {
    id: container


    width: txt.width + 20
    height: txt.height + 20


    Text {
        id: txt
        anchors.centerIn: parent
        text: qsTr("Level ") + boardGame.level
        color: boardGame.textColor
        font.pixelSize: Qt.application.font.pixelSize * 2
    }

//    states: State {
//        name: "shown"; when: container.visible
//        StateChangeScript { script: anim.start()}
//    }


    SequentialAnimation{
        id:anim
        running: container.visible
        alwaysRunToEnd: true
        PropertyAnimation  {
            target: container
            property: "opacity"
            to: 0.8
            duration: 800
        }
        PropertyAnimation  {
            target: container
            property: "opacity"
            //from: 0
            to: 0
            duration: 800
        }
        PropertyAction{
            target: container
            property: "visible"
            value: false
        }

    }






}
