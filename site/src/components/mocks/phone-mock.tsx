"use client";

import { useTranslations } from "next-intl";

export function PhoneMock() {
  const t = useTranslations("value.mock");

  return (
    <div className="mock mock-phone" role="img" aria-label="Mobile app preview">
      <div className="mock-phone-frame">
        <div className="mock-phone-screen">
          {/* Dynamic Island */}
          <div className="mock-phone-island" />
          {/* Status bar */}
          <div className="mock-phone-statusbar">
            <span className="mock-phone-time">9:41</span>
            <div className="mock-phone-indicators">
              <svg width="16" height="12" viewBox="0 0 16 12" fill="currentColor" aria-hidden="true">
                <rect x="0" y="7" width="3" height="5" rx="0.5" opacity="0.4" />
                <rect x="4.5" y="5" width="3" height="7" rx="0.5" opacity="0.6" />
                <rect x="9" y="2.5" width="3" height="9.5" rx="0.5" opacity="0.8" />
                <rect x="13.5" y="0" width="3" height="12" rx="0.5" />
              </svg>
              <svg width="24" height="12" viewBox="0 0 24 12" fill="currentColor" aria-hidden="true">
                <rect x="0" y="0.5" width="21" height="11" rx="2" stroke="currentColor" strokeWidth="1" fill="none" />
                <rect x="1.5" y="2" width="14" height="8" rx="1" />
                <rect x="22" y="3.5" width="2" height="5" rx="1" />
              </svg>
            </div>
          </div>
          {/* App content */}
          <div className="mock-phone-content">
            <div className="mock-phone-header">
              <div className="mock-phone-check">✓</div>
              <div className="mock-phone-title">{t("phoneTitle")}</div>
              <div className="mock-phone-sub">{t("phoneSub")}</div>
            </div>
            <div className="mock-qr">
              <svg viewBox="0 0 100 100" fill="none" aria-hidden="true">
                <rect width="100" height="100" rx="8" fill="#f3f4f6" />
                <g fill="#111113">
                  <rect x="8" y="8" width="24" height="24" rx="4" />
                  <rect x="12" y="12" width="16" height="16" rx="2" fill="#fff" />
                  <rect x="16" y="16" width="8" height="8" rx="1" />
                  <rect x="68" y="8" width="24" height="24" rx="4" />
                  <rect x="72" y="12" width="16" height="16" rx="2" fill="#fff" />
                  <rect x="76" y="16" width="8" height="8" rx="1" />
                  <rect x="8" y="68" width="24" height="24" rx="4" />
                  <rect x="12" y="72" width="16" height="16" rx="2" fill="#fff" />
                  <rect x="16" y="76" width="8" height="8" rx="1" />
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
          {/* Home indicator */}
          <div className="mock-phone-home" />
        </div>
      </div>
    </div>
  );
}
