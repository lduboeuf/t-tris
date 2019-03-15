import QtQuick 2.0
import QtQuick.Controls 2.2


Item {
    id: container


    width: txt.width + 20
    height: txt.height + 20
    //opacity: 0
    visible: false


    Text {
        id: txt
        anchors.centerIn: parent
        text: qsTr("Level ") + boardGame.level
        color: boardGame.textColor
        font.pixelSize: Qt.application.font.pixelSize * 2
    }

    NumberAnimation on opacity {
        id: createAnimation
        from: 0
        to: 1
        duration: 500
        running: newLevelOverlay.visible
    }
    NumberAnimation on opacity {
        id: deleteAnimation
        from: 1
        to: 0
        duration: 500
        running: !newLevelOverlay.visible
        onRunningChanged: {
            if (!running) {
                newLevelOverlay.visible = false
                newLevelOverlay.opacity = 1
            }
        }
    }


    Timer {
        id:timer
            interval: 800
            running: container.visible
            onTriggered: {
                deleteAnimation.running = true
                //visible = false
           }
    }


}
