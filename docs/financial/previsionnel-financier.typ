// =============================================================================
// BELCOVA SAS — Prévisionnel Financier 2026–2028
//
// Document à joindre à la demande d'agrément d'opérateur de détaxe
// (article 262-0 bis, I, 2° du CGI)
// =============================================================================

#import "variables.typ": *

// ── Couleurs ────────────────────────────────────────────────────────────────
#let navy     = rgb("#1a2744")
#let gold     = rgb("#c9a84c")
#let steel    = rgb("#3a5a8c")
#let cream    = rgb("#f7f5f0")
#let body-clr = rgb("#2c2c2c")
#let muted    = rgb("#888888")
#let green-ok = rgb("#2e7d32")
#let red-neg  = rgb("#c62828")

// ── Fonctions utilitaires ───────────────────────────────────────────────────

// Formatage monétaire : 1234 → "1 234 €"
#let eur(n) = {
  let sign = if n < 0 { "−" } else { "" }
  let abs-n = calc.abs(n)
  let s = str(abs-n)
  let parts = ()
  let i = s.len()
  while i > 0 {
    let start = calc.max(0, i - 3)
    parts.push(s.slice(start, i))
    i = start
  }
  let formatted = sign + parts.rev().join("\u{202f}")
  [#formatted\u{00a0}€]
}

// Cellule d'en-tête tableau
#let th(content) = table.cell(
  fill: navy,
  text(weight: "bold", fill: white, size: 9pt, content),
)

// Cellule total (fond crème, gras)
#let total-cell(content) = table.cell(
  fill: cream,
  text(weight: "bold", size: 9pt, content),
)

// Encadré hypothèse
#let hyp-box(body) = {
  block(
    width: 100%,
    fill: cream,
    stroke: (left: 3pt + gold),
    inset: (left: 12pt, right: 12pt, top: 8pt, bottom: 8pt),
    radius: (right: 3pt),
  )[
    #set text(size: 9pt, style: "italic", fill: muted)
    #body
  ]
}

// ── Mise en page ────────────────────────────────────────────────────────────

#set document(
  title: "Prévisionnel Financier 2026–2028 — BELCOVA SAS",
  author: "BELCOVA SAS",
  date: auto,
)

#set page(
  paper: "a4",
  margin: (top: 3.2cm, bottom: 2.8cm, left: 2.5cm, right: 2.5cm),
  header: context {
    if counter(page).get().first() > 1 {
      set text(size: 8pt, fill: muted)
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        smallcaps[Prévisionnel Financier — BELCOVA SAS],
        [Page #counter(page).display() sur #counter(page).final().first()],
      )
      v(2pt)
      line(length: 100%, stroke: 0.3pt + muted)
    }
  },
  footer: context {
    if counter(page).get().first() > 1 {
      line(length: 100%, stroke: 0.3pt + muted)
      v(4pt)
      set text(size: 7pt, fill: muted)
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [CONFIDENTIEL — Usage interne et demande d'agrément uniquement],
        [#counter(page).display() / #counter(page).final().first()],
      )
    }
  },
)

#set text(
  font: "New Computer Modern",
  size: 10.5pt,
  fill: body-clr,
  lang: "fr",
)
#set par(justify: true, leading: 0.7em)

#set table(stroke: 0.5pt + rgb("#cccccc"), inset: 6pt)

#show heading.where(level: 1): it => {
  v(1.6em)
  block(width: 100%)[
    #set text(size: 14pt, weight: "bold", fill: navy)
    #line(length: 100%, stroke: 1.5pt + gold)
    #v(6pt)
    #smallcaps(it.body)
    #v(4pt)
    #line(length: 100%, stroke: 0.5pt + gold)
  ]
  v(0.8em)
}

#show heading.where(level: 2): it => {
  v(1.2em)
  block(width: 100%)[
    #set text(size: 11.5pt, weight: "bold", fill: steel)
    #it.body
    #v(2pt)
    #line(length: 40%, stroke: 0.4pt + gold)
  ]
  v(0.5em)
}

#show heading.where(level: 3): it => {
  v(0.8em)
  block[
    #set text(size: 10.5pt, weight: "bold", fill: navy)
    #it.body
  ]
  v(0.3em)
}

// ═════════════════════════════════════════════════════════════════════════════
//  PAGE DE GARDE
// ═════════════════════════════════════════════════════════════════════════════

#v(3cm)

