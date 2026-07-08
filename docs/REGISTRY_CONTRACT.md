# REGISTRY_CONTRACT.md

# Grimoire Shell — Registry Contract

## Statut

Document de fondation.

Version : 0.3

---

# Objectif

Définir le rôle du Registry dans Grimoire Shell.

Le Registry est la source de vérité du Shell.

Il connaît :

* les modules disponibles
* les modules activés

Le Registry ne remplace pas les modules, les providers ou l'Action System.

---

# Principe fondamental

    Le Registry sait.
    Les modules fournissent.
    Les providers recherchent.
    L'Action System exécute.
    Le Hub invoque.

---

# Responsabilités

Le Registry est responsable de :

* l'inventaire des modules
* l'activation des modules
* la désactivation des modules
* la consultation de l'état des modules
* l'exposition des providers actifs
* l'exposition des actions actives
* l'exposition des composants actifs

---

# Ce que le Registry connaît

Le Registry maintient deux inventaires.

Modules disponibles :

    availableModules

Modules activés :

    enabledModules

Principe :

    Disponible ≠ Activé

Un module peut être connu du Shell sans être actif.

---

# Enregistrement des modules

Le Registry n'enregistre pas directement des composants.

Le Registry enregistre des manifestes de modules.

Principe :

    Module ≠ Manifest

    Le manifest décrit le module.

Chaque manifest doit posséder au minimum :

* id
* name
* version

---

# Découverte des modules

La découverte automatique complète n'est pas encore implémentée.

Pendant la PHASE 1, Grimoire Shell utilise une découverte manuelle centralisée.

Le fichier :

    quickshell/modules/modules.js

déclare les modules connus du Shell.

Principe actuel :

    modules.js
        ↓
    manifest.js
        ↓
    ModuleManager
        ↓
    Registry

Cette approche permet de stabiliser le modèle avant d'ajouter un scan automatique du disque.

La découverte automatique sera étudiée après validation du modèle de module.

---

# Activation des modules

L'activation d'un module doit :

* vérifier que le module existe
* vérifier qu'il n'est pas déjà actif
* vérifier ses dépendances minimales

Puis :

* l'ajouter à enabledModules

---

# Désactivation des modules

La désactivation d'un module doit :

* le retirer des modules actifs
* préserver les autres modules

Un module désactivé reste connu du Registry.

---

# Dépendances

Un module peut déclarer :

    dependencies

Le Registry vérifie uniquement leur présence.

La résolution avancée des dépendances fera l'objet d'une phase ultérieure.

---

# Providers

Les providers ne sont pas enregistrés directement.

Ils sont exposés par les modules actifs.

Principe :

    Registry
        ↓
    Modules actifs
        ↓
    Providers actifs

---

# Actions

Les actions ne sont pas enregistrées directement.

Elles sont exposées par les modules actifs.

Principe :

    Registry
        ↓
    Modules actifs
        ↓
    Actions actives

---

# Composants

Les composants ne sont pas enregistrés directement.

Ils sont exposés par les modules actifs.

Principe :

    Registry
        ↓
    Modules actifs
        ↓
    Components actifs

---

# Hors périmètre

Le Registry n'est pas responsable :

* de la recherche
* de l'invocation
* de l'exécution d'actions
* de l'interface utilisateur

Ces responsabilités appartiennent respectivement :

* aux Providers
* au Hub
* à l'Action System
* aux composants QML

---

# Résumé

Le Registry est le catalogue central du Shell.

Il sait :

* ce qui existe
* ce qui est actif

Il ne décide pas quoi rechercher.

Il ne décide pas quoi exécuter.

Il ne décide pas quoi afficher.
