// =============================================================================
// Chapitre 4 — Conditions de connexion
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": encadre-important, note-technique, th

= Conditions de connexion

Ce chapitre décrit les conditions de connexion mises en œuvre par notre plateforme pour l'authentification, la sécurisation et l'établissement de la liaison avec la plateforme GUN de la DGDDI.

== Interconnexion GUN

L'interconnexion avec GUN constitue l'étape 2 de la procédure d'agrément. Elle est préalable à la certification informatique PABLO et doit être effective avant l'exécution des scénarios de test.

=== Inscription sur la plateforme GUN

L'opérateur s'inscrit en tant que partenaire sur la plateforme GUN (Guichet Unique Numérique) de la DGDDI, conformément aux spécifications pour les partenaires GUN publiées sur douane.gouv.fr.

Cette inscription comprend :

+ La création d'un compte partenaire sur le portail GUN.
+ La configuration de l'identité de l'opérateur (SIREN, SIRET, informations de contact).
+ L'obtention des identifiants d'accès à l'environnement de recette puis de production.

=== Authentification SSO (Single Sign-On)

L'authentification auprès de GUN s'effectue par un mécanisme de SSO. Notre plateforme implémente le flux d'authentification suivant :

+ *Obtention du jeton d'accès* — Appel au service d'authentification GUN avec les identifiants de l'opérateur (client_id, client_secret) pour obtenir un jeton OAuth2.
+ *Appel aux web services PABLO* — Chaque requête vers les endpoints PABLO inclut le jeton d'accès dans l'en-tête HTTP `Authorization`.
+ *Renouvellement du jeton* — Le jeton est renouvelé automatiquement avant expiration, sans interruption des échanges.

#table(
  columns: (2fr, 3fr),
  table.header(th[Paramètre], th[Valeur]),
  [Méthode d'authentification], [OAuth2 — Client Credentials],
  [Type de jeton], [Bearer Token],
  [En-tête HTTP], [`Authorization: Bearer <token>`],
  [Renouvellement], [Automatique avant expiration],
)

== Sécurisation des échanges

=== Chiffrement TLS

L'ensemble des communications entre notre plateforme et GUN sont chiffrées par TLS (Transport Layer Security).

#table(
  columns: (2fr, 3fr),
  table.header(th[Paramètre], th[Valeur]),
  [Version TLS minimale], [TLS 1.2],
  [Version TLS préférée], [TLS 1.3],
  [Vérification du certificat serveur], [Oui — validation de la chaîne de certificats],
  [Protocoles désactivés], [SSLv3, TLS 1.0, TLS 1.1],
)

=== Certificats

Notre plateforme valide systématiquement le certificat serveur GUN lors de l'établissement de chaque connexion TLS. En cas d'échec de la validation (certificat expiré, chaîne incomplète, nom de domaine non concordant), la connexion est refusée et l'événement est journalisé.

== Configuration du compte API

=== URL de webhook (sens RETOUR)

Pour les échanges dans le sens DGDDI → opérateur, notre plateforme expose des endpoints REST que PABLO appelle via GUN pour transmettre ses réponses. L'URL racine de ces endpoints est déclarée dans le compte API de l'opérateur.

#table(
  columns: (2fr, 3fr),
  table.header(th[Paramètre], th[Valeur]),
  [URL webhook], [#url-webhook],
  [Protocole], [HTTPS (TLS 1.2+)],
  [Disponibilité], [24h/24, 7j/7],
  [Temps de réponse], [< 5 secondes],
)

=== Endpoints exposés

Notre plateforme expose les endpoints suivants pour la réception des messages PABLO :

