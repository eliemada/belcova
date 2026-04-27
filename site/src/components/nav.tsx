"use client";

import { useTranslations, useLocale } from "next-intl";
import { useScrolled } from "@/hooks/use-scrolled";
import { useRouter, usePathname, Link } from "@/i18n/navigation";

export function Nav({ onOpenModal }: { onOpenModal: () => void }) {
  const t = useTranslations("nav");
  const locale = useLocale();
  const scrolled = useScrolled(60);
  const router = useRouter();
  const pathname = usePathname();

  const switchLocale = (next: "en" | "fr") => {
    router.replace(pathname, { locale: next });
  };

  return (
    <nav
      className={`bel-nav ${scrolled ? "is-scrolled" : ""}`}
      aria-label="Primary"
    >
      <div className="bel-nav-inner">
        <a href="#top" className="bel-wordmark" aria-label="belcova">
          belcova
        </a>
        <div className="bel-nav-right">
          <Link href="/blog" className="bel-nav-link">
            {t("blog")}
          </Link>
          <div className="bel-lang" role="tablist" aria-label="Language">
            <button
              role="tab"
              aria-selected={locale === "en"}
              className={locale === "en" ? "is-active" : ""}
              onClick={() => switchLocale("en")}
            >
              EN
            </button>
            <span className="bel-lang-sep" aria-hidden="true">
              /
            </span>
            <button
              role="tab"
              aria-selected={locale === "fr"}
              className={locale === "fr" ? "is-active" : ""}
              onClick={() => switchLocale("fr")}
            >
              FR
            </button>
          </div>
          <button
            className="bel-btn bel-btn-primary bel-btn-sm"
            onClick={onOpenModal}
          >
            {t("getStarted")}
          </button>
        </div>
      </div>
    </nav>
  );
}
