import QtQuick 2.7
import QtQuick.Controls 2.2

import "../js/Storage.js" as Storage





Item {
    id: container

    width: content.implicitWidth
    height: content.implicitHeight

    visible: false

    property bool saveVisible: boardGame.score >0


    signal restartClicked

    function show() {
        container.visible = true;
    }

    function showHitHighScore(){
        console.log("hit high score!")
        pageStack.push("qrc:/qml/HitHighScore.qml", StackView.Immediate);
        hitHighScore = false
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
        padding: 12


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
                    boardGame.score = 0// TODO faire autrement
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








}
