var board = {

    container : null,
    blockSize: null,
    maxRow: null,
    maxColumn: null,

    init: function(blockSize, maxRow, maxColumn){
        if (this.container !== null){
            clear();
        }
        this.container = new Array(maxColumn * maxRow);
        this.blockSize = blockSize;
        this.maxRow = maxRow;
        this.maxColumn = maxColumn;
    },

    clear : function (){
        for (var i = 0; i < container.length; i++) {
            if (container[i] != null)
                container[i].destroy(); //destroy particle
                 container[i] = null;
        }
    },

    index: function (column, row) {
        return column + (row * this.maxColumn);
    },

    availablePosition: function(column, row){
        if(column < 0 || column >= this.maxColumn || row < 0 || row >= this.maxRow){
            return false;
        }
        var idx = this.index(column, row );
        if (this.container[idx] != null && this.container[idx].type!== Constant.RUNNING_CELL){
            console.log("occuped by:" + this.container[idx].type + " at x,y:" + column, row)
            return false;
        }

        return true;

    },

    createObject: function (item)
    {

        var cell = Qt.createComponent("Cell.qml");
        if(cell.status === Component.Ready){
            var maxCell = Utils.getMaxCellFromType(item.type);
            for (var point = 0; point < maxCell; point++) {
                var dynamicObject = cell.createObject(gameCanvas);
                if (dynamicObject === null) {
                    console.log("error creating item");
                    console.log(cell.errorString());
                    return false;
                }
                var x = Utils.getX(point, item.type, item.orientation);
                var y = Utils.getY(point, item.type, item.orientation);
                if(this.availablePosition(item.column + x, item.row + y)){
                    dynamicObject.x = (item.column + x) * this.blockSize;
                    dynamicObject.y = (item.row + y) * this.blockSize;
                    dynamicObject.spawned = true; //for object animation, see Cell.qml
                    dynamicObject.width = this.blockSize;
                    dynamicObject.height = this.blockSize;
                    dynamicObject.cellColor = item.color;
                    dynamicObject.type = Constant.RUNNING_CELL;
                    this.container[this.index(item.column + x, item.row + y)] = dynamicObject;
                    //console.debug("(x,y) = ("+ item.column+ " , "+ item.row+" )  -- type,orient:  " + item.type + " -- "+ item.orientation);

                }

            //    console.debug("point: "+ point + " -- (x,y) = ("+ x + " , " + y +
            //                  " ) -- col = "+column + " -- row = "+row );
            }
        } else {
            console.log("error loading item component");
            console.log(cell.errorString());
            return false;
        }
        //console.log("after create:");
        //this.debugContainer();
        return true;
    },

    canMoveTo: function(item){

        var maxCell = Utils.getMaxCellFromType(item.type);
        for (var point = 0; point < maxCell; point++) {
         //console.debug("(x,y) = ("+ item.column+ " , "+ item.row+" )  -- type,orient:  " + item.type + " -- "+ item.orientation);
            var x = Utils.getX(point, item.type, item.orientation);
            var y = Utils.getY(point, item.type, item.orientation);
            if(!this.availablePosition(item.column + x, item.row + y)){
                return false;
            }
        }
        return true;
    },

    moveTo: function (source, target){
        var maxCell = Utils.getMaxCellFromType(source.type);

        var toMove = [];
        for (var point = 0; point < maxCell; point++) {
            //console.debug("(x,y) = ("+ source.column+ " , "+ source.row+" )  -- type,orient:  " + source.type + " -- "+ source.orientation);
            var x = Utils.getX(point, source.type, source.orientation);
            var y = Utils.getY(point, source.type, source.orientation);

            var idx = this.index(source.column + x, source.row + y)
            var particle = this.container[idx];
            if(particle != null){

                x = Utils.getX(point, target.type, target.orientation);
                y = Utils.getY(point, target.type, target.orientation);


                particle.x = (target.column + x) * this.blockSize;
                particle.y = (target.row + y) * this.blockSize;
                //particle.type = Constant.RUNNING_CELL;
                var newIdx = this.index(target.column + x, target.row + y)

                toMove.push({from: idx, to: newIdx, particle: particle });
                this.container[idx] = null;
            }
        }

        for (var i=0; i < toMove.length; i++){
            var move = toMove[i]
            this.container[move.to] = move.particle;
        }



        source.column = target.column;
        source.row = target.row;
        source.orientation = target.orientation;

        //this.debugContainer();

        return true;
    },

    debugContainer: function(){
        var str = "";
        for (var i=0; i < this.container.length; i++){
            if (this.container[i]!= null)
                str += i + ":" + this.container[i] + ";";

        }
        console.log(str);
    },

    canGoDown: function(item){
        var maxCell = Utils.getMaxCellFromType(item.type);
        for (var point = 0; point < maxCell; point++) {
            var x = Utils.getX(point, item.type, item.orientation);
            var y = Utils.getY(point, item.type, item.orientation) +1;
            if ((item.row + y) >= this.maxRow){
                return false;
            }

            if(!this.availablePosition(item.column + x, item.row + y)){
                return false;
            }
        }
        return true;
    },

    changeStateOfCells: function (item){
        var maxCell = Utils.getMaxCellFromType(item.type);
        for (var point = 0; point < maxCell; point++) {
        //    console.debug("(x,y) = ("+ column+ " , "+ row+" )  -- type,orient:  " + type + " -- "+ orientation);
            var x = Utils.getX(point, item.type, item.orientation);
            var y = Utils.getY(point, item.type, item.orientation);

            var particle = this.container[this.index(item.column + x, item.row + y)]
            if(particle != null){
                particle.type = Constant.CLOCKING_CELL;
                //particle.cellColor = color;
            }
        }
        return true;
    },

    isFull: function(){
        for(var i=0; i< this.maxColumn; i++){
            if(this.container[this.index(i,0)] != null){
                return true;
            }
        }
        return false;
    },

    checkFullRow: function(){
        var hasRowFull = true;
        var delta = 0;
        for (var i=this.maxRow -1; i > 0; i--){
            for(var j=0; j<this.maxColumn; j++){
                hasRowFull = true
          //      console.debug("(col, row) = ("+ j + " , "+ i + " )" + " -- hasfullrow= "+ hasRowFull);
                if(this.container[this.index(j,i)] == null){
                    hasRowFull = false;
                    break;
                }
            }
            if(hasRowFull){
                console.debug("row full = " +i)
                this.removeFullRow(i);
                delta++;
            } else if(delta > 0){
                console.debug("row not full = " +i)
                this.moveDownAllRow(i, delta);
            }
        }
        boardGame.score += (delta*10);
        //check for new Level ?
        if(boardGame.score - lastScore > Config.SCORE){
            lastScore = boardGame.score;
            boardGame.level++;

        }

    },

    removeFullRow:function(rowNum){
        console.debug("call remove full row")
        Sound.apply(Constant.REMOVE_ROW_SOUND); //TODO-> states in boardGame
        for( var i=0; i< this.maxColumn; i++){
            var idx = this.index(i, rowNum);
            this.container[idx].dying = true;
            this.container[idx] = null;
        }
    },

    moveDownAllRow: function(rowNum, delta){
        for(var i=0; i<this.maxColumn; i++){

            var particle = this.container[this.index(i, rowNum)]
            if(particle != null){
                var target = {column:i, row:rowNum + delta, type: Constant.CELL_FIGURE, orientation:0};

                this.moveTo({column:i, row:rowNum, type: Constant.CELL_FIGURE, orientation:0},target  )
//                this.createBlock(i, rowNum + delta, Constant.CELL_FIGURE, 0)
                this.changeStateOfCells(target)
//                Tetris.board[Utils.index(i, rowNum)].destroy();
//                Tetris.board[Utils.index(i, rowNum)] = null;
            }
        }
    }




}
