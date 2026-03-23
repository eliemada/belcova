// =============================================================================
// Chapitre 1 — Introduction
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": encadre-important, th

= Introduction

== Objet du document

Le présent document constitue le dossier de certification de la plateforme EDI de la société #entreprise-nom, conformément aux exigences de l'article 202 E de l'annexe III au Code Général des Impôts et du décret n° 2017-1825 du 28 décembre 2017 relatif à la procédure d'agrément des opérateurs de détaxe.

Ce dossier a pour objectif de démontrer la capacité de notre solution informatique à communiquer avec le système PABLO de la Direction Générale des Douanes et Droits Indirects (DGDDI) au travers de la plateforme GUN (Guichet Unique Numérique), dans le respect des spécifications EDI en vigueur.

Il couvre les quatre domaines requis par l'article 202 E :

+ *Standards de communication* — Protocoles, formats et canaux d'échange utilisés.
+ *Modélisation des messages* — Structure et typage de l'ensemble des messages JSON conformes au JSD v1.7.
+ *Conditions de connexion* — Authentification, sécurité et paramétrage de la liaison avec GUN.
+ *Fonctionnement technique* — Processus de traitement, gestion des erreurs et procédures de secours.

=== Matrice de conformité

Le tableau suivant établit la correspondance entre les exigences de l'article 202 E et les chapitres du présent dossier.

