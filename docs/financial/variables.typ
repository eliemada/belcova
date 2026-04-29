// =============================================================================
// VARIABLES FINANCIÈRES — BELCOVA SAS
//
// Source unique pour le prévisionnel financier.
// Modifier ces valeurs pour ajuster les projections.
// =============================================================================

// ── Identité ────────────────────────────────────────────────────────────────
#let rcs-number          = "104 126 727"
#let siege-social        = "58 Rue de Monceau, 75008 Paris"
#let capital-initial     = "100"
#let date-document       = "29 avril 2026"
#let representant-nom    = "Elie BRUNO"
#let representant-fonction = "Président"

// ── Marché ──────────────────────────────────────────────────────────────────
#let panier-moyen-detaxe   = 580       // € TTC — achat moyen éligible détaxe
#let tva-moyenne           = 97        // € — TVA par bordereau (20% de 483,33 HT)
#let remboursement-moyen   = 97        // € — alias pour compatibilité
#let delai-remboursement-dgddi = "45"  // jours — délai remb. DGDDI → opérateur

// ── Tarification ────────────────────────────────────────────────────────────
#let taux-retrocession   = "80"        // % — part de TVA remboursée au voyageur
#let avance-voyageur     = 78          // € — montant avancé au voyageur (97 × 80%, arrondi)
#let marge-tva-par-bvx   = 19          // € — marge TVA conservée par Belcova (97 − 78)
#let frais-voyageur      = 3           // € — frais de service facturés au voyageur
#let commission-commercant = 2         // € — commission versée AU commerçant / bordereau

// ── Volumes ─────────────────────────────────────────────────────────────────
// Commerçants actifs (fin d'année)
#let nb-merchants-2026   = "10"
#let nb-merchants-2027   = "45"
#let nb-merchants-2028   = "140"

// Bordereaux traités
#let nb-bvx-2026         = "350"
#let nb-bvx-2027         = "4 200"
#let nb-bvx-2028         = "18 000"

// ── Revenus calculés ────────────────────────────────────────────────────────
// Marge TVA (écart DGDDI − remboursement voyageur)
#let rev-marge-tva-2026   = 6650       // 350 × 19 €
#let rev-marge-tva-2027   = 79800      // 4 200 × 19 €
#let rev-marge-tva-2028   = 342000     // 18 000 × 19 €

// Frais de service voyageur
#let rev-service-2026     = 1050       // 350 × 3 €
#let rev-service-2027     = 12600      // 4 200 × 3 €
#let rev-service-2028     = 54000      // 18 000 × 3 €

// Totaux produits
#let total-produits-2026  = 7700       // 6650 + 1050
#let total-produits-2027  = 92400      // 79800 + 12600
#let total-produits-2028  = 396000     // 342000 + 54000

// ── CA (alias pour synthèse) ────────────────────────────────────────────────
#let ca-2027             = 92400
#let ca-2028             = 396000

// ── Charges détaillées ──────────────────────────────────────────────────────

// Commissions commerçants (charge variable — Belcova PAIE le commerçant)
#let comm-merchant-2026  = 700         // 350 × 2 €
#let comm-merchant-2027  = 8400        // 4 200 × 2 €
#let comm-merchant-2028  = 36000       // 18 000 × 2 €

// Hébergement cloud (OVH / Scaleway)
#let cloud-2026          = 1350        // 150 €/mois × 9 mois
#let cloud-2027          = 2400        // 200 €/mois
#let cloud-2028          = 4800        // 400 €/mois (scaling)

// Domiciliation (Les Tricolores — facture connue)
#let domiciliation-2026  = 520         // 173,80 €/trimestre × 3 trim.
#let domiciliation-2027  = 700         // 4 trimestres
#let domiciliation-2028  = 700

// Assurance RC Pro
#let assurance-2026      = 375         // 500 €/an prorata 9 mois
#let assurance-2027      = 600
#let assurance-2028      = 900         // augmente avec le CA

// Expert-comptable
#let comptable-2026      = 1500        // tarif startup
#let comptable-2027      = 2400
#let comptable-2028      = 3600        // complexité croissante

// Marketing & acquisition commerçants
#let marketing-2026      = 2700        // 300 €/mois × 9 mois
#let marketing-2027      = 6000        // 500 €/mois
#let marketing-2028      = 12000       // 1000 €/mois

// Licences & outils SaaS (GitHub, monitoring, etc.)
#let licences-2026       = 675         // 75 €/mois × 9 mois
#let licences-2027       = 1200        // 100 €/mois
#let licences-2028       = 1800        // 150 €/mois

// Rémunération dirigeants (président + DG)
#let remun-dirigeants-2026  = 0        // pas de rémunération — fondateurs bénévoles
#let remun-dirigeants-2027  = 0
#let remun-dirigeants-2028  = 0

