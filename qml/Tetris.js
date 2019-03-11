Qt.include("Figures.js");
Qt.include("Figure.js");
Qt.include("Board.js");

var particleComponent = Qt.createComponent("Cell.qml");

var currentFigure, nextFigure;
var lastScore;

var column, row;
var nextColumn, nextRow;


var board, miniBoard;
var figureTypes = Object.keys(Figures)

function initGame() {

    boardGame.state = Constant.STATE_START
    //init boards

    lastScore = 0

    var blockSize = gameCanvas.width < gameCanvas.height ? gameCanvas.width / Config.MAX_CELL : gameCanvas.height / Config.MAX_CELL;
    var maxRow = Math.floor(gameCanvas.height / blockSize);
    var maxColumn = Math.floor(gameCanvas.width / blockSize);

    //delete previous board
    if (board!=null) board.clear()
    if (miniBoard!=null) miniBoard.clear()

    board = new Board(blockSize, maxRow, maxColumn);
    miniBoard = new Board(15, 5, 5);

    //start game
    currentFigure = null
    nextFigure = null
    boardGame.state = Constant.STATE_PLAY
    nextRound()

}



function drawFigure(figure, parentEntity, pBoard, pColumn, pRow){

    for (var i=0; i < figure.particles.length; i++){

        var particle = figure.particles[i];

        particle.parent = parentEntity;
        particle.width = pBoard.blockSize;
        particle.height = pBoard.blockSize;
        particle.updatePosition(pColumn, pRow);
        pBoard.insert(particle);
        //console.log("insert at:" + particle.column, particle.row)

    }


}

function moveFigure(){

    var toMove = []
    var particle,i
    for (i=0; i < currentFigure.particles.length; i++){
        particle = currentFigure.particles[i];
        board.delete(particle)
        toMove.push(particle)

    }

    for (i=0; i < toMove.length; i++){
        particle = toMove[i]
        particle.updatePosition(nextColumn, nextRow);
        board.insert(particle);
    }


    column = nextColumn
    row = nextRow
}



function createNextFigure(){

    //var type = "LINE_FIGURE";//TODO random
    var typeIdx = Math.floor(Math.random()*figureTypes.length);
    var type = figureTypes[typeIdx]
    var nextColor = Constant.color[Math.floor(Math.random()*3)];
    return new Figure(type, nextColor, Constant.ORIENTATION_DEFAULT);

    //var nextType= Math.floor(Math.random()*Constant.MAX_FIGURE);

}



/*************************************
            HANDLER
 ***********************************/
function nextRound(){

    boardGame.state = Constant.STATE_PLAY
    column = board.maxColumn / 2
    row = 0

    currentFigure = (nextFigure!=null) ? nextFigure : createNextFigure()
    drawFigure(currentFigure,gameCanvas, board, column, row);


    nextFigure = createNextFigure()
    drawFigure(nextFigure,nextFigureBoard, miniBoard, 2,2);
}


function nextStep()
{
    boardGame.state = Constant.STATE_PLAY
    nextColumn = column;
    nextRow = row +1
    controlGame();

}


function onKeyHandler(key){

        nextColumn = column
        nextRow = row

        switch(key){
        case Constant.KEY_LEFT:
            nextColumn = nextColumn - 1
            break;
        case Constant.KEY_RIGHT:
            nextColumn = nextColumn + 1
            break;
        case Constant.KEY_UP:
            currentFigure.rotate()
            break;
        case Constant.KEY_DOWN:
            nextRow = nextRow +1
            while(boardGame.state === Constant.STATE_PLAY &&
                  canMove()){
                 nextRow = nextRow +1
            }
            nextRow = nextRow -1
            break;
        case Constant.KEY_PAUSE:
            if(boardGame.state === Constant.STATE_PAUSED){
                boardGame.state = Constant.STATE_PLAY;
            } else {
                boardGame.state = Constant.STATE_PAUSED

            }
            break;

        default:
            break;
        }
        controlGame()

        return true;
}
/*************************************
          END   HANDLER
 ***********************************/

function controlGame(){

    if(canMove()){

        moveFigure()



    } else if(!canGoDown()){

        changeStateOfCells() //define particles as "Fixed" cells
        if(board.containsParticle(1)){
            boardGame.state = Constant.STATE_GAMEOVER;
            Storage.saveHighScore(new Date().toLocaleString(), boardGame.score, boardGame.level)
        } else {

            checkFullRow();

            nextRound();
        }
    }


}

function canMove(){

    //out of bounds ?
    if(column < 0 || column >= board.maxColumn || row < 0 || row >= board.maxRow){
      return false;
    }

    for (var i = 0; i < currentFigure.particles.length; i++) {
     //console.debug("(x,y) = ("+ item.column+ " , "+ item.row+" )  -- type,orient:  " + item.type + " -- "+ item.orientation);
        var particle = currentFigure.particles[i]

        if(!board.availablePosition(nextColumn + particle.refPoints.x, nextRow + particle.refPoints.y)){
            return false;
        }
    }
    return true;
}

function canGoDown(){
    for (var i = 0; i < currentFigure.particles.length; i++) {
     //console.debug("(x,y) = ("+ item.column+ " , "+ item.row+" )  -- type,orient:  " + item.type + " -- "+ item.orientation);
        var particle = currentFigure.particles[i]
        if ((particle.row + 1) >= board.maxRow){
            return false;
        }

        if(!board.availablePosition(column + particle.refPoints.x, row + particle.refPoints.y +1)){
            return false;
        }
    }
    return true;
}

 function changeStateOfCells(){
    for (var i = 0; i < currentFigure.particles.length; i++) {
        var particle = currentFigure.particles[i]
        if(particle != null){
            particle.type = Constant.CLOCKING_CELL;
        }
    }
}

function checkFullRow(){
    var hasRowFull = true;
    var delta = 0;
    //board.debugContainer()
    for (var i=board.maxRow -1; i > 0; i--){
        for(var j=0; j<board.maxColumn; j++){
            hasRowFull = true
      //      console.debug("(col, row) = ("+ j + " , "+ i + " )" + " -- hasfullrow= "+ hasRowFull);
            if(board.getAt(j,i) == null){
                hasRowFull = false;
                break;
            }
        }
        if(hasRowFull){
            console.debug("row full = " +i)
            removeFullRow(i);
            delta++;
        } else if(delta > 0){
            console.debug("row not full = " +i)
            moveDownAllRow(i, delta);
        }
    }
    boardGame.score += (delta*10);
    //check for new Level ?
    if(boardGame.score - lastScore > Config.SCORE){
        lastScore = boardGame.score;
        boardGame.level++;

    }

}

function removeFullRow(rowNum){
    boardGame.state = Constant.STATE_ROW_REMOVED
    for( var i=0; i< board.maxColumn; i++){
        var particle = board.getAt(i,rowNum)
        particle.dying = true
        board.delete(particle)
    }

}

 function moveDownAllRow(rowNum, delta){
    for(var i=0; i<board.maxColumn; i++){

        var particle = board.getAt(i,rowNum)
        if(particle != null){
            board.delete(particle)
            particle.updatePosition(i, rowNum + delta);

            board.insert(particle);

        }
    }
}

