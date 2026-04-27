// ============================================================================
//  DÉCLARATION DE NON-CONDAMNATION ET DE FILIATION — Elie BRUNO
// ============================================================================

#import "template.typ": *
#import "variables.typ": *

#set page(
  paper: "a4",
  margin: (top: 3.5cm, bottom: 3cm, left: 2.8cm, right: 2.8cm),
  header: context {
    if counter(page).get().first() >= 1 {
      set text(size: 8pt, fill: muted)
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        smallcaps[Déclaration de non-condamnation — #company-name #company-short],
        [],
      )
      v(2pt)
      line(length: 100%, stroke: 0.3pt + muted)
    }
  },
  footer: context {
    set text(size: 7pt, fill: muted)
    line(length: 100%, stroke: 0.3pt + muted)
    v(4pt)
    align(center)[
      #text(style: "italic")[#founder-first #founder-last]
    ]
  },
)

#set text(
  font: "New Computer Modern",
  size: 10.5pt,
  fill: body-color,
  lang: "fr",
)

#set par(
  justify: true,
  leading: 0.72em,
)

// ── Title ───────────────────────────────────────────────────────────────────

#v(1cm)

#align(center)[
  #text(size: 15pt, weight: "bold", fill: primary, tracking: 0.05em)[
    DÉCLARATION DE NON-CONDAMNATION ET DE FILIATION
  ]
  #v(6pt)
  #line(length: 40%, stroke: 0.8pt + accent)
]

#v(0.6cm)

#align(center)[
  #text(size: 9pt, fill: muted, style: "italic")[
    En application des dispositions de l'article A. 123-51 du Code de commerce
  ]
]

#v(0.8cm)

// ── Identity ────────────────────────────────────────────────────────────────

Je soussigné *#founder-first #founder-last*,

#v(0.2cm)

#block(
  width: 100%,
  fill: light-bg,
  inset: (x: 16pt, y: 12pt),
  radius: 3pt,
)[
  #grid(
    columns: (auto, 1fr),
    column-gutter: 12pt,
    row-gutter: 10pt,
    text(weight: "bold", fill: secondary)[Né le], [#founder-birthdate],
    text(weight: "bold", fill: secondary)[À], [#founder-birthplace],
    text(weight: "bold", fill: secondary)[Fils de], [Stéphane BRUNO],
    text(weight: "bold", fill: secondary)[Et de], [Sophie LAGET],
    text(weight: "bold", fill: secondary)[Demeurant au], [#founder-address],
  )
]

#v(0.6cm)

// ── Declaration ─────────────────────────────────────────────────────────────

#align(center)[
  #text(size: 11pt, weight: "bold", fill: primary)[Déclare sur l'honneur]
  #v(4pt)
  #line(length: 20%, stroke: 0.5pt + accent)
]

#v(0.6cm)

Conformément à l'article A. 123-51 du Code de commerce, n'avoir fait l'objet d'aucune condamnation pénale ni de sanction civile ou administrative de nature à m'interdire de gérer, administrer, diriger ou contrôler une personne morale, ou d'exercer une activité commerciale.

#v(1cm)

// ── Signature ───────────────────────────────────────────────────────────────

#align(right)[
  Fait à *#siege-ville*, le *#date-signature*.
]

#v(0.3cm)

#v(0.3cm)

#align(right)[
  #pad(right: 2cm)[
    #image("signature_elie.png", height: 1.8cm)
  ]
]

#v(0.5cm)

#align(right)[
  *#founder-first #founder-last*
]

#v(0.5cm)

// ── Legal notice ────────────────────────────────────────────────────────────

#block(
  width: 100%,
  fill: light-bg,
  stroke: (left: 3pt + accent),
  inset: (left: 12pt, right: 12pt, top: 8pt, bottom: 8pt),
  radius: (right: 3pt),
)[
  #set text(size: 8pt, style: "italic", fill: muted)
  *Article L. 123-5 du Code de commerce (alinéa 1)* — « Le fait de donner, de mauvaise foi, des indications inexactes ou incomplètes en vue d'une immatriculation, d'une radiation ou d'une mention complémentaire ou rectificative au registre du commerce et des sociétés est puni d'une amende de 4 500 € et d'un emprisonnement de 6 mois. »
]
