// ============================================================================
//  STATUTS SAS BELCOVA — Typst
//  State-of-the-art 2026 — Capital Variable — Startup-ready
// ============================================================================

#import "template.typ": *

// ── Placeholders — à remplir avant signature ───────────────────────────────

#let company-name        = "BELCOVA"
#let company-legal-form  = "Société par Actions Simplifiée à Capital Variable"
#let company-short       = "SAS"
// ── Associé Fondateur 1 — Président ──────────────────────────────────────
#let founder-first       = "Elie"
#let founder-last        = "BRUNO"
#let founder-nationality = "française"
#let founder-birthdate   = "12 décembre 2005"
#let founder-birthplace  = "Royan (Charente-Maritime)"
#let founder-address     = "29 Bis Rue de la Crête, 17110 Saint-Georges-de-Didonne"
#let founder1-actions    = "60"

// ── Associé Fondateur 2 — Directeur Général ─────────────────────────────
#let cofounder-first       = "Franklin"
#let cofounder-last        = "TRANIÉ"
#let cofounder-nationality = "française"
#let cofounder-birthdate   = "11 février 2004"
#let cofounder-birthplace  = "Neuilly-sur-Seine (Hauts-de-Seine)"
#let cofounder-address     = "3 Rue de Rouvray, 92200 Neuilly-sur-Seine"
#let cofounder-actions     = "40"

// ── Société ─────────────────────────────────────────────────────────────
#let siege-social        = "29 Bis Rue de la Crête, 17110 Saint-Georges-de-Didonne"
#let siege-ville         = "Saint-Georges-de-Didonne"
#let capital-initial     = "100"
#let capital-plancher    = "10"
#let capital-plafond     = "1 000 000"
#let nb-actions          = "100"
#let valeur-nominale     = "1"
#let duree-societe       = "99"
#let date-signature      = "2 mars 2026"
#let rcs-ville           = "La Rochelle"
#let exercice-debut      = "1er janvier"
#let exercice-fin        = "31 décembre"

// ── Signature & Paraphe ────────────────────────────────────────────────────
// Instructions :
//   1. Signez sur papier blanc, photographiez/scannez en PNG
//   2. Retirez le fond (https://remove.bg ou Preview.app sur Mac)
//   3. Placez les fichiers dans docs/legal/ et mettez à jour les chemins ci-dessous
//   4. Mettez `use-signatures` à `true` pour activer

#let use-signatures      = false                          // ✗ images absentes — réactiver après ajout des PNG
#let signature-path      = "signature.png"                // ← signature fondateur 1 (PNG, fond transparent)
#let paraphe-path        = "paraphe.png"                  // ← paraphe fondateur 1 (PNG, fond transparent)
#let signature-height    = 2.5cm
#let paraphe-height      = 0.8cm
#let cofounder-signature-path = "signature_franklin.png"  // ← signature fondateur 2 (PNG, fond transparent)
#let cofounder-paraphe-path   = "paraphe_franklin.png"    // ← paraphe fondateur 2 (PNG, fond transparent)
#let cofounder-signature-height = 2.5cm
#let cofounder-paraphe-height   = 0.8cm

// ── Filigrane (watermark) ──────────────────────────────────────────────────
// Protège contre la réutilisation abusive du document (pappers.fr, etc.)
// Options : "CONFIDENTIEL", "EXEMPLAIRE ORIGINAL", "COPIE", "NE PAS DIFFUSER"

#let use-watermark       = false                          // désactivé (pas nécessaire pour le greffe)
#let watermark-text      = "EXEMPLAIRE ORIGINAL"          // ← texte du filigrane
#let watermark-opacity   = 4%                             // ← discret mais visible à l'inspection

// ── Apply Template ───────────────────────────────────────────────────────────

#show: template.with(
  company-name: company-name,
  company-short: company-short,
  use-watermark: use-watermark,
  watermark-text: watermark-text,
  watermark-opacity: watermark-opacity,
  use-signatures: use-signatures,
  paraphe-path: paraphe-path,
  paraphe-height: paraphe-height,
  cofounder-paraphe-path: cofounder-paraphe-path,
  cofounder-paraphe-height: cofounder-paraphe-height,
  founder-last: founder-last,
  cofounder-last: cofounder-last,
)

// ════════════════════════════════════════════════════════════════════════════
//  PAGE DE GARDE
// ════════════════════════════════════════════════════════════════════════════

#page(header: none, footer: none)[
  #v(2cm)

  #align(center)[
    // Cadre décoratif supérieur
    #line(length: 60%, stroke: 2pt + accent)
    #v(8pt)
    #line(length: 45%, stroke: 0.5pt + accent)

    #v(1.2cm)

    #text(size: 32pt, weight: "bold", fill: primary, tracking: 0.15em)[
      #smallcaps(company-name)
    ]

    #v(6pt)

    #text(size: 11pt, fill: secondary, tracking: 0.08em)[
      #company-legal-form
    ]

    #v(1.8cm)

    #block(
      width: 70%,
      stroke: 1pt + primary,
      inset: 20pt,
      radius: 2pt,
    )[
      #set text(size: 18pt, weight: "bold", fill: primary)
      #align(center)[STATUTS CONSTITUTIFS]
    ]

    #v(1.5cm)

    #text(size: 10pt, fill: body-color)[
      Capital social initial : #capital-initial € \
      Siège social : #siege-social \
    ]

    #v(0.8cm)

    // Cadre décoratif inférieur
    #line(length: 45%, stroke: 0.5pt + accent)
    #v(8pt)
    #line(length: 60%, stroke: 2pt + accent)

    #v(2cm)

    #text(size: 9pt, fill: muted)[
      Statuts établis en date du #date-signature \
      Conformes aux dispositions des articles L. 227-1 et suivants du Code de commerce \
      et aux articles L. 231-1 et suivants relatifs aux sociétés à capital variable \
      \
      Associés fondateurs : #founder-last #founder-first (60 %) · #cofounder-last #cofounder-first (40 %)
    ]
  ]
]

// ════════════════════════════════════════════════════════════════════════════
//  TABLE DES MATIÈRES
// ════════════════════════════════════════════════════════════════════════════

#page(header: none, footer: none)[
  #v(1cm)
  #align(center)[
    #text(size: 16pt, weight: "bold", fill: primary)[TABLE DES MATIÈRES]
    #v(4pt)
    #line(length: 40%, stroke: 0.5pt + accent)
  ]
  #v(1cm)

  #set text(size: 10pt)

  #show outline.entry: it => {
    it.indented(it.prefix(), it.body() + [ ] + box(width: 1fr, repeat[.#h(2pt)]) + [ ] + it.page())
  }
  #outline(
    title: none,
    indent: 1.5em,
  )
]

// ════════════════════════════════════════════════════════════════════════════
//  PRÉAMBULE
// ════════════════════════════════════════════════════════════════════════════

