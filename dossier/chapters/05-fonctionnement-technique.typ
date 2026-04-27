// =============================================================================
// Chapitre 5 — Fonctionnement technique
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": encadre-important, note-technique, th

= Fonctionnement technique

Ce chapitre décrit le fonctionnement technique de notre plateforme pour chacun des processus d'échange avec PABLO, incluant les flux de traitement, la gestion des erreurs, la logique de reprise et les procédures de secours. Les diagrammes ci-dessous illustrent les trois flux principaux.

#figure(
  image("../diagrams/rendered/flux-creation.png", width: 75%),
  caption: [Diagramme de séquence — Création de BVE (A\_E\_C01)],
)

#figure(
  image("../diagrams/rendered/flux-secours.png", width: 75%),
  caption: [Diagramme de séquence — Procédure de secours (A\_E\_P01)],
)

#figure(
  image("../diagrams/rendered/flux-apurement.png", width: 75%),
  caption: [Diagramme de séquence — Apurement des BVE (R\_E\_A01 → A\_AR\_A02 / A\_EC\_A03)],
)

#note-technique[
  Tant que PABLO n'a pas reçu l'accusé de réception (`A_AR_A02` / `A_EC_A03`), il continue de réémettre le message `R_E_A01` avec les BVE non acquittés. Notre plateforme gère cette situation par idempotence : un BVE déjà traité est acquitté à nouveau sans retraitement.
]

#figure(
  image("../diagrams/rendered/flux-suppression-visa.png", width: 75%),
  caption: [Diagramme de séquence — Suppression de BVE (A\_E\_S01) et visa UE (A\_E\_U01)],
)

== Processus de création de BVE (A_E_C01)

=== Description du flux

+ L'opérateur de détaxe saisit ou importe les données du BVE (voyageur, marchandises, schéma commercial, transaction).
+ Notre plateforme valide les données localement contre le JSD `Request_A_E_C01.json` avant émission.
+ Le message `A_E_C01` est transmis à GUN via HTTPS POST.
+ GUN réceptionne le message et le transmet à PABLO pour traitement asynchrone.
+ PABLO effectue un contrôle du format et du contenu.
+ En cas de succès : le message `R_AR_C02` est renvoyé avec l'`identifiant_bve` attribué par PABLO (préfixe `FR`).
+ En cas d'échec : le message `R_EC_C03` est renvoyé avec le code erreur et la description du problème.

=== Contrôles effectués avant émission

Notre plateforme effectue les contrôles suivants avant l'envoi du message :

- *Contrôle formel* — Validation intégrale du JSON contre le JSD v1.7 (structure, types, cardinalité, patterns).
- *Contrôle de cohérence* — Vérification que le montant TTC correspond à la somme des montants des marchandises, que le montant de TVA est cohérent avec le taux de TVA appliqué.
- *Contrôle des champs facultatifs* — Les champs facultatifs sans valeur ne sont pas inclus dans le JSON (pas de balises vides).
- *Unicité de l'identifiant* — L'`identifiant_detaxe` est généré de manière unique (préfixe à 2 chiffres attribué par la DGDDI, suivi de 18 à 22 caractères alphanumériques).

=== Traitement de la réponse

