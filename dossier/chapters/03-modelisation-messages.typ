// =============================================================================
// Chapitre 3 — Modélisation des messages
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": jsd-table, encadre-important, note-technique, th

= Modélisation des messages

Ce chapitre décrit la structure de l'ensemble des messages échangés entre notre plateforme et le système PABLO, conformément au JSD v1.7. Pour chaque message, nous présentons la structure JSON attendue ainsi que les contraintes de validation champ par champ.

== Types de données de base (basicdatatype.json)

L'ensemble des types primitifs utilisés dans les messages PABLO sont définis dans le fichier `basicdatatype.json`. Notre plateforme implémente et valide chacun de ces types.

#{
  set text(size: 9pt)
  table(
    columns: (3fr, 1fr, 5fr),
    table.header(th[Type JSD], th[Type], th[Contraintes]),
    [typealphanumeric], [string], [Min. 1 car. Pattern : `^[a-zA-Z0-9]+[...]*$`],
    [type_strict_alphanumeric], [string], [Min. 1 car. Pattern : `^[a-zA-Z 0-9]+$`],
    [type_strictalpha], [string], [Lettres uniquement. Pattern : `^[a-zA-Z]+$`],
    [typealphanumeric500], [string], [typealphanumeric, max. 500 car.],
    [typealphanumeric200], [string], [typealphanumeric, max. 200 car.],
    [typealphanumeric50], [string], [typealphanumeric, max. 50 car.],
    [type_alphanumeric30], [string], [typealphanumeric, max. 30 car.],
    [type_strictalphanumeric500], [string], [type_strict_alphanumeric, max. 500 car.],
    [type_strictalphanumeric200], [string], [type_strict_alphanumeric, max. 200 car.],
    [type_strictalphanumeric50], [string], [type_strict_alphanumeric, max. 50 car.],
    [type_strictalphanumeric30], [string], [type_strict_alphanumeric, max. 30 car.],
    [type_strictalphanumeric20to24], [string], [type_strict_alphanumeric, 20–24 car.],
    [type_strictalphanumeric4to24], [string], [type_strict_alphanumeric, 4–24 car.],
    [typenumeric], [integer], [Entier positif ou nul (≥ 0)],
    [typenumericdecimal], [number], [Max. 9 999 999,99. Multiple de 0,01 (2 déc.)],
    [typetva], [number], [Max. 9 999 999,999. Multiple de 0,001 (3 déc.)],
    [type_dateJJMMAAAA], [string], [Format JJ/MM/AAAA. Pattern : `^(0[1-9]|[12][0-9]|3[0-1])/(0[1-9]|1[0-2])/[0-9]{4}$`],
    [type_zonedatetime], [string], [ISO 8601 avec fuseau et ms. Ex. : `2026-01-16T10:00:00.000+01:00`],
    [type_identifiant_douane], [string], [20–24 car. Pattern : `[a-zA-Z0-9]{20,24}$`],
    [type_identifiant_bve], [string], [20–24 car. Pattern : `FR[a-zA-Z0-9]{20,22}$`],
    [type_identifiant_bve_ps], [string], [20–24 car. Pattern : `PS[a-zA-Z0-9]{20,22}$`],
    [type_identifiant_attestation], [string], [20–24 car. Pattern : `AT[a-zA-Z0-9]{20,22}$`],
    [type_identifiant_detaxe], [string], [20–24 car. Pattern : `[0-9]{2}[a-zA-Z0-9]{18,22}$`],
    [type_code_error], [string], [Max. 5 car. Pattern : `[A-Z]{2}[0-9]{3}`],
    [type_codepays], [string], [Code ISO 3166-1 alpha-2. Pattern : `^[A-Z]{2}$`],
    [type_siret], [string], [Exactement 14 caractères],
    [type_pdf], [string], [PDF/A encodé en base64. Max. 3 500 000 car.],
    [type_email], [string], [Format email. Max. 200 car.],
  )
}

== Types composites (type.json)

=== Voyageur <voyageur>

Le nœud `voyageur` contient les données d'identification du voyageur bénéficiaire de la détaxe.

