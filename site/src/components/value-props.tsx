"use client";

import type { ReactNode } from "react";
import { useTranslations } from "next-intl";
import { useInView } from "@/hooks/use-in-view";
import { DashboardMock } from "./mocks/dashboard-mock";
import { ChartMock } from "./mocks/chart-mock";
import { PhoneMock } from "./mocks/phone-mock";

function ValueRow({
  side,
  title,
  body,
  mock,
}: {
  side: "left" | "right";
  title: string;
  body: string;
  mock: ReactNode;
}) {
  const { ref, inView } = useInView(0.25);

  return (
    <div
      ref={ref as React.Ref<HTMLDivElement>}
      className={`bel-value-row side-${side} ${inView ? "in-view" : ""}`}
    >
      <div className="bel-value-mock">{mock}</div>
      <div className="bel-value-text">
        <h3 className="bel-h3">{title}</h3>
        <p className="bel-body">{body}</p>
      </div>
    </div>
  );
}

export function ValueProps() {
  const t = useTranslations("value");

  return (
    <section className="bel-value">
      <ValueRow
        side="left"
        title={t("r1t")}
        body={t("r1d")}
        mock={<DashboardMock />}
      />
      <ValueRow
        side="right"
        title={t("r2t")}
        body={t("r2d")}
        mock={<ChartMock />}
      />
      <ValueRow
        side="left"
        title={t("r3t")}
        body={t("r3d")}
        mock={<PhoneMock />}
      />
    </section>
  );
}
