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
#let founder1-actions    = "6 000"

// ── Associé Fondateur 2 — Directeur Général ─────────────────────────────
#let cofounder-first       = "Franklin"
#let cofounder-last        = "TRANIÉ"
#let cofounder-nationality = "française"
#let cofounder-birthdate   = "11 février 2004"
#let cofounder-birthplace  = "Neuilly-sur-Seine (Hauts-de-Seine)"
#let cofounder-address     = "3 Rue de Rouvray, 92200 Neuilly-sur-Seine"
#let cofounder-actions     = "4 000"

// ── Société ─────────────────────────────────────────────────────────────
#let siege-social        = "10 Rue de Penthièvre, 75008 Paris"
#let siege-ville         = "Paris"
#let capital-initial     = "100"
#let capital-plancher    = "10"
#let capital-plafond     = "1 000 000"
#let nb-actions          = "10 000"
#let valeur-nominale     = "0,01"
#let duree-societe       = "99"
#let date-signature      = "2 mars 2026"
#let rcs-ville           = "La Rochelle"
#let exercice-debut      = "1er janvier"
#let exercice-fin        = "31 décembre"

// ── Seuils de gouvernance ──────────────────────────────────────────────────
#let seuil-engagement-unitaire = "150 000"
#let seuil-engagement-cumule   = "300 000"
#let seuil-cosignature         = "10 000"
#let seuil-embauche            = "150 000"

// ── Délais procéduraux ────────────────────────────────────────────────────
#let lock-up-duree               = "trois (3)"
#let delai-agrement              = "trois (3)"
#let delai-preemption-notif      = "cinq (5)"
#let delai-preemption-exercice   = "trente (30)"
#let delai-retrait-preavis       = "six (6)"
#let delai-retrait-vote          = "deux (2)"
#let delai-retrait-echelon       = "vingt-quatre (24)"
#let delai-liberation            = "cinq (5)"
#let delai-convocation           = "quinze (15)"
#let delai-cosignature-urgence   = "quarante-huit (48)"

// ── Pourcentages ──────────────────────────────────────────────────────────
#let seuil-convention-reglementee = "dix pour cent (10 %)"
#let seuil-convocation            = "dix pour cent (10 %)"

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
    Les présents statuts ont été rédigés dans une optique d'évolutivité, anticipant l'entrée future d'associés (business angels, fonds d'investissement) et la mise en place d'instruments d'intéressement (BSPCE, BSA, actions gratuites). Ils sont complétés par un *pacte d'associés* signé à la même date, qui organise les relations entre les Associés Fondateurs (sortie conjointe, entraînement, _vesting_, droits protecteurs, confidentialité, non-concurrence, résolution des blocages).
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
- L'activité d'opérateur de détaxe au sens des articles 202 E et suivants de l'annexe IV du Code général des impôts, dans le cadre du système PABLO de la Direction Générale des Douanes et Droits Indirects (DGDDI), sous réserve de l'obtention de l'agrément requis ;
- La fourniture de services technologiques aux commerçants, détaillants et entreprises, notamment pour la gestion des bordereaux de vente à l'exportation et la conformité douanière et fiscale ;
- La fourniture de services de paiement, de transfert de fonds et de services financiers connexes, sous réserve de l'obtention des agréments, autorisations ou enregistrements requis par la réglementation applicable, notamment auprès de l'Autorité de contrôle prudentiel et de résolution (ACPR) ;
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

Le capital social initial est fixé à la somme de *#capital-initial euros* (#capital-initial €), divisé en *#nb-actions actions* de *#valeur-nominale euro* de valeur nominale chacune, toutes de même catégorie, entièrement souscrites et intégralement libérées, réparties comme suit :

- *#founder-last #founder-first* : #founder1-actions actions, soit 60 % du capital ;
- *#cofounder-last #cofounder-first* : #cofounder-actions actions, soit 40 % du capital.

=== Variabilité du capital

Conformément aux articles L. 231-1 à L. 231-8 du Code de commerce, le capital social est *variable*.

Il pourra être augmenté par des versements successifs des associés ou l'admission de nouveaux associés, et réduit par la reprise totale ou partielle des apports effectués, sans qu'il soit nécessaire de procéder aux formalités de publicité et de modification des statuts prévues pour les augmentations et les réductions de capital.

