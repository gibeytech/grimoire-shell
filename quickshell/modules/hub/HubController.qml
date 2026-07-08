pragma Singleton

import QtQuick

QtObject {
    id: hubController

    property bool visible: false

    function open() {
        visible = true
        console.log("[Hub] Open")
    }

    function close() {
        visible = false
        console.log("[Hub] Close")
    }

    function toggle() {
        visible = !visible
        console.log("[Hub] Toggle:", visible)
    }
}
