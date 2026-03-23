RÉPUBLIQUE

FRANÇAISE

Liberté

Égalité

Fraternité

Pablo

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000000_25940e56e64d2db3c4b1d187e67762dd2cab57a0fed632e528a10ddf349f9dc3.png)

## PABLO

A 226

## Spécifications fonctionnelles EDI échanges Opérateurs de détaxe - PABLO

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000001_eb31d8c3b33cac6bc8455bf4c766c3ed107feb4297abcba50d5c9f610cd04c2f.png)

Version 5,0.1 du 06/2024

## DIFFUSION LIMITÉE

## SUIVI DES MODIFICATIONS

| Versions   | Descriptions                                     | Date    |
|------------|--------------------------------------------------|---------|
| 2.0.0      | Refonte Bve                                      | 01/18   |
| 2.0.1      | Mise à jour champ facultatif                     | 03/18   |
| 3.0.0      | Refonte du document                              | 11/19   |
| 3.0.1      | Suppression de la référence au SIRET obligatoire | 09/2020 |
| 4.0.0      | Ajout Flux Visa UE                               | 06/2024 |
| 5.0.0      | Refonte Bve Json / GUN                           | 07/2024 |

## DOCUMENTS LIES

| Versions    | Titres                                                            |
|-------------|-------------------------------------------------------------------|
| 4.0.0       | Specifications_PABLO_Operateurs_v4.odt (version Operateur ↔DGDDI) |
| 1.0.0       | Annexe-1-Format-de-donnees,ods                                    |
| 1.2.0       | Schema_PABLO_JSD_v1.0.zip                                         |
| Douane.gouv | Spécification pour les partenaires GUN                            |

## TERMES UTILISES

| Termes   | Descriptions                                                  |
|----------|---------------------------------------------------------------|
| BVE      | Bordereau de vente à l'exportation                            |
| EDI      | Échange de données informatisé                                |
| PABLO    | Projet qui vise à dématérialiser le visa douanier sur les BVE |
| DGDDI    | Direction Générale des Douanes et Droits Indirects            |
| GUN      | Guichet Unique Numerique                                      |
| JSD      | Json Schema Definition                                        |

## DIFFUSION LIMITÉE

## SOMMAIRE

| INTRODUCTION...............................................................................................................5                                     |                                                                                                                      |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| GÉNÉRALITÉS...................................................................................................................................5                  |                                                                                                                      |
| LES ACTEURS...................................................................................................................................5                  |                                                                                                                      |
| 1 Gun...........................................................................................................................................5                |                                                                                                                      |
| 2 Pablo.........................................................................................................................................5                |                                                                                                                      |
| 3 Opérateurs EDI..........................................................................................................................5                      |                                                                                                                      |
| CERTIFICATION INFORMATIQUE PABLO............................................................................................5                                    |                                                                                                                      |
| 1 Rappel sur la procédure d'agrément............................................................................................5                                |                                                                                                                      |
| 2 Enjeux et objectifs de la certification PABLO.................................................................................6                                |                                                                                                                      |
| PRINCIPES DES ÉCHANGES...............................................................................................................6                           |                                                                                                                      |
| DESCRIPTION DU MACRO-PROCESSUS..........................................................................7                                                        |                                                                                                                      |
| LISTE DES MACRO-PROCESSUS.........................................................................................................7                              |                                                                                                                      |
| MESSAGES UTILISÉS.........................................................................................................................7                      |                                                                                                                      |
| PÉRIODICITÉ ET TYPE DES MESSAGES..............................................................................................8                                  |                                                                                                                      |
| 1 Message de création...................................................................................................................8                        |                                                                                                                      |
| 2 Message de création de secours..................................................................................................8                              |                                                                                                                      |
| 3 Message de suppression.............................................................................................................8                           |                                                                                                                      |
| 4 Message d'apurement.................................................................................................................8                          |                                                                                                                      |
| 5 Message « live status                                                                                                                                          | »...............................................................................................................9    |
| 6 Message « Visa UE »..................................................................................................................9                         |                                                                                                                      |
| PROCESSUS DE CONTRÔLE DE FLUX............................................................................10                                                      |                                                                                                                      |
| CONTEXTE......................................................................................................................................10                 |                                                                                                                      |
| 1 Erreur globale...........................................................................................................................10                    |                                                                                                                      |
| 2 Erreur globale applicative..........................................................................................................10                         |                                                                                                                      |
| SCHÉMA.........................................................................................................................................10                |                                                                                                                      |
| PROCESSUS 'CRÉATION BVE'.......................................................................................11                                                |                                                                                                                      |
| CONTEXTE......................................................................................................................................11                 |                                                                                                                      |
| SCHÉMA.........................................................................................................................................11                |                                                                                                                      |
| DESCRIPTION DU PROCESSUS.........................................................................................................11                              |                                                                                                                      |
| PROCESSUS 'CRÉATION BVE DE SECOURS'.................................................................12                                                           |                                                                                                                      |
| CONTEXTE......................................................................................................................................12                 |                                                                                                                      |
| SCHÉMA.........................................................................................................................................12                |                                                                                                                      |
| DESCRIPTION DU PROCESSUS.........................................................................................................12                              |                                                                                                                      |
| PROCESSUS « SUPPRESSION LISTE DE BVE ».............................................................13                                                            |                                                                                                                      |
| CONTEXTE......................................................................................................................................13                 |                                                                                                                      |
| SCHÉMA.........................................................................................................................................13                |                                                                                                                      |
| DESCRIPTION DU PROCESSUS.........................................................................................................13                              |                                                                                                                      |
| PROCESSUS «VISA UE LISTE DE BVE »........................................................................14                                                      |                                                                                                                      |
| CONTEXTE......................................................................................................................................14                 |                                                                                                                      |
| SCHÉMA.........................................................................................................................................14                |                                                                                                                      |
| DESCRIPTION DU PROCESSUS.........................................................................................................14                              |                                                                                                                      |
| PROCESSUS «APUREMENT LISTE BVE ».......................................................................15                                                        |                                                                                                                      |
| CONTEXTE......................................................................................................................................15                 |                                                                                                                      |
| SCHÉMA.........................................................................................................................................15 DESCRIPTION DU | PROCESSUS.........................................................................................................15 |
| PROCESSUS « INFORMATION STATUTS BVE                                                                                                                              |                                                                                                                      |
|                                                                                                                                                                  | ».............................................................16                                                     |

