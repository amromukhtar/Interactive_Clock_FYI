import QtQuick 2.15

Rectangle {
    width: 100
    height: 100

    Canvas {
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.strokeStyle = "#454545";
            ctx.setLineDash([4, 4]);
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.arc(width/2, height/2, Math.min(width, height)/2 - ctx.lineWidth/2, 0, 2 * Math.PI);
            ctx.closePath();
            ctx.stroke();
        }
    }
}
