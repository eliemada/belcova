// =============================================================================
// Chapitre 7 — Annexes
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": jsd-table, encadre-important, note-technique, json-exemple, th

= Annexes

== Annexe A — Codes erreur

Le tableau suivant recense les codes erreur pouvant être signalés à l'opérateur dans les messages d'échec (`R_EC_*`, `A_EC_A03`) et les erreurs globales (`R_G001`, `R_G002`). Cette liste n'est pas exhaustive ; les codes erreur peuvent être repris dans plusieurs flux.

Les codes erreur respectent le pattern JSD `[A-Z]{2}[0-9]{3}` (2 lettres majuscules suivies de 3 chiffres, max. 5 caractères).

#table(
  columns: (1fr, 3fr, 2fr),
  table.header(th[Code], th[Description], th[Messages concernés]),
  [`ER001`], [Structure JSON invalide — le message ne respecte pas le JSD], [`R_G001`],
  [`ER002`], [Champ obligatoire manquant], [`R_G001`],
  [`ER003`], [Format de champ non conforme (pattern, type, longueur)], [`R_G001`],
  [`ER004`], [Balise présente mais vide ou composée uniquement d'espaces], [`R_G001`],
  [`SY001`], [Erreur système PABLO — indisponibilité temporaire], [`R_G002`],
  [`SY002`], [Erreur de dépendance du système PABLO], [`R_G002`],
  [`BV001`], [BVE déjà existant dans PABLO (doublon)], [`R_EC_C03`, `R_EC_P03`],
  [`BV002`], [Identifiant detaxe invalide ou non reconnu], [`R_EC_C03`, `R_EC_P03`],
  [`BV003`], [Identifiant attestation invalide (procédure de secours)], [`R_EC_P03`],
  [`BV004`], [Montant TTC non conforme (incohérence avec les marchandises)], [`R_EC_C03`, `R_EC_P03`],
  [`BV005`], [Voyageur non éligible à la détaxe (pays de résidence UE)], [`R_EC_C03`, `R_EC_P03`],
  [`BV006`], [Date d'émission hors délai autorisé], [`R_EC_C03`, `R_EC_P03`],
  [`SP001`], [BVE inexistant dans PABLO (suppression impossible)], [`R_EC_S03`],
  [`SP002`], [BVE déjà apuré (suppression impossible)], [`R_EC_S03`],
  [`SP003`], [BVE déjà supprimé], [`R_EC_S03`],
  [`VU001`], [BVE inexistant dans PABLO (visa UE impossible)], [`R_EC_U03`],
  [`VU002`], [BVE avec statut ANNULE (visa UE impossible)], [`R_EC_U03`],
  [`VU003`], [Délai de visa UE dépassé (> 6 mois + mois en cours)], [`R_EC_U03`],
  [`VU004`], [Montant TTC < 50 000 € (visa UE non requis)], [`R_EC_U03`],
  [`AP001`], [BVE inconnu de l'opérateur (apurement impossible)], [`A_EC_A03`],
  [`AP002`], [BVE déjà apuré dans le système de l'opérateur], [`A_EC_A03`],
)

#note-technique[
  Les codes ci-dessus sont présentés à titre indicatif. La DGDDI peut introduire de nouveaux codes erreur lors des évolutions du système PABLO. Notre plateforme traite tout code respectant le pattern `[A-Z]{2}[0-9]{3}` de manière générique.
]

== Annexe B — Pays éligibles à la détaxe

Sont éligibles à la détaxe les voyageurs résidant dans un pays situé hors de l'Union européenne. Le pays de résidence est identifié par un code ISO 3166-1 alpha-2 (pattern JSD : `^[A-Z]{2}$`).

=== Pays de l'Union européenne (non éligibles)

Les résidents des pays suivants ne sont *pas* éligibles à la détaxe :

#table(
  columns: (1fr, 2fr, 1fr, 2fr),
  table.header(th[Code], th[Pays], th[Code], th[Pays]),
  [`AT`], [Autriche], [`LT`], [Lituanie],
  [`BE`], [Belgique], [`LU`], [Luxembourg],
  [`BG`], [Bulgarie], [`MT`], [Malte],
  [`CY`], [Chypre], [`NL`], [Pays-Bas],
  [`CZ`], [Tchéquie], [`PL`], [Pologne],
  [`DE`], [Allemagne], [`PT`], [Portugal],
  [`DK`], [Danemark], [`RO`], [Roumanie],
  [`EE`], [Estonie], [`SE`], [Suède],
  [`ES`], [Espagne], [`SI`], [Slovénie],
  [`FI`], [Finlande], [`SK`], [Slovaquie],
  [`FR`], [France], [`HR`], [Croatie],
  [`GR`], [Grèce], [], [],
  [`HU`], [Hongrie], [], [],
  [`IE`], [Irlande], [], [],
  [`IT`], [Italie], [], [],
  [`LV`], [Lettonie], [], [],
)

=== Exemples de pays éligibles

#table(
  columns: (1fr, 2fr, 1fr, 2fr),
  table.header(th[Code], th[Pays], th[Code], th[Pays]),
  [`US`], [États-Unis], [`CN`], [Chine],
  [`JP`], [Japon], [`KR`], [Corée du Sud],
  [`GB`], [Royaume-Uni], [`CH`], [Suisse],
  [`AU`], [Australie], [`BR`], [Brésil],
  [`CA`], [Canada], [`SA`], [Arabie saoudite],
  [`IN`], [Inde], [`AE`], [Émirats arabes unis],
  [`SG`], [Singapour], [`TH`], [Thaïlande],
  [`RU`], [Russie], [`MX`], [Mexique],
)

