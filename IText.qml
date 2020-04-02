import QtQuick 2.0

Rectangle {
    id: root

    property real rowWidth
    property real rowHeight
    property alias rowText: text
    property alias backgroundColor: root.color
    property alias border: root.border
    property alias color: root.color
    
    width: parent.width
    height: 35
    anchors.bottomMargin: 10
    anchors.topMargin: 10
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"
    radius: 5
    border.width: 0
    border.color: "#4dd0e1"
    
    Text {
        id: text
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 18
        font.weight: Font.Normal
    }
}
