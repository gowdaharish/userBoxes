import QtQuick 2.12
import QtQuick.Window 2.12
import UserBoxModel 0.1
import QtQuick.Controls 2.12

Item {
    id: root
    
    anchors.fill: parent
    property alias userCount: gridview.count
    property string userName
    property string userCity
    property string userGender

    Component.onCompleted: {
        gridview.currentIndex = userboxModel.rowCount()
    }

    Row {
        id: buttonRow
        
        height: childrenRect.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.width - (addButton.width + deleteButton.width + 150)
        
        IMenuItem {
            id: addButton
            
            width: root.width/3
            buttonText.text: qsTr("Add")
            onClicked: userboxModel.addUserBox()
        }
        
        IMenuItem {
            id: deleteButton
            
            width: root.width/3
            buttonText.text: qsTr("Delete")
            onClicked: {
                if (userCount > 0)
                {
                    if (root.userCount === 1)
                    {
                        userboxModel.deleteUserBox(0)
                        return
                    }

                    userboxModel.deleteUserBox(gridview.currentIndex)

                    if (gridview.currentIndex == userCount)
                        gridview.currentIndex = userCount - 1
                }
            }
        }
    }
    
    IDivider { id: topDivider; anchors.top: buttonRow.bottom}
    
    Rectangle {
        id: gridItem
        
        anchors.top: topDivider.bottom
        anchors.bottom: bottomDivider.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        color: "#404040"
        border.width: 1
        border.color: "#504848"
        radius: 5
        
        IText {
            visible: gridview.count < 1
            anchors.centerIn: parent
            rowText.text: qsTr("Add some users and see the magic")
            rowText.font.pixelSize: 14
        }
        
        GridView {
            id: gridview
            
            height: parent.height
            width: parent.width + scrollBar.width
            clip: true
            cellHeight: parent.width/6
            cellWidth: cellHeight
            focus: true
            
            model: UserBoxModel {
                id: userboxModel
            }

            delegate: Item {
                height: gridview.cellHeight
                width: gridview.cellWidth

                IBox {
                    userName: name
                    userCity: city
                    userGender: gender
                    userPicture: picture
                    selected: gridview.currentIndex === model.index
                    boxWidth: gridview.cellWidth - 25
                    boxHeight: boxWidth
                    anchors.centerIn: parent
                    onClicked: gridview.currentIndex = model.index

                    onSelectedChanged: {
                        root.userName = userboxModel.rowCount() > 0 ? userName : qsTr("none")
                        root.userCity = userboxModel.rowCount() > 0 ? userCity : qsTr("none")
                        root.userGender = userboxModel.rowCount() > 0 ? userGender : qsTr("none")
                    }
                }
            }

            add: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 300 }
                NumberAnimation { property: "scale"; from: 0; to: 1.0; duration: 300 }
            }

            ScrollBar.vertical: ScrollBar {id: scrollBar }
        }
    }

    IDivider {id: bottomDivider; anchors.bottom: countText.top}

    IText {
        id: countText

        anchors.bottom: parent.bottom
        rowText.text: qsTr("There are ") + gridview.count + qsTr(" users")
    }
}