#jsd-table(
  [passeport], [type_strictalphanumeric30], [Oui], [1], [Numéro de passeport, max. 30 car.],
  [date_expiration_passeport], [type_dateJJMMAAAA], [Oui], [1], [Format JJ/MM/AAAA],
  [nom_voyageur], [typealphanumeric50], [Oui], [1], [Nom de famille, max. 50 car.],
  [prenom_voyageur], [typealphanumeric50], [Oui], [1], [Prénom, max. 50 car.],
  [date_naissance], [type_dateJJMMAAAA], [Oui], [1], [Format JJ/MM/AAAA],
  [adresse], [typealphanumeric500], [Non], [0..1], [Adresse complète, max. 500 car.],
  [courriel], [type_email], [Non], [0..1], [Adresse e-mail, max. 200 car.],
  [pays_residence], [type_codepays], [Oui], [1], [Code ISO 3166-1 alpha-2 (ex. : `US`, `CN`)],
  [nationalite], [type_codepays], [Oui], [1], [Code ISO 3166-1 alpha-2],
)

`additionalProperties: false` — Aucun champ supplémentaire n'est autorisé.

=== Marchandise <marchandise>

Le nœud `marchandise` décrit un article acheté par le voyageur.

#jsd-table(
  [description], [typealphanumeric500], [Oui], [1], [Description de l'article, max. 500 car.],
  [numero_identification], [typealphanumeric50], [Non], [0..1], [Référence article, max. 50 car.],
  [type], [typealphanumeric50], [Non], [0..1], [Type spécifique (pull, veste, jean...), max. 50 car.],
  [marque], [type_alphanumeric30], [Non], [0..1], [Marque de l'article, max. 30 car.],
  [couleur], [type_alphanumeric30], [Non], [0..1], [Couleur, max. 30 car.],
  [code_produit], [typenumeric], [Oui], [1], [Code produit (entier ≥ 0)],
  [quantite], [typenumeric], [Oui], [1], [Quantité (entier ≥ 0)],
  [taux_tva], [typetva], [Oui], [1], [Taux de TVA (3 décimales, max. 9 999 999,999)],
  [prix_unitaire_ttc], [typenumericdecimal], [Oui], [1], [Prix unitaire TTC (2 décimales)],
  [montant_ttc], [typenumericdecimal], [Oui], [1], [Montant total TTC (2 décimales)],
  [montant_tva], [typenumericdecimal], [Oui], [1], [Montant TVA (2 décimales)],
)

`additionalProperties: false`

#encadre-important[
  Le champ `type` de la marchandise doit être spécifique (exemples : pull, veste, jean, montre, sac). Les catégories génériques ne sont pas acceptées.
]

=== Vendeur <vendeur>

Le nœud `vendeur` (schéma Mandataire et Centre d'Achat) identifie le commerçant.

#jsd-table(
  [identifiant_vendeur], [type_siret], [Oui], [1], [SIRET — exactement 14 caractères],
  [nom_vendeur], [typealphanumeric200], [Oui], [1], [Raison sociale, max. 200 car.],
  [numero_ticket], [type_strictalphanumeric50], [Oui], [1], [Numéro du ticket de caisse, max. 50 car.],
  [date_recu_c], [type_zonedatetime], [Oui], [1], [Date du reçu de caisse, format ISO 8601],
)

`additionalProperties: false`

=== Vendeur avec facture (schéma Achat/Revente) <vendeur-facture>

Le nœud `vendeur_avec_facture` étend le vendeur standard avec les informations de facturation requises pour le schéma Achat/Revente.

#jsd-table(
  [identifiant_vendeur], [type_siret], [Oui], [1], [SIRET — exactement 14 caractères],
  [nom_vendeur], [typealphanumeric200], [Oui], [1], [Raison sociale, max. 200 car.],
  [numero_ticket], [type_strictalphanumeric50], [Oui], [1], [N° ticket de caisse, max. 50 car.],
  [date_recu_c], [type_zonedatetime], [Oui], [1], [Date du reçu de caisse],
  [numero_facture], [type_strictalphanumeric50], [Oui], [1], [N° facture opérateur → vendeur, max. 50 car.],
  [date_recu_f], [type_zonedatetime], [Oui], [1], [Date de la facture opérateur → vendeur],
  [numero_facture_bussiness], [type_strictalphanumeric50], [Oui], [1], [N° facture vendeur → opérateur, max. 50 car.],
  [date_recu_f_bussiness], [type_zonedatetime], [Oui], [1], [Date de la facture vendeur → opérateur],
)

