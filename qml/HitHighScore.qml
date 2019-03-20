import QtQuick 2.0
import QtQuick.Controls 2.2

Page {

    id:container

    background: Image {
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle{
        anchors.fill: parent
        anchors.margins: 8
        color: "white"
        opacity: 0.2
    }



    Text{
        id: txt
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        width: parent.width - parent.anchors.margins * 2
        wrapMode: Text.WordWrap
        color: "white"
        text: qsTr("Congratulation! , <br> you hit online top scores")
        font.pixelSize: Qt.application.font.pixelSize * 2
    }

    Button{
        id: closeBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txt.bottom
        anchors.topMargin: 12
        text: qsTr("Close")
        onClicked: {
            pageStack.pop()
        }
    }





}
