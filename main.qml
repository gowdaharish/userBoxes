import QtQuick 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.0

Window {
    id: root
    visible: true
    minimumWidth: 640
    minimumHeight: 480
    title: qsTr("UserBoxes")
    color: "#292929"

    Item {
        id: enclosingItem

        anchors.fill: parent
        anchors.topMargin: 5

        Row {
            id: menuRow

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 5

            IMenuItem {
                width: root.width/3 - 10
                buttonText.text: qsTr("Homescreen")
                onClicked: {
                    homeScreen.visible = true
                    screen2.visible = false
                }
            }

            IMenuItem {
                width: root.width/3 - 10
                buttonText.text: qsTr("Infoscreen")
                onClicked: {
                    homeScreen.visible = false
                    screen2.visible = true
                }
            }
        }

        Item {
            id: menuContents

            anchors.top: menuRow.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 10

            Homescreen {
                id: homeScreen

            }

            Screen2 {
                id: screen2

                visible: false
                boxCount: homeScreen.userCount
                currentUserName: homeScreen.userName
                currentUserGender: homeScreen.userGender
                currentUserCity: homeScreen.userCity
            }
        }
    }

    Settings {
        property alias x: root.x
        property alias y: root.y
        property alias width: root.width
        property alias height: root.height
    }
}
