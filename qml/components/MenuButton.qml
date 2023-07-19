import QtQuick 2.12
import QtQuick.Controls 2.12


Button {
    id: btnStart
    property alias name: btnText.text
    property bool selected: false

    height: btnText.implicitHeight * 2
    antialiasing: true
    highlighted: true

    Accessible.name: text
    Accessible.description: "This button does " + text
    Accessible.role: Accessible.Button
    Accessible.onPressAction: {
        btnStart.clicked()
    }

    contentItem: Text{
        id:btnText
        text: text
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        color: btnStart.selected || btnStart.pressed   ? "#214f4d": "transparent"
        opacity: 0.5
        border.width: 1
        border.color: "#087443"
        radius: 20
        smooth: true
    }

}
