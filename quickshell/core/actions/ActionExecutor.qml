pragma Singleton

import Quickshell
import QtQuick

QtObject {
    id: actionExecutor

    function execute(action) {
        const command = String(action || "")

        if (command.startsWith("desktop:")) {
            const desktopId = command.substring(8)
            const entry = DesktopEntries.byId(desktopId)

            if (!entry) {
                console.warn("[ActionExecutor] Desktop entry not found:", desktopId)
                return false
            }

            entry.execute()
            return true
        }

        if (command.startsWith("shell:")) {
            Quickshell.execDetached([
                "sh",
                "-c",
                command.substring(6)
            ])
            return true
        }

        console.warn("[ActionExecutor] Unknown action:", command)
        return false
    }
}