- *Capital plancher* : le capital social ne pourra être réduit en dessous de *#capital-plancher euros* (#capital-plancher €), soit dix pour cent (10 %) du capital initial.
- *Capital plafond (autorisé)* : le capital social pourra être augmenté jusqu'à *#capital-plafond euros* (#capital-plafond €) sans modification des statuts.

Toute augmentation du capital dans les limites de la clause de variabilité est soumise à l'*autorisation préalable* de la collectivité des associés statuant à la majorité des *deux tiers (2/3)* des voix. L'admission de tout nouvel associé par voie de souscription est en outre soumise à la *procédure d'agrément* prévue aux présents statuts, dans les mêmes conditions que pour les cessions à des tiers. Chaque associé bénéficie d'un *droit préférentiel de souscription* proportionnel à sa participation, exerçable dans un délai de *#delai-preemption-exercice jours* à compter de la notification du projet d'augmentation.

L'augmentation ou la réduction du capital sera constatée par le Président, qui modifiera le montant du capital social figurant dans les statuts.

Au-delà du capital plafond, toute augmentation de capital devra être décidée par la collectivité des associés statuant dans les conditions de majorité requises pour les décisions extraordinaires.

=== Droit de reprise des apports

Le retrait d'un associé par voie de reprise de ses apports est soumis à l'*autorisation préalable* de la collectivité des associés, statuant à la majorité des *deux tiers (2/3)* des voix, l'associé demandeur ne prenant pas part au vote.

La demande de retrait est notifiée au Président par lettre recommandée avec accusé de réception au moins *#delai-retrait-preavis mois* avant la clôture de l'exercice social en cours. Le Président soumet la demande au vote de la collectivité des associés dans un délai de *#delai-retrait-vote mois*.

En cas d'autorisation, le retrait prendra effet à la clôture de l'exercice au cours duquel la demande aura été formulée. Le prix de remboursement sera déterminé conformément aux dispositions de l'article 1843-4 du Code civil, à défaut d'accord entre les parties.

Le remboursement est *conditionné* à la capacité de trésorerie de la Société : il ne pourra être effectué si la trésorerie disponible, après remboursement, deviendrait inférieure à trois (3) mois de charges d'exploitation courantes. Dans ce cas, le remboursement sera échelonné sur une durée maximale de #delai-retrait-echelon mois.

En cas de refus d'autorisation, l'associé pourra céder ses actions à un tiers ou aux autres associés dans les conditions prévues aux clauses de cession des présents statuts.

#article[Catégories d'actions]

=== Actions ordinaires

Les actions composant le capital social initial sont des *actions ordinaires*, toutes de même catégorie, conférant chacune les mêmes droits :
- *Une voix* par action aux décisions collectives ;
- Le droit au dividende, au prorata du nombre d'actions détenues ;
- Le droit préférentiel de souscription aux augmentations de capital ;
- Le droit au boni de liquidation, au prorata du nombre d'actions détenues.

=== Actions de préférence

La Société pourra émettre, sur décision collective extraordinaire des associés, des *actions de préférence*, avec ou sans droit de vote, assorties de droits particuliers de toute nature, à titre temporaire ou permanent, conformément aux articles L. 228-11 et suivants du Code de commerce.

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

Pour les *émissions ultérieures* d'actions, les actions souscrites en numéraire devront être libérées de la moitié au moins de leur valeur nominale lors de la souscription. Le surplus sera libéré en une ou plusieurs fois, dans un délai maximum de #delai-liberation ans à compter de la date d'émission, sur appel du Président.

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

Le Président dispose d'un délai de *#delai-agrement mois* à compter de la réception de la notification pour faire connaître sa décision. À défaut de réponse dans ce délai, l'agrément est réputé acquis.

=== Refus d'agrément

En cas de refus d'agrément, les associés sont tenus, dans un délai de *#delai-agrement mois* à compter de la notification du refus, d'acquérir ou de faire acquérir les actions à un prix déterminé dans les conditions prévues à l'article 1843-4 du Code civil.

À défaut d'accord, le prix sera fixé par un expert désigné soit par les parties, soit à défaut d'accord entre elles, par ordonnance du Président du Tribunal de commerce compétent, statuant en la forme des référés.

