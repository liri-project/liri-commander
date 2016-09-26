/*
 * QML Material - An application framework implementing Material Design.
 *
 * Copyright (C) 2014-2016 Michael Spencer <sonrisesoftware@gmail.com>
 *               2014 Marcin Baszczewski
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 */

import QtQuick 2.4
import Material 0.3
import Material.Extras 0.1

/*!
   \qmltype Ink
   \inqmlmodule Material

   \brief Represents a ripple ink animation used in buttons and many other components.
 */
MouseArea {
    id: view

    clip: true
    hoverEnabled: Device.hoverEnabled
    z: 2

    property int startRadius: circular ? width/10 : width/6
    property int endRadius

    property Item lastCircle
    property color color: Qt.rgba(0,0,0,0.1)

    property bool circular: false
    property bool centered: false

    property int focusWidth: width - 32 * Units.dp
    property bool focused
    property color focusColor: "transparent"

    property bool showFocus: true

    onPressed: {
        createTapCircle(mouse.x, mouse.y)
    }

    onCanceled: {
        lastCircle.removeCircle();
    }

    onReleased: {
        lastCircle.removeCircle();
    }

    function createTapCircle(x, y) {
        endRadius = centered ? width/2 : radius(x, y)
        showFocus = false

        lastCircle = tapCircle.createObject(view, {
                                                       "circleX": centered ? width/2 : x,
                                                       "circleY": centered ? height/2 : y
                                                   });
    }

    function radius(x, y) {
        var dist1 = Math.max(dist(x, y, 0, 0), dist(x, y, width, height))
        var dist2 = Math.max(dist(x, y, width, 0), dist(x, y, 0, height))

        return Math.max(dist1, dist2)
    }

    function dist(x1, y1, x2, y2) {
        var xs = 0;
        var ys = 0;

        xs = x2 - x1;
        xs = xs * xs;

        ys = y2 - y1;
        ys = ys * ys;

        return Math.sqrt( xs + ys );
    }

    Rectangle {
        id: focusBackground

        anchors.fill: parent

        color: Theme.isDarkColor(focusColor) && focusColor.a > 0
                ? Qt.rgba(0,0,0,0.2) : Qt.rgba(0,0,0,0.1)

        opacity: showFocus && focused ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
        }
    }

    Rectangle {
        id: focusCircle

        anchors.centerIn: parent

        width: focused
                ? focusedState ? focusWidth
                               : Math.min(parent.width - 8 * Units.dp, focusWidth + 12 * Units.dp)
                : parent.width/5
        height: width

        radius: width/2

        opacity: showFocus && focused ? 1 : 0

        Behavior on opacity {
            NumberAnimation { duration: 500; easing.type: Easing.InOutQuad }
        }

        Behavior on width {
            NumberAnimation { duration: focusTimer.interval; }
        }

        color: focusColor.a === 0 ? Qt.rgba(1,1,1,0.4) : focusColor

        property bool focusedState

        Timer {
            id: focusTimer
            running: focused
            repeat: true
            interval: 800

            onTriggered: focusCircle.focusedState = !focusCircle.focusedState
        }
    }

    Component {
        id: tapCircle

        Item {
            id: circleItem

            anchors.fill: parent

            property bool done

            function removeCircle() {
                done = true

                if (fillSizeAnimation.running) {
                    fillOpacityAnimation.stop()
                    closeAnimation.start()

                    circleItem.destroy(500);
                } else {
                    showFocus = true
                    fadeAnimation.start();

                    circleItem.destroy(300);
                }
            }

            property real circleX
            property real circleY

            property bool closed

            Item {
                id: circleParent
                anchors.fill: parent
                visible: !circular

                Rectangle {
                    id: circleRectangle

                    x: circleItem.circleX - radius
                    y: circleItem.circleY - radius

                    width: radius * 2
                    height: radius * 2

                    opacity: 0
                    color: view.color

                    NumberAnimation {
                        id: fillSizeAnimation
                        running: true

                        target: circleRectangle; property: "radius"; duration: 500;
                        from: startRadius; to: endRadius; easing.type: Easing.InOutQuad

                        onStopped: {
                            if (done)
                                showFocus = true
                        }
                    }

                    NumberAnimation {
                        id: fillOpacityAnimation
                        running: true

                        target: circleRectangle; property: "opacity"; duration: 300;
                        from: 0; to: 1; easing.type: Easing.InOutQuad
                    }

                    NumberAnimation {
                        id: fadeAnimation

                        target: circleRectangle; property: "opacity"; duration: 300;
                        from: 1; to: 0; easing.type: Easing.InOutQuad
                    }

                    SequentialAnimation {
                        id: closeAnimation

                        NumberAnimation {
                            target: circleRectangle; property: "opacity"; duration: 250;
                            to: 1; easing.type: Easing.InOutQuad
                        }

                        NumberAnimation {
                            target: circleRectangle; property: "opacity"; duration: 250;
                            from: 1; to: 0; easing.type: Easing.InOutQuad
                        }
                    }
                }
            }

            CircleMask {
                anchors.fill: parent
                source: circleParent
                visible: circular
            }
        }
    }
}
