// ============================================================================
//  BELCOVA — Shared Typst Template for Legal Documents
//  Design system, page setup, typography, and utility functions
// ============================================================================

// ── Color Palette ────────────────────────────────────────────────────────────

#let primary    = rgb("#1a2744")   // Navy — titres, en-têtes
#let accent     = rgb("#c9a84c")   // Or — filets, accents
#let secondary  = rgb("#3a5a8c")   // Bleu acier — sous-titres
#let light-bg   = rgb("#f7f5f0")   // Crème — fonds de section
#let body-color = rgb("#2c2c2c")   // Gris foncé — texte courant
#let muted      = rgb("#888888")   // Gris — notes de bas de page

// ── Utility Functions ────────────────────────────────────────────────────────

#let note-box(body) = {
  block(
    width: 100%,
    fill: light-bg,
    stroke: (left: 3pt + accent),
    inset: (left: 12pt, right: 12pt, top: 8pt, bottom: 8pt),
    radius: (right: 3pt),
  )[
    #set text(size: 9pt, style: "italic", fill: muted)
    #body
  ]
}

#let article-counter = counter("article")

#let article(title) = {
  article-counter.step()
  v(0.8em)
  block(width: 100%)[
    #set text(size: 11pt, weight: "bold", fill: secondary)
    Article #context article-counter.display() — #title
    #v(2pt)
    #line(length: 30%, stroke: 0.3pt + accent)
  ]
  v(0.4em)
}

// ── Document Template ────────────────────────────────────────────────────────
// Apply with: #show: template.with(company-name: "...", ...)

#let template(
  company-name: "SOCIÉTÉ",
  company-short: "SAS",
  use-watermark: false,
  watermark-text: "EXEMPLAIRE ORIGINAL",
  watermark-opacity: 4%,
  use-signatures: false,
  paraphe-path: none,
  paraphe-height: 0.8cm,
  cofounder-paraphe-path: none,
  cofounder-paraphe-height: 0.8cm,
  founder-last: "",
  cofounder-last: "",
  body,
) = {
  // ── Page Setup ───────────────────────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (top: 3.5cm, bottom: 3cm, left: 2.8cm, right: 2.8cm),
    background: if use-watermark {
      place(center + horizon,
        rotate(-45deg,
          text(
            size: 60pt,
            fill: rgb("#000000").transparentize(100% - watermark-opacity),
            weight: "bold",
            tracking: 0.3em,
          )[#watermark-text]
        )
      )
    },
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 8pt, fill: muted)
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          smallcaps[Statuts — #company-name #company-short],
          [Page #counter(page).display() sur #counter(page).final().first()],
        )
        v(2pt)
        line(length: 100%, stroke: 0.3pt + muted)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        set text(size: 7pt, fill: muted)
        line(length: 100%, stroke: 0.3pt + muted)
        v(4pt)
        if use-signatures and paraphe-path != none and cofounder-paraphe-path != none {
          grid(
            columns: (1fr, 1fr, 1fr, 1fr),
            align: (left, left, center, right),
            [#image(paraphe-path, height: paraphe-height)],
            [#image(cofounder-paraphe-path, height: cofounder-paraphe-height)],
            [#counter(page).display() / #counter(page).final().first()],
            [#text(style: "italic", size: 7pt)[#founder-last · #cofounder-last]],
          )
        } else {
          align(center)[_Paraphes : \_\_\_\_\_\_\_\_ / \_\_\_\_\_\_\_\_  #h(2cm) #counter(page).display() / #counter(page).final().first()_]
        }
      }
    },
  )

  // ── Typography ─────────────────────────────────────────────────────────
  set text(
    font: "New Computer Modern",
    size: 10.5pt,
    fill: body-color,
    lang: "fr",
  )

  set par(
    justify: true,
    leading: 0.72em,
    first-line-indent: 1.2em,
  )

  // ── Heading Styles ─────────────────────────────────────────────────────
  show heading.where(level: 1): it => {
    v(1.8em)
    block(width: 100%)[
      #set text(size: 14pt, weight: "bold", fill: primary)
      #line(length: 100%, stroke: 1.5pt + accent)
      #v(6pt)
      #smallcaps(it.body)
      #v(4pt)
      #line(length: 100%, stroke: 0.5pt + accent)
    ]
    v(0.8em)
  }

  show heading.where(level: 2): it => {
    v(1.2em)
    block(width: 100%)[
      #set text(size: 11.5pt, weight: "bold", fill: secondary)
      #it.body
      #v(2pt)
      #line(length: 40%, stroke: 0.4pt + accent)
    ]
    v(0.5em)
  }

  show heading.where(level: 3): it => {
    v(0.8em)
    block[
      #set text(size: 10.5pt, weight: "bold", fill: primary)
      #it.body
    ]
    v(0.3em)
  }

  body
}
