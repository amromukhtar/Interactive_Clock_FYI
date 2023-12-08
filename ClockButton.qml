import QtQuick 2.15

Rectangle {
    property int type: 12

    Rectangle {
    id:one
    x:x
    y:y
    height: 70
    width: 70
    radius: 20
    color: 'white'
    border.color: "black"
    border.width: 4
    MouseArea{
    anchors.fill: parent;
    onClicked: {
        if(clockType==="PM" && type==24)hour-=12
        type=12
    }
    }
    Text {
        anchors.centerIn: parent
        text: "12"
        font.pixelSize: id_plate.height*0.04
        font.bold: true
    }
    }

    Rectangle {
    id:two
    x:x+80
    y:y
    height: 70
    width: 70
    radius: 20
    color: 'white'
    border.color: "black"
    border.width: 4
    MouseArea{
    anchors.fill: parent;
    onClicked: {
        if(clockType==="PM" && type==12)hour+=12
        type=24
    }
    }
    Text {
        anchors.centerIn: parent
        text: "24"
        font.pixelSize: id_plate.height*0.04
        font.bold: true
    }
    }

}