#page(header: none, footer: none)[
  #v(1cm)
  #align(center)[
    #text(size: 16pt, weight: "bold", fill: primary)[PRÉAMBULE]
    #v(4pt)
    #line(length: 40%, stroke: 0.5pt + accent)
  ]
  #v(1cm)

  Les présents statuts sont établis en vue de la constitution d'une Société par Actions Simplifiée à capital variable, conformément aux dispositions des articles L. 227-1 à L. 227-20 et L. 231-1 à L. 231-8 du Code de commerce.

  La société a pour ambition de devenir un opérateur de détaxe de référence en France et en Europe, en proposant une plateforme technologique moderne de remboursement de TVA pour les voyageurs internationaux, en conformité avec le système PABLO de la Direction Générale des Douanes et Droits Indirects (DGDDI).

  #v(0.5cm)

  #note-box[
    Les présents statuts ont été rédigés dans une optique d'évolutivité, anticipant l'entrée future d'associés (business angels, fonds d'investissement) et la mise en place d'instruments d'intéressement (BSPCE, BSA, actions gratuites). Ils intègrent les meilleures pratiques du droit des sociétés français en vigueur en 2026 et prévoient des dispositions protectrices pour l'ensemble des associés fondateurs.
  ]

  #v(0.5cm)

  #text(weight: "bold", fill: primary)[Associés fondateurs :]

  #v(0.3cm)

  #block(
    width: 100%,
    fill: light-bg,
    inset: 15pt,
    radius: 3pt,
    stroke: 0.5pt + accent,
  )[
    #set par(first-line-indent: 0em)
    *1. #founder-last #founder-first* \
    Né le #founder-birthdate à #founder-birthplace \
    De nationalité #founder-nationality \
    Demeurant au : #founder-address \
    Souscripteur de *#founder1-actions actions*, soit *60 %* du capital social initial. \
    \
    Ci-après dénommé l'« *Associé Fondateur 1* » ou le « *Président* ».
  ]

  #v(0.3cm)

  #block(
    width: 100%,
    fill: light-bg,
    inset: 15pt,
    radius: 3pt,
    stroke: 0.5pt + accent,
  )[
    #set par(first-line-indent: 0em)
    *2. #cofounder-last #cofounder-first* \
    Né le #cofounder-birthdate à #cofounder-birthplace \
    De nationalité #cofounder-nationality \
    Demeurant au : #cofounder-address \
    Souscripteur de *#cofounder-actions actions*, soit *40 %* du capital social initial. \
    \
    Ci-après dénommé l'« *Associé Fondateur 2* » ou le « *Directeur Général* ».
  ]

  #v(0.3cm)

  _Ci-après désignés ensemble les « *Associés Fondateurs* »._
]


// ════════════════════════════════════════════════════════════════════════════
//  TITRE I — FORME · OBJET · DÉNOMINATION · SIÈGE · DURÉE
// ════════════════════════════════════════════════════════════════════════════

= Titre I — Forme, Objet, Dénomination, Siège, Durée

#article[Forme]

Il est constitué entre les propriétaires des actions ci-après créées et de celles qui pourront l'être ultérieurement, une Société par Actions Simplifiée à capital variable, régie par les dispositions législatives et réglementaires en vigueur, notamment les articles L. 227-1 et suivants et L. 231-1 et suivants du Code de commerce, ainsi que par les présents statuts.

La Société est constituée entre deux associés fondateurs. Elle pourra fonctionner indifféremment sous la forme de Société par Actions Simplifiée (SAS) pluripersonnelle ou, le cas échéant, de Société par Actions Simplifiée Unipersonnelle (SASU) si elle ne comprend qu'un seul associé.

#article[Objet social]

La Société a pour objet, en France et à l'étranger :

- La conception, le développement, l'édition et la commercialisation de logiciels, applications mobiles, plateformes numériques et solutions SaaS ;
- L'exploitation d'une plateforme numérique de remboursement de taxe sur la valeur ajoutée (TVA) au profit des voyageurs non-résidents de l'Union européenne, conformément à la réglementation douanière applicable ;
- L'activité d'opérateur de détaxe agréé par la Direction Générale des Douanes et Droits Indirects (DGDDI) dans le cadre du système PABLO ;
- La fourniture de services technologiques aux commerçants, détaillants et entreprises, notamment pour la gestion des bordereaux de vente à l'exportation et la conformité douanière et fiscale ;
- La fourniture de services de paiement, de transfert de fonds et de services financiers connexes, en conformité avec la réglementation bancaire et financière applicable ;
- Le conseil, la formation et l'assistance aux entreprises en matière de technologies numériques, de conformité réglementaire et d'optimisation fiscale ;
- La prise de participations dans toute société ou entreprise, par tous moyens, la gestion de ces participations et, plus généralement, toutes opérations de holding ;
- Et plus généralement, toutes opérations industrielles, commerciales, financières, civiles, mobilières ou immobilières, pouvant se rattacher directement ou indirectement à l'un des objets spécifiés ci-dessus ou à tout objet similaire ou connexe, de nature à favoriser le développement de la Société.

#article[Dénomination sociale]

La dénomination sociale de la Société est : *#company-name*.

Dans tous les actes et documents émanant de la Société et destinés aux tiers, la dénomination sociale sera précédée ou suivie immédiatement des mots « Société par Actions Simplifiée à capital variable » ou des initiales « SAS à capital variable », de l'énonciation du montant du capital social, du numéro d'immatriculation au Registre du Commerce et des Sociétés suivi de la mention RCS et du nom de la ville où se trouve le greffe auprès duquel la Société est immatriculée.

#article[Siège social]

Le siège social est fixé au : *#siege-social*.

Il pourra être transféré en tout autre endroit du même département ou d'un département limitrophe par simple décision du Président, sous réserve de ratification par la collectivité des associés lors de la plus prochaine décision collective.

Le transfert du siège social en tout autre lieu sera décidé par décision collective extraordinaire des associés.

La Société peut établir des agences, succursales, bureaux, dépôts et comptoirs en tous lieux et dans tous pays, par décision du Président.

#article[Durée]

La durée de la Société est fixée à *#duree-societe ans* à compter de la date de son immatriculation au Registre du Commerce et des Sociétés, sauf dissolution anticipée ou prorogation décidée par la collectivité des associés.

Un an au moins avant la date d'expiration de la Société, le Président devra provoquer une décision collective des associés à l'effet de décider si la Société doit être prorogée.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE II — APPORTS · CAPITAL SOCIAL · CAPITAL VARIABLE
// ════════════════════════════════════════════════════════════════════════════

= Titre II — Apports, Capital Social, Capital Variable

#article[Apports]

=== Apports en numéraire

Les Associés Fondateurs apportent à la Société les sommes suivantes :

- *#founder-last #founder-first* apporte la somme de *soixante euros (60 €)*, correspondant à *#founder1-actions actions* d'une valeur nominale de *#valeur-nominale euro* chacune, entièrement souscrites et intégralement libérées ;

- *#cofounder-last #cofounder-first* apporte la somme de *quarante euros (40 €)*, correspondant à *#cofounder-actions actions* d'une valeur nominale de *#valeur-nominale euro* chacune, entièrement souscrites et intégralement libérées.

Soit un total de *#capital-initial euros* (#capital-initial €), correspondant à *#nb-actions actions*.

Ces sommes ont été déposées sur un compte ouvert au nom de la Société en formation auprès de *Shine France* (SIREN 828 701 557), établissement de paiement agréé, ainsi qu'il résulte du certificat de dépôt des fonds délivré par ledit établissement.

#note-box[
  Les fonds seront mis à la disposition du Président dès l'immatriculation de la Société au Registre du Commerce et des Sociétés, sur présentation de l'extrait K-bis.
]

=== Apports en industrie

Les présents statuts autorisent les apports en industrie, conformément à l'article L. 227-1 du Code de commerce. Les modalités d'un éventuel apport en industrie (nature, durée, évaluation, droits attachés) seront déterminées par décision collective unanime des associés et feront l'objet d'un avenant aux présents statuts.

Les actions émises en rémunération d'apports en industrie seront des actions inaliénables, qui ne concourent pas à la formation du capital social mais donnent droit au partage des bénéfices et de l'actif net.

#article[Capital social — Clause de variabilité]

=== Capital social statutaire

Le capital social initial est fixé à la somme de *#capital-initial euros* (#capital-initial €), divisé en *#nb-actions actions* de *#valeur-nominale euro* de valeur nominale chacune, entièrement souscrites et intégralement libérées, toutes de même catégorie, réparties comme suit :

