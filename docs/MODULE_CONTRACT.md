# MODULE_CONTRACT.md

# Grimoire Shell — Module Contract

## Statut

Document de fondation.

Version : 0.2

Phase :

```text
Architecture Foundation
```

---

# Objectif

Définir ce qu'est un module dans Grimoire Shell.

Le module est l'unité fonctionnelle fondamentale du Shell.

Le Registry ne manipule pas directement des composants ou des providers isolés.

Le Registry manipule des modules.

---

# Philosophie

Grimoire Shell doit pouvoir grandir sans devenir monolithique.

Chaque fonctionnalité importante doit être encapsulée dans un module.

Un module représente une capacité complète du système.

---

# Principe fondamental

```text
Registry
    ↓
Modules
    ↓
Providers
    ↓
Actions
    ↓
Components
```

Un module peut contenir :

* des providers
* des actions
* des composants
* de la configuration
* des services associés

---

---

# Structure d'un module

Un module Grimoire Shell est un dossier autonome.

Le manifeste n'est pas le module.

Le manifeste décrit le module.

Le module contient la logique associée à cette capacité.

Structure minimale :

```
modules/
└── example
    ├── manifest.js
    └── ExampleModule.qml
```

Structure complète possible :

```
modules/
└── example
    ├── manifest.js
    ├── ExampleModule.qml
    ├── providers/
    ├── actions/
    ├── components/
    └── config/
```

Principe :

```
Module ≠ Manifest

Manifest = entrée déclarative du module
```

Le Registry enregistre des manifestes.

Le ModuleManager orchestre les modules.

---


# Module Manifest

Chaque module doit exposer un manifeste.

Structure conceptuelle :

```text
ModuleManifest
├── id
├── name
├── version
├── author
├── description
├── dependencies
├── enabled
├── providers
├── actions
├── components
└── config
```

---

# Champs obligatoires

## id

Identifiant technique unique.

Exemples :

```text
hub
bar
system
notifications
session
obsidian
git
docker
proxmox
```

---

## name

Nom lisible du module.

Exemples :

```text
Hub
Bar
System
Notifications
Obsidian
Git
Docker
```

---

## version

Version du module.

Exemple :

```text
0.1.0
```

---

## author

Auteur du module.

Exemples :

```text
Grimoire
gibeytech
community
```

---

## description

Description courte du rôle du module.

Exemple :

```text
Unified search and invocation engine.
```

---

## dependencies

Liste des dépendances nécessaires.

Exemple :

```text
clipboard
hyprland
actions
```

Un module ne doit pas être chargé si ses dépendances obligatoires sont absentes.

---

## enabled

Indique si le module est activé.

Principe :

```text
Disponible ≠ Activé
```

---

## providers

Liste des providers déclarés par le module.

Exemple :

```text
ApplicationsProvider
DocumentationProvider
ObsidianProvider
```

---

## actions

Liste des actions déclarées par le module.

Exemple :

```text
open_application
open_document
create_obsidian_note
```

---

## components

Liste des composants QML fournis.

Exemple :

```text
HubModule.qml
BarModule.qml
ObsidianPanel.qml
```

---

## config

Configuration spécifique au module.

La configuration doit être :

* lisible
* documentable
* désactivable

---

# Types de modules

## Core Modules

Modules fondamentaux du Shell.

Ils font partie de Grimoire Shell.

Exemples :

```text
hub
bar
system
notifications
session
```

---

## Optional Modules

Modules distribués avec Grimoire Shell mais non obligatoires.

Exemples :

```text
obsidian
git
docker
proxmox
homeassistant
```

---

## User Modules

Modules ajoutés par l'utilisateur.

Objectif :

```text
Ajouter des capacités
sans modifier le cœur du Shell
```

---

# Responsabilités

## Le module fournit

* providers
* actions
* composants
* configuration

---

## Le Registry fournit

* découverte
* inventaire
* activation
* désactivation

---

## Le Hub fournit

* recherche
* invocation
* navigation

---

## L'Action System fournit

* exécution
* orchestration
* sécurité

---

# Exemple conceptuel

```text
ObsidianModule
├── manifest
├── providers
│   └── ObsidianProvider
├── actions
│   ├── open_note
│   └── create_note
├── components
│   └── ObsidianPanel.qml
└── config
```

---

# Exemple Hub

```text
HubModule
├── manifest
├── providers
│   ├── ApplicationsProvider
│   └── DocumentationProvider
├── actions
│   └── search
├── components
│   └── HubModule.qml
└── config
```

---

# Exemple Bar

```text
BarModule
├── manifest
├── providers
├── actions
├── components
│   └── BarModule.qml
└── config
```

---

# Règles

Un module doit être compréhensible seul.

Un module doit pouvoir être documenté seul.

Un module ne doit pas casser le Shell s'il est désactivé.

Un module ne doit pas exécuter directement des actions complexes.

Un module peut déclarer des actions.

L'Action System reste responsable de leur exécution.

Un module peut déclarer des providers.

Le Hub reste responsable de leur invocation.

---

# Direction long terme

Le système de modules doit permettre à Grimoire Shell de devenir extensible.

L'objectif est que le Shell puisse évoluer :

* sans devenir monolithique
* sans multiplier les dépendances cachées
* sans casser les workflows existants

Le module constitue la frontière entre :

* le cœur du Shell
* les fonctionnalités optionnelles
* les extensions utilisateur
* les futurs modules communautaires

````

---

**Après celui-ci, je pense qu'on a les quatre documents fondateurs :**

```text
ARCHITECTURE.md
PHASE_0.md
MIGRATION.md
MODULE_CONTRACT.md
````

Et honnêtement, on est à un point où on peut commencer à préparer le **premier vrai contrat logiciel du Registry**, c'est-à-dire définir ce que le Registry va réellement charger au démarrage.

