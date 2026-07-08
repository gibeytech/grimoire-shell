# PHASE 1.7 — RuntimeComponent Registry

**Statut :** en cours

---

# Objectif

Faire évoluer le Runtime pour qu'il ne soit plus seulement une liste de composants déclarés, mais un registre de `RuntimeComponent`.

---

# Travaux réalisés

## RuntimeComponent

Chaque composant déclaré par le Registry est désormais transformé en `RuntimeComponent`.

Un `RuntimeComponent` contient :

```text
id
moduleId
type
source
resolvedSource
loaded
visible
instance
```

---

## Suivi du chargement

Le `ComponentLoader` notifie désormais le Runtime lorsqu'un composant est chargé.

Logs validés :

```text
[Runtime] Component loaded: hub
```

---

# Architecture actuelle

```text
Manifest
    ↓
Registry
    ↓
ComponentDescriptor
    ↓
Runtime
    ↓
RuntimeComponent
    ↓
ComponentLoader
    ↓
Instance QML
```

---

# Résultat

Le Runtime commence à devenir le registre vivant du Shell.

Il connaît désormais :

* les composants déclarés ;
* les composants chargés ;
* leur instance QML ;
* leur état de chargement.

---

# Prochaine étape

Ajouter les capacités runtime :

```text
show(componentId)
hide(componentId)
toggle(componentId)
isLoaded(componentId)
```

Cela permettra ensuite de piloter Hub, Bar, Panels et futurs modules depuis une API commune.

