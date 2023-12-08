import QtQuick 2.15

Rectangle {
    property color color:"black"

    Rectangle {
    x:x
    y:y
    height: 30
    width: 30
    radius: 15
    color: 'black'
    MouseArea{
    anchors.fill: parent;
    onClicked: {
        color='black'
    }
    }
    }

    Rectangle {
    x:x + 35
    y:y
    height: 30
    width: 30
    radius: 15
    color: '#1976d2'
    MouseArea{
    anchors.fill: parent;
    onClicked: {
        color='#1976d2'
    }
    }
    }

    Rectangle {
    x:x + 70
    y:y
    height: 30
    width: 30
    radius: 15
    color: '#ff5722'
    MouseArea{
    anchors.fill: parent;
    onClicked: {
        color='#ff5722'
    }
    }
    }

    Rectangle {
    x:x + 105
    y:y
    height: 30
    width: 30
    radius: 15
    color: '#388e3c'
    MouseArea{
    anchors.fill: parent;
    onClicked: {
        color='#388e3c'
    }
    }
    }


}
