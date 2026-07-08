import QtQuick

Rectangle {
    id: root

    property string label: ""
    property string actionName: ""

    signal clicked(string actionName)
    signal scrolled(string actionName, int delta)

    implicitWidth: labelText.implicitWidth + 12
    implicitHeight: 24

    radius: 12
    color: mouseArea.containsMouse ? "#362824" : "transparent"

    Text {
        id: labelText

        anchors.centerIn: parent

        text: root.label
        color: "#f2ede7"
        font.pixelSize: 13
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onClicked: root.clicked(root.actionName)

        onWheel: function(wheel) {
            root.scrolled(root.actionName, wheel.angleDelta.y)
        }
    }
}
