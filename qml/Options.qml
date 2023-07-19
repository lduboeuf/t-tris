import QtQuick 2.7
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import QtGraphicalEffects 1.0


import "components"
import "../js/Configuration.js" as Config;


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
        spacing:16

        RowLayout{
            width: parent.width
            Label{
                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true
                wrapMode: Label.WordWrap
                text: qsTr("Allow saving highscores online")
                color:textColor
            }


            CustomSwitch {
                Layout.alignment: Qt.AlignRight
                checked: settings.allowNetwork
                onCheckedChanged: {
                    settings.allowNetwork = checked
                }

            }

        }

        RowLayout{
            width: parent.width
            Label{
                Layout.alignment: Qt.AlignLeft
                text: qsTr("Swipe sensibility")
                color:textColor
            }
        }

        RowLayout{
            width: parent.width
            Slider{
                //width: parent.width
                from:6
                to:60
                stepSize:6
                value: settings.swipeRatio
                onValueChanged: {
                    settings.swipeRatio = value
                }
            }
        }


        RowLayout{
            width: parent.width
            Label{
                Layout.alignment: Qt.AlignLeft
                text: qsTr("Shapes style:")
                color:textColor
            }
        }

        ButtonGroup {
            buttons: styleContainer.children
        }

        RowLayout{
            id: styleContainer
            width: parent.width
            //anchors.horizontalCenter: parent


            Button {
                id:ballBtn
                padding:0
                Layout.preferredWidth: parent.width / 2
                Layout.fillWidth: true

                checkable: true
                checked: settings.figureStyle === Config.CELL_STYLE_CIRCLE

                background: Rectangle{
                    anchors.fill: parent
                    opacity: 0.2
                    border.color: "white"
                    color:ballBtn.checked ? "blue": "transparent"
                }
                onCheckedChanged: {
                    if (checked) {
                        settings.figureStyle = Config.CELL_STYLE_CIRCLE
                    }

                }



                contentItem:Row{
                    spacing: 8
                    padding: 8


                    Image {
                        id: icon

                        sourceSize.width: 25
                        sourceSize.height: 25
                        source: "/assets/yellowStone.png"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Label{
                        id: label
                        text: qsTr("Ball")
                        color:textColor
                        anchors.verticalCenter: parent.verticalCenter


                    }
                }
            }
            Button {
                id:squareBtn
                padding:0
                Layout.preferredWidth: parent.width / 2
                Layout.fillWidth: true
                checkable: true

                checked: settings.figureStyle === Config.CELL_STYLE_SQUARE
                background: Rectangle{
                    anchors.fill: parent
                    opacity: 0.2
                    border.color: "white"
                    color:squareBtn.checked ? "blue": "transparent"

                }

                onCheckedChanged: {
                    if (checked){
                        settings.figureStyle = Config.CELL_STYLE_SQUARE
                    }
                }

                contentItem: Row{
                    spacing: 8
                    padding: 8

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter

                        width: 25
                        height: 25
                        color:"yellow"
                        anchors.margins: 2

                        LinearGradient {
                            anchors.fill: parent
                            start: Qt.point(0, 0)
                            end: Qt.point(parent.width /2 , parent.width /2)
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: Qt.lighter("yellow") }
                                GradientStop { position: 1.0; color: Qt.darker("yellow") }
                            }
                        }
                    }
                    Label{
                        anchors.verticalCenter: parent.verticalCenter

                        text: qsTr("Square")
                        color:textColor

                    }
                }
            }


        }

        RowLayout{
            width: parent.width
            Label{
                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true
                wrapMode: Label.WordWrap
                text: qsTr("Tetris extra (random bombs, uni-cell and cross figure)")
                color:textColor
            }

            CustomSwitch {
                Layout.alignment: Qt.AlignRight
                checked: settings.tetrisExtra
                onCheckedChanged: {
                    settings.tetrisExtra = checked
                }

            }

        }


    }


}
