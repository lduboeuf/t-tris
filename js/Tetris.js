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

var currentFigure, nextFigure;
var lastScore, nbRound;

var column, row, orientation; //current positions
var nextColumn, nextRow, nextOrientation; //next positions

var bomb;

var board, miniBoard;
var figureTypes = Object.keys(Figures)

var particleComponent = Qt.createComponent("../qml/Cell.qml");
var bombComponent = Qt.createComponent("../qml/Bomb.qml");



function initGame(game, gameCanvas, nextFigureBoard) {


//    if (particleComponent.status == Component.Error) {
//        console.log(particleComponent.errorString());
//    }
    gameBoard.game = game
    gameBoard.gameCanvas = gameCanvas
    gameBoard.nextFigureBoard = nextFigureBoard
    //init boards

    lastScore = 0
    gameBoard.game.score =0
    gameBoard.game.level =1

    var blockSize = gameCanvas.width < gameCanvas.height ? gameCanvas.width / Config.MAX_CELL : gameCanvas.height / Config.MAX_CELL;
    var maxRow = Math.floor(gameCanvas.height / blockSize);
    var maxColumn = Math.floor(gameCanvas.width / blockSize);

    //delete previous board
    if (board!=null) board.clear()
    if (miniBoard!=null) miniBoard.clear()
    if (currentFigure!=null) currentFigure.clear()
    if (nextFigure!=null) currentFigure.clear()

    board = new Board(blockSize, maxRow, maxColumn);
    miniBoard = new Board(15, 5, 5);

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
    if (nbRound >1 && Math.floor(Math.random()*20)===1){

        gameBoard.game.state = Config.STATE_PENDING_BOMB
        var bombColumn =  Math.floor(Math.random()*board.maxColumn);

        bomb = bombComponent.createObject();
        bomb.parent = gameBoard.gameCanvas;
        bomb.size = board.blockSize;
        bomb.column =bombColumn
        bomb.row = board.maxRow - 1

        return
    }


    gameBoard.game.state = Config.STATE_PLAY


    column = board.maxColumn / 2
    row = 0
    orientation = 0

    if (nextFigure!=null){
       //for now, easier to remove particles and create new ones
        nextFigure.clear()
        miniBoard.clear()
        currentFigure = nextFigure
    }else{
      currentFigure =  createNextFigure()
    }

    //currentFigure = (nextFigure!=null) ? nextFigure : createNextFigure()
    drawFigure(currentFigure,gameBoard.gameCanvas, board, column, row);



    nextFigure = createNextFigure()
    drawFigure(nextFigure,gameBoard.nextFigureBoard, miniBoard, 2,2);
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

        var particle = particleComponent.createObject();
        particle.cellColor = figure.color;
        particle.parent = parentEntity;
        particle.size = pBoard.blockSize;
        if (pBoard.availablePosition(pColumn + point.x, pRow + point.y)){
            particle.column = pColumn + point.x
            particle.row = pRow + point.y
            pBoard.insert(particle);
            figure.particles.push(particle)
        }

        //console.log("insert at:" + particle.column, particle.row)

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



function createNextFigure(){

    //var type = "LINE_FIGURE";//TODO random
    var typeIdx = Math.floor(Math.random()*figureTypes.length);
    var type = figureTypes[typeIdx]
    var nextColor = Config.color[Math.floor(Math.random()*4)];
    return new Figure(type, nextColor, Config.ORIENTATION_DEFAULT);

    //var nextType= Math.floor(Math.random()*Config.MAX_FIGURE);

}



/*************************************
            HANDLER
 ***********************************/


function onKeyHandler(key){

        nextColumn = column
        nextRow = row

        switch(key){
        case Config.KEY_LEFT:
            nextColumn = nextColumn - 1
            break;
        case Config.KEY_RIGHT:
            nextColumn = nextColumn + 1
            break;
        case Config.KEY_UP:

            //if (nextColumn>0 && nextRow>0 && (nextColumn<board.maxColumn-1)){

                if(nextOrientation + 1 >= currentFigure.maxOrientation){
                    nextOrientation = 0;
                } else {
                    nextOrientation++;
                }


            //}

            //currentFigure.rotate()

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
    for (var i = 0; i < points.length; i++) {

        if(!board.availablePosition(x + points[i].x, y + points[i].y)){
            return false;
        }

    }


    return true;
}

function fireBomb(pColumn, pRow){
    gameBoard.game.state = Config.STATE_FIRING_BOMB

    console.log("fire bomb(pColumn, pRow):" + pColumn, pRow)

    removeFullRow(pRow)
    removeFullColumn(pColumn)
    moveDownAllRow2(pRow-1, 1);

    if (bomb != null) bomb.destroy()

}



function checkFullRow(){

    var delta = 0;
    for (var i=board.maxRow -1; i > 0; i--){

        if (board.isFull(i)){
           //  console.debug("row full = " +i)
            gameBoard.game.state = Config.STATE_ROW_REMOVED
            removeFullRow(i);
            gameBoard.game.score +=  Config.SCORE_INCREMENT;
            delta++;
        }else if(delta > 0){
           // console.debug("row not full = " +i)
            moveDownAllRow(i, delta);
        }

    }


    //check for new Level ?
    if(gameBoard.game.score - lastScore > Config.SCORE){
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

