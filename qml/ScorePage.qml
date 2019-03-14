// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Layouts 1.3


import  "../js/Storage.js" as Storage
Page {


    title: qsTr("High scores")

    background: Image {
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

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

                Text {
                    id: score
                    anchors { horizontalCenter: parent.horizontalCenter;  verticalCenter: parent.verticalCenter;}
                    color: "white"
                    text: title


                }

            }
    }


    StackView.onActivated: {
        Storage.showHighScore()
    }


    ListView{
        anchors.fill: parent
        model: ListModel{
            id: scores
        }
        delegate: ItemDelegate{
            width: parent.width
            contentItem: Text{
                color: "white"
                text: score + " (" +date + ")"
            }


        }
    }




}
