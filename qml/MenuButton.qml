import QtQuick 2.9
import QtQuick.Controls 2.2


Button {
    id: btnStart
    property alias name: btnText.text

    anchors.left: parent.left
    anchors.right: parent.right
    height: btnText.implicitHeight * 2
    antialiasing: true


    contentItem: Text{
        id:btnText
        text: text
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        color: btnStart.pressed ? "#2b3b48": "transparent"
        border.width: 1
        border.color: "#087443"
        radius: 20
        smooth: true
    }

}
