// =============================================================================
// Page de garde
// =============================================================================

#import "../metadata.typ": *
#import "../style.typ": bleu-marine, rouge-marianne, th

#set page(header: none, footer: none)

#v(1.5cm)

// En-tête République Française
#align(center)[
  #block(width: 100%)[
    #set text(fill: bleu-marine)

    #text(size: 11pt, weight: "bold", tracking: 0.5pt)[RÉPUBLIQUE FRANÇAISE]

    #v(4pt)

    #text(size: 9.5pt)[
      Liberté -- Égalité -- Fraternité
    ]
  ]
]

#v(0.8cm)
#align(center)[#line(length: 60%, stroke: 1pt + bleu-marine)]
#v(0.8cm)

// Bloc DGDDI
#align(center)[
  #text(size: 10pt, fill: bleu-marine)[
    Direction Générale des Douanes et Droits Indirects
  ]
]

#v(1.5cm)

// Titre principal
#align(center)[
  #block(
    width: 85%,
    inset: 20pt,
    stroke: 1.5pt + bleu-marine,
    radius: 0pt,
  )[
    #set text(fill: bleu-marine)

    #text(size: 10pt, weight: "regular", tracking: 1pt)[PABLO — A 226]

    #v(8pt)

    #text(size: 20pt, weight: "bold")[
      Dossier de Certification \ de la Plateforme EDI
    ]

    #v(8pt)

    #text(size: 11pt)[
      Échanges Opérateurs de Détaxe -- Système PABLO
    ]

    #v(6pt)

    #text(size: 10pt)[
      Spécifications conformes au JSD v1.7 \
      et aux Spécifications EDI Opérateurs V5
    ]
  ]
]

#v(1.5cm)

// Informations de l'opérateur
#align(center)[
  #set text(size: 11pt)

  #text(weight: "bold")[#entreprise-nom]

  #v(4pt)

  #text(size: 10pt)[
    SIREN : #entreprise-siren \
    N° TVA intracommunautaire : #entreprise-tva-intra \
    #entreprise-adresse, #entreprise-code-postal #entreprise-ville
  ]
]

#v(1.2cm)

// Version et date
#align(center)[
  #set text(size: 10pt)
  Version #document-version — #document-date
]

#v(0.8cm)

// Mention de classification
#align(center)[
  #block(
    inset: (x: 15pt, y: 8pt),
    stroke: 1pt + rouge-marianne,
  )[
    #set text(size: 10pt, fill: rouge-marianne, weight: "bold", tracking: 1pt)
    #document-classification
  ]
]