- *#founder-last #founder-first* : #founder1-actions actions, soit 60 % du capital ;
- *#cofounder-last #cofounder-first* : #cofounder-actions actions, soit 40 % du capital.

=== Variabilité du capital

Conformément aux articles L. 231-1 à L. 231-8 du Code de commerce, le capital social est *variable*.

Il pourra être augmenté par des versements successifs des associés ou l'admission de nouveaux associés, et réduit par la reprise totale ou partielle des apports effectués, sans qu'il soit nécessaire de procéder aux formalités de publicité et de modification des statuts prévues pour les augmentations et les réductions de capital.

- *Capital plancher* : le capital social ne pourra être réduit en dessous de *#capital-plancher euros* (#capital-plancher €), soit dix pour cent (10 %) du capital initial.
- *Capital plafond (autorisé)* : le capital social pourra être augmenté jusqu'à *#capital-plafond euros* (#capital-plafond €) sans modification des statuts.

Toute augmentation du capital dans les limites de la clause de variabilité est soumise à l'*autorisation préalable* de la collectivité des associés statuant à la majorité des *deux tiers (2/3)* des voix. L'admission de tout nouvel associé par voie de souscription est en outre soumise à la *procédure d'agrément* prévue aux présents statuts, dans les mêmes conditions que pour les cessions à des tiers. Chaque associé bénéficie d'un *droit préférentiel de souscription* proportionnel à sa participation, exerçable dans un délai de *trente (30) jours* à compter de la notification du projet d'augmentation.

L'augmentation ou la réduction du capital sera constatée par le Président, qui modifiera le montant du capital social figurant dans les statuts.

Au-delà du capital plafond, toute augmentation de capital devra être décidée par la collectivité des associés statuant dans les conditions de majorité requises pour les décisions extraordinaires.

=== Droit de reprise des apports

Le retrait d'un associé par voie de reprise de ses apports est soumis à l'*autorisation préalable* de la collectivité des associés, statuant à la majorité des *deux tiers (2/3)* des voix, l'associé demandeur ne prenant pas part au vote.

La demande de retrait est notifiée au Président par lettre recommandée avec accusé de réception au moins *six (6) mois* avant la clôture de l'exercice social en cours. Le Président soumet la demande au vote de la collectivité des associés dans un délai de *deux (2) mois*.

En cas d'autorisation, le retrait prendra effet à la clôture de l'exercice au cours duquel la demande aura été formulée. Le prix de remboursement sera déterminé conformément aux dispositions de l'article 1843-4 du Code civil, à défaut d'accord entre les parties.

Le remboursement est *conditionné* à la capacité de trésorerie de la Société : il ne pourra être effectué si la trésorerie disponible, après remboursement, deviendrait inférieure à trois (3) mois de charges d'exploitation courantes. Dans ce cas, le remboursement sera échelonné sur une durée maximale de vingt-quatre (24) mois.

En cas de refus d'autorisation, l'associé pourra céder ses actions à un tiers ou aux autres associés dans les conditions prévues aux clauses de cession des présents statuts.

#article[Catégories d'actions]

La Société peut émettre, sur décision collective extraordinaire des associés, des actions de catégories différentes, notamment :

=== Actions ordinaires (catégorie A)

Les actions ordinaires confèrent à leurs titulaires :
- Le droit de vote aux décisions collectives, à raison d'une voix par action ;
- Le droit au dividende ;
- Le droit préférentiel de souscription aux augmentations de capital ;
- Le droit au boni de liquidation, au prorata de leur participation.

=== Actions de préférence

La Société pourra émettre des actions de préférence, avec ou sans droit de vote, assorties de droits particuliers de toute nature, à titre temporaire ou permanent, conformément aux articles L. 228-11 et suivants du Code de commerce.

Les actions de préférence pourront notamment conférer :
- Un droit à dividende prioritaire et/ou majoré ;
- Un droit de liquidation préférentielle (_liquidation preference_), simple ou participante ;
- Des droits de vote multiples ou un droit de veto sur certaines décisions ;
- Un droit d'information renforcé ;
- Un droit de représentation au sein d'organes de gouvernance ;
- Un droit de conversion en actions ordinaires.

Les conditions d'émission et les droits attachés à chaque catégorie d'actions de préférence seront déterminés par la décision collective extraordinaire autorisant leur émission.

#article[Libération des actions]

Les actions composant le capital initial sont *intégralement libérées* à la constitution, ainsi qu'il résulte du certificat de dépôt des fonds.

Pour les *émissions ultérieures* d'actions, les actions souscrites en numéraire devront être libérées de la moitié au moins de leur valeur nominale lors de la souscription. Le surplus sera libéré en une ou plusieurs fois, dans un délai maximum de cinq (5) ans à compter de la date d'émission, sur appel du Président.

À défaut de libération dans les délais prévus, les actions non libérées pourront faire l'objet d'une vente forcée dans les conditions prévues par la loi, après mise en demeure restée infructueuse.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE III — ACTIONS · CESSIONS · CLAUSES PROTECTRICES
// ════════════════════════════════════════════════════════════════════════════

= Titre III — Actions, Cessions et Clauses Protectrices

#article[Droits et obligations attachés aux actions]

Chaque action donne droit, dans la propriété de l'actif social et dans le partage des bénéfices, à une part proportionnelle au nombre d'actions existantes, sous réserve des droits particuliers attachés aux actions de préférence.

Les droits et obligations attachés à chaque action la suivent dans quelque main qu'elle passe. La propriété d'une action emporte de plein droit adhésion aux présents statuts et aux décisions régulièrement prises par la collectivité des associés.

Les associés ne sont responsables des pertes qu'à concurrence de leurs apports.

Les héritiers, créanciers, ayants-droit ou autres représentants d'un associé ne peuvent requérir l'apposition de scellés sur les biens et valeurs de la Société, ni en demander le partage ou la licitation, ni s'immiscer dans les actes de son administration.

#article[Indivisibilité des actions — Nue-propriété et usufruit]

Les actions sont indivisibles à l'égard de la Société. Les copropriétaires d'actions indivises sont tenus de se faire représenter par un mandataire unique choisi parmi eux ou en dehors d'eux.

En cas de démembrement de la propriété des actions, le droit de vote appartient au nu-propriétaire pour toutes les décisions collectives, sauf pour les décisions relatives à l'affectation des bénéfices, pour lesquelles le droit de vote est réservé à l'usufruitier. Toutefois, les associés pourront convenir d'une répartition différente du droit de vote entre nu-propriétaire et usufruitier, sous réserve d'en informer la Société.

#article[Registre des mouvements de titres]

La Société tient un registre des mouvements de titres, sous forme électronique ou papier, sur lequel sont inscrits, dans l'ordre chronologique, les souscriptions, achats, ventes, cessions, transmissions, échanges, nantissements et conversions d'actions. Ce registre peut être tenu sur un support numérique sécurisé.

Les transferts de propriété des actions résultent de leur inscription sur le registre des mouvements de titres de la Société. Cette inscription est effectuée par le Président ou son délégataire sur production d'un ordre de mouvement signé par le cédant ou son mandataire.

#article[Clause d'agrément]

=== Principe

Toute cession d'actions à un tiers non-associé, à quelque titre que ce soit (vente, apport, échange, donation, transmission universelle de patrimoine), est soumise à l'agrément préalable de la collectivité des associés statuant à la majorité des deux tiers (2/3) des voix des associés disposant du droit de vote, l'associé cédant ne prenant pas part au vote.

=== Procédure

Le projet de cession est notifié au Président par lettre recommandée avec accusé de réception ou par voie électronique avec accusé de réception, en indiquant le nombre d'actions dont la cession est envisagée, l'identité du cessionnaire pressenti, le prix et les conditions de la cession.

