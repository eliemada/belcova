"use client";

import { useEffect, useState } from "react";

export function Counter({
  target,
  inView,
}: {
  target: number;
  inView: boolean;
}) {
  const [val, setVal] = useState(0);

  useEffect(() => {
    if (!inView) return;

    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      setVal(target);
      return;
    }

    const dur = 1400;
    const start = performance.now();
    let raf: number;

    const tick = (now: number) => {
      const p = Math.min(1, (now - start) / dur);
      const eased = 1 - Math.pow(1 - p, 3);
      setVal(target * eased);
      if (p < 1) raf = requestAnimationFrame(tick);
    };

    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  }, [inView, target]);

  return <div className="bel-counter">€{val.toFixed(2)}</div>;
}
