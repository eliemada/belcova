// =============================================================================
// Style du dossier de certification EDI — PABLO / DGDDI
// =============================================================================

#import "metadata.typ": *

// ---------------------------------------------------------------------------
// Couleurs
// ---------------------------------------------------------------------------
#let bleu-marine = rgb("#000091")       // Bleu République Française
#let bleu-fonce = rgb("#1B1B35")
#let gris-clair = rgb("#F5F5F5")
#let gris-bordure = rgb("#CCCCCC")
#let rouge-marianne = rgb("#E1000F")

// ---------------------------------------------------------------------------
// Polices
// ---------------------------------------------------------------------------
#let police-titre = "New Computer Modern"
#let police-corps = "New Computer Modern"
#let police-code = "DejaVu Sans Mono"

// ---------------------------------------------------------------------------
// Cellule d'en-tête de tableau (bleu marine + texte blanc)
// ---------------------------------------------------------------------------
#let th(content) = table.cell(
  fill: bleu-marine,
  text(weight: "bold", fill: white, size: 9.5pt, content),
)

// ---------------------------------------------------------------------------
// Mise en page du document
// ---------------------------------------------------------------------------
#let setup-document(body) = {
  set document(
    title: "Dossier de Certification de la Plateforme EDI — PABLO",
    author: entreprise-nom,
    date: auto,
  )

  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 8pt, fill: bleu-marine)
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [Dossier de Certification EDI — PABLO],
          [#document-classification],
        )
        v(-4pt)
        line(length: 100%, stroke: 0.5pt + bleu-marine)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        line(length: 100%, stroke: 0.3pt + gris-bordure)
        v(-2pt)
        set text(size: 8pt, fill: bleu-fonce)
        grid(
          columns: (1fr, 1fr, 1fr),
          align: (left, center, right),
          [#entreprise-nom],
          [Version #document-version — #document-date],
          [Page #counter(page).display("1 / 1", both: true)],
        )
      }
    },
  )

  // Polices globales
  set text(
    font: police-corps,
    size: 10.5pt,
    lang: "fr",
    region: "FR",
  )

  // Paragraphes
  set par(justify: true, leading: 0.65em)

  // Titres numérotés "1.1.1."
  set heading(numbering: "1.1.1.")
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1em)
    set text(size: 16pt, weight: "bold", fill: bleu-marine)
    block(it)
    v(0.5em)
  }
  show heading.where(level: 2): it => {
    v(0.8em)
    set text(size: 13pt, weight: "bold", fill: bleu-marine)
    block(it)
    v(0.3em)
  }
  show heading.where(level: 3): it => {
    v(0.6em)
    set text(size: 11pt, weight: "bold", fill: bleu-fonce)
    block(it)
    v(0.2em)
  }

  // Tableaux
  set table(
    stroke: 0.5pt + gris-bordure,
    inset: 6pt,
  )

  // Blocs de code
  show raw.where(block: true): it => {
    set text(font: police-code, size: 8.5pt)
    block(
      width: 100%,
      fill: gris-clair,
      inset: 10pt,
      radius: 3pt,
      stroke: 0.5pt + gris-bordure,
      it,
    )
  }
  show raw.where(block: false): it => {
    set text(font: police-code, size: 9pt)
    box(
      fill: gris-clair,
      inset: (x: 3pt, y: 1.5pt),
      radius: 2pt,
      it,
    )
  }

  // Listes
  set list(marker: ([--], [--], [--]))
  set enum(numbering: "1.a.i.")

  body
}

// ---------------------------------------------------------------------------
// Composants réutilisables
// ---------------------------------------------------------------------------

// Tableau de champs JSD — colonnes ajustées pour éviter les débordements
#let jsd-table(..rows) = {
  set text(size: 9pt)
  table(
    columns: (2.2fr, 2.2fr, 0.7fr, 0.6fr, 3.3fr),
    table.header(
      th[Champ], th[Type JSD], th[Req.], th[Card.], th[Contraintes],
    ),
    ..rows.pos().flatten(),
  )
}

// Encadré « Important »
#let encadre-important(body) = {
  block(
    width: 100%,
    fill: rgb("#FFF3CD"),
    inset: 10pt,
    radius: 3pt,
    stroke: 0.5pt + rgb("#856404"),
    [
      #set text(size: 9.5pt)
      #strong[Important :] #body
    ],
  )
}

// Encadré « Note technique »
#let note-technique(body) = {
  block(
    width: 100%,
    fill: rgb("#D1ECF1"),
    inset: 10pt,
    radius: 3pt,
    stroke: 0.5pt + rgb("#0C5460"),
    [
      #set text(size: 9.5pt)
      #strong[Note technique :] #body
    ],
  )
}

// Référence JSON exemple
#let json-exemple(chemin) = {
  let contenu = read(chemin)
  raw(contenu, lang: "json", block: true)
}
