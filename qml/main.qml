import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Window 2.2


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


    Column {
        spacing:16
        anchors.centerIn: parent
        width:parent.width * 0.6

        MenuButton {
            name: qsTr("New Game")
            onClicked:{
                pageStack.push("qrc:/qml/GameBoard.qml", StackView.Immediate);
            }
        }
        MenuButton {
            name: qsTr("Show Scores")
            onClicked:{
                pageStack.push("qrc:/qml/ScorePage.qml");
            }
        }
        MenuButton {
            name: qsTr("Options")
            onClicked:{
                pageStack.push("qrc:/qml/Options.qml");
            }
        }
        MenuButton {
            id: btnQuit
            name: qsTr("Quit")
            onClicked:{
                Qt.quit();
            }
        }
    }



    StackView{
        id: pageStack
        anchors.fill: parent
        initialItem: Item{}
        onCurrentItemChanged: {
                currentItem.forceActiveFocus() //force focus on Page (fix issue with keyboard event on Gameboard)
        }
    }
}
