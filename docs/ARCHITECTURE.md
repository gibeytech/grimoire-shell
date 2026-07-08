# ARCHITECTURE.md

# Grimoire Shell — Architecture

## Statut

Document de fondation.

Version : 0.3

Branche :

```text
feature/grimoire-shell
```

État :

```text
PHASE 0 — Architecture Foundation
```

Aucun code QML de production ne doit être écrit avant validation complète de cette architecture.

---

# Vision

Grimoire Shell est la couche d'interface du projet Grimoire.

L'objectif n'est pas de créer un desktop spectaculaire.

L'objectif est de créer un environnement :

* cohérent
* maintenable
* modulaire
* documentable
* extensible
* accessible aux francophones

---

# Philosophie

Workflow avant esthétique.

Architecture avant implémentation.

Documentation avant complexité.

Optimisation avant remplacement.

Le vide est une qualité.

---

# Invariant fondamental

Le Labo d'un cyber alchimiste.

Créer un environnement où :

* tout est disponible
* rien n'est imposé

L'utilisateur ne doit jamais subir son environnement.

Il doit pouvoir invoquer ce dont il a besoin lorsqu'il en a besoin.

---

# Principes fondamentaux

## Principe n°1

```text
Installé ≠ Affiché
```

Une fonctionnalité peut être installée sans être visible.

---

## Principe n°2

```text
Disponible ≠ Activé
```

Une fonctionnalité peut être disponible sans être activée.

---

## Principe n°3

```text
Construire
→ Tester
→ Utiliser
→ Valider
→ Migrer
→ Nettoyer
```

Aucun composant existant ne sera supprimé avant parité fonctionnelle.

---

# Décision technologique

AGS :

```text
Abandonné
```

Quickshell :

```text
Retenu
```

Architecture cible :

```text
Hyprland       → Lua
Grimoire Shell → QML
```

---

# Architecture générale

## Modèle retenu

```text
Service-first
Component-driven
```

---

## Flux global

```text
Configuration
        ↓

Registry
        ↓

Services
        ↓

Providers
        ↓

ProviderResults
        ↓

Action System
        ↓

Hub Core
        ↓

Components
```

---

# Point d'entrée Quickshell

Le point d'entrée du shell est :

```text
quickshell/shell.qml
```

---

## Rôle

Le fichier `shell.qml` ne doit jamais devenir un fichier massif.

Il agit comme un bootstrap.

Responsabilités :

* charger la configuration
* initialiser le registry
* charger les modules activés
* démarrer le shell

---

## Modèle

```text
shell.qml
    ↓
Configuration
    ↓
Registry
    ↓
Modules activés
```

---

## Décision

```text
shell.qml = bootstrap minimal

modules/* = logique d'interface
```

---

# Configuration

La configuration définit ce que souhaite l'utilisateur.

Elle doit être :

* lisible
* documentable
* explicite
* modifiable

---

## Principe

La représentation interne peut être technique.

La représentation exposée à l'utilisateur doit être compréhensible.

Exemple utilisateur :

```text
Applications    [ON]
Documentation   [ON]
Obsidian        [ON]
Git             [OFF]
Docker          [OFF]
```

---

# Registry

Le Registry représente l'inventaire de Grimoire Shell.

Il connaît :

* les modules disponibles
* les modules activés
* les providers disponibles
* les providers activés
* les actions disponibles

---

## Modèle

Le Registry est hybride.

Il peut détecter ce qui existe.

La configuration décide ce qui est activé.

---

## Principe

```text
Disponible ≠ Activé
```

Exemple :

```text
DockerProvider
Disponible : Oui
Activé     : Non
```

---

# Services

Les services représentent les interactions système.

Ils portent :

* l'état
* les données
* la logique
* les interactions système

Ils ne gèrent jamais l'interface.

---

## Exemples

```text
services/
├── hyprland/
├── audio/
├── network/
├── bluetooth/
├── power/
├── notifications/
└── clipboard/
```

---

# Providers

Les providers alimentent le Hub.

Le Hub ne connaît pas directement les données.

Il interroge les providers disponibles.

---

## Exemples

```text
ApplicationsProvider
DocumentationProvider
ClipboardProvider
RecentProvider

ObsidianProvider
GitProvider
DockerProvider
ProxmoxProvider
```

---

## Capacités

Un provider peut fournir :

* des résultats
* des actions

Les actions restent optionnelles.

---

## Structure conceptuelle

```text
Provider
├── search()
└── actions() [optionnel]
```

---

## Extensibilité

Les providers sont extensibles.

Un utilisateur doit pouvoir ajouter un provider sans modifier le cœur du Hub.

---

# ProviderResult

Les providers retournent des objets riches.

Le Hub ne manipule pas des chaînes de caractères simples.

---

## Structure

```text
ProviderResult
├── id
├── type
├── title
├── description
├── icon
├── provider
├── score
├── actions[]
└── metadata
```

---

## Types possibles

