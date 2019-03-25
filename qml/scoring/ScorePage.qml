// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.7
import QtQuick.Controls 2.2
//import QtQuick.LocalStorage 2.0
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../components"

Page {

    id: scorePage

    title: qsTr("High scores")

    property bool showOnline: false
    property string currentName: ""
    property int currentScore:0
    property color textColor: "white"



    onShowOnlineChanged:{
        console.log("online changed:" + showOnline)
        bar.currentIndex = 1
    }

    background: Image {
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    header: NavigationBar{}

    TabBar {
        id: bar

        currentIndex: view.currentIndex

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
                border.color: bar.currentIndex == 0 ? "white" : "grey"
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
                border.color: bar.currentIndex ==1 ? "white" : "grey"
                height: 1
                anchors.bottom: parent.bottom
            }

            contentItem: Item{
                anchors.fill: onlineTabBtn
                Text{
                    text: qsTr("Shared")
                    anchors.centerIn: parent
                    color: scorePage.textColor
                    opacity: bar.currentIndex == 1 ? 1 : 0.4
                }
            }

        }

    }



    SwipeView {
        id: view
        width: parent.width


        currentIndex: bar.currentIndex
        anchors{
            top: bar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: 24

        }

        //currentIndex: bar.currentIndex

        onCurrentIndexChanged: {
            console.log("kikou current index")
        }

        LocalScores{}

        OnlineScores{}



    }





}
