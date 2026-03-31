// ============================================================================
//  PACTE D'ASSOCIÉS — BELCOVA SAS — Typst
//  Document confidentiel — Complément aux statuts constitutifs
// ============================================================================

#import "template.typ": *

#import "variables.typ": *

// ── Variables spécifiques au pacte d'associés ───────────────────────────

// Seuils de cession
#let tag-along-seuil       = "cinquante pour cent (50 %)"          // % du capital
#let drag-along-seuil      = "quatre-vingts pour cent (80 %)"     // % du capital
#let minority-seuil        = "vingt-cinq pour cent (25 %)"        // % du capital

// ── Vesting ────────────────────────────────────────────────────────────────
#let vesting-duree         = "quarante-huit (48)"                  // mois
#let vesting-cliff         = "douze (12)"                          // mois
#let vesting-cliff-pct     = "vingt-cinq pour cent (25 %)"        // % acquis après cliff
#let vesting-post-cliff    = "trente-six (36)"                     // mois (linéaire)

// ── Good / Bad Leaver ──────────────────────────────────────────────────────
#let bad-leaver-grave-pct  = "vingt-cinq pour cent (25 %)"         // % de la valeur de marché (faute grave)
#let bad-leaver-prix-pct   = "cinquante pour cent (50 %)"          // % de la valeur de marché

// ── BSPCE ──────────────────────────────────────────────────────────────────
#let bspce-pool            = "quinze pour cent (15 %)"             // % du capital pleinement dilué

// ── Non-concurrence ────────────────────────────────────────────────────────
#let non-compete-duree-dirigeants = "deux (2)"                     // ans
#let non-compete-duree-associes   = "un (1)"                       // an
#let non-compete-duree-advisors   = "six (6)"                      // mois
#let non-compete-indemnite        = "trente pour cent (30 %)"      // % du salaire brut moyen
#let non-compete-plancher         = "cinquante pour cent (50 %)"   // % du SMIC mensuel brut

// ── Gouvernance (seuils monétaires) ────────────────────────────────────────
#let seuil-dette-unitaire      = "deux cent mille euros (200 000 €)"   // € par opération
#let seuil-dette-cumule        = "cinq cent mille euros (500 000 €)"   // € cumulé par exercice
#let seuil-remuneration        = "cent mille euros (100 000 €)"        // € bruts annuels
#let seuil-info-engagement     = "cinquante mille euros (50 000 €)"    // €

// ── Clause shotgun ─────────────────────────────────────────────────────────
#let shotgun-delai-blocage        = "trois (3)"                    // mois de blocage avant déclenchement
#let shotgun-delai-declenchement  = "vingt-quatre (24)"            // mois post-immatriculation
#let shotgun-delai-info           = "quinze (15)"                  // jours — examen dossier d'info
#let shotgun-delai-complement     = "dix (10)"                     // jours — réponse compléments
#let shotgun-delai-reponse        = "soixante (60)"                // jours — acceptation/retournement
#let shotgun-delai-realisation    = "trente (30)"                  // jours — réalisation cession
#let shotgun-financement          = "quatre-vingt-dix (90)"        // jours — délai financement
#let shotgun-echelon-duree        = "douze (12)"                   // mois — paiement échelonné max

// ── Procédure Good / Bad Leaver ────────────────────────────────────────────
#let leaver-delai-expert         = "quinze (15)"                   // jours — accord sur expert
#let leaver-delai-decision       = "deux (2)"                      // mois — décision expert
#let leaver-delai-notif          = "trente (30)"                   // jours — notification qualification
#let leaver-delai-contestation   = "trente (30)"                   // jours — contestation

// ── Autres durées ──────────────────────────────────────────────────────────
#let confidentialite-survie      = "trois (3)"                     // ans post-départ
#let tag-along-notif             = "trente (30)"                   // jours — notification cession
#let tag-along-exercice          = "quinze (15)"                   // jours — exercice droit
#let bspce-exercice-depart       = "quatre-vingt-dix (90)"         // jours post-départ
#let non-compete-renonciation    = "quinze (15)"                   // jours — renonciation société
#let mediation-duree             = "trois (3)"                     // mois max

// ── Droits d'information ───────────────────────────────────────────────────
#let info-delai-preavis          = "dix (10)"                      // jours ouvrés

// ── Apply Template ───────────────────────────────────────────────────────────