## DIFFUSION LIMITÉE

| CONTEXTE......................................................................................................................................16                                                                                 |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SCHÉMA.........................................................................................................................................16                                                                                |
| DESCRIPTION DU PROCESSUS.........................................................................................................16                                                                                              |
| MODÉLISATION JSON...................................................................................................17                                                                                                           |
| PRINCIPES DE CONSTRUCTION.......................................................................................................17                                                                                               |
| ENCODAGE DES FICHIERS JSON ......................................................................................................17                                                                                              |
| DÉFINITION DES SCHÉMAS JSON (JSD) ...........................................................................................17                                                                                                  |
| 1 Schéma fonctionnel du message de création A_E_C01................................................................17                                                                                                            |
| 2 Schéma fonctionnel du message de création de secours A_E_P01................................................17                                                                                                                 |
| 3 Schéma fonctionnel du message de suppression A_E_S01...........................................................17                                                                                                              |
| 4 Schéma fonctionnel du message de suppression A_E_U01...........................................................17                                                                                                              |
| 5 Schéma fonctionnel du message d'apurement (succès) A_AR_A02...............................................17                                                                                                                   |
| 6 Schéma fonctionnel du message d'apurement (échec) A_EC_A03................................................17                                                                                                                   |
| MODÈLE GÉNÉRAL DES MESSAGES...............................................................................18 ANNEXES DU DOCUMENT..............................................................................................18 |
| SCHÉMA DÉFINITION JSON - JSD....................................................................................................18                                                                                               |
| EXEMPLE JSON...............................................................................................................................19                                                                                    |
| LES DIFFÉRENTS MESSAGES D'ERREUR...........................................................................................20                                                                                                    |

## INTRODUCTION

## GÉNÉRALITÉS

Ce document comporte toutes les spécifications nécessaires au traitement des messages EDI dans le cadre de PABLO.

Ce document présente l'ensemble des messages fonctionnels qui devront être échangés entre les systèmes d'information mis en place par les opérateurs de détaxe et celui de la DGDDI : PABLO.

## LES ACTEURS

## 1 G UN

L'intégralité des échanges EDI avec Pablo EDI (sens système opérateur EDI vers Pablo et inversement) s'effectuera par web services en REST via le canal internet avec authentification.

## 2 P ABLO

Système informatique permettant aux services douaniers de dématérialiser le cachet délivré à la détaxe dans le cadre de la procédure de vente à l'exportation (remboursement de la TVA).

## 3 OPÉRATEURS EDI

Opérateurs de détaxe transmettant à la DGDDI les bordereaux de vente en détaxe PABLO établis par leurs magasins partenaires. Cet échange s'effectue en EDI, au travers de la plateforme GUN .

## CERTIFICATION INFORMATIQUE PABLO

## 1 RAPPEL SUR LA PROCÉDURE D'AGRÉMENT

La procédure d'agrément d'un opérateur de détaxe prévoit plusieurs étapes distinctes :

1. Recevabilité de la demande par la Direction Générale
2. Interconnexion GUN (SSO)
3. Certification
4. Audit du Service Régional d'Audit (SRA)
5. Réponse définitive de la Direction Générale

## 2 ENJEUX ET OBJECTIFS DE LA CERTIFICATION PABLO

