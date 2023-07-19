import QtQuick 2.7
import QtQuick.Controls 2.2
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

    header: NavigationBar{

        onBackPressed: {
            localScores.visible = false //workaround for bug: https://bugreports.qt.io/browse/QTBUG-70335
        }
    }

    TabBar {
        id: bar

        currentIndex: view.currentIndex

        height: scorePage.header.height
        width: parent.width
        background: Rectangle{
            color: "transparent"
        }

        TabButton {
            id: localTabBtn
            height: bar.height
            anchors.bottom: parent.bottom
            background: Rectangle {
                color: "transparent"
                border.color: bar.currentIndex == 0 ? "white" : "grey"
                height: 1
                anchors.bottom: localTabBtn.bottom
            }
            contentItem: Item {
                Layout.fillWidth: true
                Label {
                    text: qsTr("Local")
                    Layout.fillWidth: true
                    //Layout.alignment: Qt.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: scorePage.textColor
                    opacity: bar.currentIndex == 0 ? 1 : 0.4
                }
            }
        }

        TabButton {
            id: onlineTabBtn
            height: bar.height
            anchors.bottom: parent.bottom
            background: Rectangle {
                color: "transparent"
                border.color: bar.currentIndex ==1 ? "white" : "grey"
                height: 1
                anchors.bottom: parent.bottom
            }

            contentItem: Item {
                Layout.fillWidth: true
                Label{
                    text: qsTr("Shared")
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: scorePage.textColor
                    opacity: bar.currentIndex == 1 ? 1 : 0.4
                }
            }
        }
    }

    SwipeView {
        id: view
        width: parent.width
        z: -1

        currentIndex: bar.currentIndex
        interactive: false
        anchors{
            top: bar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: 20

        }

        LocalScores{
            id: localScores
        }

        OnlineScores{}
    }

}