#table(
  columns: (1fr, 1fr, 3fr),
  table.header(th[Réponse], th[Type], th[Action]),
  [`R_AR_C02`], [Succès], [Le BVE est marqué comme créé. L'`identifiant_bve` PABLO est enregistré. Processus terminé.],
  [`R_EC_C03`], [Échec], [Le BVE est marqué en erreur. L'erreur est analysée, corrigée, et le message est renvoyé.],
  [`R_G001`], [Erreur globale], [Erreur de structure JSON. Le message complet est rejeté. Correction et renvoi requis.],
  [`R_G002`], [Erreur système], [Problème PABLO. Le message est mis en file d'attente pour renvoi ultérieur.],
)

#encadre-important[
  Les données transmises à la DGDDI doivent correspondre strictement aux données imprimées sur le BVE du voyageur. Il ne peut y avoir de correction ou d'annulation par ce biais une fois le message transmis. La suppression (`A_E_S01`) suivie d'un renvoi corrigé est la procédure à suivre en cas d'erreur.
]

== Processus de création de BVE de secours (A_E_P01)

=== Contexte

La procédure de secours est activée lorsque la création de bordereau classique n'est pas disponible (panne de la solution EDI, côté douane ou côté opérateur). L'opérateur récupère alors un numéro d'attestation dans Pablo-Opérateurs et crée une attestation papier à l'attention du voyageur.

=== Description du flux

+ L'opérateur récupère un `identifiant_attestation` (préfixe `AT`) via l'interface Pablo-Opérateurs.
+ L'attestation papier est établie avec les données du BVE.
+ Une fois la connexion rétablie, le message `A_E_P01` est transmis avec l'`identifiant_attestation` en complément des données habituelles du BVE.
+ Le traitement suit le même schéma que la création classique :
  - Succès : `R_AR_P02` avec l'`identifiant_bve_ps` (préfixe `PS`).
  - Échec : `R_EC_P03` avec le motif du rejet.

=== Différences avec la création classique

#table(
  columns: (2fr, 2fr, 2fr),
  table.header(th[Élément], th[Création classique (C01)], th[Création secours (P01)]),
  [Nœud racine], [`creation_bve`], [`creation_bve_secours`],
  [Champ supplémentaire], [—], [`identifiant_attestation` (requis)],
  [Préfixe identifiant PABLO], [`FR`], [`PS`],
  [Réponse succès], [`R_AR_C02`], [`R_AR_P02`],
  [Réponse échec], [`R_EC_C03`], [`R_EC_P03`],
)

== Processus de suppression de BVE (A_E_S01)

=== Description du flux

La suppression est limitée aux cas où l'opérateur a envoyé des données erronées ou incomplètes. L'opérateur procède à la suppression puis à l'envoi des données corrigées.

+ Le message `A_E_S01` est construit avec l'identifiant du BVE à supprimer et la cause de la suppression.
+ L'`identifiant_bve` peut être soit l'identifiant PABLO (`FR...`), soit l'identifiant opérateur.
+ PABLO vérifie l'existence du BVE et procède à la suppression.
+ Succès : `R_AR_S02` — le BVE est supprimé du système.
+ Échec : `R_EC_S03` — le BVE n'a pas pu être supprimé (BVE inexistant, déjà apuré, etc.).

== Processus de visa UE (A_E_U01)

=== Description du flux

+ L'opérateur transmet les BVE ayant obtenu un visa douanier d'un autre État membre de l'UE.
+ Le message peut contenir jusqu'à 100 BVE.
+ Pour chaque BVE, une copie du visa UE en PDF/A encodé en base64 est jointe.
+ PABLO vérifie l'existence de chaque BVE et ses conditions de validité.
+ La réponse peut contenir à la fois des succès (`R_AR_U02`) et des échecs (`R_EC_U03`).

=== Conditions de validité

- Le BVE doit exister dans PABLO.
- Le BVE ne doit pas avoir un statut « ANNULE ».
- Le visa doit être intervenu dans un délai de 6 mois plus le mois en cours.
- Seuls les BVE d'un montant TTC ≥ 50 000 € sont concernés.

== Processus d'apurement (R_E_A01 → A_AR_A02 / A_EC_A03)

=== Description du flux

L'apurement est initié par la DGDDI et transmis quotidiennement à J+1.

+ La DGDDI envoie le message `R_E_A01` contenant la liste des BVE confirmés ou annulés.
+ Notre plateforme réceptionne le message et traite chaque BVE.
+ Pour chaque BVE traité avec succès : inclusion dans la réponse `A_AR_A02`.
+ Pour chaque BVE en échec : inclusion dans la réponse `A_EC_A03` avec la cause.
+ Les deux messages sont envoyés sans délai à la DGDDI.