La certification informatique PABLO est un procédé qui permet à la DGDDI de valider la solution informatique de l'opérateur. La DGDDI transmet aux opérateurs le cahier de tests contenant des scénarios à exécuter. L'opérateur exécute les scénarios qui lui sont possibles. À l'issue, l'opérateur atteste sur l'honneur l'exécution ou la non-exécution de ces derniers. Les scénarios non joués devront être justifiés (ex : le logiciel vérifie préalablement un champ, une donnée, etc.).

 Il n'existe pas de corrélation entre le nombre de scénarios joués et l'obtention de la certification.

Des contrôles sur la véracité de l'attestation sur l'honneur seront régulièrement effectués. Une attestation   sur   l'honneur   falsifiée   pourra   entraîner   des   sanctions,   qui   pourront   aller   jusqu'à   la suppression de l'agrément d'opérateur de détaxe, comme prévu au décret n°2017-1825 du 28 décembre 2017.

La certification doit se dérouler dans les conditions de la production (pas d'interventions humaines, délais de réponses appropriés, etc.)

La version du logiciel opérateur utilisée devra être précisée au moment de la certification. Il est  attendu que cette version de certification soit la même que celle qui sera utilisée en production.

Les évolutions techniques PABLO, notamment les modifications concernant le format des échanges, pourront entraîner le passage d'une nouvelle certification. Les opérateurs seront prévenus lorsqu'une nouvelle session de certification sera requise.

## PRINCIPES DES ÉCHANGES

L'intégralité des échanges EDI avec Pablo EDI (sens système opérateur EDI vers Pablo et inversement) s'effectuera par web services en REST via le canal internet.

- HTTPS avec le verbe POST
- Format JSON

La publication des messages pour Pablo EDI consiste à appeler les web services exposés par l'ESB GUN2 suite à une phase d'authentification, puis à recevoir le retour de la bonne prise en compte ou de l'erreur éventuelle.

Le message sera ensuite traité en asynchrone par Pablo EDI.

Pour les échanges inverses, des web services REST doivent aussi être exposés par les systèmes opérateurs EDI. La Douane est en charge d'appeler ces web services exposés.

Le compte API crée par l'opérateur indiquera l'URL que Pablo EDI devra appeler pour pousser ses réponses à l'opérateur.

En plus   de   ces   messages   techniques,   PABLO   met   en   place   un accusé   de   réception fonctionnel qui indique l'état du traitement (succès ou échec).

Voici la cinématique des différents messages fonctionnels :

- Le sens ALLER est celui de l'opérateur vers la DGDDI (libellé = A\_X)
- Le sens RETOUR est celui de la DGDDI vers l'opérateur (libellé = R\_X)

La description des messages utilisés dans le traitement est présentée ci-après.

## DESCRIPTION DU MACRO-PROCESSUS

## LISTE DES MACRO-PROCESSUS

Voici la liste des macro-processus PABLO identifiés. Une description détaillée est proposée dans la suite du document :

| Processus                  |
|----------------------------|
| Erreur Globale PABLO       |
| Création du BVE            |
| Création de BVE de secours |
| Suppression du BVE         |
| Apurement Liste BVE        |
| Information Statuts BVE    |
| Visa UE BVE                |

## MESSAGES UTILISÉS

| Libellé   | Description                                                                                   |
|-----------|-----------------------------------------------------------------------------------------------|
| A_E_C01   | Message de creation de BVE                                                                    |
| R_AR_C02  | Message de rapport 'Accusé de réception RÉUSSITE'suite à un message de création du BVE.       |
| R_EC_C03  | Message de rapport 'Échec de l'intégration de BVE'suite à un message de création du BVE.      |
| A_E_S01   | Message de suppression de BVE                                                                 |
| R_AR_S02  | Message de rapport 'Accusé de réception RÉUSSITE'suite à un message de suppression du BVE.    |
| R_EC_S03  | Message de rapport 'Échec de la suppression de BVE'suite à un message de suppression du BVE.  |
| R_E_A01   | Message d'apurement des BVE                                                                   |
| A_AR_A02  | Message de rapport 'Accusé de réception RÉUSSITE'suite à un message d'apurement des BVE.      |
| A_EC_A03  | Message de rapport 'Échec de l'apurement des BVE' suite à un message d'apurement des BVE.     |
| A_E_U01   | Message du visa européen de Bve                                                               |
| R_AR_U02  | Message de rapport 'Accusé de réception RÉUSSITE'suite à un message de visa européen du BVE.  |
| R_EC_U03  | Message de rapport 'Échec de l'intégration de BVE'suite à un message de visa européen du BVE. |
| R_E_IS    | Message d'information de changement de statut « au fil de l'eau »                             |

Ainsi, un message ALLER sera suivi d'un message RETOUR qui constituera l'accusé de réception fonctionnel.

- Si le traitement du message s'est correctement déroulé, il y aura un message RETOUR de type « AR ».
- Si le traitement du message a échoué, il y aura un message RETOUR de type « EC ».

Pour certains types de messages, il y aura deux messages RETOUR, un de type « AR » et un de type « EC », pour indiquer ce qui a réussi et ce qui a échoué.

 Cette transmission se compose au maximum d'un BVE (bordereau de vente à l'exportation) par message pour la création et la suppression.

 En cas de message d'erreur  reçu,   il   est     impératif     de   renvoyer   le   message, notamment pour le création d'un bordereau.

