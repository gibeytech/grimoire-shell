pragma Singleton

import QtQuick

QtObject {
    id: controller

    property string activePopup: ""

    function openPopup(name) {
        if (!name) {
            return
        }

        activePopup = name
        console.log("[BarController] Open popup:", name)
    }

    function closePopup() {
        activePopup = ""
        console.log("[BarController] Close popup")
    }

    function togglePopup(name) {
        if (!name) {
            return
        }

        if (activePopup === name) {
            closePopup()
            return
        }

        openPopup(name)
    }

    function hasActivePopup() {
        return activePopup !== ""
    }
}
