import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Item {

    width: hitContent.implicitWidth
    height: hitContent.implicitHeight

    Rectangle{
        anchors.fill: parent
        anchors.margins: 8
        color: "white"
        opacity: 0.2
    }


    ColumnLayout {
        id:hitContent
        anchors.centerIn: parent


    Text{
        id: txt
        //anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        width: parent.width - parent.anchors.margins * 2
        wrapMode: Text.WordWrap
        color: "white"
        text: qsTr("Oh yes!, <br> you've reached <br><a href=\"qrc:/qml/ScorePage.qml\">online top scores</a>")
        font.pixelSize: Qt.application.font.pixelSize * 2
        onLinkActivated: {
            pageStack.push(link, {showOnline:true, currentName: nameText.text, currentScore: boardGame.score})
        }
    }


    Button{
        id: closeBtn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txt.bottom
        anchors.topMargin: 24
        text: qsTr("Close")
        onClicked: {
            container.state = ""
            //pageStack.pop()
        }
    }

    }




}
