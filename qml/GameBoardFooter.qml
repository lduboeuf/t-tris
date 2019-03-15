import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0


ToolBar {
        id:toolBarBottom

        background: Rectangle{
            anchors.fill: toolBarBottom
            color: "black";
            opacity: 0.8
            Rectangle{
                width: parent.width
                anchors.top: parent.top
                color:"#9a37a4"
                height: 1
            }
        }

        RowLayout{
            anchors.fill: parent

            ToolButton {
                id: btnLeft
                anchors.left: parent.left
                Layout.fillWidth: true
                contentItem: Image {
                    id:imgLeft
                    fillMode: Image.Pad
                    sourceSize.width: btnLeft.height  * 0.4
                    sourceSize.height: btnLeft.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "/assets/left.svg"
                }
                onClicked: {
                    if(timer.running)
                        Tetris.onKeyHandler(Config.KEY_LEFT)
                }
                ColorOverlay {
                    anchors.fill: imgLeft
                    source: imgLeft
                    color: boardGame.textColor
                }

            }



            ToolButton {
                id: btnRotate
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillWidth: true

                contentItem: Image {
                    id: imgRotate
                    fillMode: Image.Pad
                    sourceSize.width: btnRotate.height  * 0.4
                    sourceSize.height: btnRotate.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "/assets/rotate.svg"
                }

                onClicked: {
                    if(timer.running)
                        Tetris.onKeyHandler(Config.KEY_UP)
                }

                ColorOverlay {
                    anchors.fill: imgRotate
                    source: imgRotate
                    color: boardGame.textColor
                }


            }




            ToolButton {
                id: btnRight
                Layout.fillWidth: true
                anchors.right: parent.right
                contentItem: Image {
                    id: imgRight
                    fillMode: Image.Pad
                    sourceSize.width: btnLeft.height  * 0.4
                    sourceSize.height: btnLeft.height  * 0.4
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "/assets/right.svg"
                }
                onClicked: {
                    if(timer.running)
                        Tetris.onKeyHandler(Config.KEY_RIGHT)
                }

                ColorOverlay {
                    anchors.fill: imgRight
                    source: imgRight
                    color: boardGame.textColor
                }

            }
        }



    }
