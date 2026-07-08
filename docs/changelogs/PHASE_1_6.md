# PHASE 1.6 — Runtime Bootstrap

**Statut :** ✅ Validée

---

# Objectif

Supprimer progressivement le couplage direct entre le Shell et les modules afin de préparer un chargement entièrement piloté par le Registry.

La PHASE 1.6 constitue la première étape du Runtime de Grimoire Shell.

---

# Travaux réalisés

## Runtime

Introduction d'une nouvelle couche `Runtime`.

Le Runtime devient le propriétaire des `ComponentDescriptor` enregistrés lors du bootstrap.

Il ne crée pas encore les instances QML mais constitue désormais le point d'entrée du moteur d'exécution.

Architecture obtenue :

```text
Shell
    │
    ▼
ModuleManager
    │
    ▼
Registry
    │
    ▼
Runtime
```

---

## ComponentDescriptor

Le Registry ne retourne plus uniquement les informations du manifest.

Chaque composant est enrichi avec :

* id
* moduleId
* type
* source
* resolvedSource

Exemple :

```json
{
    "id": "hub",
    "moduleId": "hub",
    "type": "window",
    "source": "Hub.qml",
    "resolvedSource": "modules/hub/Hub.qml"
}
```

---

## ComponentLoader

Le ComponentLoader ne connaît plus directement les manifests.

Il charge désormais les composants à partir de leur `resolvedSource`.

Premier chargement dynamique validé.

---

## Hub

Le Hub est désormais chargé dynamiquement.

Le Shell ne crée plus directement la fenêtre du Hub.

Le Hub reste responsable de son interface tandis que son chargement est désormais piloté par le Runtime.

---

# Architecture obtenue

```text
Shell
    │
    ▼
ModuleManager
    │
    ▼
Registry
    │
    ▼
Runtime
    │
    ▼
ComponentLoader
    │
    ▼
modules/hub/Hub.qml
```

Le Shell ne dépend plus directement du Hub.

---

# Résultat

La PHASE 1.6 valide le premier chargement dynamique de composant dans Grimoire Shell.

Les bases du Runtime sont désormais en place.

Cette étape prépare directement la PHASE 1.7, qui consistera à généraliser cette architecture à l'ensemble des futurs modules (Bar, Audio, Network, Clipboard, Power, etc.).

---

# Prochaine étape

PHASE 1.7

Objectif :

Mettre en place un Runtime capable de gérer plusieurs composants de manière totalement générique, sans connaissance des modules métier.

