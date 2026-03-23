// =============================================================================
// Chapitre 2 — Standards de communication
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": encadre-important, note-technique, th

= Standards de communication

Ce chapitre décrit les standards de communication mis en œuvre par notre plateforme pour l'ensemble des échanges EDI avec le système PABLO, conformément aux spécifications de la DGDDI.

== Protocole d'échange

L'intégralité des échanges entre notre système et PABLO s'effectue par web services REST via le canal internet, au travers de la plateforme GUN (Guichet Unique Numérique).

#table(
  columns: (2fr, 3fr),
  table.header(th[Paramètre], th[Valeur]),
  [Protocole], [HTTPS (TLS 1.3)],
  [Méthode HTTP], [POST],
  [Format des messages], [JSON],
  [Encodage], [UTF-8],
  [Plateforme d'échange], [GUN — Guichet Unique Numérique],
  [Mode de traitement], [Asynchrone],
)

== Architecture des échanges

Les échanges suivent un modèle asynchrone bidirectionnel :

=== Sens ALLER (opérateur → DGDDI)

L'opérateur publie ses messages en appelant les web services REST exposés par GUN. Après authentification, le message est transmis à PABLO pour traitement asynchrone. Un accusé de réception technique GUN est renvoyé immédiatement ; l'accusé de réception fonctionnel PABLO est transmis ultérieurement.

Les messages ALLER sont identifiés par le préfixe `A_` :
- `A_E_C01` — Création de BVE
- `A_E_P01` — Création de BVE de secours
- `A_E_S01` — Suppression de BVE
- `A_E_U01` — Visa UE
- `A_AR_A02` — Accusé de réception d'apurement (succès)
- `A_EC_A03` — Accusé de réception d'apurement (échec)

=== Sens RETOUR (DGDDI → opérateur)

Pour les échanges inverses, notre système expose des web services REST que PABLO appelle via GUN pour transmettre ses réponses. L'URL de ces endpoints est déclarée dans le compte API de l'opérateur.

Les messages RETOUR sont identifiés par le préfixe `R_` :
- `R_AR_C02` — Création BVE réussie
- `R_EC_C03` — Création BVE échouée
- `R_AR_P02` — Création BVE de secours réussie
- `R_EC_P03` — Création BVE de secours échouée
- `R_AR_S02` — Suppression BVE réussie
- `R_EC_S03` — Suppression BVE échouée
- `R_AR_U02` — Visa UE réussi
- `R_EC_U03` — Visa UE échoué
- `R_E_A01` — Apurement des BVE
- `R_E_IS` — Information de changement de statut (live status)
- `R_G001` — Erreur globale (schéma JSON invalide)
- `R_G002` — Erreur globale applicative (système)

=== Modèle d'accusé de réception

Chaque message ALLER génère un accusé de réception fonctionnel PABLO :

#table(
  columns: (2fr, 2fr, 2fr),
  table.header(th[Message ALLER], th[Succès (AR)], th[Échec (EC)]),
  [`A_E_C01` — Création], [`R_AR_C02`], [`R_EC_C03`],
  [`A_E_P01` — Création secours], [`R_AR_P02`], [`R_EC_P03`],
  [`A_E_S01` — Suppression], [`R_AR_S02`], [`R_EC_S03`],
  [`A_E_U01` — Visa UE], [`R_AR_U02`], [`R_EC_U03`],
  [`R_E_A01` — Apurement], [`A_AR_A02`], [`A_EC_A03`],
)

#note-technique[
  Le message `R_E_IS` (live status) est un message d'information envoyé au fil de l'eau par la DGDDI. Il ne requiert pas d'accusé de réception fonctionnel de la part de l'opérateur.
]

== Format JSON

=== Encodage

Tous les messages échangés sont encodés en UTF-8, conformément aux spécifications PABLO V5.

=== Validation par schéma JSON (JSD)

Notre plateforme intègre les schémas JSON fournis par la DGDDI (JSD v1.7) pour la validation systématique des messages avant émission et à la réception. Ces schémas définissent :

- La structure de chaque type de message (nœuds, feuilles, cardinalité).
- Les types de données attendus (chaînes, entiers, décimaux, dates).
- Les contraintes de validation (patterns, longueurs minimales et maximales, valeurs autorisées).
- Les champs obligatoires et facultatifs.

Les fichiers JSD utilisés sont les suivants :

#table(
  columns: (2fr, 3fr),
  table.header(th[Fichier], th[Description]),
  [`basicdatatype.json`], [Types de données primitifs et simples],
  [`type.json`], [Types composites (voyageur, marchandise, vendeur, transaction, schéma commercial)],
  [`Request_A_E_C01.json`], [Schéma du message de création de BVE],
  [`Request_A_E_P01.json`], [Schéma du message de création de BVE de secours],
  [`Request_A_E_S01.json`], [Schéma du message de suppression de BVE],
  [`Request_A_E_U01.json`], [Schéma du message de visa UE],
  [`Request_R_E_A01.json`], [Schéma du message d'apurement],
  [`Request_R_E_IS.json`], [Schéma du message d'information de statut],
  [`Response_R_AR_C02.json` ... `Response_R_G002.json`], [Schémas des 12 messages de réponse],
)

#encadre-important[
  Lorsqu'un champ facultatif ne contient pas de donnée, la balise correspondante ne doit pas être présente dans le message JSON. La présence d'une balise vide ou composée uniquement d'espaces entraîne un rejet sur contrôle formel (rejet du flux dans son intégralité).
]

== Transmission des messages

=== Cardinalité

Chaque message de création (`A_E_C01`) et de suppression (`A_E_S01`) contient un seul BVE. Les messages d'apurement (`R_E_A01`) et de visa UE (`A_E_U01`) peuvent contenir plusieurs BVE (jusqu'à 100 pour le visa UE).

=== File d'attente

En cas d'indisponibilité de la plateforme d'échange entre GUN et PABLO, les messages sont automatiquement placés dans une file d'attente côté GUN. Les accusés de réception fonctionnels sont transmis lors de la reprise du système.

#note-technique[
  En cas de réception d'un accusé de réception technique GUN sans accusé de réception fonctionnel PABLO, il n'est pas nécessaire de réémettre le message. PABLO a bien reçu le message et le traitera à la reprise.
]
