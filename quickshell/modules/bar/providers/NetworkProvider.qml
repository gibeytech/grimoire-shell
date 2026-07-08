import QtQuick
import Quickshell.Networking

QtObject {
    id: provider

    property string name: "network"

    property bool wifiEnabled: false
    property bool wifiHardwareEnabled: false
    property bool connected: false
    property string networkName: ""
    property real signalStrength: 0
    property var networks: []

    property string label: buildLabel()
    function buildLabel() {
        if (!wifiHardwareEnabled) {
            return " HW Off"
        }

        if (!wifiEnabled) {
            return " Off"
        }

        if (connected && networkName !== "") {
            return " " + networkName
        }

        return ""
    }

    function refresh() {
        wifiEnabled = Networking.wifiEnabled
        wifiHardwareEnabled = Networking.wifiHardwareEnabled

        let foundConnected = false
        let foundName = ""
        let foundSignal = 0
        let foundNetworks = []

        for (let i = 0; i < Networking.devices.length; i++) {
            const device = Networking.devices[i]

            if (!device || device.type !== DeviceType.Wifi) {
                continue
            }

            if (device.scannerEnabled !== undefined) {
                device.scannerEnabled = true
            }

            for (let j = 0; j < device.networks.length; j++) {
                const network = device.networks[j]

                if (!network) {
                    continue
                }

                foundNetworks.push(network)

                if (network.connected) {
                    foundConnected = true
                    foundName = network.name
                    foundSignal = network.signalStrength
                }
            }
        }

        connected = foundConnected
        networkName = foundName
        signalStrength = foundSignal
        networks = foundNetworks
        label = buildLabel()
    }

    function toggleWifi() {
        Networking.wifiEnabled = !Networking.wifiEnabled
        refresh()
    }

    function disconnect() {
        for (let i = 0; i < Networking.devices.length; i++) {
            const device = Networking.devices[i]

            if (device && device.type === DeviceType.Wifi && device.connected) {
                device.disconnect()
                return
            }
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: provider.refresh()
    }

    Component.onCompleted: provider.refresh()

    Connections {
        target: Networking

        function onWifiEnabledChanged() {
            provider.refresh()
        }

        function onWifiHardwareEnabledChanged() {
            provider.refresh()
        }

        function onConnectivityChanged() {
            provider.refresh()
        }
    }
}