## PÉRIODICITÉ ET TYPE DES MESSAGES

En cas d'indisponibilité de la plate-forme d'échange entre Gun et PABLO, les messages sont placés dans une file d'attente sur Gun.

 En cas de réception d'un accusé réception technique GUN mais pas d'accusé de réception fonctionnel PABLO, il n'est pas nécessaire de ré-émettre systématiquement un message. Pablo a reçu le message.

Les accusés de réception du traitement fonctionnel PABLO seront envoyés au moment de la prise en charge du message par PABLO lors de la reprise du système.

## 1 MESSAGE DE CRÉATION

Les opérateurs doivent transmettre sans délai tous les BVE créés dans leur système ( un message de création contient un seul BVE ).

## 2 MESSAGE DE CRÉATION DE SECOURS

Les opérateurs doivent transmettre sans délai tous les BVE de secours crée à partir des numéros d'attestations récupérés en cas de panne de la solution EDI (douane ou opérateurs) créés dans leur système ( un message de création contient un seul BVE ).

## 3 MESSAGE DE SUPPRESSION

Les opérateurs doivent transmettre sans délai tous les BVE supprimés dans leur système ( un message de suppression contient un seul BVE ).

## 4 MESSAGE D'APUREMENT

Les messages liés à l'apurement des BVE sont transmis quotidiennement par la DGDDI et contiennent tous les BVE confirmés et annulés dans la journée précédente.

##  Pour le traitement d'apurement il est accepté qu'un message comporte plusieurs BVE.

L'envoi est réalisé à J+1. (J=date de confirmation/annulation des BVE).

PABLO étant à l'origine du message d'apurement, il est demandé à l'opérateur de répondre sans délai via un accusé de réception. Une fois l'accusé de réception reçu par PABLO, le système se chargera d'apurer les bordereaux.

## DIFFUSION LIMITÉE

Tant que le système PABLO n'aura pas reçu un accusé de réception au message d'apurement de la part de l'opérateur, il continuera d'émettre un message d'apurement avec ces bordereaux.

Ainsi, le message d'apurement peut contenir des BVE confirmés et annulés dans la journée précédente   mais   aussi   des   BVE   n'ayant   pas   obtenu   l'accusé   de   réception   au   message d'apurement envoyé précédemment.

Enfin, durant le créneau alloué aux opérations d'apurement, le processus de création et de suppression reste opérationnel. Les deux opérations ne sont toutefois pas parallélisées.

## 5 MESSAGE « LIVE STATUS »

La DGDDI peut envoyer, sur demande de l'opérateur de détaxe, un message d'information concernant l'évolution du statut de ses bordereaux. Cet envoi a lieu toutes les 5 minutes en fonction du besoin.

Cette demande peut être effectuée à tout moment auprès de la Direction Générale des Douanes et Droits Indirects.

## 6 MESSAGE « VISA UE »

Seuls les BVE visés dans un délai de 6 mois plus le mois en cours devront être déposés par le vendeur dans la base de données PABLO EDI. En effet, passé ce délai, le remboursement n'est plus possible.

Lorsque un BVE n'a pas été envoyé dans la base de donnée PABLO, ou lorsque le BVE a déjà obtenu un statut annulé suite à un contrôle en borne ou à un contrôle de nos services, le BVE ne peut plus être validé dans PABLO, ainsi ses BVE ne peuvent pas être transmis dans l'applicatif PABLO pour vérification du cachet douanier apposé par le service douanier d'un autre État membre de l'Union européenne.

Seuls les BVE visés par les services douaniers d'un autre État membre de l'UE (BVE visés ci-après) d'un montant TTC égal ou supérieur à 50 000 euros devront être déposés par le vendeur dans la base de données PABLO EDI.

sd Generale

OPERATEUR

1: Message

## PROCESSUS DE CONTRÔLE DE FLUX

## CONTEXTE

Tous les flux intégrant le système PABLO sont contrôlés. En cas d'erreur globale rencontrée, les   messages   ne   sont   pas   traités   et   un   message   G001   ou   G002   est   envoyé,   détaillant   le problème rencontré ( cf. ci-après ).

## 1 ERREUR GLOBALE

Lorsque le message ne peut être traité suite à une mauvaise structure du schéma JSON, un message de type Erreur Globale (G001) PABLO est transmis à l'opérateur. K

## 2 ERREUR GLOBALE APPLICATIVE

En cas de difficulté majeure du système PABLO et de ses dépendances, celui-ci peut envoyer un message de type Erreur Globale (G002).

## SCHÉMA

DGDDI

## DIFFUSION LIMITÉE

2 : Verification

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000002_0d97f0ffa14793c60f01189f8e6cca8fb3427f9863af20d4556618942894cd9c.png)

