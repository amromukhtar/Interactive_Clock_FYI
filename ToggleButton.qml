import QtQuick 2.15

Rectangle {
    property bool isToggled: true
    property string label:""
    property string labelPos:""

    Rectangle {
    id:toggleBtn
    height: 70
    width: 70
    radius: 20
    color: 'white'
    border.color: "black"
    border.width: 4
    MouseArea{
    anchors.fill: parent;
    onClicked: {
        isToggled=!isToggled
    }
    }
    Text {
        anchors.centerIn: parent
        text: isToggled?"OFF":"ON"
        font.pixelSize: id_plate.height*0.04
        font.bold: true
    }
    }

    Text {
        x:labelPos=="right"?x+(toggleBtn.width*1.1):x-(label.length*8)
        y:y+toggleBtn.height/2.8
        text: label
        font.pixelSize: id_plate.height*0.02
    }
}
