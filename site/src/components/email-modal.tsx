"use client";

import { useState, useCallback, type FormEvent } from "react";
import { useTranslations } from "next-intl";
import { motion, AnimatePresence } from "framer-motion";

const ease = [0.16, 1, 0.3, 1] as const;

export function EmailModal({
  open,
  onClose,
}: {
  open: boolean;
  onClose: () => void;
}) {
  const t = useTranslations("modal");
  const [email, setEmail] = useState("");
  const [submitted, setSubmitted] = useState(false);
  const [error, setError] = useState(false);

  const handleSubmit = useCallback(
    (e: FormEvent) => {
      e.preventDefault();
      if (!email || !email.includes("@")) {
        setError(true);
        return;
      }
      setError(false);
      setSubmitted(true);
    },
    [email]
  );

  const handleClose = useCallback(() => {
    onClose();
    setTimeout(() => {
      setSubmitted(false);
      setEmail("");
      setError(false);
    }, 300);
  }, [onClose]);

  return (
    <AnimatePresence>
      {open && (
        <motion.div
          className="bel-modal-overlay"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          exit={{ opacity: 0 }}
          transition={{ duration: 0.2, ease }}
          onClick={handleClose}
        >
          <motion.div
            className="bel-modal"
            initial={{ opacity: 0, y: 12, scale: 0.98 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 12, scale: 0.98 }}
            transition={{ duration: 0.3, ease }}
            onClick={(e) => e.stopPropagation()}
            role="dialog"
            aria-modal="true"
          >
            <button
              className="bel-modal-close"
              onClick={handleClose}
              aria-label="Close"
            >
              ×
            </button>

            {submitted ? (
              <div className="bel-modal-success">
                <div className="bel-modal-check">✓</div>
                <p className="bel-modal-title">{t("success")}</p>
              </div>
            ) : (
              <>
                <h2 className="bel-modal-title">{t("title")}</h2>
                <p className="bel-modal-body">{t("body")}</p>
                <form className="bel-modal-form" onSubmit={handleSubmit}>
                  <input
                    type="email"
                    className={`bel-input ${error ? "is-error" : ""}`}
                    placeholder={t("placeholder")}
                    value={email}
                    onChange={(e) => {
                      setEmail(e.target.value);
                      setError(false);
                    }}
                    autoFocus
                  />
                  <button type="submit" className="bel-btn bel-btn-primary bel-btn-lg">
                    {t("cta")}
                  </button>
                </form>
                <p className="bel-modal-consent">{t("consent")}</p>
              </>
            )}
          </motion.div>
        </motion.div>
      )}
    </AnimatePresence>
  );
}
