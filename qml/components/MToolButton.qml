import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0


ToolButton {
    id: root

    property alias imageSrc: img.source

    background: Rectangle {
        color: "transparent"
    }

    contentItem: Image {
        id:img
        fillMode: Image.Pad
        //anchors.fill: root
       /// width: root.height  * 0.9
       // height: root.height  * 0.9
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

    ColorOverlay{
        source: img
        anchors.fill: img
        color: "white"
    }

}
