pragma Singleton

import QtQuick

QtObject {
    id: registry

    property var availableModules: []
    property var enabledModules: []

    function registerModule(manifest) {
        if (!manifest || !manifest.id) {
            console.warn("[Registry] Invalid module manifest")
            return false
        }

        if (hasModule(manifest.id)) {
            console.warn("[Registry] Module already registered:", manifest.id)
            return false
        }

        availableModules.push(manifest)
        availableModulesChanged()

        if (manifest.enabled === true) {
            enableModule(manifest.id)
        }

        console.log("[Registry] Registered module:", manifest.id)
        return true
    }

    function enableModule(moduleId) {
        const module = getModule(moduleId)

        if (!module) {
            console.warn("[Registry] Cannot enable unknown module:", moduleId)
            return false
        }

        if (isEnabled(moduleId)) {
            return true
        }

        if (!dependenciesSatisfied(module)) {
            console.warn("[Registry] Cannot enable module:", moduleId)
            return false
        }

        module.enabled = true
        enabledModules.push(module)
        enabledModulesChanged()

        console.log("[Registry] Enabled module:", moduleId)
        return true
    }

    function dependenciesSatisfied(module) {
        if (!module.dependencies || module.dependencies.length === 0) {
            return true
        }

        for (let i = 0; i < module.dependencies.length; i++) {
            const dependencyId = module.dependencies[i]

            if (!hasModule(dependencyId)) {
                console.warn("[Registry] Missing dependency:", dependencyId)
                return false
            }
        }

        return true
    }

    function disableModule(moduleId) {
        if (!isEnabled(moduleId)) {
            return true
        }

        for (let i = 0; i < enabledModules.length; i++) {
            if (enabledModules[i].id === moduleId) {
                enabledModules.splice(i, 1)
                enabledModulesChanged()
                break
            }
        }

        const module = getModule(moduleId)
        if (module) {
            module.enabled = false
        }

        console.log("[Registry] Disabled module:", moduleId)
        return true
    }

    function isEnabled(moduleId) {
        for (let i = 0; i < enabledModules.length; i++) {
            if (enabledModules[i].id === moduleId) {
                return true
            }
        }

        return false
    }

    function hasModule(moduleId) {
        return getModule(moduleId) !== null
    }

    function getModule(moduleId) {
        for (let i = 0; i < availableModules.length; i++) {
            if (availableModules[i].id === moduleId) {
                return availableModules[i]
            }
        }

        return null
    }

    function getAvailableModules() {
        return availableModules
    }

    function getEnabledModules() {
        return enabledModules
    }

    function getProviders() {
        let providers = []

        for (let i = 0; i < enabledModules.length; i++) {
            const module = enabledModules[i]

            if (!module.providers) {
                continue
            }

            for (let j = 0; j < module.providers.length; j++) {
                const provider = module.providers[j]

                providers.push({
                    id: provider,
                    moduleId: module.id,
                    source: provider,
                    resolvedSource: "modules/" + module.id + "/" + provider
                })
            }
        }

        return providers
    }

    function getActions() {
        let actions = []

        for (let i = 0; i < enabledModules.length; i++) {
            const module = enabledModules[i]

            if (module.actions) {
                actions = actions.concat(module.actions)
            }
        }

        return actions
    }

    function getComponents() {
        let components = []

        for (let i = 0; i < enabledModules.length; i++) {
            const module = enabledModules[i]

            if (!module.components) {
                continue
            }

            for (let j = 0; j < module.components.length; j++) {
                const component = module.components[j]

                components.push({
                    id: component.id,
                    moduleId: module.id,
                    type: component.type,
                    source: component.source,
                    resolvedSource: "modules/" + module.id + "/" + component.source
                })
            }
        }

        return components
    }
}
