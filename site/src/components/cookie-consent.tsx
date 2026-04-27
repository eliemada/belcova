"use client";

import { useState, useEffect } from "react";
import { useTranslations } from "next-intl";

const CONSENT_KEY = "belcova_cookie_consent";

export function CookieConsent() {
  const t = useTranslations("cookies");
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const stored = localStorage.getItem(CONSENT_KEY);
    if (!stored) setVisible(true);
  }, []);

  const respond = (accepted: boolean) => {
    localStorage.setItem(CONSENT_KEY, accepted ? "accepted" : "rejected");
    setVisible(false);
    if (accepted) {
      window.dispatchEvent(new Event("cookie-consent-granted"));
    }
  };

  if (!visible) return null;

  return (
    <div className="bel-cookie-banner" role="dialog" aria-label={t("title")}>
      <p>{t("message")}</p>
      <div className="bel-cookie-actions">
        <button
          className="bel-btn bel-btn-primary bel-btn-sm"
          onClick={() => respond(true)}
        >
          {t("accept")}
        </button>
        <button
          className="bel-btn bel-btn-ghost bel-btn-sm"
          onClick={() => respond(false)}
        >
          {t("reject")}
        </button>
      </div>
    </div>
  );
}

export function hasConsent(): boolean {
  if (typeof window === "undefined") return false;
  return localStorage.getItem(CONSENT_KEY) === "accepted";
}
