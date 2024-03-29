.pragma library // Shared game state
.import "Configuration.js" as Config

Qt.include("Figures.js");
Qt.include("Figure.js");
Qt.include("Board.js");

var gameBoard = { //QML component holder
    game : null,
    gameBoard : null,
    nextFigureBoard: null
}

var scorePerRows = [40,100,300,1200]
var nbRows;

var currentFigure, nextFigure;
var lastScore, nbRound;

var column, row, orientation; //current positions
var nextColumn, nextRow, nextOrientation; //next positions

var bomb;

var board, miniBoard;
var figureTypes = Object.keys(Figures)

var particleComponent = Qt.createComponent("../qml/Cell.qml");
var bombComponent = Qt.createComponent("../qml/Bomb.qml");

var figureStyle;
var tetrisExtra = true;



function initGame(game, gameCanvas, nextFigureBoard, style, ptetrisExtra) {

    gameBoard.game = game
    gameBoard.gameCanvas = gameCanvas
    gameBoard.nextFigureBoard = nextFigureBoard
    figureStyle = style
    tetrisExtra = ptetrisExtra
    //init boards

    lastScore = 0
    nbRows = 0
    gameBoard.game.score =0
    gameBoard.game.level =0

    var blockSize = gameCanvas.width < gameCanvas.height ? gameCanvas.width / Config.MAX_CELL : gameCanvas.height / Config.MAX_CELL;
    var maxRow = Math.floor(gameCanvas.height / blockSize);
    var maxColumn = Math.floor(gameCanvas.width / blockSize);

    //delete previous board
    if (board!=null) board.clear(true)
    if (miniBoard!=null) miniBoard.clear(true)
    if (currentFigure!=null) currentFigure.clear()
    if (nextFigure!=null) currentFigure.clear()

    board = new Board(blockSize, maxRow, maxColumn);
    miniBoard = new Board(15, 5, 5);

    if (!tetrisExtra) {
        var index = figureTypes.indexOf("PLUS_FIGURE");
        if (index > -1) {
          figureTypes.splice(index, 1);
        }
        index = figureTypes.indexOf("CELL_FIGURE");
        if (index > -1) {
          figureTypes.splice(index, 1);
        }
    }

    //start game
    currentFigure = null
    nextFigure = null

    gameBoard.game.state = Config.STATE_START
    nbRound =0
    nextRound()

}

function nextRound(){


    nbRound++
    //handle bomb component
    if (tetrisExtra && nbRound >1 && Math.floor(Math.random()*22)===1){

        gameBoard.game.state = Config.STATE_PENDING_BOMB
        var bombColumn =  Math.floor(Math.random()*board.maxColumn);

        bomb = bombComponent.createObject();
        bomb.parent = gameBoard.gameCanvas;
        bomb.size = board.blockSize;
        bomb.column =bombColumn
        bomb.row = board.maxRow - 1

        return
    }

    column = board.maxColumn / 2
    row = 0
    nextRow = 0
    nextColumn = 0
    orientation = 0
    nextOrientation = 0

    if (nextFigure!=null){
       //for now, easier to remove particles and create new ones
        //nextFigure.clear()

        currentFigure = nextFigure
    }else{
      currentFigure =  createNextFigure()
    }

    drawFigure(currentFigure,gameBoard.gameCanvas, board, column, row);


    miniBoard.clear(false)
    nextFigure = createNextFigure()
    drawFigure(nextFigure,gameBoard.nextFigureBoard, miniBoard, 2,2);

    gameBoard.game.state = Config.STATE_PLAY
}


function nextStep()
{
    gameBoard.game.state = Config.STATE_PLAY
    nextColumn = column;
    nextRow = row +1
    nextOrientation = orientation

    controlGame();
}

function drawFigure(figure, parentEntity, pBoard, pColumn, pRow){
    //console.log("draw at:" + pColumn, pRow)

    var points = figure.getPoints(orientation);
    for (var i=0; i < points.length; i++){

        var point = points[i];

        var particle = figure.particles[i]
        var alreadyExist = (particle!=null)
        if (!alreadyExist){
            particle = particleComponent.createObject();
            particle.style = figureStyle
            figure.particles.push(particle)
        }

        //var particle = particleComponent.createObject();
        if (pBoard.availablePosition(pColumn + point.x, pRow + point.y)){
            particle.column = pColumn + point.x
            particle.row = pRow + point.y
            particle.cellColor = figure.color;
            particle.parent = parentEntity;
            particle.size = pBoard.blockSize;


            pBoard.insert(particle);
        }
    }
}

function moveFigure(){

    var points = currentFigure.getPoints(nextOrientation)

    var toMove = []
    var particle,i
    for (i=0; i < currentFigure.particles.length; i++){
        particle = currentFigure.particles[i];
        board.delete(particle)
        particle.column = nextColumn + points[i].x
        particle.row = nextRow +  points[i].y;
        toMove.push(particle)

    }

    for (i=0; i < toMove.length; i++){
        particle = toMove[i]
        board.insert(particle);
    }

   // console.log("moved to(column,row, orientation)" + nextColumn,nextRow, nextOrientation)


    column = nextColumn
    row = nextRow
    orientation = nextOrientation
}


function displayPoints(){

    for (var i = 0; i < figureTypes.length; i++){

        var f = new Figure(figureTypes[i], Config.ORIENTATION_DEFAULT);
        console.log(f.type)
        var tbl = "["
        for (var j=0; j < f.maxOrientation; j++){
            var pts = f.getPoints(j)
            tbl += JSON.stringify(pts) + ","
        }
        tbl += "]"
        console.log(tbl)
    }
}