#align(center)[
  #block(
    width: 85%,
    inset: 24pt,
    stroke: 1.5pt + navy,
  )[
    #set text(fill: navy)

    #text(size: 22pt, weight: "bold")[
      Prévisionnel Financier
    ]

    #v(8pt)

    #text(size: 14pt, fill: steel)[
      Exercices 2026 — 2027 — 2028
    ]

    #v(12pt)
    #line(length: 40%, stroke: 1pt + gold)
    #v(12pt)

    #text(size: 12pt, weight: "bold")[BELCOVA SAS]

    #v(4pt)

    #text(size: 10pt)[
      Société par Actions Simplifiée au capital de #capital-initial € \
      RCS Paris #rcs-number \
      #siege-social
    ]
  ]
]

#v(2cm)

#align(center)[
  #set text(size: 10pt, fill: muted)
  Document établi le #date-document \
  dans le cadre de la demande d'agrément d'opérateur de détaxe \
  (article 262-0 bis, I, 2° du Code Général des Impôts)
]

#v(1.5cm)

#align(center)[
  #block(
    inset: (x: 15pt, y: 8pt),
    stroke: 1pt + red-neg,
  )[
    #set text(size: 10pt, fill: red-neg, weight: "bold", tracking: 1pt)
    CONFIDENTIEL
  ]
]

#pagebreak()

// ═════════════════════════════════════════════════════════════════════════════
//  SOMMAIRE
// ═════════════════════════════════════════════════════════════════════════════

#outline(
  title: [Sommaire],
  depth: 2,
  indent: auto,
)

#pagebreak()

// ═════════════════════════════════════════════════════════════════════════════
//  1. SYNTHÈSE EXÉCUTIVE
// ═════════════════════════════════════════════════════════════════════════════

= Synthèse exécutive

BELCOVA SAS est un opérateur de détaxe nouvelle génération dont la plateforme numérique dématérialise intégralement le processus de remboursement de TVA pour les voyageurs internationaux non-résidents de l'Union européenne. La Société connecte les commerçants au système PABLO de la DGDDI via une interface EDI certifiée.

#v(0.5em)

