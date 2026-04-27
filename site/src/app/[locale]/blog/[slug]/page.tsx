import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations } from "next-intl/server";
import { MDXRemote } from "next-mdx-remote/rsc";
import { getPostBySlug, getAllSlugs } from "@/lib/blog";
import { ArticleJsonLd } from "@/components/json-ld";
import { Link } from "@/i18n/navigation";
import { routing } from "@/i18n/routing";

export async function generateStaticParams() {
  const params: { locale: string; slug: string }[] = [];
  for (const locale of routing.locales) {
    for (const slug of getAllSlugs(locale)) {
      params.push({ locale, slug });
    }
  }
  return params;
}

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}): Promise<Metadata> {
  const { locale, slug } = await params;
  const post = getPostBySlug(locale, slug);
  if (!post) return {};

  const baseUrl = "https://belcova.fr";
  const url = `${baseUrl}/${locale}/blog/${slug}`;

  return {
    title: `${post.title} — Belcova`,
    description: post.description,
    alternates: { canonical: url },
    openGraph: {
      title: post.title,
      description: post.description,
      url,
      type: "article",
      publishedTime: post.date,
    },
  };
}

export default async function BlogPost({
  params,
}: {
  params: Promise<{ locale: string; slug: string }>;
}) {
  const { locale, slug } = await params;
  const post = getPostBySlug(locale, slug);
  if (!post) notFound();

  const t = await getTranslations({ locale, namespace: "blog" });
  const baseUrl = "https://belcova.fr";

  return (
    <>
      <ArticleJsonLd
        title={post.title}
        description={post.description}
        datePublished={post.date}
        url={`${baseUrl}/${locale}/blog/${slug}`}
        locale={locale}
      />
      <nav className="bel-nav is-scrolled" aria-label="Primary">
        <div className="bel-nav-inner">
          <Link href="/" className="bel-wordmark" aria-label="belcova">
            belcova
          </Link>
        </div>
      </nav>
      <article className="bel-article">
        <Link href="/blog" className="bel-article-back">
          ← {t("backToAll")}
        </Link>
        <div className="bel-article-meta">
          {post.date} · {post.readingTime} {t("readMin")}
        </div>
        <h1>{post.title}</h1>
        <div className="bel-article-content">
          <MDXRemote source={post.content} />
        </div>
      </article>
    </>
  );
}
