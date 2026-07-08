pragma Singleton

import QtQuick

QtObject {
    id: runtime

    property var components: []
    property var providers: []

    function registerComponent(component) {
        if (!component || !component.id)
            return false

        if (hasComponent(component.id))
            return false

        components.push({
            id: component.id,
            moduleId: component.moduleId,
            type: component.type,
            source: component.source,
            resolvedSource: component.resolvedSource,
            loaded: false,
            visible: false
        })

        componentsChanged()

        console.log("[Runtime] Registered component:", component.id)

        return true
    }

    function registerProvider(provider) {
        if (!provider || !provider.id)
            return false

        if (hasProvider(provider.id))
            return false

        providers.push({
            id: provider.id,
            moduleId: provider.moduleId,
            source: provider.source,
            resolvedSource: provider.resolvedSource,
            loaded: false
        })

        providersChanged()

        console.log("[Runtime] Registered provider:", provider.id)

        return true
    }

    function getComponent(id) {
        for (let i = 0; i < components.length; i++) {
            if (components[i].id === id)
                return components[i]
        }

        return null
    }

    function getProvider(id) {
        for (let i = 0; i < providers.length; i++) {
            if (providers[i].id === id)
                return providers[i]
        }

        return null
    }

    function hasComponent(id) {
        return getComponent(id) !== null
    }

    function hasProvider(id) {
        return getProvider(id) !== null
    }

    function markLoaded(id) {
        const component = getComponent(id)

        if (component) {
            component.loaded = true
            componentsChanged()
            return
        }

        const provider = getProvider(id)

        if (provider) {
            provider.loaded = true
            providersChanged()
        }
    }

    function markUnloaded(id) {
        const component = getComponent(id)

        if (component) {
            component.loaded = false
            componentsChanged()
            return
        }

        const provider = getProvider(id)

        if (provider) {
            provider.loaded = false
            providersChanged()
        }
    }

    function setVisible(id, visible) {
        const c = getComponent(id)

        if (!c)
            return

        c.visible = visible
        componentsChanged()
    }

    function isVisible(id) {
        const c = getComponent(id)

        return c ? c.visible : false
    }

    function getComponents() {
        return components
    }

    function getProviders() {
        return providers
    }

    function clearComponents() {
        components = []
        componentsChanged()
    }

    function clearProviders() {
        providers = []
        providersChanged()
    }

    function clear() {
        clearComponents()
        clearProviders()
    }
}
