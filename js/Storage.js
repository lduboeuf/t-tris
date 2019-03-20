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
                tx.executeSql('DELETE FROM Scores WHERE score = 0');
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

    //online
    saveOnlineScore(name, score, level)
}

function showHighScore(){
    db.transaction(
        function(tx) {
            //Only show results for the current grid size
             var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score desc LIMIT 10');
            scores.clear()
            for(var i = 0; i < rs.rows.length; i++){
                console.log(rs.rows.item(i).date)
                scores.append({name: rs.rows.item(i).name, score: rs.rows.item(i).score, level: rs.rows.item(i).level, date: rs.rows.item(i).date})

            }
        }
    );
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
    var url = "http://localhost:8000/api.php";
    http.open("POST", url, true);

    // Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/json");
    http.setRequestHeader("TOKEN", Config.API_KEY);

    http.onreadystatechange = function() { // Call a function when the state changes.
        if (http.readyState == 4) {
            if (http.status == 201) {

                container.hitHighScore = true

               //OK highscore
            } else {
                //onlineTab.error = true
                console.log("error: " + http.status)

            }
        }
    }
    http.send(JSON.stringify(data));
}

function getOnlineScores(){

    //var scores = []
    var http = new XMLHttpRequest()
    var url = "http://localhost:8000/api.php";
    http.open("GET", url, true);

    // Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/json");
    http.setRequestHeader("TOKEN", Config.API_KEY);

    http.onreadystatechange = function() { // Call a function when the state changes.
        if (http.readyState == 4) {
            if (http.status == 200) {
                onLineScores.clear()
                var scores = JSON.parse(http.responseText)
                for(var i = 0; i < scores.length; i++){
                    onLineScores.append(scores[i])

                }

                //console.log("ok" + scores.length)
            } else {
                onlineTab.error = true
                console.log("error: " + http.status)
            }
        }
    }
    http.send();
}

