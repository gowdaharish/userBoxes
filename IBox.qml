import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {
    id: root
    
    implicitHeight: boxHeight
    implicitWidth: boxWidth
    anchors.margins: 30
    
    property real boxWidth
    property real boxHeight
    property string userName
    property string userCity
    property string userGender
    property string userPicture
    property bool selected
    property alias border: mainRect.border
    
    signal clicked()
    
    Rectangle {
        id: mainRect

        anchors.fill: parent
        color: "transparent"
        radius: 5

        Image {
            id: image

            anchors.fill: parent
            source: root.userPicture
            fillMode: Image.PreserveAspectCrop
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: imageMask
            }
        }

        Rectangle {
            id: imageMask

            width: image.width
            height: image.height
            radius: 5
            visible: false
        }

        Rectangle {
            id: nameBackRect

            height: 45
            anchors.bottom: image.bottom
            anchors.left: image.left
            anchors.right: image.right
            anchors.margins: 3
            radius: 5
            color: "#62757f"
            opacity: 0.3
        }

        Rectangle {
            id: nameRect

            anchors.fill: nameBackRect
            anchors.leftMargin: 5
            color: "transparent"

            Column {
                anchors.centerIn: parent
                spacing: 3

                Text {
                    id: name

                    width: nameRect.width
                    font.family: "Helvetica"
                    font.pointSize: 14
                    text: root.userName
                    wrapMode: Text.WordWrap
                    clip: true
                    color: "#ffffff"
                }

                Text {
                    id: city

                    width: nameRect.width
                    font.family: "Helvetica"
                    font.pointSize: 14
                    text: "City: " + root.userCity
                    wrapMode: Text.WordWrap
                    clip: true
                    color: "#ffffff"
                }
            }
        }

        DropShadow {
            id: nameRectShadow

            anchors.fill: nameRect
            horizontalOffset: 3
            verticalOffset: 3
            spread: 0.4
            radius: 8.0
            samples: 17
            color: "#aa000000"
            source: nameRect
        }

        MouseArea {
            id: rectMousearea

            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton
            cursorShape: Qt.PointingHandCursor
            onClicked: root.clicked()
            onDoubleClicked: root.doubleClicked()
        }
    }

    Rectangle {
        id: highlightRect

        width: parent.width
        height: parent.height
        anchors.fill: parent
        opacity: visible ? 1 : 0
        visible: selected
        color: "transparent"
        border.width: 10
        border.color: "black"
        radius: 5
    }
}
