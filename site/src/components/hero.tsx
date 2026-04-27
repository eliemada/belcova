"use client";

import { useTranslations } from "next-intl";
import { motion } from "framer-motion";

const ease = [0.16, 1, 0.3, 1] as const;

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

function Chevron() {
  return (
    <svg
      width="16"
      height="16"
      viewBox="0 0 16 16"
      fill="none"
      aria-hidden="true"
    >
      <path
        d="M4 6l4 4 4-4"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function MeshGradient() {
  return (
    <div className="bel-mesh" aria-hidden="true">
      <div className="bel-mesh-blob b1" />
      <div className="bel-mesh-blob b2" />
      <div className="bel-mesh-blob b3" />
    </div>
  );
}

export function Hero({ onOpenModal }: { onOpenModal: () => void }) {
  const t = useTranslations("hero");

  return (
    <section className="bel-hero" id="top">
      <div className="bel-hero-bg" aria-hidden="true">
        <MeshGradient />
        <div className="bel-grain" />
        <div className="bel-aurora" />
      </div>
      <div className="bel-hero-inner">
        <motion.h1
          className="bel-h1"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.4, ease }}
        >
          <span className="bel-h1-a">{t("headlineA")}</span>
          <span className="bel-h1-b">{t("headlineB")}</span>
        </motion.h1>
        <motion.p
          className="bel-hero-sub"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.4, ease, delay: 0.15 }}
        >
          {t("subtitle")}
        </motion.p>
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.4, ease, delay: 0.3 }}
        >
          <button
            onClick={onOpenModal}
            className="bel-btn bel-btn-primary bel-btn-lg"
          >
            <span>{t("cta")}</span>
            <Arrow />
          </button>
        </motion.div>
      </div>
      <a href="#how" className="bel-scroll-indicator" aria-label={t("scroll")}>
        <span>{t("scroll")}</span>
        <Chevron />
      </a>
    </section>
  );
}