Le Président dispose d'un délai de *trois (3) mois* à compter de la réception de la notification pour faire connaître sa décision. À défaut de réponse dans ce délai, l'agrément est réputé acquis.

=== Refus d'agrément

En cas de refus d'agrément, les associés sont tenus, dans un délai de *trois (3) mois* à compter de la notification du refus, d'acquérir ou de faire acquérir les actions à un prix déterminé dans les conditions prévues à l'article 1843-4 du Code civil.

À défaut d'accord, le prix sera fixé par un expert désigné soit par les parties, soit à défaut d'accord entre elles, par ordonnance du Président du Tribunal de commerce compétent, statuant en la forme des référés.

=== Exceptions

Ne sont pas soumises à la procédure d'agrément les cessions entre associés existants, entre conjoints, entre ascendants et descendants, ainsi que les transmissions pour cause de décès.

#article[Droit de préemption]

=== Principe

En cas de projet de cession d'actions par un associé (le « *Cédant* »), les autres associés bénéficient d'un droit de préemption proportionnel à leur participation dans le capital social.

=== Procédure

Le Cédant notifie au Président son intention de céder, en précisant le nombre d'actions, le prix unitaire, l'identité du cessionnaire pressenti et les conditions de la cession.

Le Président en informe les autres associés dans un délai de *cinq (5) jours ouvrés*. Chaque associé dispose d'un délai de *trente (30) jours* à compter de cette notification pour exercer son droit de préemption, par lettre recommandée avec accusé de réception ou par voie électronique avec accusé de réception adressée au Président.

Si les droits de préemption exercés portent sur un nombre d'actions supérieur au nombre d'actions offertes, les actions seront réparties proportionnellement à la participation de chaque associé ayant exercé son droit.

En cas de non-exercice ou d'exercice partiel du droit de préemption, le Cédant pourra librement céder les actions non préemptées au cessionnaire pressenti, aux conditions notifiées, sous réserve de l'obtention de l'agrément prévu à l'article ci-dessus.

#article[Clause de sortie conjointe (_tag-along_)]

En cas de projet de cession portant sur un nombre d'actions représentant plus de *cinquante pour cent (50 %)* du capital social, que cette cession soit réalisée par un seul ou plusieurs associés agissant de concert, chaque associé non-cédant aura le droit d'exiger que ses propres actions soient incluses dans la cession, aux mêmes conditions de prix et modalités que celles consenties au(x) cédant(s).

L'associé majoritaire cédant devra notifier aux associés minoritaires le projet de cession au moins *trente (30) jours* avant sa réalisation. Les associés minoritaires disposeront d'un délai de *quinze (15) jours* à compter de la réception de cette notification pour exercer leur droit de sortie conjointe.

En cas d'exercice du droit de sortie conjointe, le cessionnaire sera tenu d'acquérir l'ensemble des actions offertes (actions du cédant et des associés exerçant le tag-along). À défaut, la cession ne pourra avoir lieu.

#article[Clause d'entraînement (_drag-along_)]

En cas de projet de cession de la totalité des actions de la Société à un tiers, approuvé par des associés représentant au moins *quatre-vingts pour cent (80 %)* du capital social et des droits de vote, les associés minoritaires seront tenus de céder l'intégralité de leurs actions au même cessionnaire, aux mêmes conditions de prix et modalités.

Tant que la Société ne compte que *deux (2) associés*, la mise en œuvre de la clause d'entraînement requiert l'accord *unanime* de l'ensemble des associés.

Les associés représentant la majorité requise notifieront aux associés minoritaires le projet de cession au moins *trente (30) jours* avant la date de réalisation envisagée. Le prix de cession devra être au moins égal à la valeur des actions telle que déterminée par un expert indépendant désigné d'un commun accord ou, à défaut, conformément aux dispositions de l'article 1843-4 du Code civil.

#article[Clause d'inaliénabilité (_lock-up_)]

Chaque Associé Fondateur s'interdit de céder, transférer, nantir ou de consentir quelque droit que ce soit sur tout ou partie de ses actions pendant une durée de *trois (3) ans* à compter de l'immatriculation de la Société au Registre du Commerce et des Sociétés.

Cette interdiction ne s'applique pas :
- aux cessions entre associés existants ;
- aux cessions au profit du conjoint, des ascendants ou descendants du cédant ;
- aux cessions résultant d'une transmission pour cause de décès ;
- aux cessions réalisées dans le cadre d'une augmentation de capital au profit d'investisseurs financiers agréée par la collectivité des associés.

#article[Promesse de cession — _Good Leaver / Bad Leaver_]

=== Principe

Tout associé qui cesserait d'exercer ses fonctions au sein de la Société ou de lui apporter une collaboration effective (le « *Partant* ») sera tenu de céder tout ou partie de ses actions selon les conditions ci-dessous, selon la qualification de son départ.

=== _Good Leaver_ (Départ de bonne foi)

Est considéré comme _Good Leaver_ l'associé dont le départ résulte :
- d'un licenciement sans cause réelle et sérieuse ;
- d'une incapacité physique ou mentale durable ;
- d'un commun accord avec les autres associés ;
- du décès de l'associé.

Le _Good Leaver_ cédera ses actions à un prix égal à leur *valeur de marché*, déterminée par un expert indépendant conformément à l'article 1843-4 du Code civil.

=== _Bad Leaver_ (Départ fautif)

Est considéré comme _Bad Leaver_ l'associé dont le départ résulte :
- d'une démission volontaire avant l'expiration de la période d'inaliénabilité ;
- d'un licenciement pour faute grave ou lourde ;
- d'une révocation de ses fonctions de dirigeant pour juste motif ;
- d'une violation des clauses de non-concurrence ou de confidentialité.

Le prix de cession des actions du _Bad Leaver_ est déterminé selon une *échelle graduée* :
- *Faute grave, fraude ou violation majeure* (non-concurrence, confidentialité, détournement) : prix égal à la *valeur nominale* des actions ;
- *Autres cas de Bad Leaver* (démission volontaire pendant le lock-up, révocation pour juste motif non constitutif de fraude) : prix égal à *cinquante pour cent (50 %)* de la valeur de marché des actions, telle que déterminée par un expert indépendant conformément à l'article 1843-4 du Code civil.

=== Procédure de qualification _Good Leaver / Bad Leaver_

Lorsque la Société compte *plus de deux associés*, la qualification de _Good Leaver_ ou _Bad Leaver_ est prononcée par la collectivité des associés, statuant à la majorité des *deux tiers (2/3)* des voix, le Partant ne prenant pas part au vote.

Lorsque la Société ne compte que *deux associés*, la qualification est obligatoirement prononcée par un *expert indépendant* désigné d'un commun accord entre les parties ou, à défaut d'accord dans un délai de *quinze (15) jours*, par ordonnance du Président du Tribunal de commerce compétent, statuant en la forme des référés. L'expert rend sa décision motivée dans un délai de *deux (2) mois* à compter de sa désignation. Les frais d'expertise sont à la charge de la Société.

Dans tous les cas, la décision doit être motivée par écrit et notifiée au Partant dans un délai de *trente (30) jours* suivant la cessation effective des fonctions.

Le Partant dispose d'un délai de *trente (30) jours* à compter de la notification pour contester la qualification. En cas de contestation, les parties s'engagent à recourir à la procédure de médiation prévue aux présents statuts avant toute action judiciaire. En l'absence de contestation dans ce délai, la qualification est réputée définitive.

=== Vesting progressif

La totalité des actions détenues par chaque Associé Fondateur est soumise au calendrier de _vesting_ suivant :

