import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import "../components"
import "qrc:/js/RemoteStorage.js" as RemoteStorage

Item {
    id: root
    property bool error: false
    property var yearModel: []
    property var scores: []

    ListModel {
        id: scoreList
    }

    function populateModel(year) {
        scoreList.clear()
        let selectedIndex = -1
        for(let i=0; i < root.scores.length; i++) {
            const score = root.scores[i]
            if (score.year === year) {

                scoreList.append(score)

                if (parseInt(score.score) === scorePage.currentScore && score.name === scorePage.currentName) {
                    selectedIndex = scoreList.count - 1
                }
            }
        }
        onlineList.currentIndex = selectedIndex

        if (selectedIndex > -1){
           onlineList.positionViewAtIndex(selectedIndex, ListView.Center )
        } else {
            onlineList.positionViewAtBeginning()
        }
    }

    ColumnLayout {
        anchors.fill: parent

        ListView {
            id: yearsListView
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            orientation: Qt.Horizontal
            flickableDirection: Flickable.HorizontalFlick
            layoutDirection: ListView.RightToLeft
            onCountChanged: {
                var newIndex = count - 1 // last index
                positionViewAtEnd()
                currentIndex = newIndex
            }

            model: yearModel
            delegate: Item {
                width: root.width / 4
                MenuButton {
                    name: modelData
                    selected: yearsListView.currentIndex === index
                    onClicked: {
                        yearsListView.currentIndex = index
                        root.populateModel(modelData)
                    }
                }
            }
        }

        ListView{
            id:onlineList
            Layout.fillWidth: true
            Layout.fillHeight: true
            boundsBehavior: ListView.StopAtBounds
            snapMode: ListView.SnapToItem
            clip: true

            model: scoreList

            delegate: ScoreItemDelegate{
                selected: onlineList.currentIndex === index
            }
        }

    }

    Label {
        anchors.centerIn: parent
        visible: root.error
        color:scorePage.textColor
        text: qsTr("Network unreachable or service unavailable")
    }

    BusyIndicator{
        id: loading
        anchors.centerIn: parent
        running: root.scores.length === 0 && !root.error

    }

    ColorOverlay {
        anchors.fill: loading
        source: loading
        color:scorePage.textColor
    }

    Component.onCompleted:  {

        RemoteStorage.getAll(
                    function(scores){

                        var tmpYearModel = []
                        var recordToHighLight = 0
                        for(var i = 0; i < scores.length; i++){
                            var score = scores[i]

                            if (!tmpYearModel.includes(score.year)) {
                                tmpYearModel.push(score.year)
                            }
                        }

                        root.scores = scores

                        tmpYearModel.sort()
                        yearModel = tmpYearModel

                        root.populateModel(new Date().getFullYear().toString())
                    },
                    function(error){
                        root.error = true
                    }
        )
    }
}
