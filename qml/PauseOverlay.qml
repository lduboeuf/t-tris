import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0



Item {
    id: container
    width: 200
    height: 100


    signal resumeClicked

    visible: false

    Rectangle{
        anchors.fill: parent
        color: "white"
        opacity: 0.2
    }


    Column{
        id: content
        //anchors.topMargin: 12        spacing: 12
        anchors.centerIn: parent


        Text {
            id: text
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("Pause")
        }

        ToolButton {
            id: resumeImg
            //anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            contentItem: Image {
                id:playPauseImg
                fillMode: Image.Pad
                sourceSize.width: text.height  * 2
                sourceSize.height: text.height  * 2
                anchors.horizontalCenter: parent.horizontalCenter

                source: "/assets/play.svg"
            }
            onClicked:  resumeClicked()


            ColorOverlay {
                anchors.fill: resumeImg
                source: resumeImg
                color: boardGame.textColor
            }
        }




    }





}