- *Date de départ du vesting* : la date d'immatriculation de la Société au Registre du Commerce et des Sociétés ;
- *Durée totale* : *quarante-huit (48) mois* ;
- *Cliff* : *douze (12) mois* — aucune action n'est considérée comme acquise pendant les 12 premiers mois ;
- Au terme du _cliff_, *vingt-cinq pour cent (25 %)* des actions de chaque Associé Fondateur sont acquises ;
- Les actions restantes sont acquises *mensuellement*, de manière linéaire, sur les *trente-six (36) mois* suivants (soit environ 2,08 % par mois).

=== Actions soumises au vesting

- *#founder-last #founder-first* : la totalité de ses #founder1-actions actions est soumise au vesting ;
- *#cofounder-last #cofounder-first* : la totalité de ses #cofounder-actions actions est soumise au vesting.

=== Accélération du vesting

En cas de *changement de contrôle* de la Société (cession de plus de 50 % du capital à un tiers, fusion, ou introduction en bourse), la totalité des actions non encore _vestées_ de chaque Associé Fondateur sera immédiatement et intégralement acquise (*single trigger acceleration*).

=== Effet du vesting sur le départ

En cas de départ d'un Associé Fondateur, seules les actions _vestées_ à la date de cessation effective des fonctions sont conservées. Les actions non _vestées_ sont cédées à la Société ou aux autres associés à leur *valeur nominale*.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE IV — DIRECTION ET ADMINISTRATION
// ════════════════════════════════════════════════════════════════════════════

= Titre IV — Direction et Administration

#article[Président]

=== Nomination et durée

La Société est dirigée par un Président, personne physique ou personne morale. Le premier Président de la Société est *#founder-last #founder-first*, nommé pour une durée *indéterminée*.

En cas de Président personne morale, celle-ci doit désigner un représentant permanent, personne physique, soumis aux mêmes conditions et obligations que s'il était Président en son nom propre.

=== Pouvoirs

Le Président est investi des pouvoirs les plus étendus pour agir en toute circonstance au nom de la Société, dans la limite de l'objet social et sous réserve des pouvoirs expressément attribués par la loi et les présents statuts à la collectivité des associés.

Le Président représente la Société à l'égard des tiers. La Société est engagée même par les actes du Président qui ne relèvent pas de l'objet social, à moins qu'elle ne prouve que le tiers savait que l'acte dépassait cet objet ou qu'il ne pouvait l'ignorer compte tenu des circonstances.

=== Limitations de pouvoirs

Toutefois, les décisions suivantes ne pourront être prises par le Président qu'après autorisation préalable de la collectivité des associés statuant à la majorité simple :
- Tout engagement financier (emprunt, caution, garantie) d'un montant supérieur à *cent cinquante mille euros (150 000 €)* par opération ou *trois cent mille euros (300 000 €)* cumulés par exercice social ;
- Toute acquisition ou cession d'actifs d'une valeur supérieure à *cent cinquante mille euros (150 000 €)* ;
- Toute prise de participation supérieure à dix pour cent (10 %) du capital d'une autre société ;
- La conclusion de tout bail commercial d'une durée supérieure à six (6) ans ;
- L'embauche de tout salarié avec une rémunération annuelle brute supérieure à *cent cinquante mille euros (150 000 €)*.

Ces seuils seront *réévalués annuellement* par la collectivité des associés lors de l'approbation des comptes annuels. À défaut de réévaluation, les seuils de l'exercice précédent demeurent applicables. La collectivité des associés pourra également déléguer au Président des autorisations globales par catégorie d'opérations pour un exercice donné.

=== Rémunération

La rémunération du Président et du Directeur Général (fixe, variable, avantages en nature) est fixée par décision collective des associés statuant à l'*unanimité* tant que la Société ne compte que deux associés. Au-delà de deux associés, la rémunération est fixée par décision collective à la majorité simple.

=== Cessation des fonctions

Les fonctions du Président prennent fin par démission, révocation, décès, incapacité, interdiction de gérer, ou à l'arrivée du terme de son mandat le cas échéant.

Le Président peut être révoqué à tout moment par décision collective des associés, sans qu'il soit nécessaire de justifier d'un juste motif. Toutefois, si la révocation intervient sans juste motif, le Président révoqué pourra prétendre à des dommages-intérêts.

#article[Directeur Général]

Le premier Directeur Général de la Société est *#cofounder-last #cofounder-first*, nommé pour une durée *indéterminée*.

Le Directeur Général dispose des mêmes pouvoirs de représentation que le Président à l'égard des tiers, sauf limitation expressément prévue par la décision de nomination ou par les présents statuts. Il est soumis aux mêmes limitations de pouvoirs que le Président prévues à l'article ci-dessus.

Le Directeur Général peut être révoqué par décision collective des associés statuant à la majorité des *deux tiers (2/3)* des voix. Si la révocation intervient sans juste motif, le Directeur Général révoqué pourra prétendre à des dommages-intérêts.

=== Directeurs Généraux Délégués

Le Président, en accord avec le Directeur Général, peut proposer la nomination d'un ou plusieurs Directeurs Généraux Délégués, personnes physiques, dont la nomination est soumise à l'approbation de la collectivité des associés.

Les Directeurs Généraux Délégués disposent des pouvoirs qui leur sont spécifiquement délégués par le Président ou par la collectivité des associés.

#article[Comité stratégique (optionnel)]

La collectivité des associés peut, par décision collective ordinaire, décider de la création d'un *Comité stratégique* composé de deux (2) à cinq (5) membres, nommés par la collectivité des associés.

Le Comité stratégique est un organe consultatif qui a pour mission :
- D'assister le Président dans la définition de la stratégie de la Société ;
- De formuler des recommandations sur les opérations significatives ;
- D'émettre un avis sur les projets de levées de fonds ;
- De superviser la mise en place des instruments d'intéressement (BSPCE, BSA).

Les modalités de fonctionnement du Comité stratégique (convocation, quorum, périodicité) seront déterminées par la décision collective instituant ledit comité.

#article[Droit d'information renforcé de l'associé minoritaire]

Tout associé détenant au moins *vingt-cinq pour cent (25 %)* du capital social dispose d'un droit d'information renforcé comprenant :

- La communication trimestrielle d'un *tableau de bord* incluant le chiffre d'affaires, les charges, la trésorerie disponible et les engagements hors bilan ;
- L'accès permanent aux comptes bancaires de la Société en consultation (_read-only_) ;
- La communication préalable de tout projet de recrutement, de tout engagement financier supérieur à *cinquante mille euros (50 000 €)*, et de tout projet de partenariat stratégique, au moins *dix (10) jours ouvrés* avant toute décision.

Ce droit d'information est *incessible* et attaché à la qualité d'Associé Fondateur.

#article[Conventions réglementées]

Toute convention intervenant directement ou par personne interposée entre la Société et son Président, l'un de ses dirigeants, l'un de ses associés disposant d'une fraction des droits de vote supérieure à dix pour cent (10 %) ou, s'il s'agit d'une société associée, la société la contrôlant, doit être portée à la connaissance du Commissaire aux comptes, le cas échéant, et soumise à l'approbation de la collectivité des associés.

Le Président ou le dirigeant intéressé ne peut pas prendre part au vote sur l'approbation de la convention.

Les conventions portant sur les opérations courantes conclues à des conditions normales sont dispensées de la procédure d'approbation.

#article[Commissaire aux comptes]

Un ou plusieurs Commissaires aux comptes seront nommés par la collectivité des associés lorsque les conditions légales l'exigent, conformément aux seuils prévus par les articles L. 227-9-1 et R. 227-1 du Code de commerce.

En deçà des seuils légaux, la nomination d'un Commissaire aux comptes pourra être décidée par la collectivité des associés ou demandée en justice par un associé dans les conditions prévues par la loi.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE V — DÉCISIONS COLLECTIVES DES ASSOCIÉS
// ════════════════════════════════════════════════════════════════════════════

