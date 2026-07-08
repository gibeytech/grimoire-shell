# Grimoire Shell — ProviderResult Contract

Version : 0.1

---

# Objectif

Définir le format unique des résultats manipulés par le Hub.

Tous les Providers retournent exclusivement des ProviderResult.

Le Hub n'a jamais connaissance de l'origine des données.

---

# Structure

ProviderResult

id

provider

title

subtitle

icon

keywords

score

action

---

# Description

id

Identifiant unique.

provider

Nom du Provider ayant créé le résultat.

title

Titre principal.

subtitle

Texte secondaire.

icon

Nom d'icône.

keywords

Liste utilisée pour la recherche.

score

Pertinence calculée.

action

Action à transmettre à l'Action System.

---

# Invariants

Tous les Providers retournent exactement cette structure.
