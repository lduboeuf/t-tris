import QtQuick 2.7
import QtQuick.Controls 2.2

import "../js/Storage.js" as Storage





Item {
    id: container

    width: content.implicitWidth
    height: content.implicitHeight

    visible: false

    property bool saveVisible: false

    onVisibleChanged: {
        if (visible){
            saveVisible = Storage.canSave(boardGame.score)
        }
    }


    signal restartClicked

//    function show() {
//        container.visible = true;
//    }

    function showHitHighScore(){
        console.log("hit high score!")
        container.state = "hitHighScore"
        //pageStack.push("qrc:/qml/HitHighScore.qml",{currentName: nameText.text, currentScore: boardGame.score}, StackView.Immediate);
        //hitHighScore = false
    }

    HitHighScore{
        id: hitHighScorePane
        anchors.centerIn: parent
        visible: false
    }


    Rectangle{
       anchors.fill: content
       color: "white"
       opacity: 0.2
    }



    Column{
        id: content
        spacing: 12
        anchors.fill: parent
        //anchors.centerIn: parent
        padding: 24


        Text {
            id: dialogText
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("GAME OVER")
        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("Congratulations!, you reached top local high scores")
            visible: saveVisible
        }

        TextField{
            id: nameText
            visible: saveVisible
            anchors.horizontalCenter: parent.horizontalCenter
            //width: parent.width
            //focus: true
            placeholderText: qsTr('type your name here')
            onTextChanged: {
                saveBtn.enabled = (text.length > 0) ? true: false
            }

        }

        Row{
            //anchors.top: content.bottom
            //anchors.margins: 4
            spacing: 4
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
                    //boardGame.score = 0// TODO
                    container.saveVisible = false
                    dialogText.text = qsTr("Score saved")
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

    states:[

        State{
            name:"hitHighScore"
            PropertyChanges { target: content; visible: false}
            PropertyChanges { target: hitHighScorePane; visible: true}

        }


    ]








}
