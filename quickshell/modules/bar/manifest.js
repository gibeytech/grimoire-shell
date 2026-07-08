.pragma library

var manifest = {
    id: "bar",
    name: "Bar",
    version: "0.1.0",
    author: "Grimoire",
    description: "Minimal top bar for Grimoire Shell.",
    dependencies: [],
    enabled: true,

    providers: [],

    actions: [],

    components: [
        {
            id: "bar",
            type: "window",
            source: "Bar.qml"
        }
    ],

    config: {}
}
