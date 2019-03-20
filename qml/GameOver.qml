import QtQuick 2.0
import QtQuick.Controls 2.2
//import QtGraphicalEffects 1.0

import "../js/Storage.js" as Storage





Item {
    id: container
    width: 200
    height: 100

    property bool saveVisible: boardGame.score > 0
    property bool hitHighScore: false


    signal restartClicked

    function show() {
        container.visible = true;
    }

    onHitHighScoreChanged: {
        if (hitHighScore){
            console.log("hit high score!")
            pageStack.push("qrc:/qml/HitHighScore.qml", StackView.Immediate);
            hitHighScore = false
        }
    }

    visible: false

    Rectangle{
        anchors.fill: parent
        color: "white"
        opacity: 0.2
    }

//    HitHighScore{
//        id: highScore
//        visible: true
//    }


    Column{
        id: content
        spacing: 12
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.centerIn: parent

        Text {
            id: dialogText
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("GAME OVER")
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("Save your score:")
            visible: saveVisible
        }

        TextField{
            id: nameText
            visible: saveVisible
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            focus: true
            placeholderText: qsTr('type your name here')
            onTextChanged: {
                saveBtn.enabled = (text.length > 0) ? true: false
            }

        }




    }

    Row{
        anchors.top: content.bottom
        anchors.margins: 4
        anchors.horizontalCenter: parent.horizontalCenter
        //width: parent.width * 0.8
        //anchors.left: parent.left
        //width: parent.width * 0.8

        Button{
            id: saveBtn
            visible: saveVisible
            text: qsTr("Save")
            enabled: false
            onClicked: {
                Storage.saveHighScore(nameText.text, boardGame.score, boardGame.level)
                boardGame.score = 0

            }
        }

        Button{
            id: retryBtn
            text: qsTr("Retry")
            onClicked: {
                restartClicked()
                container.visible = false;
            }
        }
    }





}
