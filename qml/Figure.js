Qt.include("Figures.js")


function Figure( type, color, orientation){
    //console.log("new Figure:type, color, orientation:" + type, color, orientation)
    this.type = type
    this.color = color
    this.orientation = orientation
    this.points = Figures[type].points
    this.maxOrientation = Figures[type].maxOrientation
    this.particles = []


    for (var i=0; i < this.points.length; i++){

        var point = this.points[i];

        var particle = particleComponent.createObject();
        particle.refPoints =Qt.point(point.x, point.y)
        particle.cellColor = this.color;
        //particle.type = Constant.RUNNING_CELL;

        this.particles.push(particle);

    }

}

Figure.prototype.updatePoints = function(){

    for (var i=0; i < this.particles.length; i++){
        var point = currentFigure.points[i];
        var particle = currentFigure.particles[i];
        particle.refPoints = Qt.point(this.getX(i), this.getY(i))
        //particle.updatePosition(nextColumn, nextRow);

    }


}





Figure.prototype.rotate = function(){
    if(this.orientation + 1>= this.maxOrientation){
        this.orientation = 0;
    } else {
        this.orientation++;
    }
    this.updatePoints()
}

Figure.prototype.getX = function(point){
    switch(this.orientation){
    case 0:
        return this.points[point].x;
    case 1:
        return - this.points[point].y;
    case 2:
        return - this.points[point].x;
    case 3:
        return this.points[point].y;
    default:
        return this.points[point].x;
    }
}

Figure.prototype.getY = function(point){
    switch(this.orientation){
    case 0:
        return this.points[point].y;
    case 1:
        return this.points[point].x;
    case 2:
        return - this.points[point].y;
    case 3:
        return - this.points[point].x;
    default:
        return this.points[point].y;
    }
}




