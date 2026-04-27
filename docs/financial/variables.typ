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
#let date-document       = "27 avril 2026"
#let representant-nom    = "Elie BRUNO"
#let representant-fonction = "Président"

// ── Marché ──────────────────────────────────────────────────────────────────
#let panier-moyen-detaxe   = 580       // € TTC — achat moyen éligible détaxe
#let remboursement-moyen   = 97        // € — TVA remboursée par bordereau (≈16,7% du TTC)
#let delai-remboursement-dgddi = "45"  // jours — délai remb. DGDDI → opérateur

// ── Tarification ────────────────────────────────────────────────────────────
#let commission-par-bvx  = 5           // € — commission facturée au commerçant / bordereau
#let frais-voyageur      = 3           // € — frais de service facturés au voyageur

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
// Commissions bordereaux
#let rev-commissions-2026 = 1750       // 350 × 5 €
#let rev-commissions-2027 = 21000      // 4 200 × 5 €
#let rev-commissions-2028 = 90000      // 18 000 × 5 €

// Frais de service voyageur
#let rev-service-2026     = 1050       // 350 × 3 €
#let rev-service-2027     = 12600      // 4 200 × 3 €
#let rev-service-2028     = 54000      // 18 000 × 3 €

// Totaux produits (commissions + frais de service uniquement)
#let total-produits-2026  = 2800       // 1750 + 1050
#let total-produits-2027  = 33600      // 21000 + 12600
#let total-produits-2028  = 144000     // 90000 + 54000

// ── CA (alias pour synthèse) ────────────────────────────────────────────────
#let ca-2027             = 33600
#let ca-2028             = 144000

// ── Charges détaillées ──────────────────────────────────────────────────────

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

// Total charges
#let total-charges-2026  = 7715        // 7715 + 0 + 0
#let total-charges-2027  = 19360       // 14360 + 0 + 5000
#let total-charges-2028  = 30530       // 25530 + 0 + 5000

// ── Résultats ───────────────────────────────────────────────────────────────

// Résultat d'exploitation
#let rex-2026            = -4915       // 2800 - 7715
#let rex-2027            = 14240       // 33600 - 19360
#let rex-2028            = 113470      // 144000 - 30530

// Marges (string pour affichage)
#let pct-rex-2027        = "42,4 %"
#let pct-rex-2028        = "78,8 %"

// IS (25 % — prudence, pas de taux réduit appliqué)
#let is-2026             = 0           // déficitaire
#let is-2027             = 3560        // 25% de 14 240
#let is-2028             = 28368       // 25% de 113 470

// Résultat net
#let rn-2026             = -4915
#let rn-2027             = 10680       // 14240 - 3560
#let rn-2028             = 85102       // 113470 - 28368

// ── Seuil de rentabilité (break-even) ───────────────────────────────────────
#let mois-breakeven      = "mars 2027"
#let annee-net-positif   = "2027"
#let revenu-par-bvx      = 8           // commission + frais service = 5 + 3
#let total-fixes-mensuel = 1270        // charges fixes mensuelles hors personnel
#let seuil-bvx-mensuel   = "159"       // 1270 / 8
#let seuil-bvx-jour      = "6"         // 159 / 26 jours ouvrés
#let seuil-merchants     = "8–10"      // commerçants nécessaires pour le point mort

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
#let bfr-max-2026          = 4850      // pic de trésorerie mobilisée pour avances TVA

// ── Plan de trésorerie mensuel 2026 (Avr–Déc) ──────────────────────────────

// Apport CCA initial
#let apport-cca            = 15000

// Commissions mensuelles (montée progressive, premiers bordereaux en juillet)
#let cash-comm-jul         = 100
#let cash-comm-aug         = 175
#let cash-comm-sep         = 200
#let cash-comm-oct         = 250
#let cash-comm-nov         = 350
#let cash-comm-dec         = 400

// Remboursements DGDDI (décalé de ~45 jours)
#let cash-dgddi-aug        = 1940      // remb. bordereaux juin–juillet
#let cash-dgddi-sep        = 2910      // bordereaux juillet–août
#let cash-dgddi-oct        = 3395      // août–septembre
#let cash-dgddi-nov        = 4365      // septembre–octobre
#let cash-dgddi-dec        = 5335      // octobre–novembre

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

// Avances TVA aux voyageurs (commence en juillet)
#let avance-tva-jul        = 1940      // ~20 bordereaux × 97 €
#let avance-tva-aug        = 2910      // ~30 bordereaux
#let avance-tva-sep        = 3395      // ~35 bordereaux
#let avance-tva-oct        = 4365      // ~45 bordereaux
#let avance-tva-nov        = 5335      // ~55 bordereaux
#let avance-tva-dec        = 5820      // ~60 bordereaux

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

// Encaissements (commissions + remboursements DGDDI uniquement)
#let enc-apr               = 15100     // capital 100 + CCA 15000
#let enc-mai               = 0
#let enc-jun               = 0
#let enc-jul               = 100       // commissions uniquement
#let enc-aug               = 2115      // 175 + 1940
#let enc-sep               = 3110      // 200 + 2910
#let enc-oct               = 3645      // 250 + 3395
#let enc-nov               = 4715      // 350 + 4365
#let enc-dec               = 5735      // 400 + 5335

// Décaissements
#let dec-apr               = 950
#let dec-mai               = 850
#let dec-jun               = 950
#let dec-jul               = 2940      // 700 + 1940 + 300
#let dec-aug               = 3910      // 700 + 2910 + 300
#let dec-sep               = 4395      // 700 + 3395 + 300
#let dec-oct               = 5515      // 750 + 4365 + 400
#let dec-nov               = 6485      // 750 + 5335 + 400
#let dec-dec               = 6970      // 750 + 5820 + 400

// Solde mensuel
#let solde-apr             = 14150     // 15100 - 950
#let solde-mai             = -850
#let solde-jun             = -950
#let solde-jul             = -2840
#let solde-aug             = -1795
#let solde-sep             = -1285
#let solde-oct             = -1870
#let solde-nov             = -1770
#let solde-dec             = -1235

// Trésorerie cumulée (reste positif toute l'année)
#let cumul-apr             = 14150
#let cumul-mai             = 13300
#let cumul-jun             = 12350
#let cumul-jul             = 9510
#let cumul-aug             = 7715
#let cumul-sep             = 6430
#let cumul-oct             = 4560
#let cumul-nov             = 2790
#let cumul-dec             = 1555
