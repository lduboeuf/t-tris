import QtQuick 2.9
import QtQuick.Controls 2.2

Item{
    id: root
    width: parent.width
    height: scoreTxt.implicitHeight *3

    signal highlighted

    Rectangle{
        id: rowRect
        anchors.fill: parent
        anchors.margins: 4
        color:selected ? "blue": "white"
        radius: 5
        border.color: "white"
        opacity: 0.2

    }


    Text{
        id: scoreTxt
        x: 12
        anchors.verticalCenter: parent.verticalCenter
        color: scorePage.textColor
        text: " " +score //TODO margin doesn't work
    }

    Text{
        //Layout.fillWidth: true
        x: parent.width / 2
        anchors.verticalCenter: parent.verticalCenter
        //anchors.right: parent.right
        color: scorePage.textColor
        elide: Text.ElideRight
        text: name
    }

}
