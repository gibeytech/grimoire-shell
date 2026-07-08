# Grimoire Shell — Roadmap 04

## PHASE 0 — Architecture Foundation

Statut :

VALIDÉE

Documents validés :

* README.md
* ARCHITECTURE.md
* PHASE_0.md
* MIGRATION.md
* MODULE_CONTRACT.md
* REGISTRY_CONTRACT.md

---

## PHASE 1 — Registry Foundation

### PHASE 1.1 — Registry Foundation

Statut :

VALIDÉE

PUSHÉE

Livrables validés :

* Registry
* ModuleManager
* ModuleManifest
* Activation / désactivation
* Dépendances minimales
* Structure de module
* Discovery manuelle centralisée
* Documentation alignée

---

### PHASE 1.2 — Module Discovery

Statut :

VALIDÉE

PUSHÉE

Objectif atteint :

* shell.qml simplifié
* connaissance des modules déplacée vers ModuleManager
* modules.js conservé comme registre déclaratif
* architecture préparée pour une discovery future
* aucun scan automatique prématuré

Livrable principal :

```text
shell.qml
    ↓
ModuleManager
    ↓
Registry
```

---

### PHASE 1.3 — Dependency Resolution

Statut :

À DÉMARRER

Objectif :

Améliorer progressivement la gestion des dépendances.

Travail prévu :

* vérifier dépendances déclarées
* vérifier dépendances activées
* comportement en cas de dépendance absente
* prévention des dépendances circulaires
* documentation des règles

Règle :

Pas de résolution complexe prématurée.

---

### PHASE 1.4 — Premier module Core

Statut :

À FAIRE

Objectif :

Créer le premier module fonctionnel réel.

Candidats possibles :

* hub
* bar
* system

Décision reportée après stabilisation du moteur.

---

## PHASE 2 — Providers Foundation

Objectif :

Créer le moteur de recherche.

Premiers providers :

* ApplicationsProvider
* DocumentationProvider

---

## PHASE 3 — Action System Foundation

Objectif :

Créer le moteur d'exécution.

Livrables :

* ActionDescriptor
* ActionRegistry
* ActionExecution

Principe :

Les providers décrivent.

L'Action System exécute.

---

## PHASE 4 — Hub Foundation

Objectif :

Créer l'interface d'invocation principale.

Rappel :

Le Hub est une interface.

Il n'est pas le cœur technique du Shell.

---

## PHASE 5 — Bar Foundation

Objectif :

Créer l'Ambient Layer.

Référence :

Waybar.

---

## PHASE 6 — Panels / Control Centers

Objectif :

Créer les interfaces à la demande.

Exemples :

* audio
* réseau
* bluetooth
* power
* system

---

## PHASE 7 — Notifications

Objectif :

Évaluer un éventuel remplacement de SwayNC.

Règle :

Remplacement uniquement si gain réel démontré.

---

## PHASE 8 — Session Layer

Objectif :

Étudier le remplacement potentiel de Wlogout.

---

## PHASE 9 — Profil GibeyTech

Objectif :

Créer le profil avancé de référence.

Rappel :

```text
Grimoire Shell ≠ Profil GibeyTech
```

---

## PHASE 10 — Install.sh / Profils utilisateurs

Objectif :

Définir :

* Core
* modules optionnels
* profils utilisateurs
* setup.config()
* install.sh

À ne pas ouvrir maintenant.

---

## Principe permanent

```text
Construire
→ Tester
→ Documenter
→ Valider
→ Push
→ Continuer
```

