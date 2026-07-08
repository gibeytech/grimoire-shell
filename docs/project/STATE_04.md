# Grimoire Shell — State 04

## Statut global

Projet : Grimoire Shell

Branche : feature/grimoire-shell

Phase actuelle :

PHASE 1 — Registry Foundation

État :

* PHASE 1.1 — Registry Foundation validée et pushée
* PHASE 1.2 — Module Discovery validée
* PHASE 1.3 — Dependency Resolution à démarrer

---

## Décisions validées

### Grimoire / Grimoire Shell / Hub

Grimoire est l'écosystème global.

Grimoire Shell est la couche d'interface.

Le Hub est une interface d'invocation.

Décision :

```text
Grimoire ≠ Grimoire Shell
Grimoire Shell ≠ Hub
```

---

### Registry

Le Registry est la source de vérité du Shell.

Il connaît :

* modules disponibles
* modules activés

Il expose :

* providers actifs
* actions actives
* composants actifs

Il ne recherche pas.

Il n'exécute pas.

Il n'affiche pas.

---

### ModuleManager

Le ModuleManager orchestre les modules.

Architecture validée :

```text
shell.qml
    ↓
ModuleManager
    ↓
Registry
```

Le bootstrap reste minimal.

---

### Module

Un module est un dossier autonome.

Décision :

```text
Module ≠ Manifest
```

Structure minimale validée :

```text
modules/
└── test
    ├── manifest.js
    └── TestModule.qml
```

---

### Activation

Principe validé :

```text
Disponible ≠ Activé
```

Un module désactivé reste connu du Registry.

---

## Discovery

Discovery automatique :

Non implémentée.

Discovery actuelle :

```text
quickshell/modules/modules.js
```

Liste actuelle :

```js
var modules = [
    "test"
]
```

---

## PHASE 1.2 — Validation

Objectif :

Réduire la connaissance des modules dans shell.qml.

Résultat obtenu :

Avant :

```text
shell.qml
 ├─ connaissait modules.js
 ├─ connaissait test
 └─ connaissait TestManifest
```

Après :

```text
shell.qml
 └─ ModuleManager.registerKnownModules()

ModuleManager
 ├─ connaît les modules déclarés
 └─ enregistre les manifests

Registry
 └─ source de vérité
```

Validation :

* tests OK
* bootstrap OK
* logs conformes
* commit réalisé

Commit :

```text
phase1.2: move module discovery to module manager
```

---

## Validation technique

Commande :

```bash
quickshell -p ~/Projects/GrimoireLab/grimoire-shell/quickshell
```

Logs attendus :

```text
[Grimoire Shell] Bootstrap start
[Registry] Enabled module: test
[Registry] Registered module: test
[Grimoire Shell] Bootstrap complete
```

Le warning portal reste hors périmètre.

---

## Prochaine étape

PHASE 1.3 — Dependency Resolution

Objectif :

Améliorer progressivement la gestion des dépendances des modules sans complexifier prématurément l'architecture.

