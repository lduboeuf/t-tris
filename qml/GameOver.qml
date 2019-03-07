import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0




Item {
    id: container
    width: 200
    height: 100


    signal restartClicked

    function show() {
        container.visible = true;
    }

    visible: false

    Rectangle{
        anchors.fill: parent
        color: "white"
        opacity: 0.2
    }


    Column{
        id: content
        //anchors.topMargin: 12
        spacing: 12
        anchors.centerIn: parent
        //anchors.horizontalCenter: parent.horizontalCenter
        //anchors.fill: parent

        Text {
            id: dialogText
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            text: qsTr("GAME OVER")
        }

        Button{
            id: retryBtn
            text: qsTr("Retry")
            onClicked: {
                restartClicked()
                container.visible = false;
            }
        }

//        Item {
//            anchors.horizontalCenter: parent.horizontalCenter


//            Image {
//                id:imgReload
//                fillMode: Image.Pad
//                sourceSize.width: dialogText.height
//                sourceSize.height: dialogText.height
//                source: "/assets/rotate.svg"


//                MouseArea{
//                    anchors.fill: imgReload
//                    onClicked: {
//                        restart()
//                        container.visible = false;
//                    }
//                }

//            }

//            ColorOverlay {
//                id: overlay
//                anchors.fill: imgReload
//                source: imgReload
//                color: "white"
//            }
//        }

    }





}