= Titre V — Décisions Collectives des Associés

#article[Compétence de la collectivité des associés]

La collectivité des associés est seule compétente pour prendre les décisions suivantes :

=== Décisions ordinaires

- Approbation des comptes annuels et affectation du résultat ;
- Nomination et révocation du Président, des Directeurs Généraux et du Commissaire aux comptes ;
- Approbation des conventions réglementées ;
- Fixation de la rémunération du Président ;
- Nomination des membres du Comité stratégique ;
- Toute autre décision qui n'est pas réservée aux décisions extraordinaires.

=== Décisions extraordinaires

- Modification des statuts (sauf transfert du siège dans les cas prévus) ;
- Augmentation ou réduction du capital au-delà du capital autorisé ;
- Émission d'actions de préférence, de valeurs mobilières donnant accès au capital ;
- Émission de BSPCE, BSA, actions gratuites ;
- Fusion, scission, apport partiel d'actif ;
- Transformation de la Société ;
- Dissolution anticipée ;
- Nomination d'un liquidateur.

#article[Modalités de consultation]

=== Modes de consultation

Les associés peuvent être consultés selon les modalités suivantes :
- En assemblée générale, physique ou par visioconférence ;
- Par consultation écrite, y compris par voie électronique (courriel avec accusé de réception, plateforme de vote sécurisée) ;
- Par acte sous seing privé signé par tous les associés.

Le recours à la visioconférence et aux moyens de consultation électronique est expressément autorisé, conformément aux articles L. 227-9 et suivants du Code de commerce.

=== Convocation

Les associés sont convoqués par le Président ou, le cas échéant, par le Commissaire aux comptes, ou par un associé représentant au moins dix pour cent (10 %) du capital social.

La convocation est adressée par tout moyen, y compris par courrier électronique, au moins *quinze (15) jours* avant la date de la consultation. Elle indique l'ordre du jour, le lieu (physique ou lien de visioconférence), la date et l'heure de la réunion, ainsi que les documents nécessaires à l'information des associés.

=== Droit de communication

Tout associé a le droit de prendre connaissance, au siège social ou par voie électronique, des documents nécessaires pour lui permettre de se prononcer en connaissance de cause, au moins *quinze (15) jours* avant toute consultation.

#article[Conditions de quorum et de majorité]

=== Décisions ordinaires

Les décisions ordinaires sont adoptées à la *majorité simple* des voix des associés présents, représentés ou ayant voté par correspondance.

=== Décisions extraordinaires

Les décisions extraordinaires sont adoptées à la majorité des *deux tiers (2/3)* des voix des associés présents, représentés ou ayant voté par correspondance.

=== Décisions à l'unanimité

Les décisions suivantes requièrent l'*unanimité* des associés :
- Adoption ou modification des clauses d'inaliénabilité ;
- Augmentation des engagements des associés ;
- Transformation de la Société en une société d'une autre forme ;
- Modification de la répartition des bénéfices.

=== Droits protecteurs de l'associé minoritaire (_protective provisions_)

Nonobstant toute autre disposition des présents statuts, les décisions suivantes ne pourront être adoptées qu'avec le *consentement exprès* de tout associé détenant au moins *vingt-cinq pour cent (25 %)* du capital social (ci-après le « *Minoritaire Protégé* ») :

+ *Dilution et capital* — toute émission de nouvelles actions, valeurs mobilières ou instruments donnant accès au capital (BSPCE, BSA, obligations convertibles, actions gratuites) susceptible de diluer la participation d'un Associé Fondateur en dessous de *vingt-cinq pour cent (25 %)* du capital pleinement dilué ;
+ *Endettement significatif* — la souscription de tout emprunt, crédit ou engagement hors bilan d'un montant unitaire supérieur à *deux cent mille euros (200 000 €)* ou cumulé supérieur à *cinq cent mille euros (500 000 €)* par exercice social ;
+ *Rémunération des dirigeants* — toute fixation ou modification de la rémunération (fixe, variable, avantages en nature) du Président ou du Directeur Général au-delà de *cent mille euros (100 000 €)* bruts annuels ;
+ *Cession d'actifs stratégiques* — toute cession, licence exclusive ou apport de la propriété intellectuelle essentielle de la Société (code source, marques, brevets) ;
+ *Opérations de restructuration* — toute fusion, scission, apport partiel d'actif, ou cession de la totalité ou de la quasi-totalité des actifs de la Société ;
+ *Dissolution* — toute dissolution anticipée volontaire de la Société ;
+ *Changement d'objet social* — toute modification substantielle de l'objet social ;
+ *Distribution de dividendes* — toute mise en distribution de bénéfices au cours des trois (3) premiers exercices suivant l'immatriculation, sauf décision unanime.

Ce droit de consentement constitue un droit attaché à la qualité d'Associé Fondateur et subsistera aussi longtemps que le Minoritaire Protégé détiendra au moins *vingt-cinq pour cent (25 %)* du capital social. Il ne pourra être supprimé ou modifié qu'à l'unanimité des associés.

#note-box[
  Les _protective provisions_ visent à protéger l'associé minoritaire contre les décisions unilatérales qui pourraient affecter substantiellement la valeur de sa participation ou la gouvernance de la Société. Elles n'entravent pas la gestion courante, qui demeure du ressort du Président.
]

=== Associé unique

Tant que la Société ne comprend qu'un seul associé, celui-ci exerce les pouvoirs dévolus à la collectivité des associés. Ses décisions sont consignées sur un registre des décisions de l'associé unique.

#article[Droit de vote — Représentation]

Chaque action donne droit à une voix, sauf dispositions particulières applicables aux actions de préférence.

Un associé peut se faire représenter par un autre associé ou par un tiers muni d'un pouvoir spécial.

#article[Procès-verbaux]

Les décisions collectives sont constatées par des procès-verbaux établis sur un registre spécial coté et paraphé, ou sur des feuilles mobiles numérotées et paraphées. Les procès-verbaux peuvent également être établis et conservés sous forme électronique, dans des conditions garantissant leur intégrité et leur horodatage.

Les procès-verbaux indiquent la date et le mode de consultation, l'ordre du jour, l'identité des associés présents ou représentés, un résumé des débats, le texte des résolutions mises aux voix et le résultat des votes.

Les copies ou extraits de procès-verbaux sont certifiés conformes par le Président.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE VI — COMPTES SOCIAUX · AFFECTATION DES RÉSULTATS
// ════════════════════════════════════════════════════════════════════════════

= Titre VI — Comptes Sociaux et Affectation des Résultats

#article[Exercice social]

L'exercice social a une durée de douze (12) mois. Il commence le *#exercice-debut* et se termine le *#exercice-fin* de chaque année.

Exceptionnellement, le premier exercice social commencera à la date d'immatriculation de la Société au Registre du Commerce et des Sociétés et se terminera le *31 décembre* de l'année en cours, ou le *31 décembre* de l'année suivante si l'immatriculation intervient après le 1er octobre.

#article[Comptes annuels]

Le Président établit, à la clôture de chaque exercice, les comptes annuels (bilan, compte de résultat, annexe) conformément aux dispositions légales et réglementaires en vigueur.

Les comptes annuels sont soumis à l'approbation de la collectivité des associés dans un délai de *six (6) mois* à compter de la clôture de l'exercice.

Le Président établit un rapport de gestion exposant la situation de la Société au cours de l'exercice écoulé, son évolution prévisible, les événements importants survenus entre la date de clôture de l'exercice et la date à laquelle il est établi, ainsi que ses activités en matière de recherche et de développement.

#article[Affectation et répartition des résultats]