`additionalProperties: false`

=== Cause (erreur) <cause>

Le nœud `cause` décrit la raison d'une erreur ou d'un rejet.

#jsd-table(
  [code], [type_code_error], [Oui], [1], [Code erreur, pattern : `[A-Z]{2}[0-9]{3}`, max. 5 car.],
  [description], [typealphanumeric200], [Oui], [1], [Description de l'erreur, max. 200 car.],
)

`additionalProperties: false`

=== Transaction <transaction>

Le nœud `transaction` contient les données financières du bordereau.

#jsd-table(
  [montant_remboursement], [typenumericdecimal], [Oui], [1], [Montant du remboursement au voyageur],
  [montant_total_tva], [typenumericdecimal], [Oui], [1], [Montant total de TVA],
  [montant_total_ttc], [typenumericdecimal], [Oui], [1], [Montant total TTC],
  [mode_paiement], [integer], [Oui], [1], [Mode de paiement (code entier)],
  [detail_paiement], [string], [Non], [0..1], [Détail du mode de paiement],
  [mode_remboursement], [integer], [Oui], [1], [Mode de remboursement (code entier)],
  [detail_remboursement], [string], [Non], [0..1], [Détail du mode de remboursement],
)

== Messages de requête (sens ALLER)

=== A_E_C01 — Création de BVE <a-e-c01>

Ce message permet à l'opérateur de transmettre un BVE à créer dans le système PABLO. Chaque message contient un seul BVE.

*Nœud racine :* `creation_bve`

#jsd-table(
  [identifiant_detaxe], [type_identifiant_detaxe], [Oui], [1], [Identifiant opérateur du bordereau. 20–24 car., pattern : `[0-9]{2}[a-zA-Z0-9]{18,22}$`],
  [date_emission], [type_zonedatetime], [Oui], [1], [Date d'émission du BVE],
  [voyageur], [voyageur], [Oui], [1], [Cf. @voyageur],
  [schema_commercial], [schema], [Oui], [1], [Un des 3 schémas commerciaux (type 1, 2 ou 3)],
  [transaction], [transaction], [Oui], [1], [Cf. @transaction],
)

`additionalProperties: false` sur `creation_bve` et sur le nœud racine.

=== A_E_P01 — Création de BVE de secours <a-e-p01>

Ce message est utilisé lorsque la création de bordereau classique n'est pas disponible. L'opérateur a préalablement récupéré un numéro d'attestation dans Pablo-Opérateurs et créé une attestation papier.

*Nœud racine :* `creation_bve_secours`

#jsd-table(
  [identifiant_detaxe], [type_identifiant_detaxe], [Oui], [1], [Identifiant opérateur du bordereau],
  [identifiant_attestation], [type_identifiant_attestation], [Oui], [1], [N° d'attestation. Pattern : `AT[a-zA-Z0-9]{20,22}$`],
  [date_emission], [type_zonedatetime], [Oui], [1], [Date d'émission],
  [voyageur], [voyageur], [Oui], [1], [Cf. @voyageur],
  [schema_commercial], [schema], [Oui], [1], [Schéma commercial (type 1, 2 ou 3)],
  [transaction], [transaction], [Oui], [1], [Cf. @transaction],
)

`additionalProperties: false`

=== A_E_S01 — Suppression de BVE <a-e-s01>

Ce message permet de supprimer un BVE suite à l'envoi de données erronées ou incomplètes.

*Nœud racine :* `supprime_bve`

#jsd-table(
  [identifiant_bve], [type_identifiant_bve ou type_identifiant_detaxe], [Oui], [1], [Identifiant du BVE à supprimer (anyOf : préfixe FR ou id opérateur)],
  [cause], [cause], [Oui], [1], [Motif de la suppression, cf. @cause],
)

