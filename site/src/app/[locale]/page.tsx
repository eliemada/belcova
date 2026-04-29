"use client";

import { useState } from "react";
import { Nav } from "@/components/nav";
import { Hero } from "@/components/hero";
import { SocialProof } from "@/components/social-proof";
import { HowItWorks } from "@/components/how-it-works";
import { ValueProps } from "@/components/value-props";
import { ComparisonTable } from "@/components/comparison-table";
import { RetailerCTA } from "@/components/retailer-cta";
import { Footer } from "@/components/footer";
import { EmailModal } from "@/components/email-modal";

export default function LandingPage() {
  const [modalOpen, setModalOpen] = useState(false);

  return (
    <>
      <Nav onOpenModal={() => setModalOpen(true)} />
      <main>
        <Hero onOpenModal={() => setModalOpen(true)} />
        <SocialProof />
        <HowItWorks />
        <ValueProps />
        <ComparisonTable />
        <RetailerCTA />
      </main>
      <Footer />
      <EmailModal open={modalOpen} onClose={() => setModalOpen(false)} />
    </>
  );
}
