Qt.include("./Figures.js")


function Figure( type, color, orientation){
    this.type = type
    this.color = color
    this.orientation = orientation
    this.points = Figures[type].points
    this.maxOrientation = Figures[type].maxOrientation
    this.particles = []


}

Figure.prototype.getPoints = function(orientation){
    var points = []
    if (orientation===0) return this.points
    for (var i=0; i < this.points.length; i++){
        var point = this.getPoint(i, orientation);
        points.push(point)
        //particle.updatePosition(nextColumn, nextRow);

    }
    return points
}

Figure.prototype.clear = function(){
    for (var i = 0; i < this.particles.length; i++) {
        if (this.particles[i] != null)
            this.particles[i].destroy();
    }
    this.particles = []
}

Figure.prototype.updatePoints = function(){

    for (var i=0; i < this.particles.length; i++){
        var point = this.points[i];
        var particle = this.particles[i];
        particle.refPoints = Qt.point(this.getX(i), this.getY(i))

    }


}

Figure.prototype.changeState = function(state){
    for (var i = 0; i < this.particles.length; i++) {
        var particle = this.particles[i]
        if(particle != null){
            particle.type = state;
        }
    }
}



Figure.prototype.getPoint = function(point, orientation){
    var x,y
    switch(orientation){
        case 0:
            x = this.points[point].x;
            y = this.points[point].y;
            break
        case 1:
            x = - this.points[point].y;
            y = this.points[point].x;
            break
        case 2:
            x = - this.points[point].x;
            y = - this.points[point].y;
            break
        case 3:
            x = this.points[point].y;
            y = - this.points[point].x;
            break
        default:
            x = this.points[point].x;
            y = this.points[point].y;

    }

    return {x: x, y: y}



}






