import QtQuick 2.0
import QtQuick.Controls 2.2


Page {
    id: menu

    signal btnStartClick();
    signal btnShowScoreClick();
    signal btnOptionsClick();
    signal btnQuitClick();

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
            id: btnStart
            name: qsTr("New Game")

            onClicked:{
                btnStartClick();
            }
        }
        MenuButton {
            id: btnShowScore
            name: qsTr("Show Scores")

            onClicked:{
                btnShowScoreClick();
            }
        }
        MenuButton {
            id: btnConfig
            name: qsTr("Options")

            onClicked:{
                btnOptionsClick();
            }
        }
        MenuButton {
            id: btnQuit
            name: qsTr("Quit")

            onClicked:{
                btnQuitClick();
            }
        }
    }
}
