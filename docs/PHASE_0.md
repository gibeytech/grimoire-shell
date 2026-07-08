# PHASE_0.md

# Grimoire Shell — PHASE 0

## Nom

Architecture Foundation

---

## Statut

En cours

---

## Objectif

Construire les fondations du projet avant toute implémentation QML.

La PHASE 0 existe pour éviter :

* l'architecture improvisée
* les refontes précoces
* les dépendances circulaires
* la duplication de logique
* les composants impossibles à maintenir

---

# Principe

Aucun composant de production ne doit être développé avant validation de l'architecture.

Cette phase ne produit pas d'interface utilisateur.

Elle produit :

* une vision
* une architecture
* une arborescence
* un plan d'exécution

---

# Livrables

## Documentation

### ARCHITECTURE.md

Décrit :

* l'architecture globale
* les responsabilités
* les couches UX
* le Hub
* les Providers
* le Registry
* l'Action System

Statut :

```text
En cours de validation
```

---

### MIGRATION.md

Décrit :

* la stratégie de migration
* les composants conservés
* les composants remplacés
* les critères de parité fonctionnelle

Statut :

```text
À rédiger
```

---

### README.md

Décrit :

* la vision du projet
* les objectifs
* la philosophie

Statut :

```text
À rédiger
```

---

# Architecture validée

Architecture retenue :

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

# Décisions validées

## Quickshell

Décision :

```text
Retenu
```

---

## AGS

Décision :

```text
Abandonné
```

---

## Hub

Décision :

```text
Le Hub est le cerveau du Shell.
```

---

## Registry

Décision :

```text
Source de vérité du Shell.
```

---

## Providers

Décision :

```text
Extensibles.
```

---

## Action System

Décision :

```text
Les providers décrivent.

L'Action System exécute.
```

---

## shell.qml

Décision :

```text
Bootstrap minimal.
```

---

# Ordre de développement

## Phase 1

Registry Foundation

Objectif :

Créer la source de vérité du Shell.

Livrables :

```text
Registry
Configuration
Chargement des modules
```

---

## Phase 2

Providers Foundation

Objectif :

Créer le système de recherche.

Livrables :

```text
ApplicationsProvider
DocumentationProvider
ProviderResult
```

---

## Phase 3

Action System Foundation

Objectif :

Créer l'exécution des actions.

Livrables :

```text
ActionDescriptor
Action Registry
Action Execution
```

---

## Phase 4

Hub Foundation

Objectif :

Créer le cerveau du Shell.

Livrables :

```text
Recherche
Résultats
Invocation
```

---

## Phase 5

Bar Foundation

Objectif :

Créer la couche ambient.

Livrables :

```text
Workspaces
Horloge
État système essentiel
```

---

## Phase 6

Panels & Control Centers

Objectif :

Créer les interfaces à la demande.

Livrables :

```text
Audio
Réseau
Bluetooth
Système
```

---

## Phase 7

Notifications

Objectif :

Évaluer puis éventuellement remplacer SwayNC.

Livrables :

```text
Notification Center
Notifications
Historique
```

---

## Phase 8

Session Layer

Objectif :

Créer les composants liés à la session.

Livrables :

```text
Wlogout Replacement
Power Actions
Lock Integration
```

---

## Phase 9

Migration

Objectif :

Basculer progressivement les composants existants.

Principe :

```text
Construire
→ Tester
→ Utiliser
→ Valider
→ Migrer
→ Nettoyer
```

---

# Hors périmètre actuel

Les éléments suivants ne sont pas des cibles de remplacement prioritaires :

```text
Hypridle
```

Ces composants seront réévalués après stabilisation du Shell.

---

# Condition de sortie

La PHASE 0 est terminée lorsque :

* ARCHITECTURE.md est validé
* MIGRATION.md existe
* README.md existe
* l'ordre des phases est validé
* l'arborescence est créée

Alors seulement le développement peut commencer.