```text
application
action
document
clipboard
recent
git
obsidian
system
```

---

## Objectif

Permettre :

* recherche
* tri
* catégorisation
* actions rapides
* évolution future

sans modifier les providers.

---

# Action System

L'Action System exécute les actions.

Les providers décrivent.

L'Action System exécute.

---

## Modèle

```text
Provider
        ↓

ProviderResult
        ↓

ActionDescriptor
        ↓

Action System
        ↓

Execution
```

---

## Structure conceptuelle

```text
ActionDescriptor
├── id
├── label
├── description
├── icon
├── type
├── command
├── provider
└── metadata
```

---

## Exemples

```text
open_application
open_document
run_command

toggle_bluetooth

copy_clipboard_entry

open_obsidian_note
create_obsidian_note

open_git_project
```

---

# Hub Core

## Définition

Le Hub est le cerveau de Grimoire Shell.

Il ne s'agit pas d'un simple launcher.

Il constitue le point d'invocation principal du système.

---

## Raccourci cible

```text
SUPER + G
```

---

## Mission

Le Hub permet :

* rechercher
* lancer
* exécuter
* naviguer
* invoquer

depuis un point d'entrée unique.

---

## Vision UX

Le Hub est composé de :

### Barre de recherche

Élément principal.

Toujours au centre.

---

### Zone d'invocation

Permet l'accès rapide à :

* Applications
* Documentation
* Actions
* Système
* Récents

---

## Recherche

La recherche est unifiée.

L'utilisateur recherche une intention.

Il ne recherche pas dans une catégorie.

---

## Exemple

```text
obsidian
```

peut retourner :

```text
Application
Documentation
Action
Historique
Résultat récent
```

---

## Présentation

Décision non figée.

Deux prototypes seront testés.

### Prototype A

```text
Liste plate
```

### Prototype B

```text
Résultats catégorisés
```

---

## Décision

```text
Architecture validée

UX à expérimenter
```

---

# Architecture UX

Grimoire Shell repose sur trois couches.

---

## Ambient Layer

Couche persistante.

Calme.

Discrète.

---

### Exemple

```text
Bar
```

---

### Mission

Afficher uniquement :

* workspaces
* heure
* date
* état système essentiel

---

## Invocation Layer

Couche centrale.

---

### Exemple

```text
Hub
```

---

### Mission

Permettre :

* recherche
* navigation
* actions
* orchestration

---

## Ephemeral Layer

Couche temporaire.

---

### Exemples

```text
Popups
Panels
Overlays
Control Centers
```

---

### Mission

Apparaître à la demande.

Disparaître ensuite.

Ne jamais devenir un dashboard permanent.

---

# Components

Les composants représentent l'interface.

Ils portent :

* affichage
* interaction
* composition visuelle

Ils ne portent pas la logique métier.

---

## Exemples

```text
components/
├── bar/
├── hub/
├── notifications/
├── controls/
└── common/
```

---

# Modules

Les modules représentent des fonctionnalités complètes.

Ils orchestrent :

* services
* providers
* actions
* composants

---

## Exemples

```text
modules/
├── hub/
├── bar/
├── system/
└── notifications/
```

---

# Workspaces

Les workspaces ne sont pas des rôles.

Les workspaces ne sont pas des workflows.

Les workspaces ne sont pas des applications.

Les workspaces sont des espaces mentaux temporaires.

Ils restent sous la responsabilité d'Hyprland.

Le Hub ne doit jamais imposer leur organisation.

---

# Références fonctionnelles

Références actuelles :

```text
Waybar
Rofi
SwayNC
```

Elles restent les références fonctionnelles.

Aucune suppression avant parité fonctionnelle.

---

# Arborescence cible

```text
grimoire-shell/
├── README.md
├── docs/
│   ├── PHASE_0.md
│   ├── ARCHITECTURE.md
│   └── MIGRATION.md
│
├── quickshell/
│   └── shell.qml
│
├── config/
│   ├── providers.qml
│   ├── modules.qml
│   └── shell.qml
│
├── registry/
│
├── services/
├── providers/
├── actions/
├── components/
├── modules/
│
├── theme/
├── assets/
└── scripts/
```

---

# Distribution

Grimoire Shell est livré complet.

Les fonctionnalités sont désactivables.

L'utilisateur retire ce qu'il ne souhaite pas utiliser.

---

## Principe

```text
Présent mais désactivable
```

---

# Critères de validation

Un composant est validé uniquement si :

* la parité fonctionnelle est atteinte
* les binds sont préservés
* le workflow n'est pas dégradé
* la documentation existe
* le rollback est possible
* l'usage réel valide la solution

---

# Direction long terme

Grimoire Shell doit pouvoir exister comme projet autonome.

Il doit devenir une plateforme extensible.

Il doit permettre à chacun de s'approprier son environnement.

L'objectif n'est pas de remplacer des outils.

L'objectif est de réduire l'entropie tout en améliorant l'expérience utilisateur.