#show: template.with(
  company-name: company-name,
  company-short: company-short,
  document-type: "Pacte d'Associés",
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
      #align(center)[PACTE D'ASSOCIÉS]
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
      Pacte établi en date du #date-signature \
      Document confidentiel — Non déposé au greffe \
      \
      Associés fondateurs : #founder-last #founder-first (#founder1-pct %) · #cofounder-last #cofounder-first (#cofounder-pct %)
    ]
  ]
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

  Le présent pacte d'associés (ci-après le « *Pacte* ») est conclu entre :

  #v(0.3cm)

  + *#founder-last #founder-first*, de nationalité #founder-nationality, né le #founder-birthdate à #founder-birthplace, demeurant #founder-address, détenant #founder1-actions actions de la Société, ci-après désigné l'« *Associé Fondateur 1* » ;

  + *#cofounder-last #cofounder-first*, de nationalité #cofounder-nationality, né le #cofounder-birthdate à #cofounder-birthplace, demeurant #cofounder-address, détenant #cofounder-actions actions de la Société, ci-après désigné l'« *Associé Fondateur 2* » ;

  #v(0.3cm)

  Ci-après désignés ensemble les « *Parties* » et individuellement une « *Partie* ».

  #v(0.5cm)

  Les Parties sont les associés fondateurs de la société *#company-name*, #company-legal-form, dont les statuts constitutifs ont été signés le *#date-signature* (ci-après les « *Statuts* » et la « *Société* »).

  Le présent Pacte a pour objet d'organiser les relations entre les Parties et de compléter les Statuts par des stipulations que les Parties souhaitent conserver confidentielles.

  En cas de contradiction entre le présent Pacte et les Statuts, les Statuts prévaudront pour toute question relevant du droit des sociétés et opposable aux tiers. Le présent Pacte prévaudra pour les obligations inter-parties.

  #v(0.5cm)

  #note-box[
    Le présent pacte est un document confidentiel. Contrairement aux statuts, il n'est pas déposé au greffe et n'est pas accessible au public.
  ]
]


// ════════════════════════════════════════════════════════════════════════════
//  TITRE I — CLAUSES RELATIVES AUX CESSIONS D'ACTIONS
// ════════════════════════════════════════════════════════════════════════════

= Titre I — Clauses relatives aux Cessions d'Actions

#article[Clause de sortie conjointe (_tag-along_)]

En cas de projet de cession portant sur un nombre d'actions représentant plus de *#tag-along-seuil* du capital social, que cette cession soit réalisée par un seul ou plusieurs associés agissant de concert, chaque associé non-cédant aura le droit d'exiger que ses propres actions soient incluses dans la cession, aux mêmes conditions de prix et modalités que celles consenties au(x) cédant(s).

L'associé majoritaire cédant devra notifier aux associés minoritaires le projet de cession au moins *#tag-along-notif jours* avant sa réalisation. Les associés minoritaires disposeront d'un délai de *#tag-along-exercice jours* à compter de la réception de cette notification pour exercer leur droit de sortie conjointe.

En cas d'exercice du droit de sortie conjointe, le cessionnaire sera tenu d'acquérir l'ensemble des actions offertes (actions du cédant et des associés exerçant le tag-along). À défaut, la cession ne pourra avoir lieu.

// ⚠ AVERTISSEMENT JURIDIQUE — Références à l'article 1843-4 du Code civil dans le pacte
// Depuis l'ordonnance du 31/07/2014, l'art. 1843-4 C. civ. distingue les cessions
// prévues par la loi (al. I) et celles prévues par les statuts (al. II). Un pacte
// d'associés (convention extra-statutaire) ne déclenche pas directement l'art. 1843-4.
// Les références ci-dessous fonctionnent comme renvoi conventionnel (contractuellement
// valide), mais l'expert désigné dans ce cadre n'a pas exactement les mêmes pouvoirs
// qu'en application directe de la loi. Ce point est courant en pratique mais
// juridiquement imprécis — à clarifier lors d'une future révision du pacte.
#article[Clause d'entraînement (_drag-along_)]

En cas de projet de cession de la totalité des actions de la Société à un tiers, approuvé par des associés représentant au moins *#drag-along-seuil* du capital social et des droits de vote, les associés minoritaires seront tenus de céder l'intégralité de leurs actions au même cessionnaire, aux mêmes conditions de prix et modalités.

Tant que la Société ne compte que *deux (2) associés*, la mise en œuvre de la clause d'entraînement requiert l'accord *unanime* de l'ensemble des associés.

