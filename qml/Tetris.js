Qt.include("Utils.js");

var blockSize, maxColumn, maxRow,maxIndex, board,originX,originY,defaultOriginX,defaultOriginY;
var typeBlock,orientationBlock, color,miniBoard,nextTypeBlock,nextColor,lastScore;


function initGame() {

    boardGame.state = Constant.STATE_START


    //Delete blocks from previous game
    for (var i = 0; i < maxIndex; i++) {
        if (board[i] !=null)
            board[i].destroy();
    }
    if(miniBoard != null){
        for (var i = 0; i < 25; i++) {
            if (miniBoard[i] !=null)
                miniBoard[i].destroy();
        }
    }


    maxColumn = Config.MAX_CELL;
    maxRow = Constant.MAX_ROW_DEFAULT;
    maxIndex = maxColumn * maxRow;
    board = new Array(maxIndex);
    originX = defaultOriginX;
    originY = defaultOriginY;
    typeBlock = Constant.TYPE_FIGURE_DEFAULT;
    orientationBlock = Constant.ORIENTATION_DEFAULT;
    color = "red"
    miniBoard = new Array(25);
    nextTypeBlock = Constant.TYPE_FIGURE_DEFAULT;
    nextColor = "red"
    lastScore = 0

    blockSize = gameCanvas.width < gameCanvas.height ? gameCanvas.width / Config.MAX_CELL : gameCanvas.height / Config.MAX_CELL;
    maxRow = Math.floor(gameCanvas.height / blockSize);
    maxColumn = Math.floor(gameCanvas.width / blockSize);

    defaultOriginX = maxColumn / 2;
    defaultOriginY = 0;

    maxIndex = maxRow * maxColumn;




    //Initialize Board
    board = new Array(maxIndex);
    var newType = Math.floor(Math.random()*Constant.MAX_FIGURE);

    nextTypeBlock = Math.floor(Math.random()*Constant.MAX_FIGURE);
    nextColor =  Utils.getColorOfCell();
    Utils.drawNextFigure(2,2,nextTypeBlock)

    Utils.createBlock( defaultOriginX, defaultOriginY,
                      newType, Constant.ORIENTATION_DEFAULT);

    boardGame.state = Constant.STATE_PLAY

}


/*************************************
            HANDLER
 ***********************************/
function nextRound()
{
    controllerGame(originX, originY + 1, typeBlock, orientationBlock);
}

function onKeyHandler(key){
    if(boardGame.state !== Constant.STATE_GAMEOVER){
        var newXOnKeyHandle = originX;
        var newYOnKeyHandle = originY;
        var newOrientOnKeyHandle = orientationBlock;
        switch(key){
        case Constant.KEY_LEFT:
            newXOnKeyHandle = originX - 1;
            break;
        case Constant.KEY_RIGHT:
            newXOnKeyHandle = originX + 1;
            break;
        case Constant.KEY_UP:
            newOrientOnKeyHandle = getClockwise(typeBlock, orientationBlock)
            break;
        case Constant.KEY_DOWN:
            newYOnKeyHandle = originY + 1;
            while(boardGame.state == Constant.STATE_PLAY &&
                  canMoveTo(newXOnKeyHandle, newYOnKeyHandle, typeBlock, newOrientOnKeyHandle)){
                newYOnKeyHandle += 1;
            }
            newYOnKeyHandle -=1;
            break;
        case Constant.KEY_PAUSE:
            if(boardGame.state === Constant.STATE_PAUSED){
                boardGame.state = Constant.STATE_PLAY;
                //timer.start();
                //nameInputDialog.hide()
            } else {
                boardGame.state = Constant.STATE_PAUSED
                //timer.stop()
                //nameInputDialog.show("PAUSE");
            }
            break;

        default:
            break;
        }
        controllerGame(newXOnKeyHandle, newYOnKeyHandle, typeBlock, newOrientOnKeyHandle);
        //Sound.apply(Constant.MOVING_SOUND);
        return true;
   }

}
/*************************************
          END   HANDLER
 ***********************************/

function controllerGame(column, row, type, orientation){

    if(canMoveTo(column, row, type, orientation)){
        Utils.deleteBlock(originX, originY, typeBlock, orientationBlock);
        Utils.createBlock(column, row, type, orientation);
    } else if(!canGoDown(originX, originY + 1)){
        Utils.changeStateOfCells(originX, originY, typeBlock, orientationBlock, color);
        if(isGameOver()){
            boardGame.state = Constant.STATE_GAMEOVER;
            Utils.saveHighScore(new Date().toLocaleString())
        } else {
            checkFullRow();
            var newType = Math.floor(Math.random()*Constant.MAX_FIGURE);
            color = nextColor;
            nextColor = Utils.getColorOfCell();
            if(canMoveTo(defaultOriginX, defaultOriginY, Tetris.nextTypeBlock, Constant.ORIENTATION_DEFAULT)){
                Utils.createBlock(defaultOriginX, defaultOriginY, Tetris.nextTypeBlock, Constant.ORIENTATION_DEFAULT);
                Tetris.nextTypeBlock = newType;
                clearMiniBoard();
                Utils.drawNextFigure(2,2,newType)
            } else { //create a new one
                Utils.createBlock(defaultOriginX, defaultOriginY,
                                  Constant.CELL_FIGURE, Constant.ORIENTATION_DEFAULT);
            }
        }

    }

}