== Annexe C — Exemples de messages JSON

Les exemples suivants illustrent des messages JSON valides conformes au JSD v1.7. Ils sont fournis à titre de référence pour la certification.

=== Création de BVE — Schéma Mandataire (A_E_C01, type_schema = 1)

#json-exemple("json-examples/a_e_c01_mandataire.json")

=== Création de BVE — Schéma Achat/Revente (A_E_C01, type_schema = 2)

#json-exemple("json-examples/a_e_c01_achat_revente.json")

=== Création de BVE — Schéma Centre d'Achat (A_E_C01, type_schema = 3)

#json-exemple("json-examples/a_e_c01_centre_achat.json")

=== Création de BVE de secours (A_E_P01)

#json-exemple("json-examples/a_e_p01.json")

=== Suppression de BVE (A_E_S01)

#json-exemple("json-examples/a_e_s01.json")

=== Création BVE réussie (R_AR_C02)

#json-exemple("json-examples/r_ar_c02.json")

=== Création BVE échouée (R_EC_C03)

#json-exemple("json-examples/r_ec_c03.json")

=== Apurement des BVE (R_E_A01)

#json-exemple("json-examples/r_e_a01.json")

=== Accusé d'apurement réussi (A_AR_A02)

#json-exemple("json-examples/a_ar_a02.json")

=== Accusé d'apurement échoué (A_EC_A03)

#json-exemple("json-examples/a_ec_a03.json")

== Annexe D — Références documentaires

#table(
  columns: (3fr, 1fr, 2fr),
  table.header(th[Document], th[Version], th[Accès]),
  [Spécifications fonctionnelles EDI échanges Opérateurs de détaxe — PABLO], [V5.0.1], [DGDDI],
  [Schéma Définition JSON (JSD) — PABLO EDI], [v1.7], [DGDDI — `PABLO_EDI_JSD_v1.7.zip`],
  [Spécifications pour les partenaires GUN], [—], [douane.gouv.fr],
  [Convention d'adhésion Pablo-O], [v2], [DGDDI],
  [Formulaire d'agrément opérateur de détaxe], [v2], [DGDDI],
  [Fiche technique PABLO V2], [—], [DGDDI],
  [Fiche technique — Procédure de secours], [—], [DGDDI],
  [Décret n° 2017-1825 du 28 décembre 2017], [—], [Légifrance],
  [Article 202 E, annexe III au CGI], [—], [Légifrance],
  [Articles 262 et suivants du CGI], [—], [Légifrance],
  [JSON Schema Draft 2020-12], [—], [json-schema.org],
  [ISO 3166-1 alpha-2 — Codes pays], [—], [ISO],
  [RFC 8446 — TLS 1.3], [—], [IETF],
  [RFC 6749 — OAuth 2.0], [—], [IETF],
)
