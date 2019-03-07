import QtQuick 2.0
import QtQuick.Controls 2.2


Rectangle {
    id: container

    property bool fixed: true
    property alias text: dialogText.text

    onTextChanged: {
        console.log("text:" + text)
        visible = (text.length>0)
    }

    width: dialogText.width + 20
    height: dialogText.height + 20
    opacity: 0.4
    visible: false


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
