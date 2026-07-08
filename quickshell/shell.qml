import Quickshell
import QtQuick

import "core/modules" as Core
import "core/runtime" as Runtime
import "core/components" as Components
import "modules/modules.js" as ModuleList

ShellRoot {
    id: shell

    Components.QmlLoader {
        id: runtimeLoader
    }

    function bootstrapComponents() {
        const components = Core.ModuleManager.getComponents()

        for (let i = 0; i < components.length; i++) {
            Runtime.Runtime.registerComponent(components[i])
        }

        runtimeLoader.components = Runtime.Runtime.getComponents()

        console.log("[Grimoire Shell] Runtime components:", components.length)
    }

    function bootstrapProviders() {
        const providers = Core.ModuleManager.getProviders()

        for (let i = 0; i < providers.length; i++) {
            Runtime.Runtime.registerProvider(providers[i])
        }

        runtimeLoader.providers = Runtime.Runtime.getProviders()

        console.log("[Grimoire Shell] Runtime providers:", providers.length)
    }

    Component.onCompleted: {
        console.log("[Grimoire Shell] Bootstrap start")

        Core.ModuleManager.registerKnownModules(ModuleList.modules)

        bootstrapComponents()
        bootstrapProviders()

        console.log("[Grimoire Shell] Bootstrap complete")
    }
}
