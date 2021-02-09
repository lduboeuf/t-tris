import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0


import "qrc:/js/RemoteStorage.js" as RemoteStorage

Item {
    id: onlineTab
    property bool error: false



    ListView{
        id:onlineList
        anchors.fill: parent

        model: ListModel{
            id: onLineScores
        }
        delegate: ScoreItemDelegate{
        }
    }

    Label {
        anchors.centerIn: parent
        visible: onlineTab.error
        color:scorePage.textColor
        text: qsTr("Network unreachable or service unavailable")
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
        // Storage.getOnlineScores()


        RemoteStorage.getAll(
                    function(scores){
                        onLineScores.clear()
                        var recordToHighLight = 0
                        for(var i = 0; i < scores.length; i++){
                            var score = scores[i]
                            score.selected= (score.name === scorePage.currentName && parseInt(score.score) === scorePage.currentScore)
                            onLineScores.append(score)

                            if (score.selected){
                                recordToHighLight = i
                            }

                        }

                        if (recordToHighLight>0){
                            onlineList.positionViewAtIndex(recordToHighLight, ListView.Center )
                        }


                    },
                    function(error){
                        onlineTab.error = true
                    }
            )


        //var scores = []
//        var http = new XMLHttpRequest()
//        var url = Config.API_URL;
//        http.open("GET", url, true);

//        // Send the proper header information along with the request
//        http.setRequestHeader("Content-type", "application/json");
//        http.setRequestHeader("TOKEN", Config.API_KEY);

//        http.onreadystatechange = function() { // Call a function when the state changes.
//            if (http.readyState == 4) {
//                if (http.status == 200) {

//                   onLineScores.clear()
//                    var recordToHighLight = 0
//                    var fetchScores = JSON.parse(http.responseText)
//                    for(var i = 0; i < fetchScores.length; i++){

//                        var record = fetchScores[i]
//                        record.selected= (record.name === scorePage.currentName && parseInt(record.score) === scorePage.currentScore)
//                        onLineScores.append(record)

//                        if (record.selected){
//                            recordToHighLight = i
//                        }

//                    }



//                    if (recordToHighLight>0){
//                        onlineList.positionViewAtIndex(recordToHighLight, ListView.Center )
//                    }

//                    //console.log("ok" + scores.length)
//                } else {
//                    onlineTab.error = true
//                    console.log("error: " + http.status)
//                }
//            }
//        }
//        http.send();
    }




}