Les associés représentant la majorité requise notifieront aux associés minoritaires le projet de cession au moins *#tag-along-notif jours* avant la date de réalisation envisagée. Le prix de cession devra être au moins égal à la valeur des actions telle que déterminée par un expert indépendant désigné d'un commun accord ou, à défaut, conformément aux dispositions de l'article 1843-4 du Code civil.

#article[Clause d'inaliénabilité (_lock-up_)]

Conformément à la clause d'inaliénabilité prévue aux Statuts en application de l'article L. 227-13 du Code de commerce, chaque Associé Fondateur s'interdit de céder, transférer, nantir ou de consentir quelque droit que ce soit sur tout ou partie de ses actions pendant une durée de *#lock-up-duree ans* à compter de l'immatriculation de la Société au Registre du Commerce et des Sociétés.

Cette interdiction ne s'applique pas :
- aux cessions entre associés existants ;
- aux cessions au profit du conjoint, des ascendants ou descendants du cédant ;
- aux cessions résultant d'une transmission pour cause de décès ;
- aux cessions réalisées dans le cadre d'une augmentation de capital au profit d'investisseurs financiers agréée par la collectivité des associés ;
- aux cessions résultant de la mise en œuvre de la clause de résolution des blocages (_clause shotgun_) prévue au Titre VI du présent Pacte.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE II — PROMESSE DE CESSION ET VESTING
// ════════════════════════════════════════════════════════════════════════════

= Titre II — Promesse de Cession et Vesting

#article[Promesse de cession — _Good Leaver / Bad Leaver_]

=== Principe

Tout associé qui cesserait d'exercer ses fonctions au sein de la Société ou de lui apporter une collaboration effective (le « *Partant* ») sera tenu de céder tout ou partie de ses actions selon les conditions ci-dessous, selon la qualification de son départ.

=== _Good Leaver_ (Départ de bonne foi)

Est considéré comme _Good Leaver_ l'associé dont le départ résulte :
- d'un licenciement sans cause réelle et sérieuse ;
- d'une révocation du mandat social (Président ou Directeur Général) sans juste motif ;
- d'une incapacité physique ou mentale durable ;
- d'un commun accord avec les autres associés ;
- d'une démission volontaire postérieure à l'expiration de la période de _cliff_ prévue au calendrier de vesting ;
- du décès de l'associé.

Le _Good Leaver_ cédera ses actions à un prix égal à leur *valeur de marché*, déterminée par un expert indépendant conformément à l'article 1843-4 du Code civil.

=== _Bad Leaver_ (Départ fautif)

Est considéré comme _Bad Leaver_ l'associé dont le départ résulte :
- d'une démission volontaire avant l'expiration de la période de _cliff_ prévue au calendrier de vesting ;
- d'un licenciement pour faute grave ou lourde ;
- d'une révocation de ses fonctions de dirigeant pour juste motif ;
- d'une violation des clauses de non-concurrence ou de confidentialité.

