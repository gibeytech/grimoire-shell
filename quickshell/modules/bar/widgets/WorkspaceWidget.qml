import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

Row {
    id: root

    spacing: 8

    property var workspaces: []
    property int activeWorkspace: 1

    Process {
        id: workspaceProcess

        command: ["sh", "-c", "hyprctl workspaces -j && printf '\\n---ACTIVE---\\n' && hyprctl activeworkspace -j"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const parts = this.text.split("\n---ACTIVE---\n")

                if (parts.length !== 2) {
                    return
                }

                try {
                    const workspaceData = JSON.parse(parts[0])
                    const activeData = JSON.parse(parts[1])

                    root.workspaces = workspaceData
                        .map(workspace => workspace.id)
                        .filter(id => id > 0)
                        .sort((a, b) => a - b)

                    root.activeWorkspace = activeData.id
                } catch (error) {
                    console.warn("[WorkspaceWidget] Failed to parse hyprctl output:", error)
                }
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: workspaceProcess.running = true
    }

    Repeater {
        model: root.workspaces

        delegate: Text {
            required property int modelData

            text: modelData === root.activeWorkspace
                ? "✦" + modelData
                : "◇" + modelData

            color: modelData === root.activeWorkspace
                ? "#f2ede7"
                : "#d8d0c7"

            font.pixelSize: 13
        }
    }
}