Le bénéfice distribuable, tel que défini par la loi, est constitué par le bénéfice de l'exercice, diminué des pertes antérieures et de la dotation à la réserve légale, et augmenté du report bénéficiaire.

=== Réserve légale

Sur le bénéfice de l'exercice, diminué le cas échéant des pertes antérieures, il est prélevé *cinq pour cent (5 %)* pour constituer le fonds de réserve légale. Conformément à l'article L. 232-10 du Code de commerce, ce prélèvement cesse d'être obligatoire lorsque le fonds de réserve a atteint le dixième du capital social. La Société étant à capital variable, le capital de référence pour le calcul de ce seuil est le *capital plancher* tel que défini aux présents statuts, soit *#capital-plancher euros* (#capital-plancher €).

=== Dividendes

L'assemblée des associés peut décider la mise en distribution de tout ou partie du bénéfice distribuable, sous réserve des dispositions légales relatives aux actions de préférence.

L'assemblée peut décider la mise en paiement d'acomptes sur dividendes dans les conditions prévues par la loi.

=== Report à nouveau et réserves facultatives

Le solde du bénéfice distribuable non distribué est affecté à un ou plusieurs postes de réserves facultatives ou reporté à nouveau, sur décision de la collectivité des associés.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE VII — INSTRUMENTS D'INTÉRESSEMENT · BSPCE · BSA
// ════════════════════════════════════════════════════════════════════════════

= Titre VII — Instruments d'Intéressement

#article[Bons de Souscription de Parts de Créateur d'Entreprise (BSPCE)]

=== Autorisation

La collectivité des associés, statuant à la majorité des deux tiers, peut autoriser l'émission de *Bons de Souscription de Parts de Créateur d'Entreprise (BSPCE)* au profit des salariés et des dirigeants de la Société et de ses filiales, conformément aux articles 163 bis G et suivants du Code général des impôts.

=== Conditions d'éligibilité

La Société confirme qu'elle remplit les conditions d'éligibilité au dispositif BSPCE, à savoir :
- Être une société par actions (SAS) ;
- Être soumise à l'impôt sur les sociétés en France ;
- Avoir été créée depuis moins de quinze (15) ans ;
- Ne pas résulter d'une concentration, restructuration, extension ou reprise d'activité préexistante ;
- Avoir son capital détenu directement et de manière continue pour au moins vingt-cinq pour cent (25 %) par des personnes physiques ou par des sociétés elles-mêmes détenues à 75 % au moins par des personnes physiques.

=== Pool BSPCE

Un pool de BSPCE représentant jusqu'à *quinze pour cent (15 %)* du capital social pleinement dilué pourra être constitué par la collectivité des associés. Ce pool pourra être réparti entre les bénéficiaires selon un calendrier et des conditions d'exercice déterminés par la décision d'émission.

=== Conditions d'exercice

Les BSPCE donnent droit à la souscription d'actions ordinaires de la Société à un prix fixé lors de l'attribution. Le prix d'exercice ne pourra être inférieur à la valeur réelle des actions à la date d'attribution, telle qu'évaluée par le Président, le cas échéant avec l'assistance d'un expert indépendant, en tenant compte d'une éventuelle décote d'illiquidité.

Les BSPCE seront soumis à un calendrier de _vesting_ déterminé par la décision d'émission, avec un _cliff_ minimum de douze (12) mois.

En cas de départ du bénéficiaire, les BSPCE non encore _vestés_ seront caducs. Les BSPCE vestés pourront être exercés dans un délai de *quatre-vingt-dix (90) jours* suivant la date de cessation des fonctions, sauf en cas de _Bad Leaver_ où ils seront caducs immédiatement.

#article[Bons de Souscription d'Actions (BSA) et actions gratuites]

=== BSA

La collectivité des associés, statuant à la majorité des deux tiers, peut autoriser l'émission de *Bons de Souscription d'Actions (BSA)* au profit de toute personne, associée ou non, conformément aux dispositions du Code de commerce.

Les BSA pourront être utilisés notamment pour rémunérer des consultants, prestataires ou advisors de la Société.

=== Actions gratuites

La collectivité des associés peut également autoriser l'attribution gratuite d'actions existantes ou à émettre au profit des salariés et des dirigeants de la Société et de ses filiales, conformément aux articles L. 225-197-1 et suivants du Code de commerce.

Les conditions d'attribution (période d'acquisition, période de conservation, conditions de performance) seront déterminées par la décision d'autorisation.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE VIII — DISSOLUTION · LIQUIDATION
// ════════════════════════════════════════════════════════════════════════════

= Titre VIII — Dissolution et Liquidation

#article[Dissolution]

La Société est dissoute :
- Par l'arrivée du terme, sauf prorogation ;
- Par décision collective extraordinaire des associés ;
- Par décision judiciaire ;
- Pour toute autre cause prévue par la loi.

Si du fait de pertes constatées dans les documents comptables, les capitaux propres de la Société deviennent inférieurs à la moitié du capital social, le Président doit, dans les quatre (4) mois suivant l'approbation des comptes ayant fait apparaître cette perte, consulter les associés à l'effet de décider s'il y a lieu à dissolution anticipée de la Société.

Si la dissolution n'est pas prononcée, la Société est tenue, au plus tard à la clôture du deuxième exercice suivant celui au cours duquel la constatation des pertes est intervenue, de réduire son capital d'un montant au moins égal à celui des pertes qui n'ont pu être imputées sur les réserves.

#article[Liquidation]

La Société dissoute entre en liquidation, sauf dans les cas de fusion, scission ou dissolution sans liquidation prévus par la loi.

La collectivité des associés nomme un ou plusieurs liquidateurs dont elle détermine les pouvoirs et la rémunération. Le liquidateur représente la Société.

Après paiement des dettes et remboursement du capital, le solde est partagé entre les associés proportionnellement à leur participation dans le capital, sous réserve des droits particuliers attachés aux actions de préférence, notamment toute clause de liquidation préférentielle.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE IX — DISPOSITIONS DIVERSES
// ════════════════════════════════════════════════════════════════════════════

= Titre IX — Dispositions Diverses

#article[Confidentialité]

Chaque associé s'engage à considérer comme strictement confidentiel et à ne pas divulguer à des tiers, sans l'accord préalable et écrit du Président, toute information relative aux affaires de la Société, notamment les informations financières, commerciales, techniques, stratégiques et technologiques, les données clients, les algorithmes, le code source et les méthodes de travail.

Cette obligation de confidentialité survivra à la perte de la qualité d'associé pendant une durée de *trois (3) ans*.

La violation de cette obligation pourra constituer un juste motif de révocation et/ou de qualification en _Bad Leaver_.

#article[Non-concurrence]

Chaque associé exerçant des fonctions opérationnelles au sein de la Société s'engage, pendant toute la durée de ses fonctions et après la cessation de ses fonctions, à ne pas exercer, directement ou indirectement, une activité concurrente à l'objet social de la Société, dans les limites suivantes :

=== Durée et périmètre selon la catégorie de l'associé

- *Dirigeants (Président, Directeur Général)* : deux (2) ans, en France et dans les pays de l'Union européenne où la Société est active ;
- *Associés opérationnels non-dirigeants* : un (1) an, limité à la France ;
- *Advisors et consultants* : six (6) mois, limité à la France.

Dans tous les cas, l'obligation est limitée dans son objet aux activités de détaxe et de remboursement de TVA aux voyageurs.

=== Contrepartie financière

En contrepartie, la Société versera à l'associé concerné une indemnité mensuelle égale à *trente pour cent (30 %)* de la moyenne mensuelle de sa dernière rémunération brute perçue au cours des douze (12) derniers mois.

=== Faculté de renonciation

