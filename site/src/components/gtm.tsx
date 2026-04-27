"use client";

import { useEffect } from "react";
import Script from "next/script";
import { hasConsent } from "./cookie-consent";

const GTM_ID = "GTM-5MN5W3GC";

export function GoogleTagManager() {
  useEffect(() => {
    const onConsent = () => {
      // GTM script loads via next/script below, but only fires tags
      // when consent is granted via dataLayer push
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({
        event: "consent_granted",
        analytics_storage: "granted",
      });
    };

    // If user already accepted in a previous session
    if (hasConsent()) onConsent();

    // Listen for fresh consent
    window.addEventListener("cookie-consent-granted", onConsent);
    return () =>
      window.removeEventListener("cookie-consent-granted", onConsent);
  }, []);

  return (
    <>
      <Script id="gtm-init" strategy="afterInteractive">
        {`
          window.dataLayer = window.dataLayer || [];
          window.dataLayer.push({
            'gtm.start': new Date().getTime(),
            event: 'gtm.js'
          });
        `}
      </Script>
      <Script
        id="gtm-script"
        strategy="afterInteractive"
        src={`https://www.googletagmanager.com/gtm.js?id=${GTM_ID}`}
      />
      <noscript>
        <iframe
          src={`https://www.googletagmanager.com/ns.html?id=${GTM_ID}`}
          height="0"
          width="0"
          style={{ display: "none", visibility: "hidden" }}
        />
      </noscript>
    </>
  );
}

declare global {
  interface Window {
    dataLayer: Record<string, unknown>[];
  }
}