=== Logique de reprise

#encadre-important[
  Tant que PABLO n'a pas reçu l'accusé de réception de l'opérateur, il continue d'émettre le message d'apurement avec les BVE non acquittés. Le message peut donc contenir des BVE de la veille mais aussi des BVE de jours précédents non encore acquittés.
]

Notre plateforme gère cette situation par :
- *Détection des doublons* — Si un BVE déjà apuré est reçu à nouveau, il est inclus dans `A_AR_A02` sans retraitement.
- *Idempotence* — Le traitement d'un même BVE d'apurement produit toujours le même résultat.

== Processus d'information de statut (R_E_IS)

Le message `R_E_IS` est un message d'information envoyé au fil de l'eau par la DGDDI (toutes les 5 minutes). Il n'appelle pas d'accusé de réception fonctionnel.

Notre plateforme :
+ Réceptionne le message et valide sa structure.
+ Met à jour le statut des BVE concernés dans notre base de données.
+ Journalise l'événement.

#note-technique[
  Ce message est informatif. Le statut définitif est celui de l'apurement (`R_E_A01`). Le message `R_E_IS` permet un suivi anticipé mais le statut peut encore évoluer.
]

== Gestion des erreurs

=== Erreur globale G001 (structure JSON invalide)

Lorsque la structure JSON d'un message émis ne respecte pas le schéma attendu, PABLO renvoie un message `R_G001` contenant un tableau de causes d'erreur. Le message n'est pas traité.

*Notre traitement :*
+ L'erreur est journalisée avec le message JSON d'origine.
+ Le message est analysé pour identifier les champs en erreur.
+ Le message est corrigé et renvoyé.

=== Erreur globale applicative G002 (système)

En cas de difficulté majeure du système PABLO, un message `R_G002` est transmis avec une cause unique.

*Notre traitement :*
+ L'erreur est journalisée.
+ Le message est placé en file d'attente pour renvoi ultérieur.
+ Un mécanisme de reprise avec backoff exponentiel est activé.

=== Stratégie de reprise

#table(
  columns: (2fr, 1fr, 3fr),
  table.header(th[Situation], th[Délai], th[Action]),
  [Erreur fonctionnelle (EC)], [Immédiat], [Correction et renvoi après analyse de la cause],
  [Erreur globale G001], [Immédiat], [Correction du schéma JSON et renvoi],
  [Erreur globale G002], [Progressif], [Backoff exponentiel : 1 min, 2 min, 4 min, ... max. 30 min],
  [Timeout GUN], [5 min], [Mise en file d'attente, renvoi automatique],
  [Absence d'AR fonctionnel], [Aucun], [Pas de renvoi — PABLO a reçu le message et enverra l'AR à la reprise],
)

== Disponibilité et résilience

=== Disponibilité de la plateforme

Notre plateforme est conçue pour une disponibilité 24h/24, 7j/7, avec les garanties suivantes :

- *Endpoints webhook* — Disponibles en permanence pour la réception des messages PABLO.
- *File d'attente interne* — Les messages à émettre sont persistés et envoyés dès que possible.
- *Surveillance* — Monitoring continu des échanges avec alertes en cas d'anomalie.

=== Procédure de secours

En cas d'indisponibilité prolongée de notre plateforme EDI :

+ Les commerçants basculent sur la procédure de secours (attestation papier).
+ Les numéros d'attestation sont récupérés via Pablo-Opérateurs.
+ À la reprise, les BVE de secours sont transmis via le message `A_E_P01`.

#note-technique[
  Les opérations de création, suppression et apurement ne sont pas parallélisées côté PABLO. Toutefois, durant le créneau alloué aux opérations d'apurement (nuit), le processus de création et de suppression reste opérationnel.
]