#table(
  columns: (2.5fr, 3fr, 1.5fr),
  table.header(th[Exigence Article 202 E], th[Contenu], th[Référence]),
  [*Standards de communication*], [], [],
  [Protocole d'échange], [HTTPS POST via GUN, JSON UTF-8, traitement asynchrone], [Ch. 2.1],
  [Architecture des échanges], [Modèle bidirectionnel ALLER/RETOUR, 18 types de messages], [Ch. 2.2],
  [Format et validation JSON], [Encodage UTF-8, validation JSD v1.7 systématique], [Ch. 2.3],
  [Cardinalité et file d'attente], [1 BVE par message de création, file d'attente GUN], [Ch. 2.4],
  [*Modélisation des messages*], [], [],
  [Types de données de base], [29 types primitifs conformes à `basicdatatype.json`], [Ch. 3.1],
  [Types composites], [Voyageur, marchandise, vendeur, cause, transaction], [Ch. 3.2],
  [Messages de requête (ALLER)], [A\_E\_C01, A\_E\_P01, A\_E\_S01, A\_E\_U01, R\_E\_A01, R\_E\_IS], [Ch. 3.3],
  [Messages de réponse (RETOUR)], [R\_AR\_C02, R\_EC\_C03, et 10 autres messages], [Ch. 3.4],
  [Messages d'erreur globale], [R\_G001 (schéma), R\_G002 (système)], [Ch. 3.5],
  [Schémas commerciaux], [Mandataire, Achat/Revente, Centre d'Achat], [Ch. 6],
  [*Conditions de connexion*], [], [],
  [Interconnexion GUN], [Inscription partenaire, SSO OAuth2], [Ch. 4.1],
  [Sécurisation des échanges], [TLS 1.3, gestion des certificats], [Ch. 4.2],
  [Configuration du compte API], [URL webhook, endpoints exposés], [Ch. 4.3],
  [Environnements], [Recette et production], [Ch. 4.4],
  [Architecture technique], [Stack technique, hébergement, base de données], [Ch. 4.6],
  [*Fonctionnement technique*], [], [],
  [Création de BVE], [Flux A\_E\_C01, contrôles pré-émission, traitement réponse], [Ch. 5.1],
  [Création de BVE de secours], [Flux A\_E\_P01, attestation papier], [Ch. 5.2],
  [Suppression de BVE], [Flux A\_E\_S01, correction et renvoi], [Ch. 5.3],
  [Visa UE], [Flux A\_E\_U01, conditions de validité], [Ch. 5.4],
  [Apurement], [Flux R\_E\_A01, idempotence, détection doublons], [Ch. 5.5],
  [Information de statut], [Flux R\_E\_IS, mise à jour en temps réel], [Ch. 5.6],
  [Gestion des erreurs], [G001, G002, stratégie de reprise], [Ch. 5.7],
  [Disponibilité et résilience], [Webhooks 24/7, file d'attente, procédure de secours], [Ch. 5.8],
)

== Présentation de la société

#table(
  columns: (1fr, 2fr),
  [Raison sociale], [#entreprise-nom],
  [SIREN], [#entreprise-siren],
  [SIRET (siège)], [#entreprise-siret],
  [N° TVA intracommunautaire], [#entreprise-tva-intra],
  [Adresse], [#entreprise-adresse, #entreprise-code-postal #entreprise-ville],
  [Téléphone], [#entreprise-telephone],
  [Courriel], [#entreprise-email],
  [Site internet], [#entreprise-site-web],
  [Représentant légal], [#representant-nom — #representant-fonction],
  [Contact technique], [#contact-technique-nom — #contact-technique-email],
)

== Contexte réglementaire

La procédure de détaxe permet aux voyageurs résidant hors de l'Union européenne de bénéficier du remboursement de la TVA sur les marchandises achetées en France et exportées dans leurs bagages personnels, sous réserve du respect des conditions prévues aux articles 262 et suivants du Code Général des Impôts.

Le système PABLO (Projet visant à dématérialiser le visa douanier sur les Bordereaux de Vente à l'Exportation) constitue l'infrastructure informatique de la DGDDI permettant la gestion dématérialisée de ces bordereaux.

La procédure d'agrément d'un opérateur de détaxe comprend les étapes suivantes :

+ Recevabilité de la demande par la Direction Générale.
+ Interconnexion GUN (SSO).
+ Certification informatique PABLO.
+ Audit du Service Régional d'Audit (SRA).
+ Réponse définitive de la Direction Générale.

Le présent dossier s'inscrit dans l'étape 3 de cette procédure.

#encadre-important[
  La certification doit se dérouler dans les conditions de la production : pas d'interventions humaines, délais de réponse appropriés. La version du logiciel utilisée lors de la certification doit être identique à celle déployée en production.
]

== Documents de référence

#table(
  columns: (2fr, 1fr, 2fr),
  table.header(th[Document], th[Version], th[Source]),
  [Spécifications fonctionnelles EDI échanges Opérateurs de détaxe — PABLO], [V5.0.1], [DGDDI — juin 2024],
  [Schéma Définition JSON (JSD)], [v1.7], [DGDDI — `PABLO_EDI_JSD_v1.7`],
  [Spécifications pour les partenaires GUN], [—], [douane.gouv.fr],
  [Décret n° 2017-1825 du 28 décembre 2017], [—], [Légifrance],
  [Article 202 E, annexe III au CGI], [—], [Légifrance],
  [Convention d'adhésion Pablo-O], [v2], [DGDDI],
  [Formulaire d'agrément opérateur de détaxe], [v2], [DGDDI],
  [Fiche technique PABLO V2], [—], [DGDDI],
  [Fiche technique — Procédure de secours], [—], [DGDDI],
)

== Historique des versions du document

#table(
  columns: (1fr, 1fr, 3fr, 2fr),
  table.header(th[Version], th[Date], th[Description], th[Auteur]),
  [1.0], [#document-date], [Création initiale du dossier de certification], [#contact-technique-nom],
)

== Terminologie

#table(
  columns: (1fr, 4fr),
  table.header(th[Terme], th[Description]),
  [BVE], [Bordereau de Vente à l'Exportation],
  [EDI], [Échange de Données Informatisé],
  [PABLO], [Système de dématérialisation du visa douanier sur les BVE],
  [DGDDI], [Direction Générale des Douanes et Droits Indirects],
  [GUN], [Guichet Unique Numérique — plateforme d'échange de la DGDDI],
  [JSD], [JSON Schema Definition — schémas de validation des messages],
  [SSO], [Single Sign-On — authentification unique],
  [BVE de secours], [Bordereau créé via la procédure de secours (attestation papier)],
  [Apurement], [Confirmation ou annulation définitive d'un BVE par la DGDDI],
)