// ✓ CORRIGÉ — Bad Leaver : prix plancher à 25 % de la valeur de marché (faute grave)
// au lieu du nominal, conformément à Cass. Com. 21/06/2023, n° 21-21.875.
Le prix de cession des actions du _Bad Leaver_ est déterminé selon une *échelle graduée* :
- *Faute grave, fraude ou violation majeure* (non-concurrence, confidentialité, détournement) : prix égal à *#bad-leaver-grave-pct* de la valeur de marché des actions, telle que déterminée par un expert indépendant conformément à l'article 1843-4 du Code civil ;
- *Autres cas de Bad Leaver* (démission volontaire avant l'expiration du cliff, révocation pour juste motif non constitutif de fraude) : prix égal à *#bad-leaver-prix-pct* de la valeur de marché des actions, telle que déterminée par un expert indépendant conformément à l'article 1843-4 du Code civil.

=== Procédure de qualification _Good Leaver / Bad Leaver_

Lorsque la Société compte *plus de deux associés*, la qualification de _Good Leaver_ ou _Bad Leaver_ est prononcée par la collectivité des associés, statuant à la majorité des *deux tiers (2/3)* des voix, le Partant ne prenant pas part au vote.

Lorsque la Société ne compte que *deux associés*, la qualification est obligatoirement prononcée par un *expert indépendant* désigné d'un commun accord entre les parties ou, à défaut d'accord dans un délai de *#leaver-delai-expert jours*, par ordonnance du Président du Tribunal de commerce compétent, statuant en la forme des référés. L'expert rend sa décision motivée dans un délai de *#leaver-delai-decision mois* à compter de sa désignation. Les frais d'expertise sont à la charge de la Société.

Dans tous les cas, la décision doit être motivée par écrit et notifiée au Partant dans un délai de *#leaver-delai-notif jours* suivant la cessation effective des fonctions.

Le Partant dispose d'un délai de *#leaver-delai-contestation jours* à compter de la notification pour contester la qualification. En cas de contestation, les parties s'engagent à recourir à la procédure de médiation prévue au présent Pacte avant toute action judiciaire. En l'absence de contestation dans ce délai, la qualification est réputée définitive.

#article[Vesting progressif]

La totalité des actions détenues par chaque Associé Fondateur est soumise au calendrier de _vesting_ suivant :

- *Date de départ du vesting* : la date d'immatriculation de la Société au Registre du Commerce et des Sociétés ;
- *Durée totale* : *#vesting-duree mois* ;
- *Cliff* : *#vesting-cliff mois* — aucune action n'est considérée comme acquise pendant les 12 premiers mois ;
- Au terme du _cliff_, *#vesting-cliff-pct* des actions de chaque Associé Fondateur sont acquises ;
- Les actions restantes sont acquises *mensuellement*, de manière linéaire, sur les *#vesting-post-cliff mois* suivants (soit environ 2,08 % par mois).

=== Actions soumises au vesting

- *#founder-last #founder-first* : la totalité de ses #founder1-actions actions est soumise au vesting ;
- *#cofounder-last #cofounder-first* : la totalité de ses #cofounder-actions actions est soumise au vesting.

// ⚠ NOTE — Single-trigger vs. double-trigger acceleration
// Le single-trigger est protecteur pour les fondateurs en phase d'amorçage.
// Cependant, les investisseurs (VC) négocient généralement un double-trigger
// (changement de contrôle + départ involontaire dans les 12-24 mois suivants)
// pour maintenir la rétention des fondateurs post-acquisition.
// Anticiper cette renégociation lors d'une future levée de fonds.
=== Accélération du vesting

En cas de *changement de contrôle* de la Société (cession de plus de 50 % du capital à un tiers, fusion, ou introduction en bourse), la totalité des actions non encore _vestées_ de chaque Associé Fondateur sera immédiatement et intégralement acquise (*single trigger acceleration*).

=== Accélération du vesting en cas de départ qualifié _Good Leaver_

En cas de départ d'un Associé Fondateur qualifié de _Good Leaver_, celui-ci bénéficie d'une accélération de *douze (12) mois* de vesting supplémentaires, calculée à compter de la date de cessation effective des fonctions. Les actions ainsi accélérées sont réputées _vestées_ et cédées aux conditions de prix du _Good Leaver_ (valeur de marché).

=== Effet du vesting sur le départ

En cas de départ d'un Associé Fondateur qualifié de *_Good Leaver_*, les actions _vestées_ (y compris celles résultant de l'accélération prévue ci-dessus) sont conservées ou cédées à leur *valeur de marché*. Les actions non _vestées_ excédant l'accélération sont cédées à la Société ou aux autres associés à leur *valeur nominale*.

En cas de départ d'un Associé Fondateur qualifié de *_Bad Leaver_*, seules les actions _vestées_ à la date de cessation effective des fonctions sont conservées, aux conditions de prix du _Bad Leaver_. Les actions non _vestées_ sont cédées à la Société ou aux autres associés à leur *valeur nominale*.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE III — GOUVERNANCE ET DROITS PROTECTEURS
// ════════════════════════════════════════════════════════════════════════════

= Titre III — Gouvernance et Droits Protecteurs

#article[Droits protecteurs de l'associé minoritaire (_protective provisions_)]

Nonobstant toute autre disposition des Statuts ou du présent Pacte, les décisions suivantes ne pourront être adoptées qu'avec le *consentement exprès* de tout associé détenant au moins *#minority-seuil* du capital social (ci-après le « *Minoritaire Protégé* ») :