function createNextFigure(){

    var typeIdx = Math.floor(Math.random()*figureTypes.length);
    var type = figureTypes[typeIdx]
    //var nextColor = Config.color[Math.floor(Math.random()*4)];
    return new Figure(type, Config.ORIENTATION_DEFAULT);

    //var nextType= Math.floor(Math.random()*Config.MAX_FIGURE);
}


/*************************************
            HANDLER
 ***********************************/


function onKeyHandler(key){

    if (gameBoard.game.state !== Config.STATE_PLAY) return

        nextColumn = column
        nextRow = row

        switch(key){
        case Config.KEY_LEFT:
            nextColumn = nextColumn - 1
            break;
        case Config.KEY_FARLEFT:
            nextColumn = nextColumn - 1
            while(gameBoard.game.state === Config.STATE_PLAY &&
                 canMoveTo(nextColumn, nextRow, nextOrientation)){
                 nextColumn = nextColumn - 1
            }
            nextColumn = nextColumn+ 1
            break;
        case Config.KEY_FARRIGHT:
            nextColumn = nextColumn + 1
            while(gameBoard.game.state === Config.STATE_PLAY &&
                 canMoveTo(nextColumn, nextRow, nextOrientation)){
                 nextColumn = nextColumn+ 1
            }
            nextColumn = nextColumn-1
            break;
        case Config.KEY_RIGHT:
            nextColumn = nextColumn + 1
            break;
        case Config.KEY_UP:
            if(nextOrientation + 1 >= currentFigure.maxOrientation){
                nextOrientation = 0;
            } else {
                nextOrientation++;
            }
            break;
        case Config.KEY_DOWN:
            nextRow = nextRow +1
            while(gameBoard.game.state === Config.STATE_PLAY &&
                 canMoveTo(nextColumn, nextRow, nextOrientation)){
                 nextRow = nextRow +1
            }
            nextRow = nextRow -1
            break;
        case Config.KEY_STEP_DOWN:
            nextRow = nextRow +1
            break;
        case Config.KEY_PAUSE:
            if(gameBoard.game.state === Config.STATE_PAUSED){
                gameBoard.game.state = Config.STATE_PLAY;
            } else {
                gameBoard.game.state = Config.STATE_PAUSED

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

    if(canMoveTo(nextColumn, nextRow, nextOrientation)){

        moveFigure()

    } else if(!canMoveTo(column, row+1, orientation)){

        currentFigure.changeState(Config.CLOCKING_CELL)//define particles as "Fixed" cells


        if(board.containsParticles(1)){ //first line has particles ?
            gameBoard.game.state = Config.STATE_GAMEOVER;

        } else {

            checkFullRow()

            nextRound();
        }
    }
}

function canMoveTo(x, y, pOrientation){

    //out of bounds ?
    if(x < 0 || x >= board.maxColumn || y < 0 || y >= board.maxRow){
      return false;
    }

    var points = currentFigure.getPoints(pOrientation)
    if (points===undefined) console.log("undefined:" + pOrientation + " figure:" + currentFigure.type)
    for (var i = 0; i < points.length; i++) {

        if(!board.availablePosition(x + points[i].x, y + points[i].y)){
            return false;
        }
    }

    return true;
}

function fireBomb(pColumn, pRow){
    //console.log("fire bomb(pColumn, pRow):" + pColumn, pRow)

    removeFullRow(pRow)
    removeFullColumn(pColumn)
    moveDownAllRow2(pRow-1, 1);

    if (bomb != null) bomb.destroy()

    gameBoard.game.state = Config.STATE_FIRING_BOMB

    nextRound();
}



function checkFullRow(){

    var delta = 0;
    for (var i=board.maxRow -1; i > 0; i--){

        if (board.isFull(i)){
           //  console.debug("row full = " +i)
            gameBoard.game.state = Config.STATE_ROW_REMOVED
            removeFullRow(i);

            delta++;
        }else if(delta > 0){
           //console.debug("row not full = " +i)

            moveDownAllRow(i, delta);
        }
    }

    //score
    if ( delta > 0){
        nbRows += delta
        var newScore = scorePerRows[delta-1]
        if (gameBoard.game.level>0){
             gameBoard.game.score +=  newScore * gameBoard.game.level;
        }else{
            gameBoard.game.score +=  newScore
        }
    }

    //check for new Level ?
    if(nbRows /  (gameBoard.game.level +1)  > Config.LEVEL_DELTA){
        lastScore = gameBoard.game.score;
        gameBoard.game.state = Config.STATE_NEW_LEVEL
        gameBoard.game.level++;
    }
}


function removeFullRow(rowNum){

    for( var i=0; i< board.maxColumn; i++){
        var particle = board.getAt(i,rowNum)
        if (particle!=null){
            particle.dying = true
            board.delete(particle)
        }
    }
}

function removeFullColumn(columnNb){
   // gameBoard.game.state = Config.STATE_ROW_REMOVED
    for( var i=0; i< board.maxRow; i++){
        var particle = board.getAt(columnNb,i)
        if (particle!=null){
            particle.dying = true
            board.delete(particle)
        }
    }
}

 function moveDownAllRow2(rowNum, delta){
    for(var i=rowNum; i>0; i--){

        for (var j=0; j < board.maxColumn; j++){
            var particle = board.getAt(j,i)
            if(particle != null){
                board.delete(particle)
                particle.column = j
                particle.row = i + delta

                board.insert(particle);
            }
        }
    }
}

function moveDownAllRow(rowNum, delta){
   for(var i=0; i<board.maxColumn; i++){

       var particle = board.getAt(i,rowNum)
       if(particle != null){
           board.delete(particle)
           particle.column = i
           particle.row = rowNum + delta

           board.insert(particle);
       }
   }
}

