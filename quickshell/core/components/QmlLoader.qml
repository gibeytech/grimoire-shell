import Quickshell
import Quickshell.Io
import QtQuick
import QtQml.Models

import "../runtime" as Runtime
import "../providers" as Providers

Item {
    id: qmlRuntimeLoader

    property var components: []
    property var providers: []

    Repeater {
        model: qmlRuntimeLoader.providers

        delegate: Loader {
            id: providerLoader

            required property var modelData

            active: true
            source: Qt.resolvedUrl("../../" + modelData.resolvedSource)

            onLoaded: {
                console.log(
                    "[QmlLoader] Loaded provider:",
                    modelData.id,
                    modelData.resolvedSource
                )

                Runtime.Runtime.markLoaded(modelData.id)

                if (item) {
                    Providers.ProviderRegistry.registerProvider(item)
                } else {
                    console.warn(
                        "[QmlLoader] Provider loaded without item:",
                        modelData.id
                    )
                }
            }
        }
    }

    Instantiator {
        id: componentInstantiator

        model: qmlRuntimeLoader.components

        delegate: PanelWindow {
            id: runtimeWindow

            required property var modelData

            visible: false
            focusable: true
            color: "transparent"

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            Timer {
                id: focusTimer

                interval: 50
                repeat: false

                onTriggered: {
                    runtimeWindow.activateLoadedItem()
                }
            }

            function activateLoadedItem() {
                if (qmlLoader.item && qmlLoader.item.activate) {
                    qmlLoader.item.activate()
                    return
                }

                if (
                    qmlLoader.item
                    && qmlLoader.item.forceActiveFocus
                ) {
                    qmlLoader.item.forceActiveFocus()
                }
            }

            function deactivateLoadedItem() {
                if (
                    qmlLoader.item
                    && qmlLoader.item.deactivate
                ) {
                    qmlLoader.item.deactivate()
                }
            }

            function openWindow() {
                runtimeWindow.visible = true
                focusTimer.restart()
            }

            function closeWindow() {
                runtimeWindow.visible = false
            }

            function toggleWindow() {
                if (runtimeWindow.visible) {
                    closeWindow()
                } else {
                    openWindow()
                }
            }

            function executeCommand(command) {
                Providers.ProviderRegistry.execute(command)
            }

            onVisibleChanged: {
                if (visible) {
                    focusTimer.restart()
                } else {
                    deactivateLoadedItem()
                }
            }

            IpcHandler {
                target: modelData.id

                function toggle(): void {
                    runtimeWindow.toggleWindow()
                }

                function open(): void {
                    runtimeWindow.openWindow()
                }

                function close(): void {
                    runtimeWindow.closeWindow()
                }
            }

            MouseArea {
                anchors.fill: parent
                enabled: runtimeWindow.visible

                onClicked: {
                    runtimeWindow.closeWindow()
                }
            }

            Loader {
                id: qmlLoader

                anchors.fill: parent
                active: modelData.type === "window"

                source: Qt.resolvedUrl(
                    "../../" + modelData.resolvedSource
                )

                onLoaded: {
                    Runtime.Runtime.markLoaded(modelData.id)

                    if (item && item.actionTriggered) {
                        item.actionTriggered.connect(
                            function(command) {
                                runtimeWindow.executeCommand(command)
                                runtimeWindow.closeWindow()
                            }
                        )
                    }

                    if (item && item.closeRequested) {
                        item.closeRequested.connect(
                            function() {
                                runtimeWindow.closeWindow()
                            }
                        )
                    }

                    focusTimer.restart()
                }
            }
        }
    }
}
