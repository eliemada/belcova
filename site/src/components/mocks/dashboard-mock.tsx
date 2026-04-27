"use client";

import { useTranslations } from "next-intl";

export function DashboardMock() {
  const t = useTranslations("value.mock");

  return (
    <div className="mock mock-dash" role="img" aria-label="Dashboard preview">
      <div className="mock-chrome">
        <span className="mock-dot d1" />
        <span className="mock-dot d2" />
        <span className="mock-dot d3" />
        <span className="mock-url">app.belcova.com/refunds/blc-4821</span>
      </div>
      <div className="mock-dash-body">
        <div className="mock-dash-head">
          <div className="mock-dash-title">{t("dashTitle")}</div>
          <div className="mock-dash-store">{t("store")}</div>
        </div>
        <div className="mock-timeline">
          <div className="mock-tl-step done">
            <div className="mock-tl-dot" />
            <span>{t("purchased")}</span>
          </div>
          <div className="mock-tl-bar done" />
          <div className="mock-tl-step done">
            <div className="mock-tl-dot" />
            <span>{t("validated")}</span>
          </div>
          <div className="mock-tl-bar active" />
          <div className="mock-tl-step active">
            <div className="mock-tl-dot" />
            <span>{t("paid")}</span>
          </div>
        </div>
        <div className="mock-dash-stats">
          <div className="mock-stat">
            <div className="mock-stat-label">{t("amount")}</div>
            <div className="mock-stat-value">€127.40</div>
          </div>
          <div className="mock-stat">
            <div className="mock-stat-label">{t("eta")}</div>
            <div className="mock-stat-value">{t("days")}</div>
          </div>
        </div>
      </div>
    </div>
  );
}
