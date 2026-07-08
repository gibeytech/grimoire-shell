pragma Singleton

import Quickshell
import QtQuick

QtObject {
    id: applicationsProvider

    property string name: "applications"
    property int applicationsCount: DesktopEntries.applications.values.length

    function normalize(value) {
        return String(value || "").trim().toLowerCase()
    }

    function arrayContainsMatch(values, query) {
        if (!values)
            return false

        for (let i = 0; i < values.length; i++) {
            if (normalize(values[i]).includes(query))
                return true
        }

        return false
    }

    function fromDesktopEntry(entry) {
        return {
            id: "app." + entry.id,
            provider: name,
            title: String(entry.name || entry.id || "Application"),
            subtitle: String(entry.genericName || entry.comment || "Application"),
            icon: String(entry.icon || ""),
            keywords: entry.keywords || [],
            categories: entry.categories || [],
            score: 0,
            action: "desktop:" + entry.id,
            desktopId: entry.id
        }
    }

    function matches(result, query) {
        const normalizedQuery = normalize(query)

        if (normalizedQuery.length === 0)
            return false

        return normalize(result.title).includes(normalizedQuery)
            || normalize(result.subtitle).includes(normalizedQuery)
            || normalize(result.desktopId).includes(normalizedQuery)
            || arrayContainsMatch(result.keywords, normalizedQuery)
            || arrayContainsMatch(result.categories, normalizedQuery)
    }

    function search(query) {
        let results = []
        const applications = DesktopEntries.applications.values

        for (let i = 0; i < applications.length; i++) {
            const entry = applications[i]
            const result = fromDesktopEntry(entry)

            if (matches(result, query))
                results.push(result)
        }

        return results
    }
}