sd AEC01

OPERATEUR

1: Message AEC01

Message AEC01

## PROCESSUS 'CRÉATION BVE'

seq Traitement

## CONTEXTE

K-

K

L'opérateur doit s'assurer que les données transmises à la DGDDI correspondent toujours strictement aux données imprimées sur le BVE du voyageur. Il ne peut donc y avoir, par ce biais, de correction ou d'annulation d'une opération, dès lors que celle-ci a été transmise à la DGDDI.

Un traitement réussi d'un message ALLER se traduit par un accusé de réception fonctionnel de type AR contenant le BVE intégré avec succès.

Un traitement   en   échec   d'un   message  ALLER   se   traduit   par   un   accusé   de   réception fonctionnel de type EC contenant le BVE non intégré ainsi que le code erreur associé.

## SCHÉMA

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000003_87549d8d2c8fee5ddb909ee917d391de0a1a1f51b1fd7f9c4e171b9b00ff5658.png)

## DESCRIPTION DU PROCESSUS

- I. Transmettre un BVE : L'opérateur de détaxe transmet le BVE à créer dans le système PABLO. Cette transmission du BVE s'effectue au travers d'un message A\_E\_C01 .
- II.   Recevoir messages : L applicatif GUN réceptionne le(s) message(s) de l'opérateur.
- III. Vérifier messages : Le système PABLO effectue un contrôle du format et du contenu des messages.

Une notification est ensuite envoyée à l'opérateur.

- IV. Notifier   traitement   OK : Le  BVE  valide   est   créé   dans   le   système.   Le   message R\_AR\_C02 est transmis à GUN. Il reprend le BVE créé.
- V. Notifier traitement KO : Le BVE non valide est rejeté et le message R\_EC\_C03 est transmis à GUN. Il reprend le BVE rejeté, en mentionnant la raison de son invalidité.
- VI. Transmettre notifications GUN: PABLO transmet les messages à GUN. ( R\_EC\_C03 en cas de rejet et R\_AR\_C02 en cas de création).
- VII. Transmettre notifications PABLO : GUN transmet les messages aux opérateurs.
5. Pour le BVE contenu dans le message R\_AR\_C02 , le processus est terminé.

Si l'opérateur reçoit un accusé de réception fonctionnel de type R\_EC\_C03, celui-ci devra être renvoyé après correction des erreurs éventuelles afin de terminer le processus de création, sauf si l'erreur rencontrée est due à une création déjà effective du BVE.

GUN

DGDDI

## DIFFUSION LIMITÉE

2 : Verification

sd AEP.01

OPERATEUR

1: Message AEP01

GUN

Message AE PO1

DGDDI

2: Verification

## PROCESSUS 'CRÉATION BVE DE SECOURS'

seq Traitement

## CONTEXTE

Lorsque la création de bordereau classique n'est pas disponible, l'opérateur peut récupérer un numéro d'attestation dans Pablo-opérateurs, et créer une attestation papier à l'attention du voyageur,

Une fois la connexion rétablie, l'opérateur doit s'assurer de transmettre les données   à la DGDDI et qu'elles correspondent toujours strictement aux données de l'attestation sur le BVE du voyageur. Il ne peut donc y avoir, par ce biais, de correction ou d'annulation d'une opération, dès lors que celle-ci a été transmise à la DGDDI.

## SCHÉMA

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000004_2c417ce2f383781c2ca0080675393cafa03ecb46a28e450316fa4c344c432a5f.png)

## DESCRIPTION DU PROCESSUS

- VIII. Transmettre un BVE de secours : L'opérateur de détaxe transmet le BVE à créer dans le système PABLO. Cette transmission du BVE s'effectue au travers d'un message A\_E\_P01 .
- IX. Recevoir messages : L applicatif GUN réceptionne le(s) message(s) de l'opérateur.
- X. Vérifier messages : Le système PABLO effectue un contrôle du format et du contenu des messages.

Une notification est ensuite envoyée à l'opérateur.

- XI. Notifier   traitement   OK : Le  BVE   valide   est   créé   dans   le   système.   Le   message R\_AR\_P02 est transmis à GUN. Il reprend le BVE créé.
- XII. Notifier traitement KO : Le BVE non valide est rejeté et le message R\_EC\_P03 est transmis à GUN. Il reprend le BVE rejeté, en mentionnant la raison de son invalidité.
- XIII. Transmettre notifications GUN: PABLO transmet les messages à GUN. ( R\_EC\_P03 en cas de rejet et R\_AR\_P02 en cas de création).
- XIV. Transmettre notifications PABLO: GUN transmet les messages aux opérateurs.
5. Pour le BVE contenu dans le message R\_AR\_P02 , le processus est terminé.

Si l'opérateur reçoit un accusé de réception fonctionnel de type R\_EC\_P03, celui-ci devra être renvoyé après correction des erreurs éventuelles afin de terminer le processus de création, sauf si l'erreur rencontrée est due à une création déjà effective du BVE .