+ *Dilution et capital* — toute émission de nouvelles actions, valeurs mobilières ou instruments donnant accès au capital (BSPCE, BSA, obligations convertibles, actions gratuites) susceptible de diluer la participation d'un Associé Fondateur en dessous de *#minority-seuil* du capital pleinement dilué ;
+ *Endettement significatif* — la souscription de tout emprunt, crédit ou engagement hors bilan d'un montant unitaire supérieur à *#seuil-dette-unitaire* ou cumulé supérieur à *#seuil-dette-cumule* par exercice social ;
+ *Rémunération des dirigeants* — toute fixation ou modification de la rémunération (fixe, variable, avantages en nature) du Président ou du Directeur Général au-delà de *#seuil-remuneration* bruts annuels ;
+ *Cession d'actifs stratégiques* — toute cession, licence exclusive ou apport de la propriété intellectuelle essentielle de la Société (code source, marques, brevets) ;
+ *Opérations de restructuration* — toute fusion, scission, apport partiel d'actif, ou cession de la totalité ou de la quasi-totalité des actifs de la Société ;
+ *Dissolution* — toute dissolution anticipée volontaire de la Société ;
+ *Changement d'objet social* — toute modification substantielle de l'objet social ;
+ *Distribution de dividendes* — toute mise en distribution de bénéfices au cours des trois (3) premiers exercices suivant l'immatriculation, sauf décision unanime ;
+ *Révocation d'un Associé Fondateur dirigeant* — toute révocation du mandat social (Président ou Directeur Général) d'un Associé Fondateur, sauf révocation pour juste motif prononcée sur le fondement d'une décision motivée d'un expert indépendant désigné conformément à la procédure de qualification _Good Leaver / Bad Leaver_ prévue au Titre II du présent Pacte.

Ce droit de consentement constitue un droit attaché à la qualité d'Associé Fondateur et subsistera aussi longtemps que le Minoritaire Protégé détiendra au moins *#minority-seuil* du capital social pleinement dilué. Il ne pourra être supprimé ou modifié qu'à l'unanimité des associés.

#note-box[
  Les _protective provisions_ visent à protéger l'associé minoritaire contre les décisions unilatérales qui pourraient affecter substantiellement la valeur de sa participation ou la gouvernance de la Société. Elles n'entravent pas la gestion courante, qui demeure du ressort du Président.
]

#article[Droit d'information renforcé des Associés Fondateurs]

Tout associé détenant au moins *#minority-seuil* du capital social dispose d'un droit d'information renforcé comprenant :

- La communication trimestrielle d'un *tableau de bord* incluant le chiffre d'affaires, les charges, la trésorerie disponible et les engagements hors bilan ;
- L'accès permanent et complet aux comptes bancaires de la Société, sans préjudice du droit de co-signature prévu aux Statuts ;
- La communication préalable de tout projet de recrutement, de tout engagement financier supérieur à *#seuil-info-engagement*, et de tout projet de partenariat stratégique, au moins *#info-delai-preavis jours ouvrés* avant toute décision ;
- La notification, dans un délai de *dix (10) jours ouvrés* à compter de la première interaction formelle portant sur les conditions commerciales, de toute *négociation commerciale significative* en cours, et notamment : tout prospect ou client susceptible de représenter plus de *dix pour cent (10 %)* du chiffre d'affaires annuel de la Société (par référence au dernier exercice clos ou, à défaut, au budget prévisionnel approuvé par les associés), et tout contrat-cadre en cours de négociation. Cette notification inclut l'identité du tiers, la nature et l'enjeu estimé de la négociation, et son état d'avancement. Tout changement substantiel dans l'avancement d'une négociation précédemment notifiée devra faire l'objet d'une mise à jour dans les mêmes conditions ;
- La notification, dans un délai de *quarante-huit (48) heures*, de toute lettre d'intention (_LOI_) reçue ou émise, de tout litige, mise en demeure, assignation, contrôle fiscal ou social, ou événement susceptible d'affecter substantiellement la valeur ou la situation de la Société.

Les informations communiquées au titre du présent article sont couvertes par l'obligation de confidentialité prévue au Titre V du présent Pacte.

Ce droit d'information constitue une *obligation réciproque* : chaque Associé Fondateur dirigeant est tenu de communiquer les informations visées ci-dessus à l'autre Associé Fondateur dirigeant. Ce droit est *incessible* et attaché à la qualité d'Associé Fondateur.

