pragma Singleton

import QtQuick

import "../registry" as Registry
import "../../modules/test/manifest.js" as TestManifest
import "../../modules/hub/manifest.js" as HubManifest
import "../../modules/bar/manifest.js" as BarManifest

QtObject {
    id: moduleManager

    function registerKnownModules(moduleIds) {
        for (let i = 0; i < moduleIds.length; i++) {
            registerKnownModule(moduleIds[i])
        }
    }

    function registerKnownModule(moduleId) {
        if (moduleId === "test") {
            return registerModule(TestManifest.manifest)
        }

        if (moduleId === "hub") {
            return registerModule(HubManifest.manifest)
        }

        if (moduleId === "bar") {
            return registerModule(BarManifest.manifest)
        }

        console.warn("[ModuleManager] Unknown module:", moduleId)
        return false
    }

    function registerModule(manifest) {
        return Registry.Registry.registerModule(manifest)
    }

    function registerModules(manifests) {
        for (let i = 0; i < manifests.length; i++) {
            registerModule(manifests[i])
        }
    }

    function enableModule(moduleId) {
        return Registry.Registry.enableModule(moduleId)
    }

    function disableModule(moduleId) {
        return Registry.Registry.disableModule(moduleId)
    }

    function isModuleEnabled(moduleId) {
        return Registry.Registry.isEnabled(moduleId)
    }

    function getAvailableModules() {
        return Registry.Registry.getAvailableModules()
    }

    function getEnabledModules() {
        return Registry.Registry.getEnabledModules()
    }

    function getComponents() {
        return Registry.Registry.getComponents()
    }

    function getProviders() {
        return Registry.Registry.getProviders()
    }
}
