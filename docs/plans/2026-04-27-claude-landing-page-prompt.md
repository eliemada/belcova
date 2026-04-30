# Prompt — Belcova Landing Page + Blog

Copy everything below the line into Claude.

---

## Context

I'm building the website for **Belcova** (belcova.fr), a fintech startup that simplifies VAT refunds (détaxe) for tourists shopping in France. We compete with SkipTax and ZapTax. The company is pre-launch — we're waiting for our Douanes agrément — so the site needs to establish credibility, capture emails, and build SEO authority now.

## What to build

A **Next.js App Router** site deployed on **Vercel** with:
1. A landing page (one-page scroll)
2. A blog section (`/blog`) for SEO content
3. Bilingual EN/FR with `next-intl`, URL structure `/en/`, `/fr/`

---

## Brand Identity

**Brand name:** belcova (always lowercase)
**Tagline:** "Get your VAT back. Instantly." / "Récupérez votre TVA. Instantanément."
**Positioning:** A fintech product, not a tax service. Think Stripe, Linear, Vercel — not a 2019 WordPress tax refund site.

### Voice & Tone
- Short sentences. No jargon. Confident, not salesy.
- English-first tone — global, not provincial.
- NEVER use: "easy", "simple", "hassle-free" (competitor language)
- USE instead: "instant", "transparent", "automatic"

### Color Palette

| Role | Hex | Usage |
|------|-----|-------|
| Background | `#FFFFFF` | Primary canvas |
| Surface | `#F8F9FA` | Cards, alternating sections |
| Text primary | `#0A0A0B` | Headlines, body |
| Text secondary | `#6B7280` | Captions, labels |
| Accent | `#00A3FF` | CTAs, links, highlights — max 3 uses per viewport |
| Accent hover | `#0088D4` | Interactive states |
| Dark sections | `#111113` | Hero, retailer CTA, footer |
| Dark text | `#F0F0F0` | Text on dark sections |

### Typography

| Role | Font | Details |
|------|------|---------|
| Headlines | General Sans Variable | weight 500–700, from Fontshare |
| Body | Geist Variable | weight 400–500, from Vercel |
| Mono (data) | Geist Mono Variable | refund amounts, tracking IDs |

- Hero headline: 76px, section headers: 44px, body: 17-18px
- Never go below 16px
- `font-display: swap` on all

### CSS Custom Properties

```css
:root {
  --color-bg: #FFFFFF;
  --color-surface: #F8F9FA;
  --color-text: #0A0A0B;
  --color-text-secondary: #6B7280;
  --color-accent: #00A3FF;
  --color-accent-hover: #0088D4;
  --color-dark: #111113;
  --color-dark-text: #F0F0F0;
  --font-display: 'General Sans', system-ui, sans-serif;
  --font-body: 'Geist', system-ui, sans-serif;
  --font-mono: 'Geist Mono', monospace;
  --section-padding: clamp(80px, 10vw, 160px);
  --content-max-width: 1200px;
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
  --duration-fast: 200ms;
  --duration-normal: 300ms;
  --duration-slow: 400ms;
}
```

### Spacing Philosophy
- More whitespace than feels comfortable. Emptiness = confidence.
- Section padding: 120–160px vertical
- Content max-width: 1200px, centered

### Motion Principles
- Duration: 200–400ms, never longer
- Easing: `cubic-bezier(0.16, 1, 0.3, 1)`
- Rule: **if you notice the animation, it's too much**
- `@media (prefers-reduced-motion)`: disable all animations

### Imagery Rules
- **No stock photos. Ever.**
- Abstract gradients (dark-to-cyan mesh gradients) for decorative sections
- Product UI mockups for credibility
- Grain texture overlay (3-4% opacity) on dark sections for tactile depth
- Icons: custom line icons, 1.5px stroke, monochrome, rounded caps, 24px grid, outline only

---

## Landing Page Structure

Build these 7 sections as a single-page scroll:

### 1. Navigation Bar
- Fixed top, transparent on dark hero, frosted glass on scroll
- Left: "belcova" wordmark — General Sans 600, lowercase
- Right: language toggle (EN / FR text), one CTA "Get started" cyan pill button
- Height: 64px, no borders
- On hero (dark): wordmark white, CTA cyan
- On scroll past hero: `background: rgba(255,255,255,0.8); backdrop-filter: blur(12px)`, wordmark flips to near-black
- Mobile: wordmark left, "Get started" right, language toggle in bottom sheet

### 2. Hero (full viewport)
- `100vh`, background: `#111113`
- Animated mesh gradient: slow-moving, dark cyan at 5% opacity + deep purple hints
- Grain texture overlay at 3-4% opacity
- Content (dead center, max-width 680px):
  - Headline: "Get your VAT back.\nInstantly." — General Sans, 76px, weight 600, white. "Instantly." on its own line, weight 650
  - Subtitle (24px below): "Belcova handles your tax-free refund from purchase to payout." — Geist, 20px, `#6B7280`
  - CTA (40px below): "Start your refund →" — pill button, `#00A3FF` bg, white text, Geist 16px weight 500, padding 16px 32px. Hover: scale 1.02 + `box-shadow: 0 0 24px rgba(0,163,255,0.3)`, arrow slides 4px right
  - Scroll indicator: thin animated chevron at bottom, nearly invisible
- Load animation: headline fades in + slides up 20px (400ms), subtitle follows 150ms later, CTA follows 150ms after, mesh gradient starts after content loaded

### 3. Social Proof Bar
- White `#FFFFFF`, compact 48px padding
- Pre-launch version: "Agrément Douanes pending · GDPR compliant · Secure payments" — three trust signals separated by dots
- Geist, 14px, `#6B7280`, center-aligned

### 4. How It Works
- Background: `#F8F9FA`, padding: 140px vertical
- Header: "How it works" — General Sans, 44px, weight 600, center-aligned, no subtitle
- Three steps horizontal (desktop), vertical (mobile):
  - **Step 01 — Shop**: "Buy from any partnered store in France." Number in Geist Mono 14px cyan
  - **Step 02 — Scan**: "Scan your receipts at the airport PABLO kiosk."
  - **Step 03 — Get paid**: "Refund hits your account within 5 days." Below: **€127.40** counts up from €0.00 — Geist Mono, 36px, cyan, animates on viewport entry
- Connecting line: thin 1px `#E5E7EB` between steps, animated dot travels left-to-right on scroll
- Each step fades in + slides up 16px, staggered 100ms

### 5. Value Proposition (3 rows)
- White `#FFFFFF`, padding: 140px vertical
- Two-column, alternating image/text sides, 100px row spacing, 80px gap

**Row 1 — Image left, text right:**
- Image: Product UI mockup — refund dashboard with status timeline (Pending → Validated → Paid), amounts in Geist Mono, progress bar in cyan
- Text: "Track every euro." / "See your refund status in real-time. From purchase to payout, nothing is hidden."

**Row 2 — Text left, image right:**
- Text: "85-90% back." / "The industry gives you 60-75%. Belcova gives you more. Transparent fees, no surprises."
- Image: Minimal bar chart — "Others: 65%" in gray, "Belcova: 88%" in cyan. Bars animate height on scroll-enter.

**Row 3 — Image left, text right:**
- Image: Phone mockup — mobile UI showing QR code screen with "Ready to scan" and green checkmark
- Text: "5 minutes at the airport." / "Scan at any PABLO kiosk. We handle the rest before your flight boards."

- Titles: General Sans, 32px, weight 600. Body: Geist, 17px, `#6B7280`, max-width 400px
- Each row fades in, image slides from its side by 24px

### 6. For Retailers CTA
- Dark `#111113`, padding: 120px vertical, center-aligned
- Title: "Partner with Belcova" — General Sans, 40px, weight 600, white
- Body: "Offer tax-free shopping to every tourist who walks through your door. Zero hardware, zero complexity." — Geist, 18px, `#6B7280`, max-width 480px
- CTA: "Contact our team →" — outlined variant: transparent bg, 1.5px cyan border, cyan text. Hover: fills cyan, text white, glow
- Below: "Or email partners@belcova.com" — Geist, 14px, `#6B7280`