La Société se réserve le droit de *renoncer unilatéralement* à l'application de la clause de non-concurrence, et par conséquent au versement de l'indemnité, à condition d'en notifier l'associé concerné par lettre recommandée avec accusé de réception dans un délai de *quinze (15) jours* suivant la date effective de cessation des fonctions. La renonciation est alors totale et libère immédiatement l'associé de son obligation.

#article[Résolution des blocages (_clause shotgun_)]

En cas de désaccord persistant entre les associés sur une décision stratégique ou opérationnelle, rendant impossible le fonctionnement normal de la Société pendant une durée de plus de *trois (3) mois* (ci-après le « *Blocage* »), tout associé (l'« *Initiateur* ») pourra déclencher la procédure suivante :

+ L'Initiateur notifie à l'autre associé (le « *Destinataire* ») une offre ferme et irrévocable de rachat de la totalité de ses actions à un prix par action déterminé librement par l'Initiateur (le « *Prix Proposé* ») ;
+ Le Destinataire dispose d'un délai de *soixante (60) jours* à compter de la réception de la notification pour :
  - soit *accepter* l'offre et céder la totalité de ses actions à l'Initiateur au Prix Proposé ;
  - soit *retourner l'offre* et racheter la totalité des actions de l'Initiateur au même Prix Proposé par action ;
+ À défaut de réponse dans le délai de soixante (60) jours, le Destinataire est réputé avoir accepté l'offre de cession ;
+ La cession doit être réalisée dans un délai de *trente (30) jours* suivant l'acceptation ou le retournement de l'offre. Le paiement est effectué en une seule fois, par virement bancaire.

Ce mécanisme garantit l'équité puisque l'Initiateur, ne sachant pas si le Destinataire achètera ou vendra, est incité à proposer un prix juste.

La présente clause n'est applicable que lorsque la Société ne compte que *deux associés*. Elle ne peut être déclenchée pendant les *vingt-quatre (24) premiers mois* suivant l'immatriculation de la Société.

#article[Médiation et arbitrage]

=== Médiation préalable obligatoire

Tout litige entre associés, ou entre un associé et la Société, relatif à l'interprétation, l'exécution ou la résiliation des présents statuts, devra, préalablement à toute action judiciaire ou au déclenchement de la clause shotgun, être soumis à une tentative de *médiation* menée par un médiateur agréé auprès d'un centre de médiation reconnu (CMAP, CNMA ou équivalent).

La médiation aura une durée maximale de *trois (3) mois* à compter de la désignation du médiateur.

=== Arbitrage (optionnel)

À défaut d'accord amiable à l'issue de la médiation, les parties pourront soumettre le litige à l'arbitrage selon le règlement du Centre de Médiation et d'Arbitrage de Paris (CMAP), par un arbitre unique nommé conformément audit règlement.

=== Juridiction compétente

À défaut de clause compromissoire ou en cas de mesure urgente ou conservatoire, les tribunaux compétents seront ceux du ressort du siège social de la Société.

#article[Élection de domicile]

Pour l'exécution des présents statuts, chaque associé fait élection de domicile à l'adresse indiquée en regard de son nom dans les présents statuts ou dans le registre des associés. Toute modification d'adresse devra être notifiée au Président par lettre recommandée avec accusé de réception.

#article[Frais]

Tous les frais, droits et honoraires entraînés par la constitution de la Société et les présents statuts seront portés au compte de frais de premier établissement et amortis dans un délai maximum de cinq (5) exercices.

#article[Pouvoirs]

Tous pouvoirs sont conférés au porteur d'un original ou d'une copie certifiée conforme des présents statuts pour accomplir toutes les formalités de publicité et de dépôt prescrites par la loi.

#article[Loi applicable]

Les présents statuts sont soumis au droit français. Toute question non prévue par les présents statuts sera régie par les dispositions légales et réglementaires en vigueur applicables aux sociétés par actions simplifiées.


// ════════════════════════════════════════════════════════════════════════════
//  ANNEXE — ÉTAT DES SOUSCRIPTIONS ET VERSEMENTS
// ════════════════════════════════════════════════════════════════════════════

#pagebreak()

#align(center)[
  #text(size: 16pt, weight: "bold", fill: primary)[ANNEXE]
  #v(4pt)
  #text(size: 12pt, fill: secondary)[État des Souscriptions et des Versements]
  #v(4pt)
  #line(length: 40%, stroke: 0.5pt + accent)
]

#v(1cm)

#table(
  columns: (2fr, 1fr, 1fr, 1fr, 1fr),
  align: (left, center, center, center, center),
  stroke: 0.5pt + muted,
  inset: 8pt,

  // Header
  table.cell(fill: primary)[#text(fill: white, weight: "bold", size: 9pt)[Associé]],
  table.cell(fill: primary)[#text(fill: white, weight: "bold", size: 9pt)[Nb. actions]],
  table.cell(fill: primary)[#text(fill: white, weight: "bold", size: 9pt)[Valeur nominale]],
  table.cell(fill: primary)[#text(fill: white, weight: "bold", size: 9pt)[Montant souscrit]],
  table.cell(fill: primary)[#text(fill: white, weight: "bold", size: 9pt)[Montant libéré]],

  // Founder 1 row
  [#founder-last #founder-first],
  [#founder1-actions],
  [#valeur-nominale €],
  [60 €],
  [60 €],

  // Founder 2 row
  [#cofounder-last #cofounder-first],
  [#cofounder-actions],
  [#valeur-nominale €],
  [40 €],
  [40 €],

  // Total row
  table.cell(fill: light-bg)[*TOTAL*],
  table.cell(fill: light-bg)[*#nb-actions*],
  table.cell(fill: light-bg)[*#valeur-nominale €*],
  table.cell(fill: light-bg)[*#capital-initial €*],
  table.cell(fill: light-bg)[*#capital-initial €*],
)

#v(2cm)


// ════════════════════════════════════════════════════════════════════════════
//  SIGNATURES
// ════════════════════════════════════════════════════════════════════════════

#align(center)[
  #text(size: 16pt, weight: "bold", fill: primary)[SIGNATURES]
  #v(4pt)
  #line(length: 40%, stroke: 0.5pt + accent)
]

#v(1.5cm)

Fait à *#siege-ville*, le *#date-signature*, en *quatre (4)* exemplaires originaux.

#v(0.8cm)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 1.5cm,
  align: center,
  [
    *L'Associé Fondateur 1*\
    *Président*

    #v(0.3cm)

    #founder-last #founder-first

    #v(0.3cm)

    _« Lu et approuvé »_

    #v(0.3cm)

    #if use-signatures {
      image(signature-path, height: 1.8cm)
    } else {
      v(2cm)
      line(length: 80%, stroke: 0.5pt + body-color)
      v(0.3cm)
      text(size: 8pt, fill: muted)[(signature manuscrite)]
    }
  ],
  [
    *L'Associé Fondateur 2*\
    *Directeur Général*

    #v(0.3cm)

    #cofounder-last #cofounder-first

    #v(0.3cm)

    _« Lu et approuvé »_

    #v(0.3cm)

    #if use-signatures {
      image(cofounder-signature-path, height: 1.8cm)
    } else {
      v(2cm)
      line(length: 80%, stroke: 0.5pt + body-color)
      v(0.3cm)
      text(size: 8pt, fill: muted)[(signature manuscrite)]
    }
  ],
)

#v(0.5cm)

#if use-signatures {
  note-box[
    *Document signé numériquement.* Les paraphes des deux Associés Fondateurs figurent en pied de chaque page. Les signatures complètes figurent ci-dessus.
  ]
} else {
  note-box[
    *Rappel :* Chaque page des présents statuts doit être paraphée par les deux Associés Fondateurs. La dernière page doit être signée avec la mention manuscrite « Lu et approuvé ».
  ]
}
