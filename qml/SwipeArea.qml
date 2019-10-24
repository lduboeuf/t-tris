import QtQuick 2.0
import Qt.labs.settings 1.0

import "../js/Configuration.js" as Config

MouseArea {
    property point origin
    property real xStep: parent.width / settings.swipeRatio
    property real yStep: parent.height / settings.swipeRatio
    property int currentPos: 0
    property int currentYPos: 0
    property bool onAir: false
    property var lastSwipeDownActionDate: Date.now()
    property var lastSwipeHorizontalActionDate: Date.now()

    readonly property  int  minActionInterval: 300 //minimum time in ms between 2 actions
    signal move(int x, int y)
    signal swipe(int action)


    onPressed: {
        drag.axis = Drag.XAndYAxis
        origin = Qt.point(mouse.x, mouse.y)
        currentPos = Math.round(mouse.x / xStep)
        currentYPos = Math.round(mouse.y / yStep)
        onAir = true
        console.log("ok pressed:" + currentYPos)
    }

    onPositionChanged: {
        if (!onAir) return

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
                var nbStepsY = Math.round(mouse.y / yStep)
                if (nbStepsY > currentYPos) {
                //protect from unintended down actions
                //if (lastSwipeDownActionDate + minActionInterval < Date.now() ){
                    console.log("kikou STEP DOWN")
                    swipe(Config.KEY_STEP_DOWN)
                    lastSwipeDownActionDate = Date.now()
                    origin = Qt.point(mouse.x, mouse.y)

                //}
                }
                currentYPos = nbStepsY
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
            if (velocity > 1.5){
                swipe(Config.KEY_DOWN)
                onAir = false
                console.log("kikou bump")
                lastSwipeDownActionDate = Date.now()
                drag.axis = Drag.None
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
