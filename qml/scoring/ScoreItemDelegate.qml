import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Item{

 //   Layout.margins: 4
//    Layout.leftMargin: 12
//    Layout.topMargin: 4


    width: parent.width
    height: scoreTxt.implicitHeight *3
   // state: (name === scorePage.currentName && score == scorePage.currentScore) ? "highlighted" : ""

    signal highlighted

    Layout.margins: 12

    Rectangle{

        id: rowRect
        anchors.fill: rowScore
        //anchors.margins: 4
        color:selected ? "blue": "white"
        radius: 5
        border.color: "white"

        opacity: 0.2

    }


    RowLayout{
        id:rowScore
        // width: parent.width
        anchors.fill: parent
        anchors.margins: 4
//        Layout.alignment: Qt.AlignHCenter
//        Layout.margins: 12



        Text{

            id: scoreTxt

            Layout.leftMargin: 12
            color: scorePage.textColor
            text: " " +score //TODO margin doesn't work
        }

        Text{

            //Layout.alignment: Qt.AlignHCenter
            anchors.left: parent.horizontalCenter
            //anchors.horizontalCenter: parent.horizontalCenter
            color: scorePage.textColor
            elide: Text.ElideRight
            text: name

        }


    }

//    states: [
//        State{
//            name: "highlighted";
//            PropertyChanges {target: rowRect; color: "blue"}
//            StateChangeScript { script: highlighted()}
//        }

//    ]
}