En cas de manquement à l'obligation de notification prévue au présent article, si la clause de résolution des blocages (Titre VI) est déclenchée dans les *douze (12) mois* suivant le manquement, le Destinataire pourra exiger la *suspension de la procédure shotgun* jusqu'à ce que l'information omise soit communiquée et qu'un nouveau délai de *#shotgun-delai-info jours* soit accordé à compter de cette communication. En outre, toute omission délibérée d'une information *substantielle* — c'est-à-dire une information dont la connaissance aurait été de nature à influencer l'appréciation du prix proposé ou la décision d'accepter ou de retourner l'offre — dans le dossier d'information prévu au Titre VI constitue un manquement grave susceptible d'entraîner la *nullité de la procédure shotgun* engagée, prononcée par le tribunal compétent saisi par la partie lésée.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE IV — INSTRUMENTS D'INTÉRESSEMENT
// ════════════════════════════════════════════════════════════════════════════

= Titre IV — Instruments d'Intéressement

#article[Pool BSPCE]

Les Parties conviennent de constituer un pool de bons de souscription de parts de créateur d'entreprise (BSPCE) représentant jusqu'à *#bspce-pool* du capital social pleinement dilué de la Société.

Les conditions d'émission et d'attribution des BSPCE seront déterminées conformément aux dispositions de l'article 163 bis G du Code général des impôts et des articles L. 228-91 et suivants du Code de commerce, ainsi qu'aux autorisations prévues dans les Statuts.

Les conditions d'exercice des BSPCE sont les suivantes :

- *Prix d'exercice* : le prix d'exercice de chaque BSPCE sera au moins égal à la *juste valeur de marché* des actions sous-jacentes à la date d'attribution, telle que déterminée par le conseil d'administration ou la collectivité des associés ;
- *Vesting* : chaque attribution de BSPCE sera soumise à un calendrier de vesting comprenant un _cliff_ minimum de *#vesting-cliff mois* ;
// ✓ CORRIGÉ — Les BSPCE vestés survivent au Bad Leaver avec délai d'exercice réduit.
// Conforme à la jurisprudence (Cass. Soc. 21/10/2009, n° 08-42.026) : la suppression
// de BSPCE déjà vestés pour motif disciplinaire risque d'être requalifiée en sanction
// pécuniaire prohibée (art. L. 1331-2 C. trav.) pour les bénéficiaires salariés.
- *Effet du départ* : en cas de départ du bénéficiaire, les BSPCE non _vestés_ seront caducs de plein droit. Les BSPCE _vestés_ pourront être exercés dans un délai de *#bspce-exercice-depart jours* suivant la date de cessation effective des fonctions. En cas de qualification en _Bad Leaver_, les BSPCE non _vestés_ seront caducs de plein droit ; les BSPCE _vestés_ pourront être exercés dans un délai réduit de *trente (30) jours* suivant la notification de la qualification.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE V — ENGAGEMENTS DES ASSOCIÉS
// ════════════════════════════════════════════════════════════════════════════

= Titre V — Engagements des Associés

#article[Confidentialité]

// ✓ CORRIGÉ — Exclusions classiques ajoutées à la clause de confidentialité.
Chaque associé s'engage à considérer comme strictement confidentiel et à ne pas divulguer à des tiers, sans l'accord préalable et écrit du Président, toute information relative aux affaires de la Société, notamment les informations financières, commerciales, techniques, stratégiques et technologiques, les données clients, les algorithmes, le code source et les méthodes de travail.

Ne sont pas considérées comme confidentielles les informations qui :
- sont ou deviennent accessibles au public autrement que par le fait du débiteur de l'obligation ;
- étaient déjà en la possession légitime de l'associé avant son entrée au capital de la Société, sous réserve qu'il puisse en apporter la preuve ;
- ont été reçues d'un tiers non lié par une obligation de confidentialité envers la Société ;
- doivent être divulguées en vertu d'une obligation légale, réglementaire ou d'une décision judiciaire, sous réserve d'en informer préalablement le Président dans la mesure du possible.

Cette obligation de confidentialité survivra à la perte de la qualité d'associé pendant une durée de *#confidentialite-survie ans*.

La violation de cette obligation pourra constituer un juste motif de révocation et/ou de qualification en _Bad Leaver_.

#article[Non-concurrence]

Chaque associé exerçant des fonctions opérationnelles au sein de la Société s'engage, pendant toute la durée de ses fonctions et après la cessation de ses fonctions, à ne pas exercer, directement ou indirectement, une activité concurrente à l'objet social de la Société, dans les limites suivantes :

=== Durée et périmètre selon la catégorie de l'associé

