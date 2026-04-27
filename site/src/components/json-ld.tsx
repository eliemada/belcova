export function OrganizationJsonLd() {
  const data = {
    "@context": "https://schema.org",
    "@type": "Organization",
    name: "Belcova",
    url: "https://belcova.fr",
    logo: "https://belcova.fr/og.webp",
    address: {
      "@type": "PostalAddress",
      streetAddress: "58 rue de Monceau",
      addressLocality: "Paris",
      postalCode: "75008",
      addressCountry: "FR",
    },
    sameAs: [],
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export function WebSiteJsonLd() {
  const data = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: "Belcova",
    url: "https://belcova.fr",
    inLanguage: ["fr", "en"],
    description:
      "Belcova simplifies VAT refunds for tourists shopping in France.",
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export function FAQJsonLd({
  faqs,
}: {
  faqs: { question: string; answer: string }[];
}) {
  const data = {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    mainEntity: faqs.map((faq) => ({
      "@type": "Question",
      name: faq.question,
      acceptedAnswer: {
        "@type": "Answer",
        text: faq.answer,
      },
    })),
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}

export function ArticleJsonLd({
  title,
  description,
  datePublished,
  url,
  locale,
}: {
  title: string;
  description: string;
  datePublished: string;
  url: string;
  locale: string;
}) {
  const data = {
    "@context": "https://schema.org",
    "@type": "Article",
    headline: title,
    description,
    datePublished,
    inLanguage: locale,
    url,
    author: {
      "@type": "Organization",
      name: "Belcova",
    },
    publisher: {
      "@type": "Organization",
      name: "Belcova",
      logo: { "@type": "ImageObject", url: "https://belcova.fr/og.webp" },
    },
  };

  return (
    <script
      type="application/ld+json"
      dangerouslySetInnerHTML={{ __html: JSON.stringify(data) }}
    />
  );
}
