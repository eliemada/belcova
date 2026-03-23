// =============================================================================
// Dossier de Certification de la Plateforme EDI — PABLO
// Direction Générale des Douanes et Droits Indirects (DGDDI)
//
// Ce document constitue le dossier de certification informatique requis par
// l'article 202 E de l'annexe III au Code Général des Impôts, dans le cadre
// de la procédure d'agrément d'opérateur de détaxe.
// =============================================================================

#import "style.typ": *
#import "metadata.typ": *

#show: setup-document

// Page de garde
#include "chapters/00-page-de-garde.typ"

// Table des matières
#pagebreak()
#outline(
  title: [Sommaire],
  depth: 3,
  indent: auto,
)

// Chapitres
#include "chapters/01-introduction.typ"
#include "chapters/02-standards-communication.typ"
#include "chapters/03-modelisation-messages.typ"
#include "chapters/04-conditions-connexion.typ"
#include "chapters/05-fonctionnement-technique.typ"
#include "chapters/06-schemas-commerciaux.typ"
#include "chapters/07-annexes.typ"
