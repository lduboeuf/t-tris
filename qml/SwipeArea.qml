import QtQuick 2.0


MouseArea {
    property point origin
    property bool ready: false
    property bool toDo:true
    property int step: 2
    signal move(int x, int y)
    signal swipe(string direction)

    onPressed: {
        drag.axis = Drag.XAndYAxis
        origin = Qt.point(mouse.x, mouse.y)
    }

    onPositionChanged: {
        //we take only one of two event
        if (!toDo){
            toDo = true
            return
        }

        toDo = false


        switch (drag.axis) {
        case Drag.XAndYAxis:
            if (Math.abs(mouse.x - origin.x) > 16) {
                drag.axis = Drag.XAxis
                swipe(mouse.x - origin.x < 0 ? "left" : "right")
            }
            else if (Math.abs(mouse.y - origin.y) > 16) {
                drag.axis = Drag.YAxis
                swipe(mouse.y - origin.y < 0 ? "up" : "down")
            }
            break
        case Drag.XAxis:
            //move(mouse.x - origin.x, 0)

             swipe(mouse.x - origin.x < 0 ? "left" : "right")



            break
        case Drag.YAxis:
            //move(0, mouse.y - origin.y)
            swipe(mouse.y - origin.y < 0 ? "up" : "down")
            break
        }
    }

    onReleased: {
        switch (drag.axis) {
        case Drag.XAndYAxis: //a click
            //canceled(mouse)
            swipe("none")
            break
        case Drag.XAxis:

            swipe(mouse.x - origin.x < 0 ? "left" : "right")
            break
        case Drag.YAxis:
            swipe(mouse.y - origin.y < 0 ? "up" : "down")
            break
        }
    }
}