- *Dirigeants (Président, Directeur Général)* : #non-compete-duree-dirigeants ans, en France et dans les pays de l'Union européenne où la Société est active ;
- *Associés opérationnels non-dirigeants* : #non-compete-duree-associes an, limité à la France ;
- *Advisors et consultants* : #non-compete-duree-advisors mois, limité à la France.

Dans tous les cas, l'obligation est limitée dans son objet aux activités de détaxe et de remboursement de TVA aux voyageurs.

=== Contrepartie financière

En contrepartie, la Société versera à l'associé concerné une indemnité mensuelle égale à *#non-compete-indemnite* de la moyenne mensuelle de sa dernière rémunération brute perçue au cours des douze (12) derniers mois.

Cette indemnité mensuelle ne pourra en aucun cas être inférieure à *#non-compete-plancher du SMIC mensuel brut* en vigueur à la date de cessation effective des fonctions, y compris dans l'hypothèse où la rémunération du débiteur de l'obligation serait nulle.

// ✓ CORRIGÉ — Clause d'adaptation ajoutée pour cumul mandat/contrat de travail
// (Cass. Soc. 26/01/2022). Plancher SMIC prévu à l'alinéa « Contrepartie financière ».
=== Faculté de renonciation

La Société se réserve le droit de *renoncer unilatéralement* à l'application de la clause de non-concurrence, et par conséquent au versement de l'indemnité, à condition d'en notifier l'associé concerné par lettre recommandée avec accusé de réception dans un délai de *#non-compete-renonciation jours* suivant la date effective de cessation des fonctions. La renonciation est alors totale et libère immédiatement l'associé de son obligation.

=== Adaptation en cas de cumul mandat social et contrat de travail

Lorsqu'un associé cumule un mandat social et un contrat de travail au sein de la Société, la renonciation à la clause de non-concurrence devra être notifiée au plus tard à la date de cessation effective des fonctions salariées, conformément à la jurisprudence applicable (Cass. Soc. 26 janvier 2022). En cas de conflit entre les stipulations du présent Pacte et celles du contrat de travail relatives à la non-concurrence, les stipulations les plus protectrices du débiteur de l'obligation prévaudront.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE VI — RÉSOLUTION DES DIFFÉRENDS
// ════════════════════════════════════════════════════════════════════════════

= Titre VI — Résolution des Différends

#article[Résolution des blocages (_clause shotgun_)]

En cas de désaccord persistant entre les associés sur une décision stratégique ou opérationnelle, rendant impossible le fonctionnement normal de la Société pendant une durée de plus de *#shotgun-delai-blocage mois* (ci-après le « *Blocage* »), tout associé (l'« *Initiateur* ») pourra déclencher la procédure suivante :

+ Préalablement à l'envoi de l'offre, l'Initiateur communique au Destinataire un *dossier d'information* comprenant au minimum : (i) les comptes sociaux les plus récents ou, à défaut, une situation comptable intermédiaire datant de moins de trois (3) mois, (ii) la situation de trésorerie à jour, (iii) la liste des contrats en cours et des négociations significatives en cours, et (iv) tout événement susceptible d'affecter substantiellement la valeur de la Société. Le Destinataire dispose d'un délai de *#shotgun-delai-info jours* à compter de la réception du dossier d'information pour demander des compléments d'information, auxquels l'Initiateur doit répondre dans un délai de *#shotgun-delai-complement jours* ;
+ L'Initiateur notifie au Destinataire, par lettre recommandée avec accusé de réception et par courrier électronique avec accusé de lecture, une offre ferme et irrévocable de rachat de la totalité de ses actions à un prix par action déterminé librement par l'Initiateur (le « *Prix Proposé* ») ;
+ Le Destinataire dispose d'un délai de *#shotgun-delai-reponse jours* à compter de la réception de la notification pour :
  - soit *accepter* l'offre et céder la totalité de ses actions à l'Initiateur au Prix Proposé ;
  - soit *retourner l'offre* et racheter la totalité des actions de l'Initiateur au même Prix Proposé par action ;
+ À défaut de réponse dans le délai de #shotgun-delai-reponse jours, le Destinataire est réputé avoir accepté l'offre de cession ;
+ La cession doit être réalisée dans un délai de *#shotgun-delai-realisation jours* suivant l'acceptation ou le retournement de l'offre. Le paiement est effectué en une seule fois, par virement bancaire.

