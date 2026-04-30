// ============================================================================
//  ATTESTATION SUR L'HONNEUR — RÉGULARITÉ FISCALE ET SOCIALE
//  Pièce de substitution aux attestations DGFiP / URSSAF
//  pour société nouvellement immatriculée
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
        smallcaps[Attestation sur l'honneur — #company-name #company-short],
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
      #text(style: "italic")[#company-name #company-short — RCS Paris 104 126 727]
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

#v(0.8cm)

#align(center)[
  #text(size: 14pt, weight: "bold", fill: primary, tracking: 0.05em)[
    ATTESTATION SUR L'HONNEUR
  ]
  #v(4pt)
  #text(size: 11.5pt, weight: "bold", fill: secondary)[
    Régularité fiscale et sociale
  ]
  #v(6pt)
  #line(length: 40%, stroke: 0.8pt + accent)
]

#v(0.5cm)

#align(center)[
  #text(size: 9pt, fill: muted, style: "italic")[
    Pièce de substitution aux attestations DGFiP et URSSAF pour société nouvellement immatriculée — \
    article 262-0 bis, I, 2° du Code général des impôts ; articles 202 E et suivants de l'annexe II du CGI
  ]
]

#v(0.7cm)

// ── Identity of the legal representative ───────────────────────────────────

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
    text(weight: "bold", fill: secondary)[Demeurant au], [#founder-address],
    text(weight: "bold", fill: secondary)[Agissant en qualité de], [Président de #company-name #company-short],
  )
]

#v(0.5cm)

agissant en qualité de Président et représentant légal de la société *#company-name #company-short*, société par actions simplifiée au capital de #capital-initial euros, dont le siège social est situé #siege-social, immatriculée au Registre du Commerce et des Sociétés de Paris sous le numéro 104 126 727 (ci-après, la « Société »),

#v(0.5cm)

// ── Declaration ─────────────────────────────────────────────────────────────

#align(center)[
  #text(size: 11pt, weight: "bold", fill: primary)[Déclare sur l'honneur ce qui suit]
  #v(4pt)
  #line(length: 30%, stroke: 0.5pt + accent)
]

#v(0.5cm)

*1. Régularité fiscale.* La Société, immatriculée le 27 avril 2026 et donc dans son premier exercice social, n'a, à la date de la présente attestation, aucune dette fiscale échue auprès de la Direction Générale des Finances Publiques (DGFiP), aucune déclaration de TVA, d'impôt sur les sociétés, de cotisation foncière des entreprises (CFE) ou d'autre taxe n'étant encore exigible au titre de cet exercice.

#v(0.3cm)

*2. Indisponibilité de l'attestation en ligne.* La Société, étant dans son année de création, ne peut pas obtenir l'attestation de régularité fiscale par téléchargement direct depuis l'espace professionnel impots.gouv.fr, conformément à la doctrine administrative (BOFiP). Le formulaire n° 3666-SD sera adressé au Service des Impôts des Entreprises de Paris 8#super[ème] dès l'activation de l'espace professionnel de la Société, et la pièce sera transmise à la DGDDI en complément du présent dossier.

#v(0.3cm)

*3. Régularité sociale.* La Société n'emploie aucun salarié et ne verse aucune rémunération à ses dirigeants à la date de la présente attestation. Aucune cotisation, contribution sociale ou affiliation n'est par conséquent due à l'URSSAF, à Pôle Emploi ou à tout autre organisme de protection sociale obligatoire. La Société n'est donc pas en mesure de produire une attestation de vigilance URSSAF, faute d'assujettissement au régime général.

#v(0.3cm)

*4. Engagement.* La Société s'engage à transmettre sans délai à la DGDDI toute attestation officielle (DGFiP ou URSSAF) dès lors qu'elle deviendra obtenable, et à informer sans délai la DGDDI de toute modification de sa situation fiscale ou sociale susceptible d'affecter les conditions de l'agrément sollicité.

#v(0.3cm)

*5. Sincérité.* La présente déclaration est faite pour servir et valoir ce que de droit, et notamment pour compléter le dossier de demande d'agrément en qualité d'opérateur de détaxe déposé auprès de la Direction Générale des Douanes et Droits Indirects, conformément aux articles 202 E et suivants de l'annexe II du Code général des impôts.

#v(0.8cm)

// ── Signature ───────────────────────────────────────────────────────────────

#align(right)[
  Fait à *#siege-ville*, le *#date-signature*.
]

#v(0.4cm)

#align(right)[
  #pad(right: 2cm)[
    #image("signature_elie.png", height: 1.8cm)
  ]
]

#v(0.3cm)

#align(right)[
  *#founder-first #founder-last* \
  #text(size: 9pt, fill: muted)[Président de #company-name #company-short]
]

#v(0.6cm)

// ── Legal notice ────────────────────────────────────────────────────────────

#block(
  width: 100%,
  fill: light-bg,
  stroke: (left: 3pt + accent),
  inset: (left: 12pt, right: 12pt, top: 8pt, bottom: 8pt),
  radius: (right: 3pt),
)[
  #set text(size: 8pt, style: "italic", fill: muted)
  *Article 441-7 du Code pénal* — « Est puni d'un an d'emprisonnement et de 15 000 euros d'amende le fait : 1° D'établir une attestation ou un certificat faisant état de faits matériellement inexacts ; 2° De falsifier une attestation ou un certificat originellement sincère ; 3° De faire usage d'une attestation ou d'un certificat inexact ou falsifié. »
]