`additionalProperties: false`

=== A_E_U01 — Visa UE <a-e-u01>

Ce message transmet les BVE ayant obtenu un visa douanier d'un autre État membre de l'UE.

*Nœud racine :* `bve_visa_eu` (tableau, max. 100 éléments)

#jsd-table(
  [identifiant_douane], [type_identifiant_douane], [Oui], [1], [Identifiant du bordereau (FR, PS ou opérateur)],
  [date], [type_zonedatetime], [Oui], [1], [Date du visa UE],
  [pays], [type_codepays], [Oui], [1], [Code ISO du pays ayant apposé le visa],
  [montant], [typenumericdecimal], [Oui], [1], [Montant TTC du BVE],
  [pdf], [string], [Oui], [1], [Copie du visa UE en PDF/A encodé en base64],
)

`additionalProperties: false` — `maxItems: 100`

#encadre-important[
  Seuls les BVE visés dans un délai de 6 mois plus le mois en cours, et d'un montant TTC ≥ 50 000 € doivent être transmis. Au-delà de ce délai, le remboursement n'est plus possible.
]

=== R_E_A01 — Apurement des BVE (reçu de la DGDDI) <r-e-a01>

Ce message est envoyé quotidiennement par la DGDDI (J+1) et contient la liste des BVE confirmés ou annulés.

*Nœud racine :* `apure_bve` (tableau)

#jsd-table(
  [identifiant_douane], [type_identifiant_douane], [Oui], [1], [Identifiant du bordereau],
  [statut], [typealphanumeric50], [Oui], [1], [Statut : CONFIRME ou ANNULE],
  [lieu], [typealphanumeric200], [Oui], [1], [Lieu de l'apurement],
  [date], [type_zonedatetime], [Oui], [1], [Date de l'apurement],
  [motif], [cause], [Non], [0..1], [Motif en cas d'annulation],
)

=== R_E_IS — Information de statut (live status, reçu de la DGDDI) <r-e-is>

Message d'information envoyé au fil de l'eau (toutes les 5 minutes) concernant l'évolution du statut des bordereaux.

*Nœud racine :* `status_information` (tableau)

#jsd-table(
  [identifiant_douane], [type_identifiant_douane], [Oui], [1], [Identifiant du bordereau],
  [statut], [typealphanumeric50], [Oui], [1], [Statut courant du BVE],
  [place], [typealphanumeric50], [Oui], [1], [Lieu du changement de statut],
  [date], [type_zonedatetime], [Oui], [1], [Date du changement de statut],
  [motif], [cause], [Non], [0..1], [Motif le cas échéant],
)

#note-technique[
  Ce message est un message d'information uniquement. Le statut peut encore faire l'objet d'une modification suite à un contrôle. La base légale de consultation des statuts reste Pablo-Opérateurs.
]

== Messages de réponse (sens RETOUR)

=== R_AR_C02 — Création BVE réussie <r-ar-c02>

Accusé de réception fonctionnel confirmant la création du BVE dans PABLO.

*Nœud racine :* `bve_cree`

#jsd-table(
  [identifiant_bve], [type_identifiant_bve], [Oui], [1], [Identifiant PABLO du BVE créé. Pattern : `FR[a-zA-Z0-9]{20,22}$`],
  [identifiant_detaxe], [type_identifiant_detaxe], [Non], [0..1], [Identifiant opérateur (pour corrélation)],
)

=== R_EC_C03 — Création BVE échouée <r-ec-c03>

Accusé de réception signalant l'échec de la création du BVE.

*Nœud racine :* `echec_bve`

#jsd-table(
  [identifiant_detaxe], [type_identifiant_detaxe], [Non], [0..1], [Identifiant opérateur du BVE rejeté],
  [cause], [cause], [Oui], [1], [Motif du rejet, cf. @cause],
)

=== R_AR_P02 — Création BVE de secours réussie <r-ar-p02>

Confirmation de la création du BVE de secours.

*Nœud racine :* `bve_cree_secours`

