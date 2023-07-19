import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import Qt.labs.settings 1.0

import "components"

ApplicationWindow {
    id: window
    visible: true
    visibility: (Screen.devicePixelRatio > 2) ? Window.FullScreen : Window.AutomaticVisibility

    width: 360
    height: 520

    color:"black"

    background:  Image {
        id: background
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Settings {
            id: settings
            property bool firstTime: true
            property bool soundOff: false
            property string envMode: (Screen.devicePixelRatio > 2) ? "Mobile": "Desktop"
            property int initialLevel:0
            property bool useBomb: true
            property bool allowNetwork: true
            property int maxColumns: 12
            property int swipeRatio: 12
            property int figureStyle: 1
            property bool tetrisExtra: true
        }


    Item{
        id: menu

        Column {
            spacing:16
            anchors.centerIn: parent
            width:parent.width * 0.6

            MenuButton {
                name: qsTr("New Game")
                anchors.left: parent.left
                anchors.right: parent.right
                highlighted: true
                focus:true
                onClicked:{
                    pageStack.push("qrc:/qml/GameBoard.qml", StackView.Immediate);
                }
            }
            MenuButton {
                name: qsTr("Show Scores")
                anchors.left: parent.left
                anchors.right: parent.right
                onClicked:{
                    pageStack.push("qrc:/qml/scoring/ScorePage.qml");
                }
            }
            MenuButton {
                name: qsTr("Options")
                anchors.left: parent.left
                anchors.right: parent.right
                onClicked:{
                    pageStack.push("qrc:/qml/Options.qml");
                }
            }
            MenuButton {
                name: qsTr("About")
                anchors.left: parent.left
                anchors.right: parent.right
                onClicked:{
                    pageStack.push("qrc:/qml/About.qml");
                }
            }
            MenuButton {
                id: btnQuit
                anchors.left: parent.left
                anchors.right: parent.right
                name: qsTr("Quit")
                onClicked:{
                    Qt.quit();
                }
            }

        }
    }



    StackView{
        id: pageStack
        anchors.fill: parent
        initialItem: menu
        onCurrentItemChanged: {
            if (currentItem!=null)
                currentItem.forceActiveFocus() //force focus on Page (fix issue with keyboard event on Gameboard)
        }
    }

    Component.onCompleted: {
        if (settings.firstTime) {
            pageStack.push("qrc:/qml/About.qml");
            settings.firstTime = false
         }
    }
}