// Charges sociales dirigeants
#let charges-sociales-2026  = 0
#let charges-sociales-2027  = 0
#let charges-sociales-2028  = 0

// Salariés
#let salaries-2026       = 0
#let salaries-2027       = 0
#let salaries-2028       = 0

// Frais bancaires (Qonto)
#let banque-2026         = 225         // 25 €/mois × 9
#let banque-2027         = 360         // 30 €/mois
#let banque-2028         = 480         // 40 €/mois

// Divers & imprévus (5 % des charges externes hors divers)
#let divers-2026         = 370         // 5% de 7345
#let divers-2027         = 700         // 5% de 13660
#let divers-2028         = 1250        // 5% de 24280

// ── Charges agrégées (pour le compte de résultat) ───────────────────────────

// Charges externes = cloud + domiciliation + assurance + comptable + marketing + licences + banque + divers
#let charges-ext-2026    = 7715        // 1350+520+375+1500+2700+675+225+370
#let charges-ext-2027    = 14360       // 2400+700+600+2400+6000+1200+360+700
#let charges-ext-2028    = 25530       // 4800+700+900+3600+12000+1800+480+1250

// Charges de personnel = 0 (fondateurs bénévoles, pas de salariés)
#let charges-personnel-2026 = 0
#let charges-personnel-2027 = 0
#let charges-personnel-2028 = 0

// Amortissements (développement logiciel capitalisé sur 3 ans)
#let amortissements-2026 = 0           // pas encore d'immobilisations
#let amortissements-2027 = 5000        // début amortissement plateforme
#let amortissements-2028 = 5000

// Total charges (ext + merchant comm + personnel + amort)
#let total-charges-2026  = 8415        // 7715 + 700 + 0 + 0
#let total-charges-2027  = 27760       // 14360 + 8400 + 0 + 5000
#let total-charges-2028  = 66530       // 25530 + 36000 + 0 + 5000

// ── Résultats ───────────────────────────────────────────────────────────────

// Résultat d'exploitation
#let rex-2026            = -715        // 7700 - 8415
#let rex-2027            = 64640       // 92400 - 27760
#let rex-2028            = 329470      // 396000 - 66530

// Marges (string pour affichage)
#let pct-rex-2027        = "69,9 %"
#let pct-rex-2028        = "83,2 %"

// IS (25 % — prudence, pas de taux réduit appliqué)
#let is-2026             = 0           // déficitaire
#let is-2027             = 16160       // 25% de 64 640
#let is-2028             = 82368       // 25% de 329 470

// Résultat net
#let rn-2026             = -715
#let rn-2027             = 48480       // 64640 - 16160
#let rn-2028             = 247103      // 329470 - 82368

// ── Seuil de rentabilité (break-even) ───────────────────────────────────────
#let mois-breakeven      = "octobre 2026"
#let annee-net-positif   = "2027"
#let revenu-net-par-bvx  = 20          // marge TVA (19) + frais service (3) − comm merchant (2)
#let total-fixes-mensuel = 1270        // charges fixes mensuelles hors personnel
#let seuil-bvx-mensuel   = "64"        // 1270 / 20
#let seuil-bvx-jour      = "3"         // 64 / 22 jours ouvrés
#let seuil-merchants     = "3–4"       // commerçants nécessaires pour le point mort

// ── Charges fixes mensuelles (détail seuil de rentabilité) ──────────────────
#let cloud-mensuel-croisiere = 200
#let domiciliation-mensuel   = 58      // 700 / 12
#let assurance-mensuel       = 50      // 600 / 12
#let comptable-mensuel       = 200     // 2400 / 12
#let licences-mensuel        = 100
#let banque-mensuel          = 30
#let divers-mensuel          = 130

// ── Plan de financement initial ─────────────────────────────────────────────
#let frais-constitution    = 670       // greffe (54,40) + JAL (238,80) + domiciliation (173,80) + Qonto (202,80)
#let dev-plateforme        = 0         // développement interne, non décaissé
#let certification-pablo   = 500       // frais liés à la certification EDI
#let bfr-initial           = 3800      // 3 mois de charges fixes
#let tresorerie-securite   = 10130     // réserve pour avances TVA

#let total-besoins         = 15100     // 670 + 0 + 500 + 3800 + 10130

#let apport-cca-total      = 15000    // apport en compte courant d'associés
#let subventions           = 0         // prudence : pas de subvention comptabilisée
#let total-ressources      = 15100     // 100 + 15000

// ── BFR détaxe ──────────────────────────────────────────────────────────────
#let bfr-max-2026          = 3900      // pic de trésorerie mobilisée pour avances TVA (80%)

// ── Plan de trésorerie mensuel 2026 (Avr–Déc) ──────────────────────────────

// Apport CCA initial
#let apport-cca            = 15000

// BVE mensuels : Jul=20, Aug=30, Sep=35, Oct=45, Nov=55, Dec=60

