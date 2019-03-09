function Figure(column, row, type, color, particleSize){
    this.column = column
    this.row = row
    this.type = type
    this.color = color
    this.particleSize = particleSize
    this.particles = []

    //create particles
        var maxCell = Utils.getMaxCellFromType(item.type);
        for (var point = 0; point < maxCell; point++) {

            var x = Utils.getX(point, item.type, item.orientation);
            var y = Utils.getY(point, item.type, item.orientation);

            var width =this.particleSize
            var height =this.particleSize
                dynamicObject.x = (item.column + x) * this.blockSize;
                dynamicObject.y = (item.row + y) * this.blockSize;
                dynamicObject.width = this.blockSize;
                dynamicObject.height = this.blockSize;
                dynamicObject.cellColor = item.color;
                dynamicObject.type = Constant.RUNNING_CELL;

            }

}





