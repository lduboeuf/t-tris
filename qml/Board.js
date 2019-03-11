
function Board(blockSize, maxRow, maxColumn){
    this.blockSize = blockSize
    this.maxRow = maxRow
    this.maxColumn = maxColumn

    this.container = new Array(maxColumn * maxRow);


}

Board.prototype.clear = function(){
    for (var i = 0; i < this.container.length; i++) {
        if (this.container[i] != null)
            this.container[i].destroy(); //destroy particle
            this.container[i] = null;
    }
}

Board.prototype.index = function(column, row){
    return column + (row * this.maxColumn);
}

Board.prototype.availablePosition = function(column, row){

    if(column < 0 || column >= this.maxColumn || row < 0 || row >= this.maxRow){
        return false;
    }
    var idx = this.index(column, row );
    if (this.container[idx] != null && this.container[idx].type!== Constant.RUNNING_CELL){
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
    var str = "";
    for (var i=0; i < this.container.length; i++){
        if (this.container[i]!= null )
            str += i + ":" //+ this.container[i] + ";";

    }
    console.log(str);
}



Board.prototype.containsParticle = function(lineNumber){
    for(var i=0; i< this.maxColumn; i++){
        var idx = this.index(i,lineNumber)
        if(this.container[idx] != null && this.container[idx].type!== Constant.RUNNING_CELL){
            return true;
        }
    }
    return false;
}

