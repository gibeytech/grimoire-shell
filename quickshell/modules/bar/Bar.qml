import Quickshell
import QtQuick
import QtQuick.Layouts

import "widgets" as Widgets

PanelWindow {
    id: root

    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 40

    Rectangle {
        anchors.fill: parent

        color: "#14110f"

        border.color: "#b89a54"
        border.width: 1

        radius: 14

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16
            anchors.rightMargin: 16

            Widgets.LeftSection {}

            Item {
                Layout.fillWidth: true
            }

            Widgets.CenterSection {}

            Item {
                Layout.fillWidth: true
            }

            Widgets.RightSection {}
        }
    }
}