sd AES01

OPERATEUR

1: Message AES01

Message AES01

## PROCESSUS « SUPPRESSION LISTE DE BVE »

## CONTEXTE

La suppression d'un BVE est limitée aux cas où l'opérateur, suite à des problèmes techniques, a envoyé au système PABLO des données erronées ou incomplètes. Il procède alors à la suppression du BVE concerné puis à l'envoi des données corrigées.

{ Si Message KO: Message R\_EC\_S030 }

## SCHÉMA

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000005_8df8a65f7a9d840500716f92d1963dff182779cc8ecd087edc6d72e62433b251.png)

## DESCRIPTION DU PROCESSUS

- I. Transmettre liste BVE : l'opérateur   de   détaxe   transmet   le   BVE   à   supprimer.   Cette transmission de BVE s'effectue au travers d'un message A\_E\_S01 .
- II. Recevoir messages : L'applicatif GUN réceptionne le(s) message(s) de l'opérateur.
- III. Vérifier messages : le système PABLO effectue un contrôle sur l'existence du numéro de BVE. Si le message est valide, il traite et supprime le BVE contenu dans ce message.

Une notification est ensuite envoyée à l'opérateur.

- IV. Notifier traitement OK : Le BVE valide est supprimé dans le système. Le message R\_AR\_S02 est transmis à l'opérateur. Il renvoie le BVE correctement traité.
- V. Notifier traitement KO : Le BVE non valide est rejeté et le message R\_EC\_S03 est transmis   à   l'opérateur.   Il  renvoie  le   BVE   rejeté,   en   mentionnant   la   raison   de   son invalidité.
- VI. Transmettre notifications GUN: PABLO transmet les messages à GUN.( R\_EC\_S03 en cas de rejet et R\_AR\_S02 en cas de suppression).
- VII. Transmettre notifications PABLO: GUN transmet les messages aux opérateurs.

Pour les BVE contenu dans le message R\_AR\_S02 , le processus est terminé.

Si l'opérateur reçoit un accusé de réception fonctionnel de type R\_EC\_S03, celui-ci devra être renvoyé après correction des erreurs éventuelles afin de terminer le processus de suppression, sauf si l'erreur rencontrée est due à une absence du BVE dans PABLO.

GUN

DGDDI

sd AEU01

OPERATEUR

1 : Message AEU01

## PROCESSUS «VISA UE LISTE DE BVE »

## CONTEXTE

Seuls les BVE visés dans un délai de 6 mois plus le mois en cours devront être déposés par le vendeur dans la base de données PABLO EDI. En effet, passé ce délai, le remboursement n'est plus possible.

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000006_c5c0176a35e1c2d4827909445aa6b198cb2eb6c51b48c84945b72b58217a4199.png)

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000007_f5b475c1bc09617e7ea5bf7dc0a6910c5f180c99b0e3c9837d6436524dbec600.png)

## DESCRIPTION DU PROCESSUS

- I. Transmettre liste BVE : l'opérateur de détaxe transmet le BVE visé par un pays de l'union européenne. Cette transmission de BVE s'effectue au travers d'un message A\_E\_U01 .
- II. Recevoir messages : L'applicatif GUN réceptionne le(s) message(s) de l'opérateur.
- III. Vérifier messages : le système PABLO effectue un contrôle sur l'existence du numéro de BVE et ses conditions de validité. Si le message est valide, il le traite,

Une notification est ensuite envoyée à l'opérateur.

- IV. Notifier traitement OK : Le BVE valide est mis à jour dans le système. Le message R\_AR\_U02 est transmis à l'opérateur. Il renvoie le BVE correctement traité.
- V. Notifier traitement KO : Le BVE non valide est rejeté et le message R\_EC\_U03 est transmis   à   l'opérateur.   Il  renvoie  le   BVE   rejeté,   en   mentionnant   la   raison   de   son invalidité.
- VI. Transmettre notifications GUN: PABLO transmet les messages à GUN.( R\_EC\_U03 en cas de rejet et R\_AR\_U02 en cas de mise à jour).
- VII. Transmettre notifications PABLO: GUN transmet les messages aux opérateurs.
5. Pour les BVE contenu dans le message R\_AR\_U02 , le processus est terminé.

Si l'opérateur reçoit un accusé de réception fonctionnel de type R\_EC\_U03, celui-ci devra être renvoyé après correction des erreurs éventuelles afin de terminer le processus de suppression, sauf si l'erreur rencontrée est due à une absence du BVE dans PABLO.

GUN

DGDDI

## DIFFUSION LIMITÉE

•

2: Verification

sd REA01

DGDDI

1: Message AEA01

## PROCESSUS «APUREMENT LISTE BVE »

## CONTEXTE

Toutes les nuits, la DGDDI transmet aux opérateurs la liste des BVE à apurer.

[SI messagelnexploitable] : Erreur globale

## SCHÉMA

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000008_e7d27b474ebe417d3483b305d801aee5f3eb2a35b28aeb44f1081806a289973a.png)

