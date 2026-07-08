# README.md

# Grimoire Shell

> Une couche d'interface cohérente pour Hyprland construite avec Quickshell.

---

# Statut

🚧 En développement

Phase actuelle :

```text
Architecture Foundation
```

Branche principale du chantier :

```text
feature/grimoire-shell
```

---

# Pourquoi Grimoire Shell ?

Grimoire Shell est né d'un constat simple.

Les environnements Hyprland modernes reposent souvent sur une accumulation d'outils spécialisés :

```text
Waybar
Rofi
SwayNC
Wlogout

CSS
JSONC
Rasi
Bash

et de nombreux scripts
```

Chaque outil est excellent individuellement.

Mais leur accumulation augmente :

* la charge mentale
* la complexité de maintenance
* la difficulté de documentation
* la fragmentation de l'architecture

---

# Vision

Grimoire Shell n'a pas pour objectif de créer un desktop spectaculaire.

Son objectif est de créer un environnement :

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

```text
Tout est disponible.
Rien n'est imposé.
```

L'utilisateur ne doit jamais subir son environnement.

Il doit pouvoir invoquer les informations et les outils lorsqu'il en a besoin.

---

# Ce que Grimoire Shell n'est pas

Grimoire Shell n'est pas :

* un rice
* une démonstration technique
* une collection de widgets
* un dashboard permanent

Le projet privilégie :

```text
Calme
Clarté
Cohérence
```

---

# Architecture

Architecture générale :

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

# Le Hub

Le Hub est le cerveau du Shell.

Il constitue le point d'entrée principal du système.

Objectif :

```text
Rechercher
Lancer
Naviguer
Exécuter
Invoquer
```

depuis un point unique.

Raccourci cible :

```text
SUPER + G
```

---

# UX

Grimoire Shell repose sur trois couches.

## Ambient Layer

Couche persistante.

Discrète.

Exemple :

```text
Bar
```

---

## Invocation Layer

Couche centrale.

Exemple :

```text
Hub
```

---

## Ephemeral Layer

Couche temporaire.

Exemples :

```text
Panels
Popups
Control Centers
Notifications
```

---

# Migration

Le projet est développé en parallèle de l'environnement existant.

Principe :

```text
Construire
→ Tester
→ Utiliser
→ Valider
→ Migrer
→ Nettoyer
```

Aucun composant existant n'est supprimé avant validation de son remplaçant.

---

# Technologies

```text
Hyprland
Lua
Quickshell
QML
```

---

# État du projet

Fondations validées :

* Architecture
* Migration
* Contrat des modules
* Phase 0

Prochain objectif :

```text
Registry Foundation
```

---

# Objectif long terme

Construire une plateforme d'interface cohérente permettant aux utilisateurs de s'approprier leur environnement sans subir une architecture complexe.

L'objectif n'est pas de remplacer des outils.

L'objectif est de réduire l'entropie tout en améliorant l'expérience utilisateur.

---

# Licence

À définir.

