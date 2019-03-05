import QtQuick 2.0
import QtQuick.Controls 2.2


Rectangle {
    id: container

    signal closed

    function show(text, delay) {
        dialogText.text = text;
        container.opacity = 0.4;

        if (delay!== undefined){
            timerMsg.start()
        }
    }



    width: dialogText.width + 20
    height: dialogText.height + 20
    opacity: 0
    visible: opacity > 0

    Text {
        id: dialogText
   //     anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 10 }
        anchors.centerIn: parent
        text: ""
        color: screenGame.textColor
    }

    Timer {
            id: timerMsg

            interval: 1000
            onTriggered: {
                timerMsg.stop()
                container.opacity = 0;
                container.closed();
            }
        }




}
