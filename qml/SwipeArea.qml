import QtQuick 2.0
import "Constant.js" as Constant

MouseArea {
    property point origin
    property real xStep: parent.width / Constant.MAX_COLUMN_DEFAULT
    property int currentPos: 0
    property var lastSwipeDownActionDate: Date.now()
    property var lastSwipeUpActionDate: Date.now()

    readonly property  int  minActionInterval: 300 //minimum time in ms between 2 actions
    signal move(int x, int y)
    signal swipe(int action)


    onPressed: {
        drag.axis = Drag.XAndYAxis
        origin = Qt.point(mouse.x, mouse.y)
        currentPos = Math.round(mouse.x / xStep)
    }

    onPositionChanged: {
        switch (drag.axis) {
        case Drag.XAndYAxis:

            if (Math.abs(mouse.x - origin.x) > 16) {
                drag.axis = Drag.XAxis
            }
            else if (Math.abs(mouse.y - origin.y) > 16) {
                drag.axis = Drag.YAxis
            }
            break

        case Drag.XAxis:

            var nbSteps = Math.round(mouse.x / xStep)
            if (nbSteps > currentPos)
                swipe(Constant.KEY_RIGHT)
            else if (nbSteps < currentPos)
                swipe(Constant.KEY_LEFT)
            currentPos = nbSteps

            break
        case Drag.YAxis:



            if (mouse.y - origin.y < 0){
                if (lastSwipeUpActionDate + minActionInterval < Date.now() ) {
                    swipe(Constant.KEY_UP)
                    lastSwipeUpActionDate = Date.now()
                }
            }else{
                //protect from unintended down actions
                if (lastSwipeDownActionDate + minActionInterval < Date.now() ){
                    swipe(Constant.KEY_DOWN)
                    lastSwipeDownActionDate = Date.now()
                }
            }


            break
        }
    }

    onReleased: {

        if (lastSwipeUpActionDate + minActionInterval >= Date.now() ) return

        if (drag.axis===Drag.XAndYAxis){
            swipe(Constant.KEY_UP) //like a click
            lastSwipeUpActionDate = Date.now()
        }

    }


}
