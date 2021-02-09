import QtQuick 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import "components"


ToolBar {
        id:toolBarBottom

        signal leftPressed
        signal rightPressed
        signal rotatePressed

        height: contentHeight * 2

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

            MToolButton {
                id: btnLeft

                imageSrc: "/assets/left.svg"
                Layout.alignment: Qt.AlignLeft
                Layout.fillWidth: true
                Layout.fillHeight: true

                onClicked: {
                    leftPressed()
                }
            }

            MToolButton {
                id: btnRotate

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                Layout.fillHeight: true
                imageSrc: "/assets/rotate.svg"

                onClicked: {
                    rotatePressed()
                }
            }

            MToolButton {
                id: btnRight

                Layout.alignment: Qt.AlignRight
                Layout.fillWidth: true
                Layout.fillHeight: true
                imageSrc: "/assets/right.svg"

                onClicked: {
                    rightPressed()
                }
            }
        }


    }
