// =============================================================================
// BELCOVA SAS — Bilan d'ouverture au 27 avril 2026
// =============================================================================

// ── Couleurs (même charte que le prévisionnel) ──────────────────────────────
#let navy     = rgb("#1a2744")
#let gold     = rgb("#c9a84c")
#let steel    = rgb("#3a5a8c")
#let cream    = rgb("#f7f5f0")
#let body-clr = rgb("#2c2c2c")
#let muted    = rgb("#888888")

#let th(content) = table.cell(
  fill: navy,
  text(weight: "bold", fill: white, size: 9pt, content),
)
#let total-cell(content) = table.cell(
  fill: cream,
  text(weight: "bold", size: 9pt, content),
)

// ── Mise en page ────────────────────────────────────────────────────────────

#set document(
  title: "Bilan d'ouverture — BELCOVA SAS",
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
        smallcaps[Bilan d'ouverture — BELCOVA SAS],
        [Page #counter(page).display() sur #counter(page).final().first()],
      )
      v(2pt)
      line(length: 100%, stroke: 0.3pt + muted)
    }
  },
  footer: context {
    line(length: 100%, stroke: 0.3pt + muted)
    v(4pt)
    set text(size: 7pt, fill: muted)
    align(center)[
      BELCOVA SAS — RCS Paris 104 126 727
    ]
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

// ═════════════════════════════════════════════════════════════════════════════
//  PAGE DE GARDE
// ═════════════════════════════════════════════════════════════════════════════

#v(4cm)

#align(center)[
  #block(
    width: 85%,
    inset: 24pt,
    stroke: 1.5pt + navy,
  )[
    #set text(fill: navy)

    #text(size: 22pt, weight: "bold")[
      Bilan d'ouverture
    ]

    #v(8pt)

    #text(size: 14pt, fill: steel)[
      Au 27 avril 2026
    ]

    #v(12pt)
    #line(length: 40%, stroke: 1pt + gold)
    #v(12pt)

    #text(size: 12pt, weight: "bold")[BELCOVA SAS]

    #v(4pt)

    #text(size: 10pt)[
      Société par Actions Simplifiée au capital de 100 € \
      RCS Paris 104 126 727 \
      58 Rue de Monceau, 75008 Paris
    ]
  ]
]

#v(3cm)

#align(center)[
  #set text(size: 10pt, fill: muted)
  Date d'immatriculation : 27 avril 2026 \
  Premier exercice social : du 27 avril 2026 au 31 décembre 2026
]

#pagebreak()

// ═════════════════════════════════════════════════════════════════════════════
//  BILAN D'OUVERTURE
// ═════════════════════════════════════════════════════════════════════════════

= Bilan d'ouverture au 27 avril 2026

Le présent bilan d'ouverture est établi à la date d'immatriculation de la société BELCOVA SAS au Registre du Commerce et des Sociétés de Paris.

#v(1em)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 24pt,

  // ── ACTIF ──
  [
    #table(
      columns: (2fr, 1fr),
      table.header(
        th[Actif],
        th[Montant (€)],
      ),
      table.cell(colspan: 2, fill: cream)[
        #text(weight: "bold", size: 9pt)[Actif immobilisé]
      ],
      [Immobilisations incorporelles], [0],
      [Immobilisations corporelles], [0],
      [Immobilisations financières], [0],
      total-cell[*Total actif immobilisé*], total-cell[*0*],

      table.cell(colspan: 2, fill: cream)[
        #text(weight: "bold", size: 9pt)[Actif circulant]
      ],
      [Créances], [0],
      [Disponibilités (Qonto)], [100],
      total-cell[*Total actif circulant*], total-cell[*100*],

      [], [],
      total-cell[*TOTAL ACTIF*], total-cell[*100*],
    )
  ],

  // ── PASSIF ──
  [
    #table(
      columns: (2fr, 1fr),
      table.header(
        th[Passif],
        th[Montant (€)],
      ),
      table.cell(colspan: 2, fill: cream)[
        #text(weight: "bold", size: 9pt)[Capitaux propres]
      ],
      [Capital social], [100],
      [Réserves], [0],
      [Report à nouveau], [0],
      total-cell[*Total capitaux propres*], total-cell[*100*],

      table.cell(colspan: 2, fill: cream)[
        #text(weight: "bold", size: 9pt)[Dettes]
      ],
      [Dettes financières], [0],
      [Dettes fournisseurs], [0],
      total-cell[*Total dettes*], total-cell[*0*],

      [], [],
      total-cell[*TOTAL PASSIF*], total-cell[*100*],
    )
  ],
)

#v(1.5em)

#block(
  width: 100%,
  fill: cream,
  stroke: (left: 3pt + gold),
  inset: (left: 12pt, right: 12pt, top: 8pt, bottom: 8pt),
  radius: (right: 3pt),
)[
  #set text(size: 9pt, style: "italic", fill: muted)
  *Composition du capital* : 10 000 actions de 0,01 € de valeur nominale, intégralement souscrites et libérées. \
  Elie BRUNO : 5 500 actions (55 %) — Franklin TRANIÉ : 4 500 actions (45 %).
]

#v(1em)

Le capital social de 100 € a été intégralement libéré et déposé sur le compte bancaire de la société (Qonto) à la date d'immatriculation. Aucun apport en nature n'a été réalisé.

À la date d'ouverture, la société ne détient aucune immobilisation, aucune créance et aucune dette. Les frais de constitution (670 €) seront comptabilisés en charges sur l'exercice 2026.

#v(3em)

#align(center)[
  #line(length: 30%, stroke: 0.5pt + muted)
  #v(0.5em)
  #text(size: 9pt, fill: muted)[
    Fait à Paris, le 29 avril 2026 \
    Elie BRUNO — Président
  ]
]
