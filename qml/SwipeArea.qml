import QtQuick 2.0
import Qt.labs.settings 1.0

import "../js/Configuration.js" as Config

MouseArea {
    property point origin
    property real xStep: parent.width / settings.swipeRatio
    property int currentPos: 0
    property var lastSwipeDownActionDate: Date.now()
    property var lastSwipeHorizontalActionDate: Date.now()

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
                lastSwipeHorizontalActionDate = Date.now()
            }
            else if (Math.abs(mouse.y - origin.y) > 16) {
                drag.axis = Drag.YAxis
            }
            break

        case Drag.XAxis:

            var nbSteps = Math.round(mouse.x / xStep)
            if (nbSteps > currentPos)
                swipe(Config.KEY_RIGHT)
            else if (nbSteps < currentPos)
                swipe(Config.KEY_LEFT)
            currentPos = nbSteps


            break
        case Drag.YAxis:



            if (mouse.y - origin.y < 0){
                //disable key up
//                if (lastSwipeUpActionDate + minActionInterval < Date.now() ) {
//                    swipe(Config.KEY_UP)
//                    lastSwipeUpActionDate = Date.now()
//                }
            }else{
                //protect from unintended down actions
                if (lastSwipeDownActionDate + minActionInterval < Date.now() ){
                    swipe(Config.KEY_STEP_DOWN)
                    lastSwipeDownActionDate = Date.now()
                }
            }


            break
        }
    }

    onClicked: {



        if (drag.axis===Drag.XAndYAxis){
            swipe(Config.KEY_UP)
        }
    }

    onReleased: {

//        if (lastSwipeUpActionDate + minActionInterval >= Date.now() ) return
        var velocity

        if (drag.axis===Drag.YAxis){

             velocity = (mouse.y - origin.y) / (Date.now() - lastSwipeDownActionDate)
            //console.log("velocity:" + velocity)
            if (velocity > 1){
                swipe(Config.KEY_DOWN)
                lastSwipeDownActionDate = Date.now()
            }


        }else if (drag.axis===Drag.XAxis){

//            var delta = mouse.x - origin.x
//            //var delta = Math.abs(mouse.x - origin.x)
//            velocity = Math.abs(delta) / (Date.now() - lastSwipeHorizontalActionDate)
//            //onsole.log("velocityX:" + velocity + " delta:" + delta + " time:" + (Date.now() - lastSwipeHorizontalActionDate))
//            if (velocity > 1){

//                if (delta>0){
//                    swipe(Config.KEY_FARRIGHT)
//                }else{
//                    swipe(Config.KEY_FARLEFT)
//                }


//                //lastSwipeHorizontalActionDate = Date.now()
//            }


        }

    }


}
