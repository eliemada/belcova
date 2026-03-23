# Detaxe Brand Identity Design

**Version:** 1.0
**Date:** 2026-03-17
**Status:** Validated

---

## 1. Brand Positioning

**Brand name:** detaxe
**Tagline:** "Get your VAT back. Instantly." / "Récupérez votre TVA. Instantanément."
**Brand word:** Modern
**Positioning:** The next-generation VAT refund platform. Not a tax service — a fintech product.

### Target Audiences (priority order)

1. **Institutional credibility** — Douanes agrément reviewers, potential investors
2. **Tourists** — main landing experience, track and receive VAT refunds
3. **Retailers** — secondary page, B2B onboarding

### Voice & Tone

- Short sentences. No jargon.
- Confident, not salesy. State facts, don't persuade.
- Bilingual (EN/FR) but English-first in tone — global, not provincial.
- Never use: "easy", "simple", "hassle-free" (SkipTax language)
- Use instead: "instant", "transparent", "automatic"

### Competitive Contrast

| | SkipTax | detaxe |
|---|---|---|
| Feel | 2019 WordPress | 2026 fintech |
| Color | Orange + dark blue | White + cyan blue |
| Typography | Arial | Geist + variable display |
| Hero | Cluttered, 6 elements | One headline, one button |
| Tone | "Easy and simple!" | "Instant. Transparent." |
| First impression | "A tax refund site" | "A fintech product" |
| Whitespace | Cramped | Generous, confident |
| Icons | Stock clip art | Custom line icons |
| Imagery | Stock photos | Gradients + real UI |
| Animations | None | Subtle micro-interactions |
| Overall | "We're a startup" | "We're the standard" |

---

## 2. Visual System

### Color Palette

| Role | Color | Hex | Usage |
|---|---|---|---|
| Background | White | `#FFFFFF` | Primary canvas |
| Surface | Light gray | `#F8F9FA` | Cards, sections |
| Text primary | Near-black | `#0A0A0B` | Headlines, body |
| Text secondary | Gray | `#6B7280` | Captions, labels |
| Accent | Cyan blue | `#00A3FF` | CTAs, links, highlights — max 3x per page |
| Accent hover | Deep cyan | `#0088D4` | Interactive states |
| Dark sections | Charcoal | `#111113` | Hero, feature blocks, footer |
| Dark text on dark | White | `#F0F0F0` | Text on dark sections |

### Typography

- **Headlines:** General Sans Variable (weight 500–700, animated on interaction)
- **Body:** Geist (weight 400–500)
- **Mono (data/numbers):** Geist Mono (refund amounts, tracking IDs)
- **Scale:** Hero headline 64–80px, section headers 36–48px, body 18px
- **Rule:** Never go below 16px on anything

### Spacing Philosophy

- More whitespace than feels comfortable
- Section padding: 120–160px vertical
- Content max-width: 1200px, centered
- Emptiness = confidence

---

## 3. Website Structure

### Pages

1. **Hero / Landing** — one headline, one CTA, dark background
2. **How it works** — 3 steps, animated sequence, light background
3. **For Retailers** — separate page, B2B tone, ROI-focused
4. **About / Trust** — agrément status, team, compliance (Douanes credibility)

### Hero Section Spec

- Dark charcoal (`#111113`) background
- Headline: "Get your VAT back. Instantly." — General Sans, 72px, white
- One CTA button: "Start your refund" — cyan blue (`#00A3FF`), pill-shaped
- Nothing else. No image, no subtext, no navbar clutter.
- Subtle gradient or grain texture on dark background for depth

### How It Works Section

- Light background (`#F8F9FA`)
- 3 steps horizontal sequence: **Shop → Scan → Refund**
- Each step: custom icon + 1 short sentence
- Animated: steps reveal on scroll with subtle slide-up
- Refund step shows a number animating up (e.g. "€127.40") in Geist Mono

### Micro-interactions (the 2026 layer)

- Variable font weight shift on headline hover
- CTA button: subtle scale + glow on hover
- Scroll-triggered fade-ins (smooth ease-out, not bounce)
- Numbers animate/count up when entering viewport
- Cursor-following subtle gradient on dark sections
- Duration: 200–400ms max
- Easing: `cubic-bezier(0.16, 1, 0.3, 1)` (smooth deceleration)
- Rule: if you notice the animation, it's too much

---

## 4. Brand Assets & Media

### Logo

- Wordmark-first: "detaxe" in General Sans, weight 600
- Lowercase only (like stripe, vercel, linear)
- The "x" has a subtle cyan accent (slash or crossbar in `#00A3FF`)
- No icon/symbol initially — wordmark is the brand

### Photography / Imagery

- No stock photos. Ever.
- Abstract gradients (dark-to-cyan mesh gradients) for decorative sections
- Product screenshots / UI mockups for credibility
- If people: real, candid, diverse tourists — not posed stock
- Grain texture overlay on dark sections for tactile depth

### Iconography

- Custom line icons, 1.5px stroke weight
- Monochrome (near-black or white on dark)
- Rounded caps, consistent 24px grid
- Outline only — never filled

### Motion Principles

- Duration: 200–400ms, never longer
- Easing: `cubic-bezier(0.16, 1, 0.3, 1)`
- Rule: if you notice the animation, it's too much

---

## 5. Implementation Tools

### Recommended Stack for Website

- **Framework:** Next.js or Astro (static landing + dynamic app)
- **Styling:** Tailwind CSS
- **Animations:** Framer Motion
- **Fonts:** Google Fonts (General Sans via Fontshare, Geist via Vercel)
- **Design tool:** Figma for mockups before code
- **Deployment:** Vercel

### Font Loading

```css
/* General Sans — from Fontshare */
@font-face {
  font-family: 'General Sans';
  src: url('/fonts/GeneralSans-Variable.woff2') format('woff2');
  font-weight: 200 700;
  font-display: swap;
}

/* Geist — from Vercel */
@font-face {
  font-family: 'Geist';
  src: url('/fonts/Geist-Variable.woff2') format('woff2');
  font-weight: 100 900;
  font-display: swap;
}

/* Geist Mono */
@font-face {
  font-family: 'Geist Mono';
  src: url('/fonts/GeistMono-Variable.woff2') format('woff2');
  font-weight: 100 900;
  font-display: swap;
}
```

### CSS Custom Properties

```css
:root {
  /* Colors */
  --color-bg: #FFFFFF;
  --color-surface: #F8F9FA;
  --color-text: #0A0A0B;
  --color-text-secondary: #6B7280;
  --color-accent: #00A3FF;
  --color-accent-hover: #0088D4;
  --color-dark: #111113;
  --color-dark-text: #F0F0F0;

  /* Typography */
  --font-display: 'General Sans', system-ui, sans-serif;
  --font-body: 'Geist', system-ui, sans-serif;
  --font-mono: 'Geist Mono', monospace;

  /* Spacing */
  --section-padding: clamp(80px, 10vw, 160px);
  --content-max-width: 1200px;

  /* Motion */
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
  --duration-fast: 200ms;
  --duration-normal: 300ms;
  --duration-slow: 400ms;
}
```
