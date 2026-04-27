"use client";

import { useTranslations } from "next-intl";

function Arrow() {
  return (
    <svg
      className="bel-arrow"
      width="16"
      height="16"
      viewBox="0 0 16 16"
      fill="none"
      aria-hidden="true"
    >
      <path
        d="M3 8h10M9 4l4 4-4 4"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

export function RetailerCTA() {
  const t = useTranslations("retail");

  return (
    <section className="bel-retail">
      <h2 className="bel-retail-title">{t("title")}</h2>
      <p className="bel-retail-body">{t("body")}</p>
      <a
        href="mailto:partners@belcova.com"
        className="bel-btn bel-btn-outline"
      >
        <span>{t("cta")}</span>
        <Arrow />
      </a>
      <p className="bel-retail-or">{t("or")}</p>
    </section>
  );
}
