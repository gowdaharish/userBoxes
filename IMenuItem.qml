import QtQuick 2.0

Rectangle {
    id: buttonRect

    height: 40
    width: paren.width/3 - 5
    color: "#404040"
    radius: 5

    property alias buttonText: text
    signal clicked()

    Rectangle {
        id: maskRect
        anchors.fill: parent
        color: "#575757"
        radius: buttonRect.radius
        visible: buttonMousearea.pressed
    }

    Text {
        id: text
        text: qsTr("Button")
        color: "white"
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
        font.pixelSize: 15
        font.weight: Font.Normal
    }

    MouseArea {
        id: buttonMousearea
        anchors.fill: buttonRect
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        onClicked: buttonRect.clicked()
    }

    states: [
        State {
            name: "hasMouse"
            when: buttonMousearea.containsMouse
            PropertyChanges {
                target: buttonRect
                color: "#6e6e6e"
            }
            PropertyChanges {
                target: buttonMousearea
                cursorShape: Qt.PointingHandCursor
            }
        }
    ]
}
