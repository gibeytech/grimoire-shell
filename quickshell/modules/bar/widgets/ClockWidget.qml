import QtQuick

Text {
    id: root

    property date currentDate: new Date()

    text: Qt.formatDateTime(currentDate, "HH:mm   ·   ddd dd MMM")

    color: "#f2ede7"
    font.pixelSize: 13

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: root.currentDate = new Date()
    }
}
