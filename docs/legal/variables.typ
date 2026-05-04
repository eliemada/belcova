// ============================================================================
//  VARIABLES PARTAGÉES — BELCOVA SAS
//  Source unique pour les statuts et le pacte d'associés
// ============================================================================

// ── Société ─────────────────────────────────────────────────────────────
#let company-name        = "BELCOVA"
#let company-legal-form  = "Société par Actions Simplifiée"
#let company-short       = "SAS"

// ── Associé Fondateur 1 — Président ──────────────────────────────────────
#let founder-first       = "Elie"
#let founder-last        = "BRUNO"
#let founder-nationality = "française"
#let founder-birthdate   = "12 décembre 2005"
#let founder-birthplace  = "Royan (Charente-Maritime)"
#let founder-address     = "29 Bis Rue de la Crête, 17110 Saint-Georges-de-Didonne"
#let founder1-actions    = "5 500"
#let founder1-pct        = "55"                                  // % du capital

// ── Associé Fondateur 2 — Directeur Général ─────────────────────────────
#let cofounder-first       = "Franklin"
#let cofounder-last        = "TRANIÉ"
#let cofounder-nationality = "française"
#let cofounder-birthdate   = "11 février 2004"
#let cofounder-birthplace  = "Neuilly-sur-Seine (Hauts-de-Seine)"
#let cofounder-address     = "3 Rue de Rouvray, 92200 Neuilly-sur-Seine"
#let cofounder-actions     = "4 500"
#let cofounder-pct         = "45"                                // % du capital

// ── Capital & Siège ─────────────────────────────────────────────────────
#let siege-social        = "58 Rue de Monceau, 75008 Paris"
#let siege-ville         = "Paris"
#let capital-initial     = "100"
#let nb-actions          = "10 000"
#let valeur-nominale     = "0,01"
#let date-document       = "21 avril 2026"
#let date-signature      = "4 mai 2026"

// ── Lock-up ──────────────────────────────────────────────────────────────
#let lock-up-duree       = "trois (3)"                           // ans

// ── Signature & Paraphe ────────────────────────────────────────────────────
// Instructions :
//   1. Signez sur papier blanc, photographiez/scannez en PNG
//   2. Retirez le fond (https://remove.bg ou Preview.app sur Mac)
//   3. Placez les fichiers dans docs/legal/ et mettez à jour les chemins ci-dessous
//   4. Mettez `use-signatures` à `true` pour activer

#let use-signatures      = false                          // désactivé — signatures manuelles
#let signature-path      = "signature_elie.png"            // ← signature fondateur 1 (PNG, fond transparent)
#let paraphe-path        = "paraphe_elie.png"              // ← paraphe fondateur 1 (PNG, fond transparent)
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
