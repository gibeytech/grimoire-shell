import Quickshell
import QtQuick

FloatingWindow {
    id: root

    visible: false

    implicitWidth: 300
    implicitHeight: 180

    color: "transparent"

    Rectangle {
        anchors.fill: parent

        radius: 16
        color: "#14110f"

        border.width: 1
        border.color: "#b89a54"

        Text {
            anchors.centerIn: parent

            text: "Status Popup"

            color: "#f2ede7"
            font.pixelSize: 16
        }
    }
}