## DESCRIPTION DU PROCESSUS

- I. Transmettre   liste   BVE : La   DGDDI   transmet   la   liste   des   BVE   à   apurer.   Cette transmission de BVE s'effectue au travers d'un message R\_E\_A01 .
- II. Recevoir messages : L'applicatif GUN réceptionne le(s) message(s) de l'opérateur.
- III. Vérifier messages : Le système PABLO effectue un contrôle du format et du contenu des messages.
- IV. Notifier  traitement   OK : Le BVE valide est apuré dans  le système. Le  message A\_AR\_A02 est transmis à GUN.
- V. Notifier   traitement   KO : Le   BVE   n'est   pas   apuré   dans   le   système. Le   message A\_EC\_A03 est transmis à GUN.
- VI. Transmettre notifications GUN: PABLO transmet les messages à GUN.( A\_EC\_A03 en cas de rejet et A\_AR\_A02 en cas d'apurement).
- VII. Transmettre notifications PABLO : GUN transmet les messages aux opérateurs.

Une ou plusieurs notifications sont ensuite envoyées à l'opérateur (KO et/ou OK).

Pour les BVE contenus dans le message A\_AR\_A02 , le processus est terminé.

Si l'opérateur reçoit un accusé de réception fonctionnel de type A\_EC\_A03, celui-ci devra être renvoyé après correction des erreurs éventuelles afin de terminer le processus d'apurement, sauf si l'erreur rencontrée est due à un apurement déjà effectif d'un ou plusieurs BVE.

GUN

OPERATEUR

## DIFFUSION LIMITÉE

2 : Verificatior

sd REA01

DGDDI

GUN

OPERATEUR

## DIFFUSION LIMITÉE

## PROCESSUS « INFORMATION STATUTS BVE »

## CONTEXTE

L'apurement des statuts des bordereaux confirmés ou annulés est effectué par un batch nocturne à J+1. Ce système ayant des limites fonctionnelles, il a été décidé de le compléter par un envoi « au fil de l'eau » des statuts.

Le   nouveau   système   collecte   régulièrement   les   bordereaux   ayant   acquit   un   statut « ANNULE » ou « CONFIRME » afin de les transmettre par EDI aux opérateurs concernés.

Attention, ce message est un message d'information et le statut peut toujours faire l'objet d'une modification suite à contrôle par exemple.

## SCHÉMA

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000009_cee034bfcf13eada799b4006efa1978bc07db69270cbc651ad197b5b34793e76.png)

## DESCRIPTION DU PROCESSUS

- I. Constitution\_Message\_R\_E\_IS : Le système PABLO collecte les bordereaux qui ont été confirmés ou annulés depuis le dernier envoi et génère un message JSON R\_E\_IS constitué des informations relatives à ces bordereaux.
- II. Envoi\_Message\_R\_E\_IS : Le système PABLO procède à l'envoi du message R\_E\_IS via L'applicatif GUN et n'attend pas d'accusé réception fonctionnel PABLO de la part de l'opérateur de détaxe.

La base légale de consultation des statuts des bordereaux étant Pablo-Opérateurs.  Ce service est maintenu afin de  conserver le fonctionnement actuel des solutions opérateurs, à terme, ce service sera remplacé par une solution plus appropriée.

## MODÉLISATION JSON

## PRINCIPES DE CONSTRUCTION

Chaque schéma décrit un type de message donné. Nous définissons donc un type de schémas par message. Ces schémas décrivent la structure du JSON et les types des données à saisir.

Nous définissons également des types de données simples qui précisent le format des informations   basé   sur   un   type   de   données   primitif   défini.   L'utilisation   de   ces   schémas permettra à l'expéditeur de valider avant l'envoi la structure générale des fichiers JSON.

Dans la suite du document, on parlera de « flux JSON ».

## ENCODAGE DES FICHIERS JSON

L'encodage attendu des fichiers JSON est l' « UTF-8 ».

## DÉFINITION DES SCHÉMAS JSON (JSD)

Il existe un fichier mis en place pour l'en-tête (GUN), commun à l'ensemble des types de flux défini dans les spécifications GUN.

Cette   définition   est   complétée   par   un   autre   fichier  JSON  propre   à   chacun   des   flux « ALLER » (A\_E\_C01, A\_E\_P01, A\_E\_S01, A\_AR\_A02 , A\_E\_A03 ou A\_E\_U01). Il permet de définir la structure et le type de contenu des différents flux JSON.

Ce schéma permet notamment de vérifier la validité du flux Json.

On distinguera deux types de contrôles :

- Le contrôle formel des feuilles inclus le respect du fichier JSD, le type et la cardinalité. Le non-respect du contrôle formel induit le rejet du flux  dans son intégralité.
- Le non-respect du contrôle de cohérence induit le rejet du seul bordereau incriminé.

