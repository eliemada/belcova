# Belcova Landing Page Design

**Version:** 1.0
**Date:** 2026-03-17
**Status:** Validated
**Brand identity:** See [2026-03-17-brand-identity-design.md](./2026-03-17-brand-identity-design.md)

---

## Page Structure (top to bottom)

1. Navigation Bar
2. Hero (full viewport)
3. Social Proof Bar
4. How It Works
5. Value Proposition (3 rows)
6. For Retailers CTA
7. Footer

---

## 1. Navigation Bar

- Fixed top, transparent on dark hero, frosted glass on scroll
- Left: "belcova" wordmark — General Sans 600, lowercase
- Right: language toggle (`EN / FR` text), one CTA "Get started" cyan pill button
- Height: 64px, no borders

**Behavior:**
- On hero (dark): wordmark and links white, CTA stays cyan
- On scroll past hero: `background: rgba(255,255,255,0.8); backdrop-filter: blur(12px)`, wordmark and text flip to near-black
- Transition: 300ms `var(--ease-out)`
- Mobile: wordmark left, "Get started" right. Language toggle in bottom sheet.

---

## 2. Hero

- Full viewport height (`100vh`)
- Background: dark charcoal `#111113`
- Animated mesh gradient: slow-moving, dark cyan (`#00A3FF` at 5% opacity) + deep purple hints
- Grain texture overlay at 3-4% opacity

### Content (dead center)

**Headline:**
```
Get your VAT back.
Instantly.
```
- General Sans Variable, 76px, weight 600, white `#F0F0F0`
- Line height: 1.05
- "Instantly." on own line, weight 650
- Max-width: 680px, center-aligned

**Subtitle (24px below headline):**
```
Belcova handles your tax-free refund from purchase to payout.
```
- Geist, 20px, weight 400, `#6B7280`

**CTA (40px below subtitle):**
```
[ Start your refund → ]
```
- Pill-shaped, `#00A3FF` background, white text, Geist 16px weight 500
- Padding: 16px 32px
- Hover: scale 1.02 + `box-shadow: 0 0 24px rgba(0,163,255,0.3)`
- Arrow slides 4px right on hover

**Scroll indicator:** thin animated chevron at bottom, nearly invisible

### Load animation
1. Headline fades in + slides up 20px (400ms, ease-out)
2. Subtitle follows 150ms later
3. CTA follows 150ms after
4. Mesh gradient starts moving after content loaded

---

## 3. Social Proof Bar

- White background `#FFFFFF`
- Compact: 48px vertical padding
- Center-aligned text: "Trusted by tourists from 30+ countries" — Geist, 14px, `#6B7280`
- Row of desaturated country flag icons (US, UK, CN, JP, KR, DE, UAE) at 40% opacity

**Pre-launch alternative:**
```
Agrément Douanes pending · GDPR compliant · Secure payments
```
Three trust signals separated by dots.

---

## 4. How It Works

- Background: `#F8F9FA`
- Padding: 140px vertical

### Header
```
How it works
```
- General Sans, 44px, weight 600, `#0A0A0B`, center-aligned
- No subtitle

### Three steps (horizontal desktop, vertical mobile)

Each step — no card border, no shadow, just spacing:

**Step 01 — Shop**
- Number: Geist Mono, 14px, `#00A3FF`
- Title: General Sans, 28px, weight 600, near-black
- Body: "Buy from any partnered store in France." — Geist, 17px, `#6B7280`, max-width 280px

**Step 02 — Scan**
- "Scan your receipts at the airport PABLO kiosk."

**Step 03 — Get paid**
- "Refund hits your account within 5 days."
- Below description: **€127.40** animates from €0.00 — Geist Mono, 36px, `#00A3FF`
- Counts up when section enters viewport

### Connecting line
- Thin `1px #E5E7EB` line between steps
- Animated dot travels left-to-right on scroll
- Line draws itself as user scrolls

### Scroll animation
- Each step fades in + slides up 16px, staggered 100ms
- Connecting line draws left-to-right
- Traveling dot follows progression

---

## 5. Value Proposition

- White background `#FFFFFF`
- Padding: 140px vertical
- Two-column, alternating image/text sides
- Row spacing: 100px
- Image/text gap: 80px

### Row 1 — Image left, text right