=== Exceptions

Ne sont pas soumises à la procédure d'agrément les cessions entre associés existants, entre conjoints, entre ascendants et descendants, ainsi que les transmissions pour cause de décès.

#article[Droit de préemption]

=== Principe

En cas de projet de cession d'actions par un associé (le « *Cédant* »), les autres associés bénéficient d'un droit de préemption proportionnel à leur participation dans le capital social.

=== Procédure

Le Cédant notifie au Président son intention de céder, en précisant le nombre d'actions, le prix unitaire, l'identité du cessionnaire pressenti et les conditions de la cession.

Le Président en informe les autres associés dans un délai de *#delai-preemption-notif jours ouvrés*. Chaque associé dispose d'un délai de *#delai-preemption-exercice jours* à compter de cette notification pour exercer son droit de préemption, par lettre recommandée avec accusé de réception ou par voie électronique avec accusé de réception adressée au Président.

Si les droits de préemption exercés portent sur un nombre d'actions supérieur au nombre d'actions offertes, les actions seront réparties proportionnellement à la participation de chaque associé ayant exercé son droit.

En cas de non-exercice ou d'exercice partiel du droit de préemption, le Cédant pourra librement céder les actions non préemptées au cessionnaire pressenti, aux conditions notifiées, sous réserve de l'obtention de l'agrément prévu à l'article ci-dessus.

#article[Clause d'inaliénabilité (_lock-up_)]

Conformément à l'article L. 227-13 du Code de commerce, chaque Associé Fondateur s'interdit de céder, transférer, nantir ou de consentir quelque droit que ce soit sur tout ou partie de ses actions pendant une durée de *#lock-up-duree ans* à compter de l'immatriculation de la Société au Registre du Commerce et des Sociétés.

Cette interdiction ne s'applique pas :
- aux cessions entre associés existants ;
- aux cessions au profit du conjoint, des ascendants ou descendants du cédant ;
- aux cessions résultant d'une transmission pour cause de décès ;
- aux cessions réalisées dans le cadre d'une augmentation de capital au profit d'investisseurs financiers agréée par la collectivité des associés ;
- aux cessions résultant de la mise en œuvre d'un mécanisme de résolution des blocages entre associés prévu par le pacte d'associés.

