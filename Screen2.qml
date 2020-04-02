import QtQuick 2.12
import QtQuick.Window 2.12

Item {
    id: root
    anchors.fill: parent
    property string boxCount
    property string currentColor
    property string currentUserName
    property string currentUserGender
    property string currentUserCity

    IText {
        id: mainText

        rowText.text: qsTr("User Details")
    }
    
    IDivider {id: divider; anchors.top: mainText.bottom; anchors.topMargin: 15}

    Column
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.topMargin: 50
        spacing: 30

        IText {
            id: boxCountText

            rowText.text: qsTr("Total users: ") + boxCount
        }
        
        IText {
            id: userName

            rowText.text: qsTr("Selected user name: ") + currentUserName
        }

        IText {
            id: userGender

            rowText.text: qsTr("Gender: ") + currentUserGender
        }

        IText {
            id: userCity

            rowText.text: qsTr("City: ") + currentUserCity
        }
    }
}