#table(
  columns: (2fr, 3fr, 2fr),
  table.header(th[Endpoint], th[Description], th[Messages reçus]),
  [`POST /webhooks/pablo/creation`], [Résultat de création de BVE], [`R_AR_C02`, `R_EC_C03`],
  [`POST /webhooks/pablo/creation-secours`], [Résultat de création de BVE de secours], [`R_AR_P02`, `R_EC_P03`],
  [`POST /webhooks/pablo/suppression`], [Résultat de suppression de BVE], [`R_AR_S02`, `R_EC_S03`],
  [`POST /webhooks/pablo/visa-ue`], [Résultat de visa UE], [`R_AR_U02`, `R_EC_U03`],
  [`POST /webhooks/pablo/apurement`], [Demande d'apurement], [`R_E_A01`],
  [`POST /webhooks/pablo/statut`], [Information de statut], [`R_E_IS`],
  [`POST /webhooks/pablo/erreur`], [Erreurs globales], [`R_G001`, `R_G002`],
)

#encadre-important[
  Nos endpoints sont disponibles en permanence. En cas de maintenance planifiée, les messages sont mis en file d'attente côté GUN et traités dès la reprise du service.
]

== Environnements

Notre plateforme dispose de deux environnements distincts :

#table(
  columns: (1fr, 2fr, 2fr),
  table.header(th[Environnement], th[Usage], th[Connexion GUN]),
  [Recette], [Certification PABLO, tests d'intégration], [Environnement de recette GUN],
  [Production], [Exploitation courante], [Environnement de production GUN],
)

#note-technique[
  La version du logiciel utilisée lors de la certification en recette est identique à celle déployée en production, conformément aux exigences de la DGDDI.
]

== Architecture technique envisagée

Notre plateforme repose sur une architecture web moderne, conçue pour la fiabilité des échanges EDI avec PABLO.

=== Composants principaux

#table(
  columns: (2fr, 2fr, 3fr),
  table.header(th[Composant], th[Technologie], th[Rôle]),
  [Serveur applicatif], [Python / FastAPI], [Traitement des messages ALLER et RETOUR, validation JSD, logique métier],
  [Base de données], [PostgreSQL], [Persistance des BVE, vendeurs, transactions, audit trail des messages],
  [File d'attente], [Redis / Celery], [File d'attente des messages à émettre, gestion des reprises et du backoff exponentiel],
  [Serveur webhook], [FastAPI (ASGI)], [Réception des messages RETOUR de PABLO via GUN, disponible 24h/24],
  [Validation JSD], [Pydantic + JSON Schema], [Validation systématique des messages avant émission et à la réception contre le JSD v1.7],
  [Hébergement], [Cloud (infrastructure européenne)], [Serveurs hébergés en Union européenne, conformité RGPD],
)

=== Schéma d'architecture

#figure(
  image("../diagrams/rendered/architecture.png", width: 90%),
  caption: [Architecture technique de la plateforme EDI],
)

=== Principes de conception

- *Persistance avant émission* — Tout message est persisté en base de données avant d'être transmis à GUN. En cas de panne, les messages non acquittés sont réémis à la reprise.
- *Idempotence* — Le traitement des messages RETOUR est idempotent. Un message reçu en doublon (notamment pour l'apurement) produit le même résultat sans effet de bord.
- *Validation stricte* — Les modèles Pydantic reproduisent exactement les contraintes du JSD v1.7 (`additionalProperties: false`, patterns, cardinalités). Un message non conforme est rejeté avant émission.
- *Séparation des environnements* — Les environnements de recette et de production utilisent des bases de données, des configurations et des identifiants GUN distincts.

== Journalisation et traçabilité

L'ensemble des échanges avec GUN/PABLO sont journalisés de manière exhaustive :

- *Messages émis* — Horodatage, identifiant du message, contenu JSON, code de réponse HTTP GUN.
- *Messages reçus* — Horodatage de réception, type de message, contenu JSON, résultat du traitement.
- *Erreurs* — Code erreur, description, message JSON ayant provoqué l'erreur, actions correctives entreprises.
- *Authentification* — Horodatage des obtentions et renouvellements de jetons, échecs d'authentification.

Les journaux sont conservés pendant une durée minimale de 3 ans, conformément aux obligations réglementaires.
