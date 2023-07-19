import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3

import "components"

Page {

    property color textColor: "white"

    title: qsTr("About")


    background: Image {
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }



    header:NavigationBar{
    }


    Image {
           id:logo
           fillMode: Image.PreserveAspectCrop
           anchors.horizontalCenter: parent.horizontalCenter
           opacity: 0.1
           source: "/assets/ttris.png"

     }


    Column {
        id: content
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
            text: qsTr('Use swipe left/right/bottom to move pieces, tap to rotate or use bottom control buttons. On Desktop you can use arrow keys.<br> Swipe speed can be managed in option menu')
            color: textColor
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - parent.padding *2
            wrapMode: Text.WordWrap
            text: qsTr('Please notice that online scores are stored freely on http://lduboeuf.ouvaton.org/ttris/, we collect only scores and user provided names. See source code for details')
            color: textColor
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr('<a href="https://github.com/lduboeuf/t-tris">source code here</a>')
            onLinkActivated: Qt.openUrlExternally(link)
            linkColor: "white"
        }

        MenuButton{
            name: qsTr('OK')
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 24
            selected: true
            onClicked: {
                pageStack.pop(null)
            }
        }
    }




}
