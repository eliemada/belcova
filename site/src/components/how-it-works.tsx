"use client";

import { useTranslations } from "next-intl";
import { useInView } from "@/hooks/use-in-view";
import { Counter } from "./counter";

export function HowItWorks() {
  const t = useTranslations("how");
  const { ref, inView } = useInView(0.3);

  const steps = [
    { n: t("s1n"), h: t("s1t"), d: t("s1d") },
    { n: t("s2n"), h: t("s2t"), d: t("s2d") },
    { n: t("s3n"), h: t("s3t"), d: t("s3d") },
  ];

  return (
    <section className="bel-how" id="how" ref={ref as React.Ref<HTMLElement>}>
      <h2 className="bel-h2">{t("title")}</h2>
      <div className={`bel-steps ${inView ? "in-view" : ""}`}>
        <div className="bel-steps-line" aria-hidden="true">
          <div className="bel-steps-dot" />
        </div>
        {steps.map((s, i) => (
          <div
            key={i}
            className="bel-step"
            style={{ "--d": `${i * 100}ms` } as React.CSSProperties}
          >
            <div className="bel-step-num">{s.n}</div>
            <h3 className="bel-step-h">{s.h}</h3>
            <p className="bel-step-d">{s.d}</p>
            {i === 2 && <Counter target={127.4} inView={inView} />}
          </div>
        ))}
      </div>
    </section>
  );
}
