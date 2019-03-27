import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

import "components"

Page {

    property color textColor: "white"

    title: qsTr("Options")


    background: Image {
        source: "/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop
    }


    header:NavigationBar{}

    //    Label{
    //        text: qsTr("not implemented yet")
    //        color:textColor
    //    }

    Column{
        anchors.fill: parent
        anchors.margins: 12
        spacing:12


//        RowLayout{
//            width: parent.width
//            Label{

//                anchors.left: parent.left
//                text: qsTr("Initial level")
//                color:textColor
//            }

//            ComboBox{
//                anchors.right:  parent.right
//                currentIndex: settings.initialLevel
//                model: 9
//                onCurrentIndexChanged:{
//                    settings.initialLevel = currentIndex
//                }

//            }

//            //        Switch {
//            //            id: initialLevelSwitch
//            //            anchors.right:  parent.right
//            //            checked: settings.initialLevel
//            //        }

//        }

//        RowLayout{
//            width: parent.width
//            Label{
//                anchors.left: parent.left
//                text: qsTr("Max number of columns")
//                color:textColor
//            }


//            ComboBox{
//                anchors.right:  parent.right
//                currentIndex: settings.maxColumns
//                model: [12,14,16,18,20,22,24,26,28,30]
//                onCurrentIndexChanged:{
//                    settings.maxColumns = currentIndex
//                }

//            }
//        }

//        RowLayout{
//            width: parent.width
//            Label{
//                anchors.left: parent.left
//                text: qsTr("Enable random bombs")
//                color:textColor
//            }


//            Switch {
//                anchors.right:  parent.right
//                checked: settings.useBomb
//                onCheckedChanged: {
//                    settings.useBomb = checked
//                }
//            }

//        }

        RowLayout{
            width: parent.width
            Label{
                anchors.left: parent.left
                Layout.fillWidth: true
                wrapMode: Label.WordWrap
                text: qsTr("Allow saving highscores online")
                color:textColor
            }


            Switch {
                id:control
                anchors.right:  parent.right
                indicator: Rectangle {
                        implicitWidth: 48
                        implicitHeight: 26
                        x: control.width - width - control.rightPadding
                        y: parent.height / 2 - height / 2
                        radius: 13
                        color: control.checked ? "#17a81a" : "transparent"
                        border.color: control.checked ? "#17a81a" : "#cccccc"

                        Rectangle {
                            x: control.checked ? parent.width - width : 0
                            width: 26
                            height: 26
                            radius: 13
                            color: control.down ? "#cccccc" : "#ffffff"
                            border.color: control.checked ? (control.down ? "#17a81a" : "#21be2b") : "#999999"
                        }
                    }


                checked: settings.allowNetwork
                onCheckedChanged: {
                    settings.allowNetwork = checked
                }

            }

        }

    }


}
