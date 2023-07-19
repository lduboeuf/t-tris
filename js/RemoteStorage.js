.pragma library // Shared game state
.import "qrc:/js/Configuration.js" as Config



function getAll(onSucess, onError){

    var http = new XMLHttpRequest()
    var url = Config.API_URL;
    http.open("GET", url, true);

    // Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/json");
    http.setRequestHeader("TOKEN", Config.API_KEY);

    http.onreadystatechange = function() { // Call a function when the state changes.
        if (http.readyState == 4) {
            if (http.status == 200) {

                //onLineScores.clear()
                var scores = []
                var recordToHighLight = 0
                var fetchScores = JSON.parse(http.responseText)
                for(var i = 0; i < fetchScores.length; i++){

                    var record = fetchScores[i]
                    scores.push(record)

                }
                console.log('ok onSucess')
                onSucess(scores)


            } else {
                onError(http.status)
            }
        }
    }
    http.send();
}

function canSave(score, onSuccess, onError){
    //check online scores
    var http = new XMLHttpRequest()
    http.open("GET", Config.API_URL + "?operation=canSave&score=" +score, true);

    // Send the proper header information along with the request
    //http.setRequestHeader("Content-type", "application/json");
    http.setRequestHeader("TOKEN", Config.API_KEY);

    http.onreadystatechange = function() { // Call a function when the state changes.
        if (http.readyState == 4) {
            if (http.status == 200) {

                onSuccess(JSON.parse(http.responseText))

                //OK highscore
            } else if (http.status == 0 || http.status >400) {
                //onlineTab.error = true
                onError(http.status)
                console.log("error: " + http.status)

            } else {
               //TODO gameOverItem.isConnected = true
            }
        }
    }
    http.send();
}

function save(data, onSuccess, onError){
    //var scores = []

//    var data = {
//        name: name,
//        score:score,
//        level: level,
//        env: settings.envMode
//    }

    var http = new XMLHttpRequest()
    http.open("POST", Config.API_URL, true);

    // Send the proper header information along with the request
    http.setRequestHeader("Content-Type", "application/json");
    http.setRequestHeader("TOKEN", Config.API_KEY);

    http.onreadystatechange = function() { // Call a function when the state changes.
        if (http.readyState == 4) {
            if (http.status == 201) {

                onSuccess()

                //OK highscore
            } else {
                onError()
                //onlineTab.error = true
                //console.log("error: " + http.status + "resp:" + http.responseText)

            }
        }
    }
    http.send(JSON.stringify(data));
}


