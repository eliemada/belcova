import type { Metadata } from "next";
import Image from "next/image";
import { getTranslations } from "next-intl/server";
import { getAllPosts } from "@/lib/blog";
import { Link } from "@/i18n/navigation";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "blog" });
  const baseUrl = "https://belcova.fr";

  return {
    title: `${t("title")} — Belcova`,
    description: t("sub"),
    alternates: {
      canonical: `${baseUrl}/${locale}/blog`,
      languages: {
        en: `${baseUrl}/en/blog`,
        fr: `${baseUrl}/fr/blog`,
      },
    },
  };
}

export default async function BlogIndex({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "blog" });
  const posts = getAllPosts(locale);

  return (
    <>
      <nav className="bel-nav is-scrolled" aria-label="Primary">
        <div className="bel-nav-inner">
          <Link href="/" className="bel-wordmark" aria-label="belcova">
            belcova
          </Link>
          <div className="bel-nav-right">
            <Link href="/blog" className="bel-blog-link" style={{ fontSize: 14, fontWeight: 500, color: "var(--color-text)" }}>
              {t("title")}
            </Link>
          </div>
        </div>
      </nav>
      <div className="bel-blog">
        <header className="bel-blog-header">
          <h1 className="bel-h2">{t("title")}</h1>
          <p className="bel-body" style={{ marginTop: 8 }}>
            {t("sub")}
          </p>
        </header>
        {posts.length === 0 ? (
          <p className="bel-body" style={{ textAlign: "center", padding: "64px 0" }}>
            Coming soon.
          </p>
        ) : (
          <div className="bel-blog-grid">
            {posts.map((post) => (
              <Link
                key={post.slug}
                href={`/blog/${post.slug}`}
                className="bel-blog-card"
              >
                {post.image && (
                  <div className="bel-blog-card-img">
                    <Image
                      src={post.image}
                      alt={post.title}
                      width={800}
                      height={450}
                      sizes="(max-width: 768px) 100vw, 400px"
                    />
                  </div>
                )}
                <div className="bel-blog-card-body">
                  <div className="bel-blog-card-meta">
                    {post.date} · {post.readingTime} {t("readMin")}
                  </div>
                  <h3>{post.title}</h3>
                  <p>{post.description}</p>
                </div>
              </Link>
            ))}
          </div>
        )}
      </div>
    </>
  );
}
