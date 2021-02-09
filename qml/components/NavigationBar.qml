import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

ToolBar {
    id:toolBar

    property color txtColor: "white"

    signal backPressed

    background: Rectangle{
        anchors.fill: toolBar
        color:toolBar.txtColor
        opacity: 0.2
    }

    height: contentHeight * 1.4

    RowLayout {

        anchors.fill: parent

        MToolButton {
            imageSrc: "/assets/back.svg"
            onClicked: {
                toolBar.backPressed()
                pageStack.pop(null)
            }
        }

        Label {
            text: title
            elide: Label.ElideRight
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
            Layout.fillWidth: true
            color: toolBar.txtColor
        }


    }
}
