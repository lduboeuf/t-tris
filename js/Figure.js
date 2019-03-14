Qt.include("./Figures.js")


function Figure( type, color, orientation){
    //console.log("new Figure:type, color, orientation:" + type, color, orientation)
    this.type = type
    this.color = color
    this.orientation = orientation
    this.points = Figures[type].points
    this.maxOrientation = Figures[type].maxOrientation
    this.particles = []


//    for (var i=0; i < this.points.length; i++){

//        var point = this.points[i];

//        var particle = particleComponent.createObject();
//        //particle.refPoints =Qt.point(point.x, point.y)
//        particle.cellColor = this.color;
////        if (this.type === "BOMB"){
////            particle.imgSource = "/assets/bomb.png"
////            particle.animate = true
////        }

//        //particle.type = Constant.RUNNING_CELL;

//        this.particles.push(particle);

//    }

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
        //particle.updatePosition(nextColumn, nextRow);

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



//Figure.prototype.rotate = function(){
//    if(this.orientation + 1>= this.maxOrientation){
//        this.orientation = 0;
//    } else {
//        this.orientation++;
//    }
//    this.updatePoints()
//}

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

//Figure.prototype.getX = function(point, orientation){
//    switch(orientation){
//    case 0:
//        return this.points[point].x;
//    case 1:
//        return - this.points[point].y;
//    case 2:
//        return - this.points[point].x;
//    case 3:
//        return this.points[point].y;
//    default:
//        return this.points[point].x;
//    }
//}

//Figure.prototype.getY = function(point, orientation){
//    switch(orientation){
//    case 0:
//        return this.points[point].y;
//    case 1:
//        return this.points[point].x;
//    case 2:
//        return - this.points[point].y;
//    case 3:
//        return - this.points[point].x;
//    default:
//        return this.points[point].y;
//    }
//}




