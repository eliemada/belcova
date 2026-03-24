// ============================================================================
//  PACTE D'ASSOCIÉS — BELCOVA SAS — Typst
//  Document confidentiel — Complément aux statuts constitutifs
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
#let nb-actions          = "100"
#let valeur-nominale     = "1"
#let date-signature      = "2 mars 2026"

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

#let use-watermark       = false                          // désactivé
#let watermark-text      = "EXEMPLAIRE ORIGINAL"          // ← texte du filigrane
#let watermark-opacity   = 4%                             // ← discret mais visible à l'inspection

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
      Associés fondateurs : #founder-last #founder-first (60 %) · #cofounder-last #cofounder-first (40 %)
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

En cas de projet de cession portant sur un nombre d'actions représentant plus de *cinquante pour cent (50 %)* du capital social, que cette cession soit réalisée par un seul ou plusieurs associés agissant de concert, chaque associé non-cédant aura le droit d'exiger que ses propres actions soient incluses dans la cession, aux mêmes conditions de prix et modalités que celles consenties au(x) cédant(s).

L'associé majoritaire cédant devra notifier aux associés minoritaires le projet de cession au moins *trente (30) jours* avant sa réalisation. Les associés minoritaires disposeront d'un délai de *quinze (15) jours* à compter de la réception de cette notification pour exercer leur droit de sortie conjointe.

En cas d'exercice du droit de sortie conjointe, le cessionnaire sera tenu d'acquérir l'ensemble des actions offertes (actions du cédant et des associés exerçant le tag-along). À défaut, la cession ne pourra avoir lieu.

#article[Clause d'entraînement (_drag-along_)]

En cas de projet de cession de la totalité des actions de la Société à un tiers, approuvé par des associés représentant au moins *quatre-vingts pour cent (80 %)* du capital social et des droits de vote, les associés minoritaires seront tenus de céder l'intégralité de leurs actions au même cessionnaire, aux mêmes conditions de prix et modalités.

Tant que la Société ne compte que *deux (2) associés*, la mise en œuvre de la clause d'entraînement requiert l'accord *unanime* de l'ensemble des associés.

Les associés représentant la majorité requise notifieront aux associés minoritaires le projet de cession au moins *trente (30) jours* avant la date de réalisation envisagée. Le prix de cession devra être au moins égal à la valeur des actions telle que déterminée par un expert indépendant désigné d'un commun accord ou, à défaut, conformément aux dispositions de l'article 1843-4 du Code civil.

#article[Clause d'inaliénabilité (_lock-up_)]

Conformément à la clause d'inaliénabilité prévue aux Statuts en application de l'article L. 227-13 du Code de commerce, chaque Associé Fondateur s'interdit de céder, transférer, nantir ou de consentir quelque droit que ce soit sur tout ou partie de ses actions pendant une durée de *trois (3) ans* à compter de l'immatriculation de la Société au Registre du Commerce et des Sociétés.

Cette interdiction ne s'applique pas :
- aux cessions entre associés existants ;
- aux cessions au profit du conjoint, des ascendants ou descendants du cédant ;
- aux cessions résultant d'une transmission pour cause de décès ;
- aux cessions réalisées dans le cadre d'une augmentation de capital au profit d'investisseurs financiers agréée par la collectivité des associés.


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

#article[Vesting progressif]

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
//  TITRE III — GOUVERNANCE ET DROITS PROTECTEURS
// ════════════════════════════════════════════════════════════════════════════

= Titre III — Gouvernance et Droits Protecteurs

#article[Droits protecteurs de l'associé minoritaire (_protective provisions_)]

Nonobstant toute autre disposition des Statuts ou du présent Pacte, les décisions suivantes ne pourront être adoptées qu'avec le *consentement exprès* de tout associé détenant au moins *vingt-cinq pour cent (25 %)* du capital social (ci-après le « *Minoritaire Protégé* ») :

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

#article[Droit d'information renforcé de l'associé minoritaire]

Tout associé détenant au moins *vingt-cinq pour cent (25 %)* du capital social dispose d'un droit d'information renforcé comprenant :

- La communication trimestrielle d'un *tableau de bord* incluant le chiffre d'affaires, les charges, la trésorerie disponible et les engagements hors bilan ;
- L'accès permanent aux comptes bancaires de la Société en consultation (_read-only_) ;
- La communication préalable de tout projet de recrutement, de tout engagement financier supérieur à *cinquante mille euros (50 000 €)*, et de tout projet de partenariat stratégique, au moins *dix (10) jours ouvrés* avant toute décision.

Ce droit d'information est *incessible* et attaché à la qualité d'Associé Fondateur.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE IV — INSTRUMENTS D'INTÉRESSEMENT
// ════════════════════════════════════════════════════════════════════════════

= Titre IV — Instruments d'Intéressement

#article[Pool BSPCE]

Les Parties conviennent de constituer un pool de bons de souscription de parts de créateur d'entreprise (BSPCE) représentant jusqu'à *quinze pour cent (15 %)* du capital social pleinement dilué de la Société.

Les conditions d'émission et d'attribution des BSPCE seront déterminées conformément aux dispositions des articles L. 228-36-1 et suivants du Code de commerce et aux autorisations prévues dans les Statuts.

Les conditions d'exercice des BSPCE sont les suivantes :

- *Prix d'exercice* : le prix d'exercice de chaque BSPCE sera au moins égal à la *juste valeur de marché* des actions sous-jacentes à la date d'attribution, telle que déterminée par le conseil d'administration ou la collectivité des associés ;
- *Vesting* : chaque attribution de BSPCE sera soumise à un calendrier de vesting comprenant un _cliff_ minimum de *douze (12) mois* ;
- *Effet du départ* : en cas de départ du bénéficiaire, les BSPCE non _vestés_ seront caducs de plein droit ; les BSPCE _vestés_ pourront être exercés dans un délai de *quatre-vingt-dix (90) jours* suivant la date de cessation effective des fonctions, sauf en cas de qualification en _Bad Leaver_, auquel cas l'ensemble des BSPCE (vestés et non vestés) seront immédiatement caducs.


// ════════════════════════════════════════════════════════════════════════════
//  TITRE V — ENGAGEMENTS DES ASSOCIÉS
// ════════════════════════════════════════════════════════════════════════════

= Titre V — Engagements des Associés

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


// ════════════════════════════════════════════════════════════════════════════
//  TITRE VI — RÉSOLUTION DES DIFFÉRENDS
// ════════════════════════════════════════════════════════════════════════════

= Titre VI — Résolution des Différends

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

Tout litige entre associés, ou entre un associé et la Société, relatif à l'interprétation, l'exécution ou la résiliation du présent Pacte, devra, préalablement à toute action judiciaire ou au déclenchement de la clause shotgun, être soumis à une tentative de *médiation* menée par un médiateur agréé auprès d'un centre de médiation reconnu (CMAP, CNMA ou équivalent).

La médiation aura une durée maximale de *trois (3) mois* à compter de la désignation du médiateur.

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
