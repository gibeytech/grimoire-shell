import QtQuick

Rectangle {
    id: root

    property string title: ""
    property string value: ""

    width: 260
    height: 120

    radius: 14
    color: "#14110f"

    border.color: "#b89a54"
    border.width: 1

    Column {
        anchors.fill: parent
        anchors.margins: 16

        spacing: 12

        Text {
            text: root.title

            color: "#f2ede7"
            font.pixelSize: 15
            font.bold: true
        }

        Text {
            text: root.value

            color: "#d8d0c7"
            font.pixelSize: 13
        }
    }
}
