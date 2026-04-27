"use client";

import { useTranslations } from "next-intl";

export function SocialProof() {
  const t = useTranslations("social");

  return (
    <section className="bel-social" aria-label="Trust signals">
      <div className="bel-social-inner">
        <span>{t("a")}</span>
        <span className="bel-dot" aria-hidden="true">
          ·
        </span>
        <span>{t("b")}</span>
        <span className="bel-dot" aria-hidden="true">
          ·
        </span>
        <span>{t("c")}</span>
      </div>
    </section>
  );
}
