.pragma library

var manifest = {
    id: "hub",
    name: "Grimoire Hub",
    version: "0.1.0",
    author: "Grimoire",
    description: "Minimal invocation hub for Grimoire Shell.",
    dependencies: [],
    enabled: true,

    providers: [
        "providers/ApplicationsProvider.qml",
        "providers/ActionsProvider.qml"
    ],

    actions: [],

    components: [
        {
            id: "hub",
            type: "window",
            source: "Hub.qml"
        }
    ],

    config: {}
}