#table(
  columns: (1fr, 1fr, 1fr),
  table.header(
    th[Indicateur],
    th[2027],
    th[2028],
  ),
  [Chiffre d'affaires], [#eur(ca-2027)], [#eur(ca-2028)],
  [Résultat d'exploitation], [#eur(rex-2027)], [#eur(rex-2028)],
  [Marge d'exploitation], [#pct-rex-2027], [#pct-rex-2028],
  [Bordereaux traités], [#nb-bvx-2027], [#nb-bvx-2028],
  [Commerçants actifs], [#nb-merchants-2027], [#nb-merchants-2028],
)

#v(0.5em)

Le modèle économique repose sur deux sources de revenus et un mécanisme d'incitation commerçant :

+ *Marge TVA* — BELCOVA rembourse #taux-retrocession % de la TVA au voyageur et conserve les #eur(marge-tva-par-bvx) restants par bordereau. Ce différentiel entre le remboursement DGDDI (100 % de la TVA) et l'avance au voyageur constitue la source de revenus principale.

+ *Frais de service voyageur* — contribution forfaitaire du voyageur pour le traitement dématérialisé et l'accompagnement (#eur(frais-voyageur) par opération).

+ *Commission commerçant* — à contre-courant du marché, BELCOVA *verse* une commission de #eur(commission-commercant) par bordereau au commerçant partenaire, là où les opérateurs historiques ne leur reversent rien ou avec un délai de ~100 jours. Ce modèle aligne les intérêts et accélère l'acquisition de commerçants.

Ce modèle *sans abonnement ni frais d'entrée* supprime toute barrière pour les commerçants : l'inscription est gratuite et le commerçant est rémunéré à la transaction.

La Société atteint le *seuil de rentabilité opérationnelle en #mois-breakeven* et dégage un résultat net positif dès l'exercice #annee-net-positif.

// ═════════════════════════════════════════════════════════════════════════════
//  2. HYPOTHÈSES CLÉS
// ═════════════════════════════════════════════════════════════════════════════

= Hypothèses clés

== Marché et positionnement

Le marché français de la détaxe représente environ *26 millions* de voyageurs internationaux éligibles par an. Le montant moyen d'un achat détaxé se situe autour de *#eur(panier-moyen-detaxe)* TTC, pour un remboursement moyen de TVA de *#eur(remboursement-moyen)* par bordereau.

Le marché est actuellement dominé par deux acteurs historiques (Global Blue et Planet) qui traitent plus de 90 % des volumes. BELCOVA se positionne sur le segment des commerçants de taille moyenne (10–200 bordereaux/mois) mal servis par les opérateurs historiques, avec une approche *100 % numérique* et des tarifs compétitifs.

#hyp-box[
  *Hypothèse de pénétration* : BELCOVA vise 0,05 % du marché adressable en année 1, 0,3 % en année 2, et 1 % en année 3. Ces hypothèses sont conservatrices et supposent un démarrage limité à l'Île-de-France.
]

== Hypothèses de revenus

#table(
  columns: (2.5fr, 1fr, 1fr, 1fr),
  table.header(
    th[Paramètre],
    th[2026#sub[(9 mois)]],
    th[2027],
    th[2028],
  ),
  [Commerçants actifs (fin d'année)],
    [#nb-merchants-2026], [#nb-merchants-2027], [#nb-merchants-2028],
  [Bordereaux traités],
    [#nb-bvx-2026], [#nb-bvx-2027], [#nb-bvx-2028],
  [Marge TVA / bordereau (20 %)],
    [#eur(marge-tva-par-bvx)], [#eur(marge-tva-par-bvx)], [#eur(marge-tva-par-bvx)],
  [Frais de service voyageur],
    [#eur(frais-voyageur)], [#eur(frais-voyageur)], [#eur(frais-voyageur)],
  [Commission versée au commerçant],
    [#eur(commission-commercant)], [#eur(commission-commercant)], [#eur(commission-commercant)],
)

== Hypothèses de charges

#table(
  columns: (2.5fr, 1fr, 1fr, 1fr),
  table.header(
    th[Poste],
    th[2026#sub[(9 mois)]],
    th[2027],
    th[2028],
  ),
  [Hébergement cloud (OVH / Scaleway)],
    [#eur(cloud-2026)], [#eur(cloud-2027)], [#eur(cloud-2028)],
  [Domiciliation (Les Tricolores)],
    [#eur(domiciliation-2026)], [#eur(domiciliation-2027)], [#eur(domiciliation-2028)],
  [Assurance RC Pro],
    [#eur(assurance-2026)], [#eur(assurance-2027)], [#eur(assurance-2028)],
  [Expert-comptable],
    [#eur(comptable-2026)], [#eur(comptable-2027)], [#eur(comptable-2028)],
  [Marketing & acquisition],
    [#eur(marketing-2026)], [#eur(marketing-2027)], [#eur(marketing-2028)],
  [Licences & outils SaaS],
    [#eur(licences-2026)], [#eur(licences-2027)], [#eur(licences-2028)],
  [Rémunération dirigeants],
    [#eur(remun-dirigeants-2026)], [#eur(remun-dirigeants-2027)], [#eur(remun-dirigeants-2028)],
  [Charges sociales dirigeants],
    [#eur(charges-sociales-2026)], [#eur(charges-sociales-2027)], [#eur(charges-sociales-2028)],
  [Salariés (brut + charges)],
    [#eur(salaries-2026)], [#eur(salaries-2027)], [#eur(salaries-2028)],
  [Frais bancaires (Qonto)],
    [#eur(banque-2026)], [#eur(banque-2027)], [#eur(banque-2028)],
  [Frais divers & imprévus (5 %)],
    [#eur(divers-2026)], [#eur(divers-2027)], [#eur(divers-2028)],
)

#hyp-box[
  *Politique de rémunération* : Les fondateurs ne perçoivent aucune rémunération sur la période du prévisionnel. La totalité des résultats est réinvestie dans le développement de la plateforme et la croissance commerciale.
]

// ═════════════════════════════════════════════════════════════════════════════
//  3. COMPTE DE RÉSULTAT PRÉVISIONNEL
// ═════════════════════════════════════════════════════════════════════════════

= Compte de résultat prévisionnel

#table(
  columns: (3fr, 1fr, 1fr, 1fr),
  table.header(
    th[Poste],
    th[2026#sub[(9 mois)]],
    th[2027],
    th[2028],
  ),
  // ── Produits ──
  table.cell(colspan: 4, fill: cream)[
    #text(weight: "bold", size: 9pt)[Produits d'exploitation]
  ],
  [Marge TVA (20 % conservés)], [#eur(rev-marge-tva-2026)], [#eur(rev-marge-tva-2027)], [#eur(rev-marge-tva-2028)],
  [Frais de service voyageur], [#eur(rev-service-2026)], [#eur(rev-service-2027)], [#eur(rev-service-2028)],
  total-cell[*Total produits*],
    total-cell[*#eur(total-produits-2026)*],
    total-cell[*#eur(total-produits-2027)*],
    total-cell[*#eur(total-produits-2028)*],

  // ── Charges ──
  table.cell(colspan: 4, fill: cream)[
    #text(weight: "bold", size: 9pt)[Charges d'exploitation]
  ],
  [Achats & charges externes], [#eur(charges-ext-2026)], [#eur(charges-ext-2027)], [#eur(charges-ext-2028)],
  [Commissions commerçants], [#eur(comm-merchant-2026)], [#eur(comm-merchant-2027)], [#eur(comm-merchant-2028)],
  [Charges de personnel], [#eur(charges-personnel-2026)], [#eur(charges-personnel-2027)], [#eur(charges-personnel-2028)],
  [Dotations aux amortissements], [#eur(amortissements-2026)], [#eur(amortissements-2027)], [#eur(amortissements-2028)],
  total-cell[*Total charges*],
    total-cell[*#eur(total-charges-2026)*],
    total-cell[*#eur(total-charges-2027)*],
    total-cell[*#eur(total-charges-2028)*],

  // ── Résultats ──
  table.cell(colspan: 4, fill: cream)[
    #text(weight: "bold", size: 9pt)[Résultats]
  ],
  [*Résultat d'exploitation*],
    [#eur(rex-2026)], [#eur(rex-2027)], [#eur(rex-2028)],
  [Impôt sur les sociétés (25 %)],
    [#eur(is-2026)], [#eur(is-2027)], [#eur(is-2028)],
  total-cell[*Résultat net*],
    total-cell[*#eur(rn-2026)*],
    total-cell[*#eur(rn-2027)*],
    total-cell[*#eur(rn-2028)*],
)

#v(0.5em)

#hyp-box[
  *Taux IS réduit* : BELCOVA bénéficie du taux réduit de 15 % sur les premiers 42~500 € de bénéfice (PME, CA < 10 M€). Le taux de 25 % s'applique au-delà. Le prévisionnel utilise le taux normal de 25 % par prudence.
]

// ═════════════════════════════════════════════════════════════════════════════
//  4. PLAN DE TRÉSORERIE MENSUEL — ANNÉE 1
// ═════════════════════════════════════════════════════════════════════════════

= Plan de trésorerie — Exercice 2026

Le plan de trésorerie mensuel détaille les flux d'encaissements et décaissements pour les 9 premiers mois d'activité (avril–décembre 2026).

== Flux spécifiques à l'activité de détaxe

L'opérateur de détaxe avance *#taux-retrocession % de la TVA* au voyageur au moment de la validation du bordereau en bureau de douane. La DGDDI rembourse ensuite *100 % de la TVA* à l'opérateur via un mécanisme de compensation. Le *décalage de trésorerie* entre l'avance au voyageur et le remboursement intégral par l'État est estimé à *#delai-remboursement-dgddi jours* en moyenne. L'écart de 20 % entre le remboursement DGDDI et l'avance au voyageur constitue la marge TVA de l'opérateur.

#hyp-box[
  *Gestion du décalage* : Le montant avancé par bordereau est de #eur(avance-voyageur) (#taux-retrocession % de #eur(tva-moyenne) de TVA, sur un panier moyen de #eur(panier-moyen-detaxe) TTC). Avec #nb-bvx-2026 bordereaux sur 9 mois et un délai de remboursement de #delai-remboursement-dgddi jours, le besoin de trésorerie lié à ce décalage est maîtrisé et ne dépasse pas #eur(bfr-max-2026) à son pic.
]

== Tableau de trésorerie simplifié

#set text(size: 8.5pt)

#table(
  columns: (2fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header(
    th[Poste],
    th[Avr], th[Mai], th[Juin], th[Juil],
    th[Août], th[Sept], th[Oct], th[Nov], th[Déc],
  ),
  // ── Encaissements ──
  table.cell(colspan: 10, fill: cream)[
    #text(weight: "bold")[Encaissements]
  ],
  [Capital libéré],
    [#eur(100)], [—], [—], [—], [—], [—], [—], [—], [—],
  [Apport CCA],
    [#eur(apport-cca)], [—], [—], [—], [—], [—], [—], [—], [—],
  [Frais service voyageur],
    [—], [—], [—],
    [#eur(cash-service-jul)], [#eur(cash-service-aug)], [#eur(cash-service-sep)],
    [#eur(cash-service-oct)], [#eur(cash-service-nov)], [#eur(cash-service-dec)],
  [Remb. DGDDI (TVA 100 %)],
    [—], [—], [—],
    [—], [#eur(cash-dgddi-aug)], [#eur(cash-dgddi-sep)],
    [#eur(cash-dgddi-oct)], [#eur(cash-dgddi-nov)], [#eur(cash-dgddi-dec)],
  total-cell[*Total encaissements*],
    total-cell[*#eur(enc-apr)*], total-cell[*#eur(enc-mai)*], total-cell[*#eur(enc-jun)*],
    total-cell[*#eur(enc-jul)*], total-cell[*#eur(enc-aug)*], total-cell[*#eur(enc-sep)*],
    total-cell[*#eur(enc-oct)*], total-cell[*#eur(enc-nov)*], total-cell[*#eur(enc-dec)*],

  // ── Décaissements ──
  table.cell(colspan: 10, fill: cream)[
    #text(weight: "bold")[Décaissements]
  ],
  [Charges fixes],
    [#eur(dec-fixes-apr)], [#eur(dec-fixes-mai)], [#eur(dec-fixes-jun)],
    [#eur(dec-fixes-jul)], [#eur(dec-fixes-aug)], [#eur(dec-fixes-sep)],
    [#eur(dec-fixes-oct)], [#eur(dec-fixes-nov)], [#eur(dec-fixes-dec)],
  [Avances TVA voyageurs (#taux-retrocession %)],
    [—], [—], [—],
    [#eur(avance-tva-jul)], [#eur(avance-tva-aug)], [#eur(avance-tva-sep)],
    [#eur(avance-tva-oct)], [#eur(avance-tva-nov)], [#eur(avance-tva-dec)],
  [Comm. commerçants],
    [—], [—], [—],
    [#eur(dec-comm-jul)], [#eur(dec-comm-aug)], [#eur(dec-comm-sep)],
    [#eur(dec-comm-oct)], [#eur(dec-comm-nov)], [#eur(dec-comm-dec)],
  [Marketing],
    [#eur(dec-mkt-apr)], [#eur(dec-mkt-mai)], [#eur(dec-mkt-jun)],
    [#eur(dec-mkt-jul)], [#eur(dec-mkt-aug)], [#eur(dec-mkt-sep)],
    [#eur(dec-mkt-oct)], [#eur(dec-mkt-nov)], [#eur(dec-mkt-dec)],
  total-cell[*Total décaissements*],
    total-cell[*#eur(dec-apr)*], total-cell[*#eur(dec-mai)*], total-cell[*#eur(dec-jun)*],
    total-cell[*#eur(dec-jul)*], total-cell[*#eur(dec-aug)*], total-cell[*#eur(dec-sep)*],
    total-cell[*#eur(dec-oct)*], total-cell[*#eur(dec-nov)*], total-cell[*#eur(dec-dec)*],

  // ── Solde ──
  table.cell(colspan: 10, fill: navy)[
    #text(weight: "bold", fill: white)[Trésorerie]
  ],
  [*Solde mensuel*],
    [#eur(solde-apr)], [#eur(solde-mai)], [#eur(solde-jun)],
    [#eur(solde-jul)], [#eur(solde-aug)], [#eur(solde-sep)],
    [#eur(solde-oct)], [#eur(solde-nov)], [#eur(solde-dec)],
  total-cell[*Trésorerie cumulée*],
    total-cell[*#eur(cumul-apr)*], total-cell[*#eur(cumul-mai)*], total-cell[*#eur(cumul-jun)*],
    total-cell[*#eur(cumul-jul)*], total-cell[*#eur(cumul-aug)*], total-cell[*#eur(cumul-sep)*],
    total-cell[*#eur(cumul-oct)*], total-cell[*#eur(cumul-nov)*], total-cell[*#eur(cumul-dec)*],
)

#set text(size: 10.5pt)

// ═════════════════════════════════════════════════════════════════════════════
//  5. PLAN DE FINANCEMENT INITIAL
// ═════════════════════════════════════════════════════════════════════════════

= Plan de financement initial

#table(
  columns: (2fr, 1fr, 2fr, 1fr),
  table.header(
    th[Besoins],
    th[Montant],
    th[Ressources],
    th[Montant],
  ),
  [Frais de constitution],
    [#eur(frais-constitution)],
    [Capital social],
    [#eur(100)],
  [Développement plateforme#super[1]],
    [#eur(dev-plateforme)],
    [Apports en compte courant d'associés],
    [#eur(apport-cca-total)],
  [Certification PABLO],
    [#eur(certification-pablo)],
    [Subventions (BPI, French Tech)],
    [#eur(subventions)],
  [BFR initial (3 mois)],
    [#eur(bfr-initial)],
    [],
    [],
  [Trésorerie de sécurité],
    [#eur(tresorerie-securite)],
    [],
    [],
  total-cell[*Total besoins*],
    total-cell[*#eur(total-besoins)*],
    total-cell[*Total ressources*],
    total-cell[*#eur(total-ressources)*],
)

#v(0.3em)
#text(size: 8.5pt, fill: muted)[
  #super[1] Le développement est réalisé en interne par les fondateurs. Le montant correspond à la valorisation du temps investi (estimation à titre indicatif, non décaissé).
]

// ═════════════════════════════════════════════════════════════════════════════
//  6. SEUIL DE RENTABILITÉ
// ═════════════════════════════════════════════════════════════════════════════

= Seuil de rentabilité

== Charges fixes mensuelles (régime de croisière)

#table(
  columns: (3fr, 1fr),
  table.header(
    th[Poste],
    th[Mensuel],
  ),
  [Hébergement cloud], [#eur(cloud-mensuel-croisiere)],
  [Domiciliation], [#eur(domiciliation-mensuel)],
  [Assurance RC Pro], [#eur(assurance-mensuel)],
  [Expert-comptable], [#eur(comptable-mensuel)],
  [Licences & outils], [#eur(licences-mensuel)],
  [Frais bancaires], [#eur(banque-mensuel)],
  [Divers], [#eur(divers-mensuel)],
  total-cell[*Total charges fixes*],
    total-cell[*#eur(total-fixes-mensuel)*],
)

== Calcul du point mort

#hyp-box[
  *Revenu net par bordereau* = marge TVA (#eur(marge-tva-par-bvx)) + frais de service (#eur(frais-voyageur)) − commission commerçant (#eur(commission-commercant)) = *#eur(revenu-net-par-bvx)* \
  *Charges fixes mensuelles* = #eur(total-fixes-mensuel) (hors personnel) \
  *Point mort mensuel* = #total-fixes-mensuel / #revenu-net-par-bvx = *#seuil-bvx-mensuel bordereaux/mois* \
  Soit environ *#seuil-bvx-jour bordereaux/jour* — un volume atteignable avec #seuil-merchants commerçants actifs.
]

// ═════════════════════════════════════════════════════════════════════════════
//  7. ANALYSE DES RISQUES FINANCIERS
// ═════════════════════════════════════════════════════════════════════════════

= Analyse des risques financiers

== Risque de trésorerie (décalage détaxe)

L'opérateur avance le remboursement de TVA au voyageur avant d'être remboursé par la DGDDI. Ce décalage est le principal risque de trésorerie.

*Mitigation :*
- Plafonnement du montant de remboursement instantané
- Constitution d'une réserve de trésorerie dédiée
- En dernier recours : mise en place d'une caution bancaire (1/4 des engagements, art. 262-0 bis, I, 2°)

== Risque de concentration

Dépendance à un nombre limité de commerçants en phase de démarrage.

*Mitigation :*
- Diversification géographique progressive (Île-de-France puis France entière)
- Mix de revenus (commissions + SaaS) réduisant la dépendance au volume de bordereaux

== Risque réglementaire

Modification des seuils de détaxe ou du système PABLO.

*Mitigation :*
- Veille réglementaire permanente
- Architecture technique modulaire permettant l'adaptation rapide

// ═════════════════════════════════════════════════════════════════════════════
//  8. CONCLUSION
// ═════════════════════════════════════════════════════════════════════════════

= Conclusion

Le prévisionnel financier de BELCOVA SAS démontre :

+ *Une structure de coûts maîtrisée* — charges fixes limitées grâce à une infrastructure cloud et un développement internalisé.

+ *Un seuil de rentabilité atteignable* — le point mort est atteint avec un volume modeste de bordereaux, compatible avec les hypothèses de pénétration de marché.

+ *Un risque de trésorerie contenu* — le décalage lié aux avances de TVA est géré par une réserve dédiée et un plafonnement des remboursements instantanés.

+ *Une capacité à honorer les engagements de l'opérateur de détaxe* — conformément aux exigences de l'article 262-0 bis, I, 2° du CGI.

#v(2em)

#align(center)[
  #line(length: 30%, stroke: 0.5pt + muted)
  #v(0.5em)
  #text(size: 9pt, fill: muted)[
    Fait à Paris, le #date-document \
    #representant-nom — #representant-fonction
  ]
]
