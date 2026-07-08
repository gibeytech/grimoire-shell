import QtQuick

import "." as Widgets

Rectangle {
    implicitWidth: 180
    implicitHeight: 26

    radius: 13
    color: "#2b211d"

    Widgets.ClockWidget {
        anchors.centerIn: parent
    }
}
