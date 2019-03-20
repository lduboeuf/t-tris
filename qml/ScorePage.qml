// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import QtQuick.Controls 2.2
//import QtQuick.LocalStorage 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0



import  "../js/Storage.js" as Storage
Page {

    id: scorePage

    title: qsTr("High scores")

    property color textColor: "white"

    background: Image {
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    header:ToolBar {
        id:toolBar


        background: Rectangle{
            anchors.fill: toolBar
            color:scorePage.textColor
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

    TabBar {
        id: bar
        //anchors.bottom: view.bottom
        width: parent.width
        background: Rectangle{
            color: "transparent"
            border.color: "grey"
            anchors.bottom: bar.bottom
            height: 1
        }

        TabButton {
            id: localTabBtn

            height: parent.height
            background: Rectangle {
                    color: "transparent"
                    border.color: bar.currentIndex == 0 ? "#087443" : "grey"
                    height: 1
                    anchors.bottom: parent.bottom
                }
            contentItem: Item{
                anchors.fill: localTabBtn
                Text{
                   text: qsTr("Local")
                   anchors.centerIn: parent
                   color: scorePage.textColor
                   opacity: bar.currentIndex == 0 ? 1 : 0.4
                }
            }
        }
        TabButton {
            id: onlineTabBtn
            height: parent.height
            background: Rectangle {
                    color: "transparent"
                    border.color: bar.currentIndex ==1 ? "#087443" : "grey"
                    height: 1
                    anchors.bottom: parent.bottom
                }

            contentItem: Item{
                anchors.fill: onlineTabBtn
                Text{
                   text: qsTr("Online")
                   anchors.centerIn: parent
                   color: scorePage.textColor
                   opacity: bar.currentIndex == 1 ? 1 : 0.4
                }
            }

        }

    }



    StackLayout {
        id: view
        //anchors.fill: parent
        width: parent.width

        anchors{
            top: bar.bottom
            bottom: parent.bottom

        }

        currentIndex: bar.currentIndex


        Item {
            id: localTab
            anchors.fill: parent


            Component.onCompleted:  {
                Storage.showHighScore()
            }


            ListView{
               anchors.fill: parent
                model: ListModel{
                    id: scores
                }
                delegate: ScoreItemDelegate{ }



            }



        }
        Item {
            id: onlineTab
            anchors.fill: parent
            property bool error: false


            ListView{
                anchors.fill: parent
                model: ListModel{
                    id: onLineScores
                }
                delegate: ScoreItemDelegate{}
            }

            Label {
                anchors.centerIn: parent
                visible: onlineTab.error
                color:scorePage.textColor
                text: qsTr("Network unreachable or serice unavailable")
            }

            BusyIndicator{
                id: loading
                anchors.centerIn: parent
                running: (onLineScores.count == 0 && !onlineTab.error)

            }

            ColorOverlay {
                anchors.fill: loading
                source: loading
                color:scorePage.textColor
            }


            Component.onCompleted:  {
                Storage.getOnlineScores()

            }


        }

    }








}
