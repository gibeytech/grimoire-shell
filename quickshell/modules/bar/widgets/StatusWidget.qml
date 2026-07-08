import Quickshell
import Quickshell.Io
import QtQuick

import "." as Widgets

Row {
    id: root

    spacing: 10

    property int brightnessPercent: 0
    property int volumePercent: 0
    property int batteryPercent: 0
    property string batteryState: ""

    function refreshStatus() {
        refreshProcess.running = true
    }

    function runCommand(command) {
        actionProcess.command = ["sh", "-c", command]
        actionProcess.running = true
    }

    function handleScroll(action, delta) {
        const up = delta > 0

        if (action === "brightness") {
            runCommand(up ? "brightnessctl set +5%" : "brightnessctl set 5%-")
            return
        }

        if (action === "volume") {
            runCommand(up
                ? "current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9][0-9]*%' | head -1 | tr -d '%'); next=$((current + 5)); if [ \"$next\" -gt 100 ]; then next=100; fi; pactl set-sink-volume @DEFAULT_SINK@ ${next}%"
                : "current=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9][0-9]*%' | head -1 | tr -d '%'); if [ \"$current\" -gt 100 ]; then next=100; else next=$((current - 5)); fi; if [ \"$next\" -lt 0 ]; then next=0; fi; pactl set-sink-volume @DEFAULT_SINK@ ${next}%"
            )
            return
        }

        console.log("[StatusWidget] Scroll ignored:", action)
    }

    function handleClick(action) {
        console.log("[StatusWidget] Click:", action)
    }

    function batteryIcon() {
        if (batteryState === "charging") {
            return ""
        }

        return ""
    }

    Process {
        id: actionProcess

        onExited: root.refreshStatus()
    }

    Process {
        id: refreshProcess

        command: [
            "sh",
            "-c",
            "echo BRIGHTNESS_CURRENT=$(brightnessctl get); " +
            "echo BRIGHTNESS_MAX=$(brightnessctl max); " +
            "pactl get-sink-volume @DEFAULT_SINK@ | head -1; " +
            "battery=$(upower -e | grep BAT | head -1); " +
            "if [ -n \"$battery\" ]; then upower -i \"$battery\" | grep -E 'percentage|state'; fi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = this.text

                const brightnessCurrentMatch = output.match(/BRIGHTNESS_CURRENT=(\d+)/)
                const brightnessMaxMatch = output.match(/BRIGHTNESS_MAX=(\d+)/)
                const volumeMatch = output.match(/\/\s*(\d+)%/)
                const batteryPercentMatch = output.match(/percentage:\s*(\d+)%/)
                const batteryStateMatch = output.match(/state:\s*([a-zA-Z-]+)/)

                if (brightnessCurrentMatch && brightnessMaxMatch) {
                    const current = Number(brightnessCurrentMatch[1])
                    const max = Number(brightnessMaxMatch[1])

                    if (max > 0) {
                        root.brightnessPercent = Math.round((current / max) * 100)
                    }
                }

                if (volumeMatch) {
                    root.volumePercent = Number(volumeMatch[1])
                }

                if (batteryPercentMatch) {
                    root.batteryPercent = Number(batteryPercentMatch[1])
                }

                if (batteryStateMatch) {
                    root.batteryState = batteryStateMatch[1]
                }
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true

        onTriggered: root.refreshStatus()
    }

    Component.onCompleted: root.refreshStatus()

    Widgets.StatusItem {
        label: root.brightnessPercent + "% ☀"
        actionName: "brightness"
        onClicked: actionName => root.handleClick(actionName)
        onScrolled: (actionName, delta) => root.handleScroll(actionName, delta)
    }

    Widgets.StatusItem {
        label: root.volumePercent + "% "
        actionName: "volume"
        onClicked: actionName => root.handleClick(actionName)
        onScrolled: (actionName, delta) => root.handleScroll(actionName, delta)
    }

    Widgets.StatusItem {
        label: ""
        actionName: "bluetooth"
        onClicked: actionName => root.handleClick(actionName)
        onScrolled: (actionName, delta) => root.handleScroll(actionName, delta)
    }

    Widgets.StatusItem {
        label: ""
        actionName: "network"
        onClicked: actionName => root.handleClick(actionName)
        onScrolled: (actionName, delta) => root.handleScroll(actionName, delta)
    }

    Widgets.StatusItem {
        label: root.batteryPercent + "% " + root.batteryIcon()
        actionName: "battery"
        onClicked: actionName => root.handleClick(actionName)
        onScrolled: (actionName, delta) => root.handleScroll(actionName, delta)
    }
}
