// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Layouts 1.3


import  "Utils.js" as Utils
Page {


    header:ToolBar {
        id:toolBar

        background: Rectangle{
            anchors.fill: toolBar
            color:"white"
            opacity: 0.2
        }

            RowLayout {

                anchors.fill: parent
                ToolButton {
                    id: toolButtonLeft
                    contentItem: Image {
                        id:navImage
                        fillMode: Image.Pad
                        sourceSize.width: toolButtonLeft.height  * 0.4
                        sourceSize.height: toolButtonLeft.height  * 0.4
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "/assets/back.svg"
                    }
                    onClicked: {
                        pageStack.pop()
                    }

                }
            }
    }


    StackView.onActivated: {
        Utils.showHighScore(1)
    }


    DialogS7 {
        id: dialog
    }
}
