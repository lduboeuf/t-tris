//Qt.include("Utils.js")

Qt.include("board.js");
Qt.include("MiniBoard.js");


var currentItem, nextItem;
var lastScore;

var miniBoard;

function initGame() {

    boardGame.state = Constant.STATE_START
    //init board

    lastScore = 0

    var blockSize = gameCanvas.width < gameCanvas.height ? gameCanvas.width / Config.MAX_CELL : gameCanvas.height / Config.MAX_CELL;
    var maxRow = Math.floor(gameCanvas.height / blockSize);
    var maxColumn = Math.floor(gameCanvas.width / blockSize);

    board.init(blockSize, maxRow, maxColumn);

    miniBoard = new MiniBoard();

    //init default and next Figure

    currentItem = nextFigure();
    board.createObject(currentItem);

    nextItem = nextFigure();
    miniBoard.drawFigure(nextItem)



    boardGame.state = Constant.STATE_PLAY

}



function nextFigure(){
    var nextType= Math.floor(Math.random()*Constant.MAX_FIGURE);
    var nextColor = Constant.color[Math.floor(Math.random()*3)];
    var nextItem = {
        column :board.maxColumn / 2,
        row : 0,
        type : nextType,
        orientation: Constant.ORIENTATION_DEFAULT,
        color :nextColor
    }
    return nextItem
}



/*************************************
            HANDLER
 ***********************************/
function nextRound(){
    currentItem = deepCopy(nextItem);
    board.createObject(currentItem);

    nextItem = nextFigure();
    miniBoard.drawFigure(nextItem)
}


function nextStep()
{

    var nextItem = deepCopy(currentItem)
    nextItem.row = nextItem.row +1;

    controllerGame(nextItem);
}

function deepCopy(source, target) {
    target = target || {};
    for (var i in source) {
        if (typeof source[i] === 'object') {
            target[i] = (source[i].constructor === Array) ? [] : {};
            deepCopy(source[i], target[i]);
        } else {
            target[i] = source[i];
        }
    }
    return target;
}

function onKeyHandler(key){


    var target = deepCopy(currentItem)

        switch(key){
        case Constant.KEY_LEFT:
            target.column = target.column -1;
            break;
        case Constant.KEY_RIGHT:
            target.column = target.column +1;
            break;
        case Constant.KEY_UP:
            target.orientation = Utils.getClockwise(target.type, target.orientation)
            break;
        case Constant.KEY_DOWN:
            target.row = target.row +1
            while(boardGame.state === Constant.STATE_PLAY &&
                  board.canMoveTo(target)){
                target.row = target.row +1;
            }
            target.row = target.row -1;
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
        controllerGame(target);
        //Sound.apply(Constant.MOVING_SOUND);
        return true;
}
/*************************************
          END   HANDLER
 ***********************************/

function controllerGame(item){

    if(board.canMoveTo(item)){

        board.moveTo(currentItem, item)
        //Utils.deleteBlock(originX, originY, typeBlock, orientationBlock);
        //Utils.createBlock(column, row, type, orientation);
    } else if(!board.canGoDown(currentItem)){

        board.changeStateOfCells(currentItem); //mark particles as not RUNNING CELL
        if(board.isFull()){
            boardGame.state = Constant.STATE_GAMEOVER;
            Utils.saveHighScore(new Date().toLocaleString())
        } else {
            board.checkFullRow();

            nextRound();




//            currentItem = nextItem;

//            if(board.canMoveTo(currentItem)){
//                board.createObject(currentItem);

//                nextItem = nextFigure();
//                miniBoard.drawFigure(nextItem)
//            } else {
//                currentItem.type = Constant.CELL_FIGURE;
//                board.createObject(currentItem);

//            }
        }

    }

}
