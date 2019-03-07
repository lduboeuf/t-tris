import QtQuick 2.0
import QtQuick.Controls 2.2


Rectangle {
    id: container

    property bool fixed: true
    property alias text: dialogText.text

    width: dialogText.width + 20
    height: dialogText.height + 20
    visible: text.length > 0
    opacity: 0.4


    Text {
        id: dialogText
        anchors.centerIn: parent
        text: ""
        color: boardGame.textColor
    }

    Timer {
            id: timerMsg

            interval: 600
            running: !fixed
            onTriggered: {
                visible = false
           }
    }






}
