pragma Singleton

import QtQuick
import Quickshell

QtObject {
    id: iconResolver

    readonly property string fallbackIconPath:
        "image://icon/application-x-executable"

    function normalize(icon) {
        return String(icon || "").trim()
    }

    function resolve(icon) {
        const iconName = normalize(icon)

        if (iconName.length === 0) {
            return fallbackIconPath
        }

        return "image://icon/" + iconName
    }

    function hasIcon(icon) {
        return normalize(icon).length > 0
    }
}
