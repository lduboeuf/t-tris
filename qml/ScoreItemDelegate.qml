import QtQuick 2.0
import QtQuick.Layouts 1.3


RowLayout{


    height: scoreTxt.height *2
    width: parent.width

//    Rectangle{
//        anchors.fill: parent
//        color: "white"
//        opacity: 0.2
//    }

    //                    Text{
    //                        id:indice
    //                        anchors.left: parent.left
    //                        //Layout.alignment: Qt.AlignLeft

    //                        color: scorePage.textColor
    //                        text: index + 1
    //                        opacity: 0.5
    //                    }

    Text{

        id: scoreTxt

        //anchors.left: parent.left
        //Layout.alignment: Qt.AlignLeft
        anchors.leftMargin:  4
        color: scorePage.textColor
        text: " " +score //TODO
    }

    Text{
        //anchors.left: scoreTxt.right
        //anchors.right: dateText.left
        anchors.horizontalCenter: parent.horizontalCenter
        //width: parent.width - (scoreTxt.width + dateText.width)
        color: scorePage.textColor
        elide: Text.ElideRight
        //wrapMode: Text.WordWrap
        text: name

    }

//    Text{
//        id:dateText
//        //Layout.alignment: Qt.AlignRight
//        // anchors.right: parent.right
//        anchors.rightMargin: 4
//        anchors.right: parent.right
//        color: scorePage.textColor
//        // wrapMode: Text.Wrap
//        text: model.date
//    }

}