Lorsque la cardinalité est facultative, en cas d'absence de donnée. Il est attendu que la balise   ne   soit   pas   présente.   La   présence   d'une   balise   sans   donnée   ou   composée uniquement d'une chaîne d'espaces induira un rejet sur contrôle formel (rejet du flux dans son intégralité).

## 1 SCHÉMA FONCTIONNEL DU MESSAGE DE CRÉATION A\_E\_C01

Cf. Annexe-1-Formats-de-donnees.ods#Request\_A\_E\_C01

- 2 SCHÉMA FONCTIONNEL DU MESSAGE DE CRÉATION DE SECOURS A\_E\_P01

Cf. Annexe-1-Formats-de-donnees.ods#Request\_A\_E\_P01

- 3 SCHÉMA FONCTIONNEL DU MESSAGE DE SUPPRESSION A\_E\_S01

Cf.  Annexe-1-Formats-de-donnees.ods#Request\_A\_E\_S01

- 4 SCHÉMA FONCTIONNEL DU MESSAGE DE SUPPRESSION A\_E\_U01

Cf. Annexe-1-Formats-de-donnees.ods#Request\_A\_E\_U01

- 5 SCHÉMA FONCTIONNEL DU MESSAGE D'APUREMENT (SUCCÈS) A\_AR\_A02

Cf.  Annexe-1-Formats-de-donnees.ods#Request\_A\_AR\_A02

- 6 SCHÉMA FONCTIONNEL DU MESSAGE D'APUREMENT (ÉCHEC) A\_EC\_A03

Cf.  Annexe-1-Formats-de-donnees.ods#Request\_A\_EC\_A03

## DIFFUSION LIMITÉE

## MODÈLE GÉNÉRAL DES MESSAGES

Modèle propre au protocole Gun + messages Pabloe:

- A\_E\_C01
- A\_AR\_A02
- A\_E\_S01
- A\_E\_A03
- A\_E\_U01

## ANNEXES DU DOCUMENT

## SCHÉMA DÉFINITION JSON  - JSD

Différents JSD sont fournis et permettent de créer les flux « Aller ». Les fichiers JSD sont disponibles sur douane.gouv.fr.

Il est fortement recommander  de créer vos fichiers à l'aide de ces schémas.

Les schémas peuvent evolués indépendamment des exemple ci-dessous.

- basicdatatype.json définit les type primitifs et simples particuliers.
- Request.json définit la structure racine, elle est composée de plusieurs schema au choix ( A\_E\_C01,  A\_E\_S01, A\_AR\_A02,  A\_E\_A03  ou  A\_E\_U01  )
- A\_E\_C01.json
- A\_E\_S01.json
- A\_EC\_A03.json
- A\_AR\_A02.json
- A\_E\_U01.json

![Image](out2/Pablo_Specifications_EDI_Operateurs_V5_artifacts/image_000010_6350d88ecd5460b7217c408a12fb4766495b82b1f5c697f9ab5ae3bb590934fa.png)

{

```
"creation_bve": { "identifiant_detaxe": "12345678901234567890", "date_emission": "2024-06-19T09:47:53.591+02:00", "voyageur": { "passeport": "XXX", "date_expiration_passeport": "01/10/1944", "nom_voyageur": "John", "prenom_voyageur": "Doe", "date_naissance": "01/10/2044", "adresse": "0", "pays_residence": "XX", "nationalite": "XX" }, "schema_commercial": { "type_schema": 1, "detail_schema": { "vendeurs_md": { "vendeur_detaxe": { "identifiant_vendeur": "0123456789123", "nom_vendeur": "XXXX" }, "numero_ticket": "X65X0", "date_recu": "2024-06-19T09:47:53.591+02:00", "marchandises": [ { "description": "XXXX", "type": "XXXXX", "marque": "0XXXXX3" "numero_identification": "XX156X", "couleur": "XXXX", "code_produit": 21654984, "quantite": 21654984, "taux_tva": 21654984, "montant_ttc": 1256.02, "montant_tva": 1256.02 }, { "description": "0", "type": "0", …. } ] } } }, "transaction": { "montant_remboursement": 1256.02, "montant_total_tva": 1256.02, "montant_total_ttc": 1256.02, "mode_paiement": 1, "detail_paiement": "XXX", "mode_remboursement": 1, "detail_remboursement": "XXX" } } }
```

## EXEMPLE JSON

Il existent des solutions en ligne ou téléchargeable afin de generer les exemple des Json attendus à l'aide des schéma fournis.

## DIFFUSION LIMITÉE

## DIFFUSION LIMITÉE

## LES DIFFÉRENTS MESSAGES D'ERREUR

Le  tableau   suivant   recense   les   erreurs   non   exhaustives,   qui   peuvent   être   signalées   à l'opérateur et archivées à la DGDDI, justifiant ainsi l'échec d'une opération (hors message technique de communication - cf. documentation GUN).

Les codes erreurs  peuvent être repris dans plusieurs flux, la liste n'est pas exhaustive.

Cf. Annexe-1-Formats-de-donnees.ods#Code\_error