### 7. Footer
- Continues dark `#111113`, separated by `1px #222224` line
- Padding: 80px top, 48px bottom
- Columns:
  1. "belcova" wordmark + "The modern way to get your VAT back."
  2. Product: How it works, For retailers, FAQ
  3. Company: About, Contact
  4. Legal: Privacy policy, Terms of service, Cookie policy
  5. Languages: EN / FR toggle
- Bottom bar: "© 2026 Belcova · Paris, France" — Geist, 13px, `#4B5563`, centered
- No social icons

---

## Blog Section

Build a blog at `/blog` (and `/fr/blog` for French) for SEO content.

### Blog Design
- Same nav/footer as landing page
- Blog index: grid of article cards (title + date + reading time + excerpt), 2 columns desktop, 1 mobile
- Article page: max-width 720px, centered, generous typography (Geist 18px, line-height 1.7)
- Article headings in General Sans
- Code blocks in Geist Mono if needed
- Share buttons: copy link only, no social clutter
- Related articles at bottom (2-3 cards)

### Blog Architecture
- MDX files in `/content/blog/` with frontmatter (title, date, description, author, lang, slug)
- Auto-generated sitemap including blog posts
- RSS feed at `/feed.xml`
- Schema markup: Article, Organization, BreadcrumbList

### Pre-launch blog posts to create (stubs with proper SEO metadata):

**English:**
1. "How to Get a VAT Refund in France — 2026 Guide" — target: "vat refund france"
2. "Tax-Free Shopping in Paris: The Complete Guide" — target: "tax free shopping paris"
3. "PABLO Kiosk at CDG Airport: Step-by-Step" — target: "pablo kiosk cdg"
4. "How Much VAT Can You Get Back in France?" — target: "france vat refund amount"
5. "Minimum Purchase for Tax-Free Shopping in France" — target: "minimum purchase tax free france"

**French:**
1. "Comment proposer la détaxe dans votre magasin" — target: "détaxe commerçant"
2. "Opérateur de détaxe en France : comparatif 2026" — target: "opérateur détaxe comparatif"
3. "PABLO EDI : guide complet pour les commerçants" — target: "pablo edi détaxe"

---

## SEO Requirements

- `<title>`: "Belcova — VAT Refund for Tourists in France | Tax-Free Shopping"
- `<meta description>`: "Belcova simplifies VAT refunds for tourists shopping in France. Get 85-90% back, tracked in real-time from purchase to payout."
- Single `<h1>`: "Get your VAT back. Instantly."
- Open Graph image: dark hero with wordmark, 1200x630px
- `hreflang` tags for EN/FR on every page
- Semantic HTML: h1 → h2 → h3 hierarchy
- JSON-LD schema: Organization + WebSite + FAQ (if FAQ exists) + Article (on blog posts)
- Auto-generated `sitemap.xml` with all pages and blog posts
- `robots.txt` allowing all crawlers
- Canonical URLs on every page

---

## Technical Requirements

- **Framework:** Next.js 15 App Router
- **Styling:** Tailwind CSS v4
- **Animations:** Framer Motion
- **i18n:** next-intl with `/en/` and `/fr/` URL prefixes
- **Deployment:** Vercel
- **Performance:** Lighthouse 95+, total page weight under 500KB
- **Responsive breakpoints:** Desktop 1200px+, Tablet 768–1199px (hero text 56px), Mobile <768px (hero text 40px, single column, section padding 80px)
- **Accessibility:** WCAG AA contrast, focus states with cyan outline ring, semantic HTML, alt text on all images

---

## Pre-launch specifics

Since we don't have the agrément yet:
- The "Start your refund" CTA should open an **email capture modal** ("Get notified when we launch") instead of a real flow
- Social proof bar shows trust signals, not customer testimonials
- No pricing page yet
- "Agrément Douanes pending" displayed transparently — builds trust
