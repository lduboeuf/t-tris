import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "components"

Page {

    property color textColor: "white"

    title: qsTr("Options")


    background: Image {
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }


    header:NavigationBar{}

    Label{
        text: qsTr("not implemented yet")
        color:textColor
    }
}
