import QtQuick 2.0

import "qrc:/js/Configuration.js" as Config
import  "qrc:/js/Storage.js" as Storage


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

//            onHighlighted: {
//                //localList.currentIndex = index
//                localList.positionViewAtIndex(index, ListView.Center )
//            }
        }

    }

    Component.onCompleted:  {
        //Storage.showHighScore()

        Storage.db.transaction(
                    function(tx) {
                        //Only show results for the current grid size
                        var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score desc LIMIT ' + Config.MAX_LOCAL_SCORES);
                        scores.clear()
                        var recordToHighLight = 0;
                        for(var i = 0; i < rs.rows.length; i++){
                            var record = {
                                name: rs.rows.item(i).name,
                                score: rs.rows.item(i).score,
                                level: rs.rows.item(i).level,
                                date: rs.rows.item(i).date,
                            }

                            record.selected= (record.name === scorePage.currentName && record.score === scorePage.currentScore)


                            if (record.selected){

                                //localList.currentIndex = i
                                recordToHighLight = i

                                console.log("kikou :"+ record.name)
                            }

                            scores.append(record)

                        }

                        if (recordToHighLight>0)
                            localList.positionViewAtIndex(recordToHighLight, ListView.Center )
                    }
                    );

    }





}
