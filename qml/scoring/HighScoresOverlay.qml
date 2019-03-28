import QtQuick 2.7
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2
import Qt.labs.settings 1.0


import "qrc:/js/Configuration.js" as Config
import  "qrc:/js/Storage.js" as Storage


Item{

    id: gameOverItem
    anchors.margins: 12
    anchors.fill: parent


    property bool onError: false
    property bool isConnected: false
    property bool hitLocalHighScore: false
    property bool hitOnlineHighScore: false

    property int level: 0
    property int score:0

    //visible: false


    signal restartClicked


    function checkHighScore(score, level) {
        console.log("score changer:" + score)

        //gameOverItem.visible = true

        if (score ===0) return


        gameOverItem.score = score
        gameOverItem.level = level


        hitLocalHighScore = Storage.canSave(score) //synchronous
        //Storage.canSaveOnline(score, response)

        //check online scores
        var http = new XMLHttpRequest()
        http.open("GET", Config.API_URL + "?operation=canSave&score=" +score, true);

        // Send the proper header information along with the request
        //http.setRequestHeader("Content-type", "application/json");
        http.setRequestHeader("TOKEN", Config.API_KEY);

        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.readyState == 4) {
                if (http.status == 200) {
                    console.log(http.responseText)
                     gameOverItem.isConnected = true
                    var response = JSON.parse(http.responseText)
                    gameOverItem.hitOnlineHighScore = response.canSave


                    //OK highscore
                } else if (http.status == 0 || http.status >400) {
                    //onlineTab.error = true
                    gameOverItem.onError = true
                    console.log("error: " + http.status)

                } else {
                    gameOverItem.isConnected = true
                }
            }
        }
        http.send();

    }

    function saveOnlineScore(name, score, level){
        //var scores = []

        var data = {
            name: name,
            score:score,
            level: level,
            env: settings.envMode
        }

        var http = new XMLHttpRequest()
        http.open("POST", Config.API_URL, true);

        // Send the proper header information along with the request
        http.setRequestHeader("Content-Type", "application/json");
        http.setRequestHeader("TOKEN", Config.API_KEY);

        http.onreadystatechange = function() { // Call a function when the state changes.
            if (http.readyState == 4) {
                if (http.status == 201) {

                    gameOverItem.showHighScorePage()

                    //OK highscore
                } else {
                    //onlineTab.error = true
                    console.log("error: " + http.status + "resp:" + http.responseText)

                }
            }
        }
        http.send(JSON.stringify(data));
    }



    function showHighScorePage(){
        pageStack.push("qrc:/qml/scoring/ScorePage.qml", {showOnline:gameOverItem.hitOnlineHighScore & allowSaveOnline.checked, currentName: nameText.text, currentScore: score})

    }

    Rectangle{
        anchors.fill: parent
        color: "white"
        opacity: 0.2
    }

    Text {
        id:gameOverTitle
        anchors.horizontalCenter: parent.horizontalCenter
        padding: 24
        font.pixelSize: Qt.application.font.pixelSize * 2
        color: "white"
        text: qsTr("GAME OVER")
    }

    Button{
        anchors.centerIn: parent
        visible: !hitLocalHighScore && !hitOnlineHighScore
        text: qsTr("Retry")
        onClicked: {
            gameOverItem.restartClicked()

        }
    }







        Flickable{
            id:hitHighScoreItem
            visible: hitLocalHighScore || hitOnlineHighScore
            anchors{
                top: gameOverTitle.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right

            }

            //anchors.fill: parent
            contentHeight: content.height

            bottomMargin: Qt.inputMethod.visible ? Qt.inputMethod.keyboardRectangle.height:0




            Column{
                id: content
                spacing: 12
                anchors.fill: parent
                //anchors.fill: parent
                //anchors.centerIn: parent
                padding: 24


                Text {
                    id: title
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    text: qsTr("Congratulations!")
                    visible: hitLocalHighScore || hitOnlineHighScore
                }



                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - parent.padding
                    color: "white"
                    wrapMode: Text.WordWrap
                    text: qsTr("you reached top local high scores")
                    visible: hitLocalHighScore
                }

                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "white"
                    width: parent.width - parent.padding
                    wrapMode: Text.WordWrap
                    text: qsTr("Yes!, you reached top online high scores")
                    visible: hitOnlineHighScore
                }
                Text{
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "brown"
                    width: parent.width - parent.padding
                    wrapMode: Text.WordWrap
                    visible:onError
                    horizontalAlignment: Qt.AlignHCenter
                    //width: parent.width - parent.padding
                    text: qsTr("Could not checked for shared top scores,<br> maybe your  offline ?")
                    //visible: onError
                }


                BusyIndicator {
                    id: loader
                    //visible: !onError
                    anchors.horizontalCenter: parent.horizontalCenter
                    running:gameOverItem.visible && !onError && !isConnected
                }

                ColorOverlay {
                    //anchors.fill: loader
                    source: loader
                    color:"white"
                }




                TextField{
                    id: nameText
                    visible: hitLocalHighScore || hitOnlineHighScore
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Qt.AlignVCenter
                    color:"white"
                    inputMethodHints: Qt.ImhNoPredictiveText; //workaround for onTextChanged not fired on mobile
                    maximumLength: 25
                    background: Rectangle {
                        anchors.top: parent.bottom
                        color:"transparent"
                        height: 1
                        border.color: "white"
                    }

                    placeholderText: qsTr('type your name here')

                    onTextChanged: {
                        saveBtn.enabled = (text.length > 2) ? true: false
                    }

                }

                Button{
                    id: saveBtn
                    text: qsTr("Save")
                    enabled: false
                    visible: hitLocalHighScore || hitOnlineHighScore
                    anchors.horizontalCenter: parent.horizontalCenter

                    onClicked: {
                        Storage.saveHighScore(nameText.text, gameOverItem.score, gameOverItem.level)
                        if (hitOnlineHighScore && allowSaveOnline.checked){
                            saveOnlineScore(nameText.text, gameOverItem.score, gameOverItem.level)
                        }else{
                            showHighScorePage()
                        }
                        gameOverItem.visible = false
                    }
                }

                Row {
                    visible: hitOnlineHighScore
                   // anchors.horizontalCenter: parent.horizontalCenter
                    CheckBox {
                            id:allowSaveOnline
                            checked: settings.allowNetwork
                        }

                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Allow save online")
                        color:"white"
                    }


                }






            }


        }






    //GameOver{}
    onStateChanged: {
        console.log(state)
    }




}
