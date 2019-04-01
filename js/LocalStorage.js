.pragma library
.import "qrc:/js/Configuration.js" as Config
.import QtQuick.LocalStorage 2.0 as DBStorage


var db = DBStorage.LocalStorage.openDatabaseSync("TetrisScores", "", "Local Tetris High Scores",100);
db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER, level NUMBER, date TEXT)');

                if (db.version == "1.0") {
                    db.changeVersion("1.0", "1.1", function(tx) {
                        tx.executeSql('ALTER TABLE Scores ADD COLUMN date TEXT');
                        tx.executeSql('UPDATE Scores SET date = \'\'');
                        tx.executeSql('UPDATE Scores SET name = \'ABC\'');
                        tx.executeSql('DELETE FROM Scores');
                    });

                }
            })


function saveHighScore(name, score, level) {
    //OfflineStorage
    var dataStr = "INSERT INTO Scores VALUES(?, ?, ?, ?)";
    var data = [name, score, level, new Date().toLocaleDateString("i")];
    db.transaction(
                function(tx) {
                    tx.executeSql(dataStr, data);
                }
                );


}

function canSave(score) {
    //OfflineStorage
    var can = false
    var dataStr = "SELECT count(*) as nb FROM Scores WHERE score >= ?";
    var data = [score];
    db.transaction(
                function(tx) {
                    var rs = tx.executeSql(dataStr, data);
                    if (rs.rows.length > 0) {
                        var nb = rs.rows.item(0).nb
                        can = (nb < Config.MAX_LOCAL_SCORES)

                    }
                }
                );

    console.log("can save")

    return can
}

function getAll(){
    var scores = []
    db.transaction(
                function(tx) {
                    //Only show results for the current grid size
                    var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score desc LIMIT ' + Config.MAX_LOCAL_SCORES);
                    //scores.clear()

                    var recordToHighLight = 0;
                    for(var i = 0; i < rs.rows.length; i++){
                        var record = {
                            name: rs.rows.item(i).name,
                            score: rs.rows.item(i).score,
                            level: rs.rows.item(i).level,
                            date: rs.rows.item(i).date,
                        }

                        scores.push(record)

                    }

                }
                );
    return scores
}



