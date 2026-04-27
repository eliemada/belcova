"use client";

import { useTranslations } from "next-intl";

export function PhoneMock() {
  const t = useTranslations("value.mock");

  return (
    <div className="mock mock-phone" role="img" aria-label="Mobile app preview">
      <div className="mock-phone-frame">
        <div className="mock-phone-notch" />
        <div className="mock-phone-content">
          <div className="mock-phone-header">
            <div className="mock-phone-check">✓</div>
            <div className="mock-phone-title">{t("phoneTitle")}</div>
            <div className="mock-phone-sub">{t("phoneSub")}</div>
          </div>
          <div className="mock-qr">
            {/* Stylized QR grid */}
            <svg viewBox="0 0 100 100" fill="none" aria-hidden="true">
              <rect width="100" height="100" rx="8" fill="#f3f4f6" />
              <g fill="#111113">
                {/* Corner markers */}
                <rect x="8" y="8" width="24" height="24" rx="4" />
                <rect x="12" y="12" width="16" height="16" rx="2" fill="#fff" />
                <rect x="16" y="16" width="8" height="8" rx="1" />
                <rect x="68" y="8" width="24" height="24" rx="4" />
                <rect x="72" y="12" width="16" height="16" rx="2" fill="#fff" />
                <rect x="76" y="16" width="8" height="8" rx="1" />
                <rect x="8" y="68" width="24" height="24" rx="4" />
                <rect x="12" y="72" width="16" height="16" rx="2" fill="#fff" />
                <rect x="16" y="76" width="8" height="8" rx="1" />
                {/* Data dots */}
                <rect x="40" y="12" width="5" height="5" rx="1" />
                <rect x="50" y="12" width="5" height="5" rx="1" />
                <rect x="40" y="22" width="5" height="5" rx="1" />
                <rect x="55" y="22" width="5" height="5" rx="1" />
                <rect x="40" y="40" width="5" height="5" rx="1" />
                <rect x="50" y="40" width="5" height="5" rx="1" />
                <rect x="60" y="40" width="5" height="5" rx="1" />
                <rect x="40" y="50" width="5" height="5" rx="1" />
                <rect x="55" y="50" width="5" height="5" rx="1" />
                <rect x="40" y="60" width="5" height="5" rx="1" />
                <rect x="50" y="60" width="5" height="5" rx="1" />
                <rect x="60" y="60" width="5" height="5" rx="1" />
                <rect x="70" y="60" width="5" height="5" rx="1" />
                <rect x="80" y="50" width="5" height="5" rx="1" />
                <rect x="70" y="50" width="5" height="5" rx="1" />
                <rect x="80" y="40" width="5" height="5" rx="1" />
                <rect x="12" y="40" width="5" height="5" rx="1" />
                <rect x="22" y="50" width="5" height="5" rx="1" />
                <rect x="12" y="55" width="5" height="5" rx="1" />
              </g>
            </svg>
          </div>
          <div className="mock-phone-ref">
            <span className="mock-phone-ref-label">{t("phoneRef")}</span>
            <span className="mock-phone-ref-val">BLC-4821-FR</span>
          </div>
        </div>
      </div>
    </div>
  );
}