// Frais de service voyageur (encaissés au moment du service)
#let cash-service-jul      = 60        // 20 × 3 €
#let cash-service-aug      = 90        // 30 × 3 €
#let cash-service-sep      = 105       // 35 × 3 €
#let cash-service-oct      = 135       // 45 × 3 €
#let cash-service-nov      = 165       // 55 × 3 €
#let cash-service-dec      = 180       // 60 × 3 €

// Remboursements DGDDI (TVA intégrale, décalé ~45 jours)
#let cash-dgddi-aug        = 1940      // remb. bordereaux juillet (20 × 97 €)
#let cash-dgddi-sep        = 2910      // bordereaux août (30 × 97 €)
#let cash-dgddi-oct        = 3395      // bordereaux septembre (35 × 97 €)
#let cash-dgddi-nov        = 4365      // bordereaux octobre (45 × 97 €)
#let cash-dgddi-dec        = 5335      // bordereaux novembre (55 × 97 €)

// Charges fixes mensuelles (simplifiées)
#let dec-fixes-apr         = 950       // constitution + premiers frais
#let dec-fixes-mai         = 650
#let dec-fixes-jun         = 650
#let dec-fixes-jul         = 700
#let dec-fixes-aug         = 700
#let dec-fixes-sep         = 700
#let dec-fixes-oct         = 750
#let dec-fixes-nov         = 750
#let dec-fixes-dec         = 750

// Avances TVA aux voyageurs (80% de la TVA, au moment du service)
#let avance-tva-jul        = 1560      // 20 × 78 €
#let avance-tva-aug        = 2340      // 30 × 78 €
#let avance-tva-sep        = 2730      // 35 × 78 €
#let avance-tva-oct        = 3510      // 45 × 78 €
#let avance-tva-nov        = 4290      // 55 × 78 €
#let avance-tva-dec        = 4680      // 60 × 78 €

// Commissions commerçants (versées au moment du service)
#let dec-comm-jul          = 40        // 20 × 2 €
#let dec-comm-aug          = 60        // 30 × 2 €
#let dec-comm-sep          = 70        // 35 × 2 €
#let dec-comm-oct          = 90        // 45 × 2 €
#let dec-comm-nov          = 110       // 55 × 2 €
#let dec-comm-dec          = 120       // 60 × 2 €

// Marketing mensuel
#let dec-mkt-apr           = 0
#let dec-mkt-mai           = 200
#let dec-mkt-jun           = 300
#let dec-mkt-jul           = 300
#let dec-mkt-aug           = 300
#let dec-mkt-sep           = 300
#let dec-mkt-oct           = 400
#let dec-mkt-nov           = 400
#let dec-mkt-dec           = 400

// ── Totaux mensuels ─────────────────────────────────────────────────────────

// Encaissements (frais service + remboursements DGDDI)
#let enc-apr               = 15100     // capital 100 + CCA 15000
#let enc-mai               = 0
#let enc-jun               = 0
#let enc-jul               = 60        // frais service uniquement
#let enc-aug               = 2030      // 90 + 1940
#let enc-sep               = 3015      // 105 + 2910
#let enc-oct               = 3530      // 135 + 3395
#let enc-nov               = 4530      // 165 + 4365
#let enc-dec               = 5515      // 180 + 5335

// Décaissements (fixes + avances TVA + comm merchant + marketing)
#let dec-apr               = 950
#let dec-mai               = 850       // 650 + 200
#let dec-jun               = 950       // 650 + 300
#let dec-jul               = 2600      // 700 + 1560 + 40 + 300
#let dec-aug               = 3400      // 700 + 2340 + 60 + 300
#let dec-sep               = 3800      // 700 + 2730 + 70 + 300
#let dec-oct               = 4750      // 750 + 3510 + 90 + 400
#let dec-nov               = 5550      // 750 + 4290 + 110 + 400
#let dec-dec               = 5950      // 750 + 4680 + 120 + 400

// Solde mensuel
#let solde-apr             = 14150     // 15100 - 950
#let solde-mai             = -850
#let solde-jun             = -950
#let solde-jul             = -2540     // 60 - 2600
#let solde-aug             = -1370     // 2030 - 3400
#let solde-sep             = -785      // 3015 - 3800
#let solde-oct             = -1220     // 3530 - 4750
#let solde-nov             = -1020     // 4530 - 5550
#let solde-dec             = -435      // 5515 - 5950

// Trésorerie cumulée
#let cumul-apr             = 14150
#let cumul-mai             = 13300
#let cumul-jun             = 12350
#let cumul-jul             = 9810      // 12350 - 2540
#let cumul-aug             = 8440      // 9810 - 1370
#let cumul-sep             = 7655      // 8440 - 785
#let cumul-oct             = 6435      // 7655 - 1220
#let cumul-nov             = 5415      // 6435 - 1020
#let cumul-dec             = 4980      // 5415 - 435
