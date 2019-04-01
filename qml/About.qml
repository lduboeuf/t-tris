import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "components"

Page {

    property color textColor: "black"

    title: qsTr("About")


//    background: Image {
//        source: "/assets/ttris.png"
//        fillMode: Image.PreserveAspectCrop
//        //opacity: 0.2
//    }

    background: Rectangle{
        anchors.fill: parent
        color: "white"
        //opacity: 0.2
    }


    Image {
           id:logo
           fillMode: Image.Pad
           anchors.horizontalCenter: parent.horizontalCenter
           //sourceSize.width: parent.width * 0.3
           //sourceSize.height: parent.height * 0.3
           source: "/assets/ttris.png"
           opacity: 0.1
     }

    header:NavigationBar{
        txtColor:"black"
    }

    Column {
        anchors.fill: parent
        spacing:24
        padding:24



        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr('Welcome to t-tris!')
            color: textColor
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
             width: parent.width - parent.padding *2
             wrapMode: Text.WordWrap
            text: qsTr('Use swipe left/right/bottom to move pieces, tap to rotate or use bottom control buttons. On Desktop you can use arrow keys')
            color: textColor
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - parent.padding *2
            wrapMode: Text.WordWrap
            text: qsTr('Please notice that online scores are stored freely on https://lduboeuf.ouvaton.org, we collect only scores and user provided names. See source code for details')
            color: textColor
        }

        Button{
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr('source code here')
            onClicked: {
                Qt.openUrlExternally("https://github.com/lduboeuf/t-tris");
            }
        }



    }


}
