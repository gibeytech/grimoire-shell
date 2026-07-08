pragma Singleton

import QtQuick

import "../actions" as Actions

QtObject {
    id: providerRegistry

    property var providers: []
    property int applicationsCount: 0

    function registerProvider(provider) {
        if (!provider) {
            return false
        }

        if (hasProvider(provider.name)) {
            return true
        }

        providers.push(provider)
        providersChanged()

        if (provider.name === "applications" && provider.applicationsCount !== undefined) {
            applicationsCount = provider.applicationsCount
        }

        console.log("[ProviderRegistry] Registered provider:", provider.name || "<unnamed>")
        return true
    }

    function hasProvider(name) {
        for (let i = 0; i < providers.length; i++) {
            if (providers[i] && providers[i].name === name) {
                return true
            }
        }

        return false
    }

    function search(query) {
        let results = []

        for (let i = 0; i < providers.length; i++) {
            const provider = providers[i]

            if (!provider || !provider.search) {
                continue
            }

            const providerResults = provider.search(query)

            if (providerResults && providerResults.length > 0) {
                results = results.concat(providerResults)
            }
        }

        return results
    }

    function execute(action) {
        return Actions.ActionExecutor.execute(action)
    }
}
