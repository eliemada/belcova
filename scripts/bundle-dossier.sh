#!/usr/bin/env bash
# =============================================================================
# BELCOVA — Bundle du dossier d'agrément opérateur de détaxe
#
# Assemble les 4 pièces requises par l'article 202 E (annexe II du CGI)
# en un seul PDF prêt à soumettre à la DGDDI.
#
# Dépendances : typst, pdfunite (poppler-utils)
# Usage : ./scripts/bundle-dossier.sh
# =============================================================================

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/build"
OUTPUT="$BUILD/belcova-dossier-agrement.pdf"

echo "=== BELCOVA — Préparation du dossier d'agrément ==="
echo ""

# ── Vérifier les dépendances ─────────────────────────────────────────────────
for cmd in typst pdfunite gs; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "ERREUR : '$cmd' non trouvé. Installez-le :"
    case "$cmd" in
      pdfunite) echo "  brew install poppler" ;;
      gs)       echo "  brew install ghostscript" ;;
      *)        echo "  brew install $cmd" ;;
    esac
    exit 1
  fi
done

mkdir -p "$BUILD"

# ── 1. Compiler les documents Typst ──────────────────────────────────────────
echo "1/4  Compilation du prévisionnel financier..."
typst compile "$ROOT/docs/financial/previsionnel-financier.typ" "$BUILD/previsionnel-financier.pdf"

echo "2/4  Compilation du bilan d'ouverture..."
typst compile "$ROOT/docs/financial/bilan-ouverture.typ" "$BUILD/bilan-ouverture.pdf"

echo "3/4  Préparation du Kbis (suppression protection copie)..."
gs -dNOPAUSE -dBATCH -dQUIET -sDEVICE=pdfwrite -sOutputFile="$BUILD/kbis.pdf" "$ROOT/docs/legal/kbis_104126727.pdf"

echo "4/4  Compilation du dossier de certification EDI..."
typst compile "$ROOT/dossier/main.typ" "$BUILD/dossier-certification-edi.pdf"

# ── 2. Vérifier que toutes les pièces existent ───────────────────────────────
echo ""
echo "=== Vérification des pièces ==="

PIECES=(
  "$BUILD/kbis.pdf"
  "$BUILD/bilan-ouverture.pdf"
  "$BUILD/previsionnel-financier.pdf"
  "$ROOT/docs/personal/casier-elie.pdf"
  "$ROOT/docs/personal/casier-franklin.pdf"
  "$BUILD/dossier-certification-edi.pdf"
)

LABELS=(
  "Pièce 1 — Extrait Kbis (SIREN 104 126 727)"
  "Pièce 2a — Bilan d'ouverture au 27/04/2026"
  "Pièce 2b — Prévisionnel financier 2026–2028"
  "Pièce 3a — Bulletin n°3 — Elie BRUNO (Président)"
  "Pièce 3b — Bulletin n°3 — Franklin TRANIÉ (DG)"
  "Pièce 4 — Dossier de certification EDI — PABLO"
)

ALL_OK=true
for i in "${!PIECES[@]}"; do
  if [[ -f "${PIECES[$i]}" ]]; then
    PAGES=$(python3 -c "
import subprocess
result = subprocess.run(['mdls', '-name', 'kMDItemNumberOfPages', '-raw', '${PIECES[$i]}'], capture_output=True, text=True)
print(result.stdout.strip() if result.stdout.strip() != '(null)' else '?')
" 2>/dev/null || echo "?")
    echo "  ✓ ${LABELS[$i]} (${PAGES} pages)"
  else
    echo "  ✗ ${LABELS[$i]} — MANQUANT"
    ALL_OK=false
  fi
done

if [[ "$ALL_OK" != "true" ]]; then
  echo ""
  echo "ERREUR : pièces manquantes. Corrigez avant de relancer."
  exit 1
fi

# ── 3. Assembler le bundle ───────────────────────────────────────────────────
echo ""
echo "=== Assemblage du dossier complet ==="
pdfunite "${PIECES[@]}" "$OUTPUT"

TOTAL_PAGES=$(python3 -c "
import subprocess
result = subprocess.run(['mdls', '-name', 'kMDItemNumberOfPages', '-raw', '$OUTPUT'], capture_output=True, text=True)
print(result.stdout.strip())
" 2>/dev/null || echo "?")

echo ""
echo "=== Dossier prêt ==="
echo "  Fichier : $OUTPUT"
echo "  Pages   : $TOTAL_PAGES"
echo "  Taille  : $(du -h "$OUTPUT" | cut -f1)"
echo ""
echo "Pièces incluses :"
for label in "${LABELS[@]}"; do
  echo "  • $label"
done
echo ""
echo "À soumettre par voie électronique ou par LRAR à :"
echo "  Direction Générale des Douanes et Droits Indirects"
echo "  Bureau E2 — Agrément opérateurs de détaxe"
echo ""
