import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "../../core/providers" as Providers
import "../../core/icons" as Icons

Item {
    id: root

    signal actionTriggered(string command)
    signal closeRequested()

    property int maxResults: 6
    property int selectedIndex: 0
    property int providerGeneration: Providers.ProviderRegistry.applicationsCount
    property string searchText: searchInput.text.trim().toLowerCase()
    property var results: []

    function activate() {
        refreshResults()
        searchInput.forceActiveFocus()
    }

    function deactivate() {
    }

    function refreshResults() {
        if (searchText.length === 0) {
            results = []
        } else {
            results = Providers.ProviderRegistry.search(searchText).slice(0, maxResults)
        }

        clampSelection()
    }

    function clampSelection() {
        if (results.length === 0) {
            selectedIndex = -1
            return
        }

        if (selectedIndex < 0) {
            selectedIndex = 0
        }

        if (selectedIndex >= results.length) {
            selectedIndex = results.length - 1
        }
    }

    function moveSelection(delta) {
        if (results.length === 0) {
            selectedIndex = -1
            return
        }

        selectedIndex = selectedIndex + delta

        if (selectedIndex < 0) {
            selectedIndex = results.length - 1
        }

        if (selectedIndex >= results.length) {
            selectedIndex = 0
        }
    }

    function triggerSelected() {
        if (selectedIndex < 0 || selectedIndex >= results.length) {
            return
        }

        root.actionTriggered(results[selectedIndex].action)
        root.closeRequested()
    }

    onProviderGenerationChanged: {
        refreshResults()
    }

    Component.onCompleted: {
        refreshResults()
        activate()
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: 720
        spacing: 10

        Rectangle {
            Layout.fillWidth: true
            height: 58

            radius: 16
            color: "#14110f"
            border.width: 1
            border.color: searchInput.activeFocus ? "#d18a5d" : "#6a5136"

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 18
                anchors.rightMargin: 18
                spacing: 14

                Text {
                    text: ">"
                    color: "#d18a5d"
                    font.pixelSize: 24
                    Layout.alignment: Qt.AlignVCenter
                }

                TextInput {
                    id: searchInput

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter

                    text: ""
                    color: "#f2ede7"
                    selectionColor: "#45332d"
                    selectedTextColor: "#f2ede7"
                    font.pixelSize: 22
                    clip: true

                    focus: true
                    cursorVisible: activeFocus

                    onTextChanged: {
                        selectedIndex = 0
                        root.refreshResults()
                    }

                    Keys.onEscapePressed: function(event) {
                        root.closeRequested()
                        event.accepted = true
                    }

                    Keys.onUpPressed: function(event) {
                        root.moveSelection(-1)
                        event.accepted = true
                    }

                    Keys.onDownPressed: function(event) {
                        root.moveSelection(1)
                        event.accepted = true
                    }

                    Keys.onReturnPressed: function(event) {
                        root.triggerSelected()
                        event.accepted = true
                    }

                    Keys.onEnterPressed: function(event) {
                        root.triggerSelected()
                        event.accepted = true
                    }

                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        visible: searchInput.text.length === 0
                        text: "Rechercher..."
                        color: "#8f8378"
                        font.pixelSize: 22
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 6
            visible: root.results.length > 0

            Repeater {
                model: root.results

                delegate: Rectangle {
                    property bool selected: index === root.selectedIndex
                    property string resolvedIcon: Icons.IconResolver.resolve(modelData.icon)
                    property bool iconAvailable: Icons.IconResolver.hasIcon(modelData.icon)

                    Layout.fillWidth: true
                    height: 76

                    radius: 12
                    color: selected ? "#2b211d" : "#14110f"
                    border.width: 0

                    Rectangle {
                        width: 4
                        radius: 2
                        color: selected ? "#d18a5d" : "#14110f"

                        anchors {
                            left: parent.left
                            top: parent.top
                            bottom: parent.bottom
                            topMargin: 10
                            bottomMargin: 10
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 16
                        anchors.rightMargin: 16
                        spacing: 14

                        Rectangle {
                            width: 36
                            height: 36
                            radius: 10
                            color: selected ? "#362824" : "#221d1a"
                            Layout.alignment: Qt.AlignVCenter

                            IconImage {
                                anchors.centerIn: parent
                                implicitSize: 24
                                source: resolvedIcon
                                asynchronous: true
                                mipmap: true
                                visible: iconAvailable
                            }

                            Text {
                                anchors.centerIn: parent
                                text: "◈"
                                color: selected ? "#d18a5d" : "#b08b62"
                                font.pixelSize: 16
                                visible: !iconAvailable
                            }
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 1

                            Text {
                                Layout.fillWidth: true
                                text: modelData.title
                                color: "#f5efe8"
                                font.pixelSize: 17
                                elide: Text.ElideRight
                            }

                            Text {
                                Layout.fillWidth: true
                                text: modelData.subtitle
                                color: "#9d8d7d"
                                font.pixelSize: 13
                                elide: Text.ElideRight
                                visible: modelData.subtitle.length > 0
                            }

                        }
                    }

                    MouseArea {
                        id: mouse

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor

                        onEntered: {
                            root.selectedIndex = index
                        }

                        onClicked: {
                            root.actionTriggered(modelData.action)
                            root.closeRequested()
                        }
                    }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            visible: searchInput.text.length > 0

            text: "↑ ↓ Naviguer    Entrée Ouvrir    Esc Fermer"
            color: "#756658"
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