Ce mécanisme garantit l'équité puisque l'Initiateur, ne sachant pas si le Destinataire achètera ou vendra, est incité à proposer un prix juste.

=== Délai de financement et modalités de paiement en cas de retournement

En cas de retournement de l'offre par le Destinataire, celui-ci bénéficie d'un délai de *#shotgun-financement jours* à compter de la notification du retournement pour réunir le financement nécessaire à l'acquisition. Pendant ce délai, le retournement demeure ferme et irrévocable.

À l'expiration du délai de financement, si le Destinataire n'est pas en mesure de justifier de la disponibilité des fonds nécessaires, le retournement est réputé caduc et le Destinataire est réputé avoir accepté l'offre initiale de cession. La cession de ses actions à l'Initiateur devra alors être réalisée dans un délai de *#shotgun-delai-realisation jours* suivant l'expiration du délai de financement, au Prix Proposé.

Le Destinataire exerçant le retournement peut proposer un paiement du prix en *trois (3) échéances* sur une durée maximale de *#shotgun-echelon-duree mois*, selon l'échéancier suivant : un tiers (1/3) du prix à la date de réalisation de la cession, un tiers (1/3) à six (6) mois et le solde à #shotgun-echelon-duree mois. Le paiement échelonné est garanti par un *nantissement de premier rang* sur la totalité des actions acquises, constitué au jour de la réalisation de la cession. En cas de défaut de paiement d'une échéance, la totalité du solde restant dû devient immédiatement exigible.

La présente clause n'est applicable que lorsque la Société ne compte que *deux associés*. Elle ne peut être déclenchée pendant les *#shotgun-delai-declenchement premiers mois* suivant l'immatriculation de la Société.

#article[Médiation et arbitrage]

=== Médiation préalable obligatoire

Tout litige entre associés, ou entre un associé et la Société, relatif à l'interprétation, l'exécution ou la résiliation du présent Pacte, devra, préalablement à toute action judiciaire ou au déclenchement de la clause shotgun, être soumis à une tentative de *médiation* menée par un médiateur agréé auprès d'un centre de médiation reconnu (CMAP, CNMA ou équivalent).

La médiation aura une durée maximale de *#mediation-duree mois* à compter de la désignation du médiateur.

=== Arbitrage (optionnel)

À défaut d'accord amiable à l'issue de la médiation, les parties pourront soumettre le litige à l'arbitrage selon le règlement du Centre de Médiation et d'Arbitrage de Paris (CMAP), par un arbitre unique nommé conformément audit règlement.

=== Juridiction compétente

À défaut de clause compromissoire ou en cas de mesure urgente ou conservatoire, les tribunaux compétents seront ceux du ressort du siège social de la Société.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE VII — DISPOSITIONS FINALES
// ════════════════════════════════════════════════════════════════════════════

= Titre VII — Dispositions Finales

#article[Durée du pacte]

Le présent pacte est conclu pour la durée de la Société. Il cessera de plein droit de produire ses effets en cas de dissolution de la Société ou lorsqu'un associé cessera de détenir des actions de la Société, sous réserve des clauses qui survivent expressément à la perte de la qualité d'associé (confidentialité, non-concurrence).

#article[Indivisibilité]

Les stipulations du présent pacte forment un tout indivisible. La nullité ou l'inopposabilité d'une clause n'affectera pas la validité des autres, les parties s'engageant dans ce cas à négocier de bonne foi une clause de remplacement ayant un effet économique et juridique équivalent.

#article[Modification]

Toute modification du présent pacte devra être constatée par un avenant écrit signé par l'ensemble des parties.

#article[Loi applicable]

Le présent pacte est soumis au droit français.

#article[Élection de domicile]

Pour l'exécution du présent pacte, chaque partie fait élection de domicile à l'adresse indiquée en tête des présentes.


// ════════════════════════════════════════════════════════════════════════════
//  SIGNATURES
// ════════════════════════════════════════════════════════════════════════════

#pagebreak()

#align(center)[
  #text(size: 16pt, weight: "bold", fill: primary)[SIGNATURES]
  #v(4pt)
  #line(length: 40%, stroke: 0.5pt + accent)
]

#v(1.5cm)

Fait à *#siege-ville*, le *#date-signature*, en *deux (2)* exemplaires originaux.

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
    *Rappel :* Chaque page du présent pacte doit être paraphée par les deux Associés Fondateurs. La dernière page doit être signée avec la mention manuscrite « Lu et approuvé ».
  ]
}
