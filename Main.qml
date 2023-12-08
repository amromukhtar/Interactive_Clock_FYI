import QtQuick 2.15
// import QtQuick.Controls 2.15

Window {
        id: id_root
        visible: true
        width: 820
        height: 820


        property color color: "white"
        property int hourPos:0
        property int hour:0
        property int minute:0
        property string clockType:"AM"


        function handleHourChange(newHour){
          if(hourPos==11 && Math.abs(hourPos-newHour)>5){
              clockType=clockType==="AM"?"PM":"AM"
          }
          else if(hourPos==0 && Math.abs(newHour-hourPos)>5){
              clockType=clockType==="AM"?"PM":"AM"
          }
          let hourTypeValue=clockType==="AM"?hourPos:hourPos+12
          hour=clockBtn.type===12? hourPos:hourTypeValue
        }

        function moveNeedles(type,value) {
            if(type==="minute"){
            let newMin=value/6
            let newHour=hourPos
            minute_needle.rotation=value
            if(minute==59 && Math.abs(minute-newMin)>45){
                if(hourPos===11) newHour=0
                else newHour++
            }
            else if(minute==0 && Math.abs(newMin-minute)>45){
                if(hourPos===0) newHour=11
               else  newHour--
            }
            handleHourChange(newHour)
            minute=newMin
            hourPos=newHour
            hour_needle.rotation=(hourPos * 30) + (minute * 0.5)
            }
            else{
                let newHour=value/30
                hour_needle.rotation=value
                handleHourChange(newHour)
                hourPos=newHour
                minute= (newHour - Math.floor(newHour)) * 60
                minute_needle.rotation=minute * 6
            }

        }

        Timer {
               id: timer
               interval: 1000
               repeat: true
               running: true
               onTriggered: {
                   second_needle.rotation = (new Date()).getSeconds() * 6
               }
           }



        ToggleButton{
            id:leftUpperBtn
            label:"Hour Hand"
            labelPos:"right"
            x:50
            y:50
        }

        ToggleButton{
            id:rightUpperBtn
            label:"Minute Hand"
            labelPos:"left"
            x:700
            y:50
        }

        ToggleButton{
            id:rightBottomBtn
            label:"Digital"
            labelPos:"left"
            x:700
            y:640
        }

        ClockButton{
            id:clockBtn
            x:620
            y:720
        }


        ToggleButton{
            id:leftBottomBtn
            label:"Dash Lines"
            labelPos:"right"
            x:50
            y:700
        }

        ColorButton{
            id:colorBtn
            x:50
            y:780
        }


        Rectangle {
            id: id_plate

            anchors.centerIn: parent
            height: id_root.width-120
            width: height
            radius: width/2
            color: id_root.color
            border.color: colorBtn.color
            border.width: 40


            Text {
                id:am_pm
                color:'black'
                anchors.horizontalCenter:id_plate.horizontalCenter
                y:id_plate.height*0.4
                text: clockType
                font.pixelSize: id_plate.height*0.03
                font.bold: true
                visible: rightBottomBtn.isToggled && clockBtn.type===12
            }


            Repeater {
                model: 60

                Item {
                    id: minutePoints

                    property int hour: index
                    height: id_plate.height/2
                    transformOrigin: Item.Bottom
                    rotation: index * 6
                    x: id_plate.width/2
                    y: 0

                    Rectangle {
                        height: id_plate.height*0.04
                        width: height/12
                        radius: 1
                        color: colorBtn.color
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: id_plate.height*0.03
                    }
                }
            }

            Repeater {
                model: 12

                Item {
                    id: hourPoints

                    property int hour: index
                    height: id_plate.height/2
                    transformOrigin: Item.Bottom
                    rotation: index * 30
                    x: id_plate.width/2
                    y: 0

                    Rectangle {
                        height: id_plate.height*0.08
                        width: height/6.5
                        radius: 1
                        color: colorBtn.color
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 4
                    }

                    Text {
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                        }
                        x: 0
                        y: id_plate.height*0.07
                        rotation: 360 - index * 30
                        text: hourPoints.hour == 0 ? 12 : hourPoints.hour
                        font.pixelSize: id_plate.height*0.12
                        font.bold: true
                    }

                    Text {
                        color:'white'
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 3
                        x: 0
                        y: id_plate.height*0.07
                        rotation: 360 - index * 30
                        text: hourPoints.hour == 0 ? "00" : (hourPoints.hour * 5)
                        font.pixelSize: id_plate.height*0.03
                        font.bold: true
                    }
                }

        }

        Item {
            id: hour_needle

            Rectangle {
                width: 20
                height: id_plate.height * 0.28
                color: "black"
                anchors {
                    horizontalCenter: hour_needle.horizontalCenter
                }
                antialiasing: true
                y: hour_needle.height * 0.25
                visible :leftUpperBtn.isToggled

                DashedCircle {
                    x:-40
                    y: -hour_needle.height*0.18
                    color:"transparent"
                    visible :leftBottomBtn.isToggled
                }

                MouseArea{
                                   anchors.fill: parent;
                                   onPositionChanged:  {

                                       var point =  mapToItem (id_plate, mouse.x, mouse.y);
                                       var diffX = (point.x - (id_plate.height/2));
                                       var diffY = -1 * (point.y - (id_plate.width/2));
                                       var rad = Math.atan (diffY / diffX);
                                       var deg = (rad * 180 / Math.PI);

                                       let rot
                                       if (diffX > 0 && diffY > 0) {
                                           rot = 90 - Math.abs (deg);
                                       }
                                       else if (diffX > 0 && diffY < 0) {
                                           rot = 90 + Math.abs (deg);
                                       }
                                       else if (diffX < 0 && diffY > 0) {
                                           rot = 270 + Math.abs (deg);
                                       }
                                       else if (diffX < 0 && diffY < 0) {
                                           rot = 270 - Math.abs (deg);
                                       }

                                       moveNeedles("hour",rot)
                                   }
                               }

            }



            anchors {
                top: id_plate.top
                bottom: id_plate.bottom
                horizontalCenter: parent.horizontalCenter
            }

        }


        Item {
            id: minute_needle

            Rectangle {
                width: 20
                height: id_plate.height * 0.45
                color: colorBtn.color
                anchors {
                    horizontalCenter: minute_needle.horizontalCenter
                }
                antialiasing: true
                y: minute_needle.height * 0.07
                visible :rightUpperBtn.isToggled

                DashedCircle {
                    x:-40
                    color:"transparent"
                    visible :leftBottomBtn.isToggled
                }

                MouseArea{
                                   anchors.fill: parent;
                                   onPositionChanged:  {
                                       var point =  mapToItem (id_plate, mouse.x, mouse.y);
                                       var diffX = (point.x - (id_plate.height/2));
                                       var diffY = -1 * (point.y - (id_plate.width/2));
                                       var rad = Math.atan (diffY / diffX);
                                       var deg = (rad * 180 / Math.PI);

                                       let rot
                                       if (diffX > 0 && diffY > 0) {
                                           rot = 90 - Math.abs (deg);
                                       }
                                       else if (diffX > 0 && diffY < 0) {
                                           rot = 90 + Math.abs (deg);
                                       }
                                       else if (diffX < 0 && diffY > 0) {
                                           rot = 270 + Math.abs (deg);
                                       }
                                       else if (diffX < 0 && diffY < 0) {
                                           rot = 270 - Math.abs (deg);
                                       }

                                       moveNeedles("minute",rot)
                                   }
                               }
            }

            anchors {
                top: id_plate.top
                bottom: id_plate.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }



        Item {
            id: second_needle

            Rectangle {
                width: 10
                height: id_plate.height * 0.45
                color: "red"
                anchors {
                    horizontalCenter: second_needle.horizontalCenter
                }
                antialiasing: true
                y: second_needle.height * 0.07
            }

            rotation: (new Date()).getSeconds() * 6
            antialiasing: true

            anchors {
                top: id_plate.top
                bottom: id_plate.bottom
                horizontalCenter: parent.horizontalCenter
            }

        }

        Rectangle {
            anchors {
                horizontalCenter: id_plate.horizontalCenter
            }
            y:id_plate.height*0.3
            height: 70
            width: 200
            opacity: 0.8
            color: "white"
            visible :rightBottomBtn.isToggled

            Text {
                color:'black'
                anchors.centerIn:  parent
                text: `${hour==0?12:hour}:${String(minute).length==1?"0"+minute:minute}`
                font.pixelSize: id_plate.height*0.08
                font.bold: true
            }

        }
}

}


