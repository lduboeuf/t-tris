
function MiniBoard(){
    this.blockSize = 15;
    this.container = [];
    this.maxColumn = 5;
    this.posX = 2;
    this.posY = 2;
}

MiniBoard.prototype.clear = function(){
    for (var i = 0; i < this.container.length; i++) {
        if (this.container[i] !== null)
            this.container[i].destroy(); //destroy particle
            this.container[i] = null;
    }
}


MiniBoard.prototype.drawFigure = function(item){
    this.clear();
    var cell = Qt.createComponent("Cell.qml");

    if(cell.status ===Component.Ready){
        var maxCell = Utils.getMaxCellFromType(item.type);
        for (var point = 0; point < maxCell; point++) {
            var dynamicObject = cell.createObject(nextFigureBoard);
            if (dynamicObject === null) {
                console.log("error creating block");
                console.log(cell.errorString());
                return false;
            }
            var x = Utils.getX(point, item.type, 0);
            var y = Utils.getY(point, item.type, 0);

            dynamicObject.x = (this.posX + x) * this.blockSize;
            dynamicObject.y = (this.posY + y) * this.blockSize;
            dynamicObject.width = this.blockSize;
            dynamicObject.height = this.blockSize;
            dynamicObject.cellColor = item.color;
            dynamicObject.type = Constant.CLOCKING_CELL;
            this.container.push(dynamicObject);

        }
    } else {
        console.log("error loading block component");
        console.log(cell.errorString());
        return false;
    }
    console.log("visible ?:" + nextFigure.width, nextFigure.height)
    return true;
}


//var miniBoard = {

//    blockSize: 15,
//    container : null,
//    maxColumn:5,
//    posX:2,
//    posY:2,

//    init: function(){
//        if (this.container !== null){
//            this.clear();
//        }
//        this.container = new Array(25);
//    },

//    clear : function (){
//        for (var i = 0; i < this.container.length; i++) {
//            if (this.container[i] != null)
//                this.container[i].destroy(); //destroy particle
//                this.container[i] = null;
//        }
//    },

//    index: function (column, row) {
//        return column + (row * this.maxColumn);
//    },

//    drawFigure: function(item){
//        this.clear();
//        var cell = Qt.createComponent("Cell.qml");

//        if(cell.status ===Component.Ready){
//            var maxCell = Utils.getMaxCellFromType(item.type);
//            for (var point = 0; point < maxCell; point++) {
//                var dynamicObject = cell.createObject(nextFigure);
//                if (dynamicObject === null) {
//                    console.log("error creating block");
//                    console.log(cell.errorString());
//                    return false;
//                }
//                var x = Utils.getX(point, item.type, 0);
//                var y = Utils.getY(point, item.type, 0);

//                dynamicObject.x = (this.posX + x) * this.blockSize;
//                dynamicObject.y = (this.posY + y) * this.blockSize;
//                dynamicObject.width = this.blockSize;
//                dynamicObject.height = this.blockSize;
//                dynamicObject.cellColor = item.color;
//                dynamicObject.type = Constant.CLOCKING_CELL;
//                this.container[this.index(this.posX + x, this.posY + y)] = dynamicObject;
//            //    console.debug("point: "+ point + " -- (x,y) = ("+ x + " , " + y +
//            //                  " ) -- col = "+column + " -- row = "+row );
//            }
//        } else {
//            console.log("error loading block component");
//            console.log(cell.errorString());
//            return false;
//        }
//        console.log("visible ?:" + nextFigure.width, nextFigure.height)
//        return true;
//    }




//}