#note-box[
  Des clauses complémentaires relatives aux cessions d'actions (sortie conjointe, entraînement, promesse de cession, _good leaver / bad leaver_, _vesting_) sont prévues dans le pacte d'associés signé entre les Associés Fondateurs à la même date que les présents statuts.
]


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
- Tout engagement financier (emprunt, caution, garantie) d'un montant supérieur à *cent cinquante mille euros (#seuil-engagement-unitaire €)* par opération ou *trois cent mille euros (#seuil-engagement-cumule €)* cumulés par exercice social ;
- Toute acquisition ou cession d'actifs d'une valeur supérieure à *cent cinquante mille euros (#seuil-engagement-unitaire €)* ;
- Toute prise de participation supérieure à dix pour cent (10 %) du capital d'une autre société ;
- La conclusion de tout bail commercial d'une durée supérieure à six (6) ans ;
- L'embauche de tout salarié avec une rémunération annuelle brute supérieure à *cent cinquante mille euros (#seuil-embauche €)*.

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

#article[Conventions réglementées]

Toute convention intervenant directement ou par personne interposée entre la Société et son Président, l'un de ses dirigeants, l'un de ses associés disposant d'une fraction des droits de vote supérieure à #seuil-convention-reglementee ou, s'il s'agit d'une société associée, la société la contrôlant, doit être portée à la connaissance du Commissaire aux comptes, le cas échéant, et soumise à l'approbation de la collectivité des associés.

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

Les associés sont convoqués par le Président ou, le cas échéant, par le Commissaire aux comptes, ou par un associé représentant au moins #seuil-convocation du capital social.

La convocation est adressée par tout moyen, y compris par courrier électronique, au moins *#delai-convocation jours* avant la date de la consultation. Elle indique l'ordre du jour, le lieu (physique ou lien de visioconférence), la date et l'heure de la réunion, ainsi que les documents nécessaires à l'information des associés.

=== Droit de communication

Tout associé a le droit de prendre connaissance, au siège social ou par voie électronique, des documents nécessaires pour lui permettre de se prononcer en connaissance de cause, au moins *#delai-convocation jours* avant toute consultation.

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

=== Associé unique

Tant que la Société ne comprend qu'un seul associé, celui-ci exerce les pouvoirs dévolus à la collectivité des associés. Ses décisions sont consignées sur un registre des décisions de l'associé unique.

#article[Droit de vote — Représentation]

Chaque action donne droit à *une voix* aux décisions collectives, sous réserve des droits particuliers attachés aux actions de préférence qui pourraient être émises ultérieurement.

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

// ⚠ NOTE — Dispense de rapport de gestion pour les petites entreprises
// Depuis la loi PACTE (2019), les « petites entreprises » au sens de l'art. L. 230-1
// C. com. (ne dépassant pas 2 sur 3 : bilan 6 M€, CA 12 M€, 50 salariés) sont
// dispensées du rapport de gestion (art. L. 232-1 IV). BELCOVA en bénéficie
// certainement dans ses premières années. L'obligation statutaire ci-dessous est
// plus exigeante que la loi — le Président ne sera pas en faute s'il ne le produit
// pas tant que la dispense légale s'applique.
Le Président établit un rapport de gestion exposant la situation de la Société au cours de l'exercice écoulé, son évolution prévisible, les événements importants survenus entre la date de clôture de l'exercice et la date à laquelle il est établi, ainsi que ses activités en matière de recherche et de développement.

#article[Affectation et répartition des résultats]

Le bénéfice distribuable, tel que défini par la loi, est constitué par le bénéfice de l'exercice, diminué des pertes antérieures et de la dotation à la réserve légale, et augmenté du report bénéficiaire.

=== Réserve légale

// ⚠ AVERTISSEMENT JURIDIQUE — Réserve légale et capital de référence
// L'utilisation du capital plancher comme référence pour le seuil de la réserve
// légale (10 % de 10 € = 1 €) est une interprétation minoritaire. L'ANSA
// (Association Nationale des Sociétés par Actions) retient le capital effectif
// à la date de clôture de l'exercice comme référence. La question n'est pas
// définitivement tranchée par la jurisprudence. Si le capital augmente
// significativement, l'écart entre les deux interprétations deviendra important.
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
- Avoir son capital détenu directement et de manière continue pour au moins quinze pour cent (15 %) par des personnes physiques ou par des sociétés elles-mêmes détenues à 75 % au moins par des personnes physiques.

=== Conditions d'émission

Les conditions d'émission des BSPCE (nombre, prix d'exercice, calendrier de _vesting_, pool maximal, conditions d'exercice et de caducité) seront déterminées par la décision collective d'émission.

#note-box[
  Les conditions détaillées relatives au pool BSPCE et aux règles applicables en cas de départ d'un bénéficiaire sont précisées dans le pacte d'associés.
]

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

Si la dissolution n'est pas prononcée, la Société est tenue de reconstituer ses capitaux propres dans les conditions et délais prévus à l'article L. 225-248 du Code de commerce, tel que modifié par la loi n° 2023-171 du 9 mars 2023.

#article[Liquidation]

La Société dissoute entre en liquidation, sauf dans les cas de fusion, scission ou dissolution sans liquidation prévus par la loi.

La collectivité des associés nomme un ou plusieurs liquidateurs dont elle détermine les pouvoirs et la rémunération. Le liquidateur représente la Société.

Après paiement des dettes et remboursement du capital, le solde est partagé entre les associés proportionnellement à leur participation dans le capital, sous réserve des droits particuliers attachés aux actions de préférence, notamment toute clause de liquidation préférentielle.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE IX — DISPOSITIONS DIVERSES
// ════════════════════════════════════════════════════════════════════════════

= Titre IX — Dispositions Diverses

#article[Litiges]

Tout litige relatif à l'interprétation ou à l'exécution des présents statuts sera soumis aux tribunaux compétents du ressort du siège social de la Société.

#note-box[
  Les engagements des associés en matière de confidentialité, non-concurrence, résolution des blocages et médiation sont prévus dans le pacte d'associés signé entre les Associés Fondateurs à la même date que les présents statuts.
]

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
