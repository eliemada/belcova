import type { MetadataRoute } from "next";
import { getAllSlugs } from "@/lib/blog";
import { routing } from "@/i18n/routing";

const BASE_URL = "https://belcova.fr";

export default function sitemap(): MetadataRoute.Sitemap {
  const entries: MetadataRoute.Sitemap = [];

  // Landing page for each locale
  for (const locale of routing.locales) {
    entries.push({
      url: `${BASE_URL}/${locale}`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 1.0,
      alternates: {
        languages: {
          en: `${BASE_URL}/en`,
          fr: `${BASE_URL}/fr`,
        },
      },
    });
  }

  // Blog index for each locale
  for (const locale of routing.locales) {
    entries.push({
      url: `${BASE_URL}/${locale}/blog`,
      lastModified: new Date(),
      changeFrequency: "weekly",
      priority: 0.8,
      alternates: {
        languages: {
          en: `${BASE_URL}/en/blog`,
          fr: `${BASE_URL}/fr/blog`,
        },
      },
    });
  }

  // Blog posts
  for (const locale of routing.locales) {
    const slugs = getAllSlugs(locale);
    for (const slug of slugs) {
      entries.push({
        url: `${BASE_URL}/${locale}/blog/${slug}`,
        lastModified: new Date(),
        changeFrequency: "monthly",
        priority: 0.7,
      });
    }
  }

  return entries;
}
