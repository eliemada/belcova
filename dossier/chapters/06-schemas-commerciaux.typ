// =============================================================================
// Chapitre 6 — Schémas commerciaux
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": jsd-table, encadre-important, note-technique, th

= Schémas commerciaux

Le système PABLO prend en charge trois schémas commerciaux distincts, identifiés par le champ `type_schema` du nœud `schema_commercial`. Ce chapitre décrit en détail la structure de chaque schéma et les différences de modélisation.

== Vue d'ensemble

#table(
  columns: (1fr, 1fr, 3fr),
  table.header(th[type\_schema], th[Désignation], th[Description]),
  [1], [Mandataire], [L'opérateur agit en tant que mandataire d'un vendeur unique. Un seul vendeur par BVE.],
  [2], [Achat/Revente], [L'opérateur achète les marchandises au vendeur et les revend au voyageur. Factures bidirectionnelles requises. Un ou plusieurs vendeurs.],
  [3], [Centre d'Achat], [L'opérateur est un centre d'achat regroupant plusieurs vendeurs sous une même enseigne. Un ou plusieurs vendeurs.],
)

Le schéma commercial est sélectionné par le champ `type_schema` selon le mécanisme `oneOf` du JSD :

```json
"schema_commercial": {
  "oneOf": [
    { "$ref": "type.json#/$defs/mandataire" },
    { "$ref": "type.json#/$defs/achat_revente" },
    { "$ref": "type.json#/$defs/centre_achat" }
  ]
}
```

== Schéma 1 — Mandataire

=== Contexte

Dans le schéma Mandataire, l'opérateur de détaxe agit pour le compte d'un vendeur unique. Le vendeur conserve la relation commerciale avec le voyageur ; l'opérateur gère uniquement la procédure de détaxe.

=== Structure JSON

```json
{
  "type_schema": 1,
  "detail_schema": {
    "vendeurs_md": {
      "vendeur_detaxe": { ... },
      "marchandises": [ ... ]
    }
  }
}
```

=== Champs du nœud `detail_schema`

#jsd-table(
  [vendeurs_md], [vendeur_md], [Oui], [1], [Objet unique (pas un tableau). Contient le vendeur et ses marchandises.],
)

`additionalProperties: false`

=== Structure de `vendeur_md`

#jsd-table(
  [vendeur_detaxe], [vendeur], [Oui], [1], [Données du vendeur (SIRET, nom, ticket, date). Cf. @vendeur],
  [marchandises], [array of marchandise], [Oui], [1..n], [Liste des articles achetés. Cf. @marchandise],
)

`additionalProperties: false`

#encadre-important[
  Dans le schéma Mandataire, `vendeurs_md` est un *objet unique* (pas un tableau), contrairement aux schémas Achat/Revente et Centre d'Achat où `vendeurs_ar` et `vendeurs_ca` sont des tableaux.
]

== Schéma 2 — Achat/Revente

=== Contexte

Dans le schéma Achat/Revente, l'opérateur achète les marchandises au vendeur d'origine puis les revend au voyageur. Ce schéma requiert des informations de facturation supplémentaires : la facture de l'opérateur vers le vendeur et la facture du vendeur vers l'opérateur.

=== Structure JSON

```json
{
  "type_schema": 2,
  "detail_schema": {
    "vendeurs_ar": [
      {
        "vendeur_detaxe": { ... },
        "marchandises": [ ... ]
      }
    ]
  }
}
```

=== Champs du nœud `detail_schema`

#jsd-table(
  [vendeurs_ar], [array of vendeur_ar], [Oui], [1..n], [Tableau de vendeurs avec factures. Un ou plusieurs vendeurs par BVE.],
)

`additionalProperties: false`

=== Structure de `vendeur_ar`

#jsd-table(
  [vendeur_detaxe], [vendeur_avec_facture], [Oui], [1], [Données du vendeur *avec facturation*. Cf. @vendeur-facture],
  [marchandises], [array of marchandise], [Oui], [1..n], [Liste des articles],
)

`additionalProperties: false`

=== Champs supplémentaires de `vendeur_avec_facture`

Par rapport au vendeur standard, le type `vendeur_avec_facture` ajoute quatre champs obligatoires :

#table(
  columns: (2fr, 2fr, 3fr),
  table.header(th[Champ], th[Type JSD], th[Description]),
  [`numero_facture`], [`type_strictalphanumeric50`], [Numéro de facture de l'opérateur vers le vendeur],
  [`date_recu_f`], [`type_zonedatetime`], [Date de cette facture],
  [`numero_facture_bussiness`], [`type_strictalphanumeric50`], [Numéro de facture du vendeur vers l'opérateur],
  [`date_recu_f_bussiness`], [`type_zonedatetime`], [Date de cette facture],
)

#note-technique[
  L'orthographe `bussiness` (avec double 's') est celle du JSD officiel v1.7 de la DGDDI. Notre plateforme utilise exactement cette orthographe pour assurer la conformité.
]

== Schéma 3 — Centre d'Achat

=== Contexte

Le schéma Centre d'Achat s'applique lorsque l'opérateur est un centre commercial ou un regroupement de commerces. Le centre d'achat est identifié par son propre SIRET et regroupe un ou plusieurs vendeurs.

=== Structure JSON

```json
{
  "type_schema": 3,
  "detail_schema": {
    "identifiant_ca": "01234567891234",
    "nom_ca": "Centre Commercial Exemple",
    "vendeurs_ca": [
      {
        "vendeur_detaxe": { ... },
        "marchandises": [ ... ]
      }
    ]
  }
}
```

=== Champs du nœud `detail_schema`

#jsd-table(
  [identifiant_ca], [type_siret], [Oui], [1], [SIRET du centre d'achat — 14 caractères],
  [nom_ca], [typealphanumeric50], [Oui], [1], [Nom du centre d'achat, max. 50 car.],
  [vendeurs_ca], [array of vendeur_ca], [Oui], [1..n], [Tableau des vendeurs du centre],
)

`additionalProperties: false`

=== Structure de `vendeur_ca`

#jsd-table(
  [vendeur_detaxe], [vendeur], [Oui], [1], [Données du vendeur standard (SIRET, nom, ticket, date). Cf. @vendeur],
  [marchandises], [array of marchandise], [Oui], [1..n], [Liste des articles],
)

`additionalProperties: false`

== Tableau comparatif des trois schémas

#table(
  columns: (2.5fr, 2fr, 2fr, 2fr),
  table.header(th[Caractéristique], th[Mandataire (1)], th[Achat/Revente (2)], th[Centre d'Achat (3)]),
  [Nœud vendeurs], [`vendeurs_md`], [`vendeurs_ar`], [`vendeurs_ca`],
  [Type de nœud], [Objet unique], [Tableau], [Tableau],
  [Type de vendeur], [`vendeur`], [`vendeur_avec_facture`], [`vendeur`],
  [Champs facture], [Non], [Oui (4 champs)], [Non],
  [Identifiant du centre], [Non], [Non], [Oui (`identifiant_ca`, `nom_ca`)],
  [Nombre de vendeurs], [1], [1..n], [1..n],
)
