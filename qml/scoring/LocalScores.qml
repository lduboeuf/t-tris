import QtQuick 2.12

import "qrc:/js/LocalStorage.js" as LocalStorage


Item {
    id: localTab
    // anchors.fill: parent


    ListView{
        id:localList
        anchors.fill: parent

        //currentIndex: -1



        model: ListModel{
            id: scores
        }
        delegate: ScoreItemDelegate{
        }

    }

    Component.onCompleted:  {
        //Storage.showHighScore()

        var recordToHighLight = 0;
        var scoresData = LocalStorage.getAll()
        scores.clear()
        for(var i = 0; i < scoresData.length; i++){

            var score = scoresData[i]

            score.selected= (score.name === scorePage.currentName && score.score === scorePage.currentScore)

            if (score.selected){
                recordToHighLight = i
            }

            scores.append(score)

        }

        if (recordToHighLight>0)
            localList.positionViewAtIndex(recordToHighLight, ListView.Center )


    }





}
