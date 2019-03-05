import QtQuick 2.0
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0


Dialog {
    id: confirmationDialog

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 200
    height: 100
    opacity: 0.6
    parent: ApplicationWindow.overlay

    modal: true
    title: qsTr("GAME OVER")
    standardButtons: Dialog.Abort | Dialog.Retry


    Column {
        //spacing: 20
        anchors.fill: parent
        Label {
            text: ""
        }

    }

}



//Item {
//    id: container
//    width: 200
//    height: 100

//    opacity: 0.2

//    signal restart

//    function show() {
//        container.visible = true;
//    }

//    visible: false



//    Column{
//        id: content
//        anchors.centerIn: parent
//        //anchors.fill: parent

//        Text {
//            id: dialogText
//            anchors.horizontalCenter: parent.horizontalCenter
//            color: "white"
//            text: qsTr("GAME OVER")
//        }

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

//    }





//}
