import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Item{
    id: root
    width: parent.width
    height: childrenRect.height

    property bool selected: false

    signal highlighted

    Rectangle{
        id: rowRect
        anchors.fill: layout
        anchors.margins: 4
        color:root.selected ? "blue": "white"
        radius: 5
        border.color: "white"
        opacity: 0.2

    }

    RowLayout {
        id: layout
        width: parent.width
        height: scoreTxt.implicitHeight *3

        Text{
            id: scoreTxt
            Layout.leftMargin: 12
            color: scorePage.textColor
            text: " " +score
        }

        Text{
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            color: scorePage.textColor
            elide: Text.ElideRight
            text: name
        }
    }



}
