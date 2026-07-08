import QtQuick

import ".." as Bar
import "../providers" as Providers
import "." as Widgets

Widgets.StatusItem {
    id: root

    property var networkProvider: Providers.NetworkProvider {}

    label: networkProvider.label
    actionName: "network"

    onClicked: actionName => {
        console.log("[NetworkWidget] Click:", actionName)
        Bar.BarController.togglePopup(actionName)
    }

    onScrolled: (actionName, delta) => {
        console.log("[NetworkWidget] Scroll ignored:", actionName)
    }
}