#jsd-table(
  [identifiant_bve_ps], [type_identifiant_bve_ps], [Non], [0..1], [Identifiant PABLO du BVE de secours. Pattern : `PS[a-zA-Z0-9]{20,22}$`],
  [identifiant_detaxe], [type_identifiant_detaxe], [Non], [0..1], [Identifiant opérateur],
)

=== R_EC_P03 — Création BVE de secours échouée <r-ec-p03>

Échec de la création du BVE de secours.

*Nœud racine :* `echec_bve_secours`

#jsd-table(
  [identifiant_detaxe], [type_identifiant_detaxe], [Oui], [1], [Identifiant opérateur],
  [cause], [cause], [Oui], [1], [Motif du rejet],
)

=== R_AR_S02 — Suppression BVE réussie <r-ar-s02>

Confirmation de la suppression du BVE.

*Nœud racine :* `bve_supprime`

#jsd-table(
  [identifiant_bve], [type_identifiant_bve], [Oui], [1], [Identifiant PABLO du BVE supprimé],
)

=== R_EC_S03 — Suppression BVE échouée <r-ec-s03>

Échec de la suppression du BVE.

*Nœud racine :* `echec_suppr_bve`

#jsd-table(
  [identifiant_bve], [type_identifiant_bve], [Oui], [1], [Identifiant du BVE],
  [cause], [cause], [Oui], [1], [Motif du rejet],
)

=== R_AR_U02 — Visa UE réussi <r-ar-u02>

Confirmation de la prise en compte du visa UE.

*Nœud racine :* `bve_visa_eu` (tableau)

#jsd-table(
  [identifiant_douane], [type_identifiant_douane], [Oui], [1], [Identifiant du bordereau validé],
)

=== R_EC_U03 — Visa UE échoué <r-ec-u03>

Échec de la prise en compte du visa UE.

*Nœud racine :* `echec_bve_visa_eu` (tableau)

#jsd-table(
  [identifiant_douane], [type_identifiant_douane], [Oui], [1], [Identifiant du bordereau rejeté],
  [cause], [cause], [Non], [0..1], [Motif du rejet le cas échéant],
)

=== A_AR_A02 — Accusé d'apurement réussi (envoyé à la DGDDI) <a-ar-a02>

L'opérateur confirme la bonne réception et le traitement de l'apurement.

*Nœud racine :* `bve_apure` (tableau)

#jsd-table(
  [identifiant_douane], [type_identifiant_douane], [Oui], [1], [Identifiant du bordereau apuré avec succès],
)

`additionalProperties: false`

=== A_EC_A03 — Accusé d'apurement échoué (envoyé à la DGDDI) <a-ec-a03>

L'opérateur signale un échec dans le traitement de l'apurement.

*Nœud racine :* `echec_apure_bve` (tableau)

#jsd-table(
  [identifiant_douane], [type_identifiant_douane], [Oui], [1], [Identifiant du bordereau en erreur],
  [cause], [cause], [Oui], [1], [Motif de l'échec],
)

`additionalProperties: false`

== Messages d'erreur globale

=== R_G001 — Erreur globale (schéma JSON) <r-g001>

Message transmis par PABLO lorsque la structure JSON du message reçu ne respecte pas le schéma attendu. Le message n'est pas traité.

*Nœud racine :* `error_information` (tableau de `cause`)

Chaque élément du tableau contient :
#jsd-table(
  [code], [type_code_error], [Oui], [1], [Code de l'erreur de validation],
  [description], [typealphanumeric200], [Oui], [1], [Description de l'erreur],
)

=== R_G002 — Erreur globale applicative (système) <r-g002>

Message transmis en cas de difficulté majeure du système PABLO ou de ses dépendances.

*Nœud racine :* `error_information` (objet `cause` unique)

#jsd-table(
  [code], [type_code_error], [Oui], [1], [Code de l'erreur système],
  [description], [typealphanumeric200], [Oui], [1], [Description de l'erreur],
)

#note-technique[
  La différence entre G001 et G002 réside dans la structure : G001 renvoie un tableau de causes (plusieurs erreurs de validation), tandis que G002 renvoie une cause unique (erreur système).
]
