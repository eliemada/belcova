"use client";

import { useTranslations } from "next-intl";
import { useInView } from "@/hooks/use-in-view";

export function ChartMock() {
  const t = useTranslations("value.mock");
  const { ref, inView } = useInView(0.5);

  return (
    <div
      className="mock mock-chart"
      ref={ref as React.Ref<HTMLDivElement>}
      role="img"
      aria-label="Refund comparison chart"
    >
      <div className="mock-chart-bars">
        <div className="mock-bar-col">
          <div
            className="mock-bar others"
            style={{ height: inView ? "55%" : "0%" }}
          />
          <div className="mock-bar-label">55%</div>
          <div className="mock-bar-name">{t("chartOthers")}</div>
        </div>
        <div className="mock-bar-col">
          <div
            className="mock-bar ours"
            style={{ height: inView ? "80%" : "0%" }}
          />
          <div className="mock-bar-label accent">80%</div>
          <div className="mock-bar-name">{t("chartUs")}</div>
        </div>
      </div>
    </div>
  );
}
