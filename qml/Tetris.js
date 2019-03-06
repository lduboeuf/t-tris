Qt.include("Utils.js");

var blockSize;
var maxColumn = Config.MAX_CELL;
var maxRow = Constant.MAX_ROW_DEFAULT;
var maxIndex = maxColumn * maxRow;
var board = new Array(maxIndex);
var originX = defaultOriginX;
var originY = defaultOriginY;
var defaultOriginX;
var defaultOriginY;
var typeBlock = Constant.TYPE_FIGURE_DEFAULT;
var orientationBlock = Constant.ORIENTATION_DEFAULT;
var gameState = Constant.GAMEOVER_STATE;
var color = "red"
var miniBoard = new Array(25);
var nextTypeBlock = Constant.TYPE_FIGURE_DEFAULT;
var nextColor = "red"
var lastScore = 0


function startNewGame() {
    if(miniBoard !== null){
        for (var i = 0; i < 25; i++) {
            if (miniBoard[i] !== undefined && miniBoard[i] !==null)
                miniBoard[i].destroy();
        }
    }

    blockSize = gameCanvas.width < gameCanvas.height ? gameCanvas.width / Config.MAX_CELL : gameCanvas.height / Config.MAX_CELL;
    maxRow = Math.floor(gameCanvas.height / blockSize);
    maxColumn = Math.floor(gameCanvas.width / blockSize);

    defaultOriginX = maxColumn / 2;
    defaultOriginY = 0;

    //Delete blocks from previous game    
    for (var i = 0; i < maxIndex; i++) {
        if (board[i] !== undefined && board[i] !==null)
            board[i].destroy();
    }
    gameState = Constant.PLAYING_STATE;

    maxIndex = maxRow * maxColumn;
    gameCanvas.score = 0;
    //nameInputDialog.hide();

    //Initialize Board
    board = new Array(maxIndex);
    var newType = Math.floor(Math.random()*Constant.MAX_FIGURE);

    nextTypeBlock = Math.floor(Math.random()*Constant.MAX_FIGURE);
    nextColor =  Utils.getColorOfCell();
    Utils.drawNextFigure(2,2,nextTypeBlock)

    Utils.createBlock( defaultOriginX, defaultOriginY,
                      newType, Constant.ORIENTATION_DEFAULT);
    //Sound.apply(Constant.NEW_LEVEL_SOUND);
    timer.start();
}


/*************************************
            HANDLER
 ***********************************/
function timerHandler()
{
    if(gameState !== Constant.GAMEOVER_STATE){
        controllerGame(originX, originY + 1, typeBlock, orientationBlock);
    }
}

function onKeyHandler(key){
    if(gameState !== Constant.GAMEOVER_STATE){
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
            while(gameState == Constant.PLAYING_STATE &&
                  canMoveTo(newXOnKeyHandle, newYOnKeyHandle, typeBlock, newOrientOnKeyHandle)){
                newYOnKeyHandle += 1;
            }
            newYOnKeyHandle -=1;
            break;
        case Constant.KEY_PAUSE:
            if(gameState === Constant.PAUSING_STATE){
                gameState = Constant.PLAYING_STATE;
                timer.start();
                nameInputDialog.hide()
            } else {
                gameState = Constant.PAUSING_STATE
                timer.stop()
                nameInputDialog.show("PAUSE");
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
    if(gameState === Constant.PLAYING_STATE){
        if(canMoveTo(column, row, type, orientation)){
            Utils.deleteBlock(originX, originY, typeBlock, orientationBlock);
            Utils.createBlock(column, row, type, orientation);
        } else if(!canGoDown(originX, originY + 1)){
            Utils.changeStateOfCells(originX, originY, typeBlock, orientationBlock);
            if(isGameOver()){
                gameState = Constant.GAMEOVER_STATE;
                //Sound.apply(Constant.GAME_OVER_SOUND);
                gameOverOverlay.show()
                //nameInputDialog.show(qsTr("GAME OVER"));
                Utils.saveHighScore("ABC")
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
                } else {
                    Utils.createBlock(defaultOriginX, defaultOriginY,
                                      Constant.CELL_FIGURE, Constant.ORIENTATION_DEFAULT);
                }
            }

        }
    }
}
