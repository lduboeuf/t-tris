

var db = LocalStorage.openDatabaseSync("TetrisScores", "1.0", "Local Tetris High Scores",100);
db.transaction(
    function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER, level NUMBER)');
    }
)


function saveHighScore(name, score, level) {
    //OfflineStorage
    var dataStr = "INSERT INTO Scores VALUES(?, ?, ?)";
    var data = [name, score, level];
    db.transaction(
        function(tx) {
            tx.executeSql(dataStr, data);
        }
    );
}

function showHighScore(){
    db.transaction(
        function(tx) {
            //Only show results for the current grid size
             var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score desc LIMIT 10');
            scores.clear()
            for(var i = 0; i < rs.rows.length; i++){
                scores.append({date: rs.rows.item(i).name, score: rs.rows.item(i).score, level: rs.rows.item(i).level})

            }
        }
    );
}

