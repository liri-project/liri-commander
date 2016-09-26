import QtQuick 2.7
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0

import Material 0.3
import Material.ListItems 0.1 as ListItem
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.0
import QtQuick.LocalStorage 2.0



ApplicationWindow {
    id: commanderwindow
    height: 200
    width: 500
    flags: Qt.WindowStaysOnTopHint | Qt.WindowCloseButtonHintCustomizeWindowHint | Qt.CustomizeWindowHint
    x: {
        console.log(Screen.width - 520)
        Screen.width - 520
    }
    y: {
        35
    }
    Item {


        id: page
        visible: true
        width:500


        Rectangle {
            height:200
            //width:parent.width
            //x: commanderwindow.right
            color: theme.primaryColor

            IconButton {

                iconName: 'navigation/close'
                anchors.topMargin: dp(20)
                height: dp(36)
                width: dp(12)
                x: 475
                onClicked: {
                    Qt.quit()
                }

            }



         }

         Rectangle {
             width:parent.width
                color:"transparent"
             height:200


             Text {
                    text: "What's up?"
                    height:30
                    width:parent.width
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    y:40
              }

              ActionButton {
                    x: 220
                    y: 110

                    action: Action {
                        id: addContent
                        text: "&Copy"
                        shortcut: "Ctrl+C"
                        onTriggered: {
                            console.log("clicked button")
                        }
                    }
                    iconName: "av/pause"
                    Image {
                        source: "icons/social/public.svg"
                        height:50
                        width:50
                    }
                }


         }
    }

}