/***********************************


**********************************/

function getX(point, type, orientaion){
    switch(orientaion){
    case 0:
        return FIGURE.list_figure[type][point].x;
    case 1:
        return - FIGURE.list_figure[type][point].y;
    case 2:
        return - FIGURE.list_figure[type][point].x;
    case 3:
        return FIGURE.list_figure[type][point].y;
    default:
        return FIGURE.list_figure[type][point].x;
    }
}

function getY(point, type, orientaion){
    switch(orientaion){
    case 0:
        return FIGURE.list_figure[type][point].y;
    case 1:
        return FIGURE.list_figure[type][point].x;
    case 2:
        return - FIGURE.list_figure[type][point].y;
    case 3:
        return - FIGURE.list_figure[type][point].x;
    default:
        return FIGURE.list_figure[type][point].y;
    }
}

/***********************************
**********************************/
function getMaxCellFromType(type){
    if(type < Constant.MAX_FIGURE && type >= 0){
        return Constant.arrMaxCell[type];
    } else {
        return 4;
    }
}

function getMaxOrientationFromType(type){
    if(type < Constant.MAX_FIGURE && type >= 0){
        return Constant.arrMaxOrientation[type];
    } else {
        return 1;
    }
}

//Index function used instead of a 2D array
function index(column, row) {
    return column + (row * Tetris.maxColumn);
}

function availablePosition(column, row){
    if(column < 0 || column >= Tetris.maxColumn || row < 0 || row >= Tetris.maxRow){
        return false;
    }
    if (Tetris.board[Utils.index(column, row )] != null &&
            Tetris.board[Utils.index(column, row)].type == Constant.CLOCKING_CELL){
        return false;
    }

    return true;
}

function removeFullRow(rowNum){
    console.debug("call remove full row")
    Sound.apply(Constant.REMOVE_ROW_SOUND);
    for( var i=0; i< Tetris.maxColumn; i++){
        Tetris.board[Utils.index(i, rowNum)].dying = true;
        Tetris.board[Utils.index(i, rowNum)] = null;
    }
}

function moveDownAllRow(rowNum, delta){
    for(var i=0; i<Tetris.maxColumn; i++){

        var particle = Tetris.board[Utils.index(i, rowNum)]

        if(particle != null){
            Utils.createBlock(i, rowNum + delta, Constant.CELL_FIGURE, 0)
            Utils.changeStateOfCells(i, rowNum + delta, Constant.CELL_FIGURE, 0, particle.cellColor)
            delete particle
        }
    }
}

function changeStateOfCells(column, row, type, orientation, color){
    var maxCell = Utils.getMaxCellFromType(type);
    for (var point = 0; point < maxCell; point++) {
    //    console.debug("(x,y) = ("+ column+ " , "+ row+" )  -- type,orient:  " + type + " -- "+ orientation);
        var x = Utils.getX(point, type, orientation);
        var y = Utils.getY(point, type, orientation);

        if(Tetris.board[Utils.index(column + x, row + y)] != null){
            Tetris.board[Utils.index(column + x, row + y)].type = Constant.CLOCKING_CELL;
            Tetris.board[Utils.index(column + x, row + y)].cellColor = color;
        }
    }
    return true;
}

function deleteBlock(column, row, type, orientation){
    var maxCell = Utils.getMaxCellFromType(type);
    for (var point = 0; point < maxCell; point++) {
    //    console.debug("(x,y) = ("+ column+ " , "+ row+" )  -- type,orient:  " + type + " -- "+ orientation);
        var x = Utils.getX(point, type, orientation);
        var y = Utils.getY(point, type, orientation);
        if(Tetris.board[Utils.index(column + x, row + y)] != null){
            Tetris.board[Utils.index(column + x, row + y)].destroy();
            Tetris.board[Utils.index(column + x, row + y)] = null;
        }
    }
    return true;
}

function createBlock(column, row, type, orientation)
{
    Tetris.originX = column;
    Tetris.originY = row;
    Tetris.typeBlock = type;
    Tetris.orientationBlock = orientation;
    var cell = Qt.createComponent("Cell.qml");
    if(cell.status === Component.Ready){
        var maxCell = Utils.getMaxCellFromType(type);
        for (var point = 0; point < maxCell; point++) {
            var dynamicObject = cell.createObject(gameCanvas);
            if (dynamicObject === null) {
                console.log("error creating block");
                console.log(cell.errorString());
                return false;
            }
            var x = Utils.getX(point, type, orientation);
            var y = Utils.getY(point, type, orientation);
            if(availablePosition(column + x, row + y)){
                dynamicObject.x = (column + x) * Tetris.blockSize;
                dynamicObject.y = (row + y) * Tetris.blockSize;
                dynamicObject.spawned = true; //for object animation, see Cell.qml
                dynamicObject.width = Tetris.blockSize;
                dynamicObject.height = Tetris.blockSize;
                dynamicObject.cellColor = Tetris.color;
                dynamicObject.type = Constant.RUNNING_CELL;
                Tetris.board[Utils.index(column + x, row + y, Tetris.maxColumn)] = dynamicObject;
            }
        //    console.debug("point: "+ point + " -- (x,y) = ("+ x + " , " + y +
        //                  " ) -- col = "+column + " -- row = "+row );
        }
    } else {
        console.log("error loading block component");
        console.log(cell.errorString());
        return false;
    }
    return true;
}

function getColorOfCell(){
    return Constant.color[Math.floor(Math.random()*3)];
}

//function setIntervalTimer(newTimer){
//    boardGame.intervalTimer = newTimer;
//    if(newTimer < 10){
//        boardGame.intervalTimer = 10;
//    }
//}