**Image:** Product UI mockup — refund dashboard with status timeline (Pending → Validated → Paid), amounts in Geist Mono, progress bar in cyan

**Text:**
```
Track every euro.

See your refund status in real-time.
From purchase to payout, nothing is hidden.
```
- Title: General Sans, 32px, weight 600
- Body: Geist, 17px, `#6B7280`, max-width 400px

### Row 2 — Text left, image right

**Text:**
```
85-90% back.

The industry gives you 60-75%.
Belcova gives you more. Transparent fees, no surprises.
```

**Image:** Minimal bar chart — two bars. "Others: 65%" in gray, "Belcova: 88%" in cyan. Geist Mono labels. Bars animate height on scroll-enter.

### Row 3 — Image left, text right

**Image:** Phone mockup — mobile UI showing QR code screen with "Ready to scan" and green checkmark

**Text:**
```
5 minutes at the airport.

Scan at any PABLO kiosk.
We handle the rest before your flight boards.
```

### Scroll animation
- Each row fades in on viewport entry
- Image slides from its side (left or right) by 24px

---

## 6. For Retailers CTA

- Dark charcoal `#111113` — mirrors hero
- Padding: 120px vertical
- Center-aligned, single column

**Content:**
```
Partner with Belcova

Offer tax-free shopping to every tourist
who walks through your door. Zero hardware,
zero complexity.
```
- Title: General Sans, 40px, weight 600, white
- Body: Geist, 18px, `#6B7280`, max-width 480px

**CTA (40px below):**
```
[ Contact our team → ]
```
- Outlined variant: transparent background, 1.5px cyan border, cyan text
- Hover: fills cyan, text white, glow effect

**Below CTA (24px):**
```
Or email partners@belcova.com
```
- Geist, 14px, `#6B7280`

---

## 7. Footer

- Continues dark `#111113` from Section 6
- Separated by `1px #222224` line
- Padding: 80px top, 48px bottom

### Three columns (desktop), stacked (mobile)

**Column 1:**
- "belcova" wordmark: General Sans, 20px, weight 600, white
- "The modern way to get your VAT back." — Geist, 15px, `#6B7280`

**Column 2 — Product:**
- How it works
- For retailers
- FAQ

**Column 3 — Company:**
- About
- Contact

**Column 4 — Legal:**
- Privacy policy
- Terms of service
- Cookie policy

**Column 5 — Languages:**
- EN / FR toggle

### Bottom bar (48px below columns)
```
© 2026 Belcova · Paris, France
```
- Geist, 13px, `#4B5563`, center-aligned
- No social icons unless active accounts exist

---

## 8. Global Specs

### Performance
- Target: Lighthouse 95+
- Fonts: preload variable woff2 files, `font-display: swap`
- Images: WebP, lazy-loaded below fold
- Mesh gradient: CSS-only or lightweight canvas
- Total page weight: under 500KB

### Responsive Breakpoints
- Desktop: 1200px+ (full layout)
- Tablet: 768–1199px (sections stack, hero text 56px)
- Mobile: <768px (single column, hero text 40px, section padding 80px)

### Accessibility
- WCAG AA contrast on all text
- Focus states: cyan outline ring on interactive elements
- `@media (prefers-reduced-motion)`: all animations disabled
- Semantic HTML: h1 (hero) → h2 (sections) → h3 (cards)
- Alt text on all images

### SEO
- Single h1: "Get your VAT back. Instantly."
- Meta: "Belcova — the modern VAT refund platform for tourists in France. 85-90% back, tracked in real-time."
- Open Graph image: dark hero with wordmark, 1200x630px
- `hreflang` tags for EN/FR

### i18n Architecture
- Auto-detect via `navigator.language` / `Accept-Language` header
- Manual override: EN/FR toggle persisted in `localStorage`
- URL structure: `/en/`, `/fr/` for SEO
- All visible text externalized to translation files
- Designed for future expansion (CJK, Arabic RTL)

---

## Implementation Stack

| Layer | Tool |
|---|---|
| Framework | Next.js (App Router) or Astro |
| Styling | Tailwind CSS |
| Animations | Framer Motion |
| Fonts | General Sans (Fontshare), Geist (Vercel) |
| i18n | next-intl or astro-i18n |
| Deployment | Vercel |
| Design | Figma mockups before code |
