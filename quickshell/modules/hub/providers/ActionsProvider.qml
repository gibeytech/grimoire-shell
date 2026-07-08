pragma Singleton

import QtQuick

QtObject {
    id: actionsProvider

    property string name: "actions"

    property var actions: [
        {
            id: "lock",
            title: "Verrouiller",
            subtitle: "Verrouiller la session",
            icon: "system-lock-screen",
            keywords: ["lock", "verrouiller", "session"],
            action: "shell:hyprlock"
        },
        {
            id: "logout",
            title: "Déconnexion",
            subtitle: "Ouvrir le menu de déconnexion",
            icon: "system-log-out",
            keywords: ["logout", "déconnexion", "quitter", "session"],
            action: "shell:wlogout --buttons-per-row 2"
        },
        {
            id: "reboot",
            title: "Redémarrer",
            subtitle: "Redémarrer la machine",
            icon: "system-reboot",
            keywords: ["reboot", "redémarrer", "restart"],
            action: "shell:systemctl reboot"
        },
        {
            id: "shutdown",
            title: "Éteindre",
            subtitle: "Éteindre la machine",
            icon: "system-shutdown",
            keywords: ["shutdown", "poweroff", "éteindre", "arrêter"],
            action: "shell:systemctl poweroff"
        },
        {
            id: "reload-hyprland",
            title: "Recharger Hyprland",
            subtitle: "Recharger la configuration Hyprland",
            icon: "view-refresh",
            keywords: ["reload", "hyprland", "recharger", "config"],
            action: "shell:hyprctl reload"
        },
        {
            id: "notifications",
            title: "Notifications",
            subtitle: "Afficher ou masquer SwayNC",
            icon: "preferences-system-notifications",
            keywords: ["notifications", "swaync", "notif"],
            action: "shell:swaync-client -t"
        }
    ]

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

    function fromAction(action) {
        return {
            id: "action." + action.id,
            provider: name,
            title: action.title,
            subtitle: action.subtitle,
            icon: action.icon,
            keywords: action.keywords || [],
            categories: ["action", "system"],
            score: 0,
            action: action.action
        }
    }

    function matches(result, query) {
        const normalizedQuery = normalize(query)

        if (normalizedQuery.length === 0)
            return false

        return normalize(result.title).includes(normalizedQuery)
            || normalize(result.subtitle).includes(normalizedQuery)
            || arrayContainsMatch(result.keywords, normalizedQuery)
            || arrayContainsMatch(result.categories, normalizedQuery)
    }

    function search(query) {
        let results = []

        for (let i = 0; i < actions.length; i++) {
            const result = fromAction(actions[i])

            if (matches(result, query))
                results.push(result)
        }

        return results
    }
}
