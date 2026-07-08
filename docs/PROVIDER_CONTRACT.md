# Grimoire Shell — Provider Contract

Version : 0.1

---

# Objectif

Définir le contrat commun à tous les Providers de Grimoire Shell.

Un Provider est une source de résultats.

Il ne possède aucune logique d'affichage.

Il ne lance aucune action.

Il décrit uniquement des résultats.

---

# Pipeline

Provider
        ↓
ProviderResult[]
        ↓
Hub
        ↓
Action System

---

# Responsabilités

Un Provider :

- recherche des informations
- construit des ProviderResult
- applique éventuellement un score
- ne connaît jamais le Hub

---

# Ne doit jamais

- créer des composants QML
- ouvrir une fenêtre
- exécuter une commande
- connaître les autres Providers

---

# Contrat

Chaque Provider expose :

results(query)

qui retourne :

ProviderResult[]

---

# Invariants

- indépendant
- testable
- déclaratif
- réutilisable

# Grimoire Shell — PROVIDER_CONTRACT

## Objectif

Définir le rôle d'un Provider dans Grimoire Shell.

Un Provider expose des résultats interrogeables par le Hub ou toute autre interface d'invocation.

Il décrit des capacités.
Il ne gère pas l'interface.
Il n'orchestre pas le Shell.

---

## Principe

Un Provider appartient à un module.

Un module peut déclarer zéro, un ou plusieurs providers dans son manifest.

Le Core ne doit jamais connaître les providers concrets.

---

## ProviderDescriptor

Format minimal :

```js
{
    id: "applications",
    source: "providers/ApplicationsProvider.qml"
}
