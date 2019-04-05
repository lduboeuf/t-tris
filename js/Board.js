
function Board(blockSize, maxRow, maxColumn){
    this.blockSize = blockSize
    this.maxRow = maxRow
    this.maxColumn = maxColumn

    this.container = new Array(maxColumn * maxRow);


}

Board.prototype.clear = function(destroyParticle){
    for (var i = 0; i < this.container.length; i++) {
        if (this.container[i] != null && destroyParticle){
            this.container[i].destroy(); //destroy particle
        }
        this.container[i] = null;
    }
}

Board.prototype.getFirstOccupiedRow = function(column){
    for (var i = 0; i < this.maxRow; i++) {
        var idx = this.index(column, i );
        if (this.container[idx]!=null && this.container[idx].type!== Config.RUNNING_CELL){
            return i
        }

    }

    return this.maxRow-1

}

Board.prototype.index = function(column, row){
    return column + (row * this.maxColumn);
}

Board.prototype.availablePosition = function(column, row){

    //out of bounds?
    if(column < 0 || column >= this.maxColumn  || row >= this.maxRow){
        return false;
    }
    var idx = this.index(column, row );
    if (this.container[idx] != null && this.container[idx].type!== Config.RUNNING_CELL){
        return false;
    }

    return true;

}

Board.prototype.insert = function(particle){
    //console.log("insert particle at(column,row):" + particle.column, particle.row)
    this.container[this.index(particle.column, particle.row)] = particle;
    //this.debugContainer()

}

Board.prototype.getAt = function(column, row){
    return this.container[this.index(column, row)];

}

Board.prototype.delete = function(particle){
    this.container[this.index(particle.column, particle.row)] = null;
}

Board.prototype.debugContainer = function(){

    for(var i=0; i< this.maxRow; i++){
        var row = ""
        for(var j=0; j< this.maxColumn; j++){
            var idx = this.index(j,i)
            if (this.container[idx]!= null ){
                row += j + ","
            }

        }
        console.log("row " + i + ":" +row)
    }

//    for (var i=0; i < this.container.length; i++){
//        if (this.container[i]!= null )
//            str += i + ":" //+ this.container[i] + ";";

//    }
//    console.log(str);
}


Board.prototype.countParticles = function(rowNum){
    var nb = 0
    for(var i=0; i< this.maxColumn; i++){
        var idx = this.index(i,rowNum)
        if(this.container[idx] != null && this.container[idx].type!== Config.RUNNING_CELL){
           nb++;
        }
    }
    return nb;
}

Board.prototype.isFull = function(rowNum){

    for(var i=0; i< this.maxColumn; i++){
        var idx = this.index(i,rowNum)
        if(this.container[idx] == null){
           return false
        }
    }
    return true;
}


Board.prototype.containsParticles = function(lineNumber){
    for(var i=0; i< this.maxColumn; i++){
        var idx = this.index(i,lineNumber)
        if(this.container[idx] != null && this.container[idx].type!== Config.RUNNING_CELL){
            return true;
        }
    }
    return false;
}

