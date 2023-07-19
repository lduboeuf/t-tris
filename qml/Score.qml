import QtQuick 2.0

Item {
    id: scoreItem

    property int lastScore: 0
    property int score: boardGame.score

    onScoreChanged: {
        console.log("score:" + score)
        scoreAdded.text = "+" + (score - lastScore)
        if (score>0)
            scoreChangedAnimation.start()
        else
            txtScore.text = "0"

        lastScore = score
    }

    Text {
        id:txtScore
        //property int score:0
        color: boardGame.textColor
        text: "0"

    }

    Text {
        id: scoreAdded
        y: -100
        anchors.left: txtScore.left
        color: boardGame.textColor
        font.bold: true
        //text : "+" + (scoreItem.score - scoreItem.lastScore)



    }

    SequentialAnimation{
        id: scoreChangedAnimation
        ParallelAnimation{

            NumberAnimation {
                        target: scoreAdded
                        properties: "opacity"
                        easing.type: Easing.InExpo
                        //easing: Easing.Linear
                        from: 1
                        to:0
                        duration: 1200
                    }
            NumberAnimation {
                        target: scoreAdded
                        properties: "y"
                        from: gameCanvas.height / 2
                        //to:boardGame.y - header.height
                        to: txtScore.y
                        duration: 1200
                    }

        }

        PropertyAction { target: txtScore; property: "text"; value: boardGame.score }
        NumberAnimation {
            property: "scale"
            target: txtScore
            to:txtScore.scale*1.4
            duration: 200
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            property: "scale"
            target: txtScore
            //from:stats.font.pixelSize
            to:txtScore.scale
            duration: 200
            easing.type: Easing.InOutQuad
        }
      }
}
