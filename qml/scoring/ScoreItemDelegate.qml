import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Item{

    width: parent.width
    height: scoreTxt.implicitHeight *3

    signal highlighted

    Layout.margins: 12

    Rectangle{

        id: rowRect
        anchors.fill: rowScore
        color:selected ? "blue": "white"
        radius: 5
        border.color: "white"

        opacity: 0.2

    }


    RowLayout{
        id:rowScore
        anchors.fill: parent
        anchors.margins: 4


        Text{

            id: scoreTxt

            Layout.leftMargin: 12
            color: scorePage.textColor
            text: " " +score //TODO margin doesn't work
        }

        Text{
            anchors.left: parent.horizontalCenter
            color: scorePage.textColor
            elide: Text.ElideRight
            text: name

        }


    }

}
