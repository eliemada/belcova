"use client";

import { useTranslations } from "next-intl";
import { useInView } from "@/hooks/use-in-view";

function Check() {
  return (
    <svg
      className="bel-cmp-icon bel-cmp-check"
      width="20"
      height="20"
      viewBox="0 0 20 20"
      fill="none"
      aria-hidden="true"
    >
      <path
        d="M5 10.5l3.5 3.5L15 7"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function Cross() {
  return (
    <svg
      className="bel-cmp-icon bel-cmp-cross"
      width="20"
      height="20"
      viewBox="0 0 20 20"
      fill="none"
      aria-hidden="true"
    >
      <path
        d="M6 6l8 8M14 6l-8 8"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

type RowKey = "refundRate" | "merchantFee" | "mobileApp" | "tracking" | "delay";

const ROW_KEYS: readonly RowKey[] = [
  "refundRate",
  "merchantFee",
  "mobileApp",
  "tracking",
  "delay",
] as const;

const ICON_ROWS: ReadonlySet<RowKey> = new Set([
  "mobileApp",
  "tracking",
]);

const BELCOVA_POSITIVE: ReadonlySet<RowKey> = new Set([
  "mobileApp",
  "tracking",
]);

export function ComparisonTable() {
  const t = useTranslations("compare");
  const { ref, inView } = useInView(0.15);

  return (
    <section
      ref={ref as React.Ref<HTMLElement>}
      className={`bel-cmp ${inView ? "in-view" : ""}`}
      aria-label={t("title")}
    >
      <h2 className="bel-cmp-heading">{t("title")}</h2>
      <p className="bel-cmp-sub">{t("subtitle")}</p>

      <div className="bel-cmp-wrap">
        <table className="bel-cmp-table">
          <thead>
            <tr>
              <th className="bel-cmp-th bel-cmp-label" scope="col">
                <span className="sr-only">{t("feature")}</span>
              </th>
              <th className="bel-cmp-th bel-cmp-col-other" scope="col">
                {t("others")}
              </th>
              <th className="bel-cmp-th bel-cmp-col-us" scope="col">
                {t("us")}
              </th>
            </tr>
          </thead>
          <tbody>
            {ROW_KEYS.map((key) => {
              const isIcon = ICON_ROWS.has(key);
              const belcovaPositive = BELCOVA_POSITIVE.has(key);

              return (
                <tr key={key} className="bel-cmp-row">
                  <td className="bel-cmp-cell bel-cmp-label">
                    {t(`rows.${key}.label`)}
                  </td>
                  <td className="bel-cmp-cell bel-cmp-col-other">
                    {isIcon ? (
                      <Cross />
                    ) : (
                      <span>{t(`rows.${key}.other`)}</span>
                    )}
                  </td>
                  <td className="bel-cmp-cell bel-cmp-col-us">
                    {isIcon && belcovaPositive ? (
                      <Check />
                    ) : (
                      <span>{t(`rows.${key}.belcova`)}</span>
                    )}
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </section>
  );
}
