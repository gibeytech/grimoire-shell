# MIGRATION.md

# Grimoire Shell — Stratégie de migration

## Statut

Document de fondation.

Version : 0.2

---

# Objectif

Définir les règles de migration entre l'environnement actuel Grimoire V2 et Grimoire Shell.

Ce document existe pour éviter :

* les régressions
* les pertes de fonctionnalités
* les remplacements prématurés
* les réécritures inutiles
* les ruptures de workflow

---

# Vision

Grimoire Shell n'est pas un remplacement immédiat de l'environnement actuel.

Grimoire Shell est développé en parallèle de Grimoire V2.

L'objectif est de construire un Shell complet avant toute bascule majeure.

---

# Principe fondamental

Grimoire Shell ne remplace pas des outils.

Grimoire Shell remplace des interfaces lorsqu'un gain réel est démontré.

---

# Règle absolue

Nous ne faisons jamais :

```text
Supprimer
→ Reconstruire
→ Espérer
```

Nous faisons :

```text
Construire
→ Tester
→ Utiliser
→ Valider
→ Migrer
→ Nettoyer
```

---

# Mode de développement

Le projet est développé en mode :

```text
Développement + Test
```

Pendant toute la durée du chantier :

* Waybar reste disponible
* Rofi reste disponible
* SwayNC reste disponible
* Wlogout reste disponible
* Hyprlock reste disponible
* Hypridle reste disponible

Grimoire Shell est exécuté en parallèle.

---

# Règle anti-trou de workflow

Aucune étape du projet ne doit créer un trou dans le workflow quotidien.

L'utilisateur doit toujours conserver :

* une barre fonctionnelle
* un launcher fonctionnel
* des notifications fonctionnelles
* un menu de session fonctionnel
* un lock screen fonctionnel
* une gestion idle fonctionnelle

Le chantier Grimoire Shell ne doit jamais empêcher le travail quotidien.

---

# Gestion des binds

Pendant le développement :

Les binds existants restent prioritaires.

Exemples :

```text
SUPER+SPACE
SUPER+R
SUPER+V
SUPER+SHIFT+Q
```

continuent d'utiliser les outils actuels.

Les nouvelles fonctions Grimoire Shell utilisent des binds de test temporaires.

Exemple :

```text
SUPER+ALT+G
SUPER+ALT+P
```

---

# Bascule finale

La migration définitive n'a lieu qu'à la fin du projet.

Conditions :

* Hub validé
* Bar validée
* Panels validés
* Notifications validées
* Session Layer validé
* Documentation terminée

Alors seulement :

```text
Waybar
Rofi
SwayNC
Wlogout
```

pourront être remplacés.

Les binds définitifs seront alors mis à jour.

---

# État actuel de référence

L'environnement de référence est :

```text
Grimoire V2
```

Basé sur :

```text
Hyprland
Waybar
Rofi
SwayNC
Wlogout
Hyprlock
Hypridle
```

Cet environnement reste la référence fonctionnelle pendant tout le chantier.

---

# Classification des composants

## Catégorie A — Remplacement prévu

### Waybar

Statut :

```text
Cible de migration
```

Motif :

```text
Ambient Layer
```

---

### Rofi

Statut :

```text
Cible de migration
```

Motif :

```text
Hub Core
```

---

### Wlogout

Statut :

```text
Cible de migration
```

Motif :

```text
Session Layer
```

---

# Catégorie B — Évaluation nécessaire

### SwayNC

Statut :

```text
À évaluer
```

Motif :

```text
Le gain réel doit être démontré.
```

---

# Catégorie C — Conservation actuelle

### Hypridle

Statut :

```text
Conservé
```

Motif :

```text
Service mature
```

Aucune cible de remplacement à ce stade.

---

### Hyprlock

Statut :

```text
Conservé
```

Motif :

```text
Aucune valeur ajoutée démontrée.
```

Réévaluation éventuelle après stabilisation du Shell.

---

# Phases de migration

## Étape 1

Architecture

Objectif :

```text
Créer les fondations.
```

Aucune migration.

---

## Étape 2

Registry

Providers

Action System

Objectif :

```text
Créer le moteur.
```

Aucune migration.

---

## Étape 3

Hub

Objectif :

Créer un Hub fonctionnel.

Équivalent actuel :

```text
Rofi
```

Mode :

```text
Parallèle
```

---

## Étape 4

Bar

Objectif :

Créer une Ambient Layer fonctionnelle.

Équivalent actuel :

```text
Waybar
```

Mode :

```text
Parallèle
```

---

## Étape 5

Panels & Control Centers

Objectif :

Créer les interfaces à la demande.

Aucune suppression.

---

## Étape 6

Notifications

Objectif :

Évaluer le remplacement de SwayNC.

Condition :

```text
Parité démontrée.
```

---

## Étape 7

Session Layer

Objectif :

Créer :

```text
Power Actions
Logout UI
Session Controls
```

Équivalent actuel :

```text
Wlogout
```

Mode :

```text
Parallèle
```

---

## Étape 8

Migration finale

Objectif :

Basculer l'environnement vers Grimoire Shell.

Conditions :

* parité fonctionnelle
* stabilité validée
* usage quotidien validé
* documentation terminée

---

# Critères de parité

Un composant n'est considéré comme remplaçable que si :

* toutes les fonctions utiles sont présentes
* le workflow est préservé
* les performances sont acceptables
* la stabilité est validée
* plusieurs jours d'utilisation réelle ont été réalisés

---

# Critères de suppression

Un composant existant ne peut être retiré que lorsque :

* la parité est atteinte
* la stabilité est validée
* le rollback n'est plus nécessaire
* la documentation existe

---

# Rollback

Chaque étape doit pouvoir être annulée.

Principe :

```text
Rollback possible à tout moment.
```

Aucune migration irréversible n'est autorisée.

---

# Vision long terme

L'objectif n'est pas de remplacer l'écosystème Hyprland.

L'objectif est de construire une couche cohérente au-dessus de celui-ci.

Grimoire Shell doit intégrer lorsque cela apporte une valeur réelle.

Il doit conserver lorsqu'une solution existante reste la meilleure option.

