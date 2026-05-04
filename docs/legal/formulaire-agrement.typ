// =============================================================================
// Formulaire de demande d'agrément opérateur de détaxe — BELCOVA SAS
// Reproduction du formulaire officiel DGDDI (version 2.0) pré-rempli
// =============================================================================

#let navy = rgb("#1a2744")
#let field-bg = rgb("#f5f5f5")
#let field-border = rgb("#999999")
#let dgddi-blue = rgb("#003399")

#set document(
  title: "Demande d'agrément opérateur de détaxe — BELCOVA",
  author: "BELCOVA SAS",
)

#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm),
  footer: context {
    set text(size: 8pt, fill: rgb("#666666"))
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [Version 2.0],
      [Page #counter(page).display() / #counter(page).final().first()],
    )
  },
)

#set text(
  font: "New Computer Modern",
  size: 10.5pt,
  lang: "fr",
)

// ── Fonction champ rempli ───────────────────────────────────────────────────
#let field(label, content) = {
  block(
    width: 100%,
    stroke: 0.5pt + field-border,
    below: 12pt,
  )[
    #block(
      width: 100%,
      fill: rgb("#e0e0e0"),
      inset: (x: 8pt, y: 4pt),
    )[
      #text(size: 9pt, weight: "bold")[#label]
    ]
    #block(
      width: 100%,
      inset: (x: 10pt, y: 8pt),
    )[
      #set text(size: 11pt)
      #content
    ]
  ]
}

// ═════════════════════════════════════════════════════════════════════════════
//  EN-TÊTE OFFICIEL
// ═════════════════════════════════════════════════════════════════════════════

#grid(
  columns: (1fr, 1fr),
  align: (left, right),
  [
    #text(size: 10pt, weight: "bold")[RÉPUBLIQUE\ FRANÇAISE]
    #v(2pt)
    #text(size: 8pt, style: "italic")[
      Liberté \ Égalité \ Fraternité
    ]
  ],
  [
    #text(size: 11pt, weight: "bold", fill: dgddi-blue)[Douane.gouv.fr]
    #v(2pt)
    #text(size: 8pt, style: "italic", fill: rgb("#666666"))[
      Le portail de la direction générale \
      des douanes et droits indirects
    ]
  ],
)

#v(1em)

#align(center)[
  #block(
    width: 90%,
    fill: rgb("#f0f0f8"),
    stroke: 0.5pt + rgb("#cccccc"),
    inset: 16pt,
  )[
    #set text(size: 11pt, weight: "bold")
    Demande d'agrément relatif à l'activité d'opérateur de détaxe pour l'exercice de l'activité d'opérateur de détaxe

    #v(6pt)
    #set text(size: 9pt, weight: "regular")
    (article 262-0 bis ; articles 202 E, 202 F et 202 H de l'annexe II du code général des impôts)
  ]
]

#v(1em)

// ═════════════════════════════════════════════════════════════════════════════
//  CHAMPS PRÉ-REMPLIS
// ═════════════════════════════════════════════════════════════════════════════

#field("1 – Raison sociale de l'entreprise")[
  BELCOVA \
  Société par Actions Simplifiée (SAS) au capital de 100 €
]

#field("2 – Nom de commercialisation")[
  Belcova
]

#field("3 – Date et lieu de création de l'entreprise")[
  27 avril 2026, Paris \
  RCS Paris — N° de gestion 2026B21768
]

#field("4 – Adresse du siège de l'entreprise")[
  58 rue de Monceau \
  75008 Paris \
  France
]

#field("5 – n° SIRET (à défaut seulement, n°SIREN)")[
  SIRET : 104 126 727 00015 \
  SIREN : 104 126 727
]

#field("6 – n° TVA intra-communautaire")[
  FR 35 104 126 727
]

#field("7 – Identité du représentant de l'entreprise (si plusieurs représentants, indiquez toutes les identités)")[
  *Elie BRUNO* — Président \
  Né le 12 décembre 2005 à Royan (17) \
  Domicile : 29 bis rue de la Crête, 17110 Saint-Georges-de-Didonne

  #v(6pt)

  *Franklin TRANIÉ* — Directeur général \
  Né le 11 février 2004 à Neuilly-sur-Seine (92) \
  Domicile : 3 rue de Rouvray, 92200 Neuilly-sur-Seine
]

#field("8 – Identité et qualité de la personne de l'entreprise en relation avec la DGDDI")[
  Elie BRUNO — Président \
  Téléphone : +33 7 85 63 57 01 \
  Email : contact\@belcova.fr
]

#field("9 – Adresse des différents établissements liées à l'activité d'opérateur de détaxe")[
  Établissement unique (siège social) : \
  58 rue de Monceau, 75008 Paris
]

#field("10 – Adresse de messagerie de contact (envoi des alertes relatives à la détaxe)")[
  alertes\@belcova.fr
]

#v(2em)

#grid(
  columns: (1fr, 1fr),
  [
    A : *Paris*
  ],
  [
    Le : *4 mai 2026*
  ],
)

#v(1em)

Nom et Prénom du signataire : *Elie BRUNO*

#v(1.5em)

#align(center)[
  #text(weight: "bold")[Signature :]

  #v(0.5cm)

  #image("signature_elie.png", height: 1.8cm)

  #v(0.3cm)

  #line(length: 40%, stroke: 0.3pt + rgb("#cccccc"))
]
