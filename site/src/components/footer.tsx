"use client";

import { useTranslations, useLocale } from "next-intl";
import { useRouter, usePathname, Link } from "@/i18n/navigation";

export function Footer() {
  const t = useTranslations("footer");
  const locale = useLocale();
  const router = useRouter();
  const pathname = usePathname();

  const switchLocale = (next: "en" | "fr") => {
    router.replace(pathname, { locale: next });
  };

  const productLinks = t.raw("product") as string[];
  const companyLinks = t.raw("company") as string[];
  const legalLinks = t.raw("legal") as string[];

  return (
    <footer className="bel-footer">
      <div className="bel-footer-inner">
        <div className="bel-footer-grid">
          <div className="bel-footer-brand">
            <div className="bel-footer-wordmark">belcova</div>
            <p className="bel-footer-tagline">{t("tagline")}</p>
          </div>
          <div className="bel-footer-col">
            <h4 className="bel-footer-heading">{t("productH")}</h4>
            <ul>
              {productLinks.map((link) => (
                <li key={link}>
                  <a href="#">{link}</a>
                </li>
              ))}
            </ul>
          </div>
          <div className="bel-footer-col">
            <h4 className="bel-footer-heading">{t("companyH")}</h4>
            <ul>
              {companyLinks.map((link) => (
                <li key={link}>
                  <a href="#">{link}</a>
                </li>
              ))}
              <li>
                <Link href="/blog">Blog</Link>
              </li>
            </ul>
          </div>
          <div className="bel-footer-col">
            <h4 className="bel-footer-heading">{t("legalH")}</h4>
            <ul>
              {legalLinks.map((link) => (
                <li key={link}>
                  <a href="#">{link}</a>
                </li>
              ))}
            </ul>
          </div>
          <div className="bel-footer-col">
            <h4 className="bel-footer-heading">{t("langH")}</h4>
            <div className="bel-footer-lang">
              <button
                className={locale === "en" ? "is-active" : ""}
                onClick={() => switchLocale("en")}
              >
                English
              </button>
              <button
                className={locale === "fr" ? "is-active" : ""}
                onClick={() => switchLocale("fr")}
              >
                Français
              </button>
            </div>
          </div>
        </div>
        <div className="bel-footer-bottom">
          <p>{t("copy")}</p>
        </div>
      </div>
    </footer>
  );
}