function drawNextFigure(column, row, type){
    var cell = Qt.createComponent("Cell.qml");
    var blockSize = 15;
    if(cell.status == Component.Ready){
        var maxCell = Utils.getMaxCellFromType(type);
        for (var point = 0; point < maxCell; point++) {
            var dynamicObject = cell.createObject(nextFigure);
            if (dynamicObject == null) {
                console.log("error creating block");
                console.log(cell.errorString());
                return false;
            }
            var x = Utils.getX(point, type, 0);
            var y = Utils.getY(point, type, 0);
            if(availablePosition(column + x, row + y)){
                dynamicObject.x = (column + x) * blockSize;
                dynamicObject.y = (row + y) * blockSize;
                dynamicObject.width = blockSize;
                dynamicObject.height = blockSize;
                dynamicObject.cellColor = Tetris.nextColor;
                dynamicObject.type = Constant.CLOCKING_CELL;
                Tetris.miniBoard[Utils.getIndex(column + x, row + y)] = dynamicObject;
            }
        //    console.debug("point: "+ point + " -- (x,y) = ("+ x + " , " + y +
        //                  " ) -- col = "+column + " -- row = "+row );
        }
    } else {
        console.log("error loading block component");
        console.log(cell.errorString());
        return false;
    }
    return true;
}

function getIndex(column, row){
    return column + (row * 5);
}

function saveHighScore(name) {
    //OfflineStorage
    var db = LocalStorage.openDatabaseSync("TetrisScores", "1.0", "Local Tetris High Scores",100);
    var dataStr = "INSERT INTO Scores VALUES(?, ?, ?)";
    var data = [name, boardGame.score, boardGame.level];
    db.transaction(
        function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER, level NUMBER)');
            tx.executeSql(dataStr, data);
        }
    );
}

function showHighScore(){
    var db = LocalStorage.openDatabaseSync("TetrisScores", "1.0", "Local Tetris High Scores",100);
    db.transaction(
        function(tx) {
              tx.executeSql('CREATE TABLE IF NOT EXISTS Scores(name TEXT, score NUMBER, level NUMBER)');
            //Only show results for the current grid size
             var rs = tx.executeSql('SELECT * FROM Scores ORDER BY score desc LIMIT 10');
            scores.clear()
            for(var i = 0; i < rs.rows.length; i++){
                scores.append({date: rs.rows.item(i).name, score: rs.rows.item(i).score, level: rs.rows.item(i).level})

            }
            //dialog.show(r);
        }
    );
}

function canMoveTo(column, row, type, orientation){

    var maxCell = Utils.getMaxCellFromType(type);
    for (var point = 0; point < maxCell; point++) {
    //    console.debug("(x,y) = ("+ column+ " , "+ row+" )  -- type,orient:  " + type + " -- "+ orientation);
        var x = Utils.getX(point, type, orientation);
        var y = Utils.getY(point, type, orientation);
        if(!Utils.availablePosition(column + x, row + y)){
            return false;
        }
    }
    return true;
}

function getClockwise(type, orientation){
    var maxOrient = Utils.getMaxOrientationFromType(type)
    if(orientation + 1>= maxOrient){
        return 0;
    } else {
        return orientation + 1;
    }
}

function isGameOver(){
    for(var i=0; i< maxColumn; i++){
        if(board[Utils.index(i,0)] != null){
            return true;
        }
    }
    return false;
}

function checkFullRow(){
    var hasRowFull = true;
    var delta = 0;
    for (var i=maxRow -1; i > 0; i--){
        for(var j=0; j<maxColumn; j++){
            hasRowFull = true
      //      console.debug("(col, row) = ("+ j + " , "+ i + " )" + " -- hasfullrow= "+ hasRowFull);
            if(board[Utils.index(j,i)] == null){
                hasRowFull = false;
      //          console.debug("Call here -------------------------------hasFull= "+ hasRowFull)
                break;
            }
        }
        if(hasRowFull){
            console.debug("row full = " +i)
            Utils.removeFullRow(i);
            delta++;
        } else if(delta > 0){
            console.debug("row not full = " +i)
            Utils.moveDownAllRow(i, delta);
        }
    }
    boardGame.score += (delta*10);
    //check for new Level ?
    if(boardGame.score - lastScore > Config.SCORE){
        lastScore = boardGame.score;
        boardGame.level++;
        //timer.interval = timer.interval - Config.REDUCED_TIME;
        //boardGame.state = Constant.STATE_NEW_LEVEL
    }
    //updateIntervalTimer(boardGame.level, boardGame.score, lastScore)

}

//function updateIntervalTimer(level, currScore, lScore){
//    if(currScore - lScore > Config.SCORE){
//        lastScore = currScore;
//        //timer.interval = timer.interval - Config.REDUCED_TIME;
//        boardGame.state = Constant.STATE_NEW_LEVEL
//    }
//}

function canGoDown(column, row){
    var maxCell = Utils.getMaxCellFromType(typeBlock);
    for (var point = 0; point < maxCell; point++) {
        var x = Utils.getX(point, typeBlock, orientationBlock);
        var y = Utils.getY(point, typeBlock, orientationBlock);
        if ((row + y) >= maxRow){
            return false;
        }

        if(board[Utils.index(column + x, row + y)] != null &&
                board[Utils.index(column + x, row + y)].type === Constant.CLOCKING_CELL){
            return false;
        }
    }
    return true;
}

function clearMiniBoard(){
    if(miniBoard != null){
        for (var i = 0; i < miniBoard.length; i++) {
            if (miniBoard[i] != null)
                miniBoard[i].destroy();
                 miniBoard[i] = null;
        }
    }
}
