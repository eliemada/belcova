# Detaxe Platform - System Design Document

**Version:** 1.0
**Date:** 2025-12-18
**Status:** Draft
**Authors:** Team Detaxe

---

## Executive Summary

Detaxe is a modern VAT refund platform for tourists shopping in France, competing with SkipTax and ZapTax. We differentiate through:

- **Better economics:** 85-90% refund rate (vs 80% industry standard)
- **Superior technology:** Real-time tracking, faster processing
- **Better UX:** Modern interface (vs SkipTax's poor UI)
- **Transparent pricing:** Clear, unbundled fees

**Target Market:** Retailers in Paris initially, expanding to other tourist cities.

**Business Model:** Full-service PABLO operator - 10-15% commission on VAT refunds.

---

## Table of Contents

1. [Business Context](#business-context)
2. [System Architecture](#system-architecture)
3. [PABLO EDI Integration](#pablo-edi-integration)
4. [Data Models](#data-models)
5. [Refund Processing Engine](#refund-processing-engine)
6. [Frontend Architecture](#frontend-architecture)
7. [Error Handling & Resilience](#error-handling--resilience)
8. [Security & Compliance](#security--compliance)
9. [Deployment & DevOps](#deployment--devops)
10. [Implementation Roadmap](#implementation-roadmap)

---

## Business Context

### Market Analysis

**Competitors:**
- **SkipTax:** Fast technology, poor UI, slow customer service, low adoption
- **ZapTax:** Great UI, higher fees (20-25%), larger market share

**Our Positioning:** Best of both worlds - SkipTax's speed + ZapTax's UX + lower fees.

### Value Proposition

**For Retailers:**
- Lower commission than ZapTax (competitive with SkipTax)
- Better UX attracts more tourists to their stores
- Fast onboarding and white-glove support
- Real-time analytics and reporting

**For Tourists:**
- 85-90% refund rate (vs 80% competitors)
- Transparent pricing - no hidden fees
- Fast processing and payment
- Multiple payment options (SEPA, Revolut, Wise)
- Real-time tracking

### Go-to-Market Strategy

**Phase 1 (Months 1-6):** Paris luxury retailers
- Target: 20-30 high-end stores (Champs-Élysées, Le Marais, Saint-Germain)
- High transaction values (€500-5000 average)
- Build case studies and testimonials

**Phase 2 (Months 6-12):** Expand Paris coverage
- Mid-tier retailers
- More locations

**Phase 3 (Year 2+):** Geographic expansion
- Nice, Lyon, Bordeaux
- Other EU countries

### Team & Resources

- **Founding team:** 2-3 CS students (3rd year bachelor + 1st year master)
- **Timeline:** Side project + summer intensive (3-4 months full-time)
- **Outsourcing:** Madagascar team for customer support and manual processing
- **Hiring:** Can hire developers/designers once MVP validated

---

## System Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Frontend Layer                           │
├──────────────────┬──────────────────┬───────────────────────┤
│  detaxe.com      │ retailer.detaxe  │  admin.detaxe.com     │
│  (Tourist Portal)│  (Retailer Portal│  (Ops Dashboard)      │
└────────┬─────────┴────────┬─────────┴──────────┬────────────┘
         │                  │                     │
         └──────────────────┴─────────────────────┘
                            │
                    ┌───────▼────────┐
                    │   API Gateway   │
                    │   (FastAPI)     │
                    └───────┬────────┘
                            │
         ┌──────────────────┼──────────────────┐
         │                  │                  │
    ┌────▼─────┐    ┌──────▼──────┐   ┌──────▼──────┐
    │  PABLO   │    │   Refund    │   │  Payment    │
    │   EDI    │    │  Processing │   │  Processing │
    │ Service  │    │   Engine    │   │   Service   │
    └────┬─────┘    └──────┬──────┘   └──────┬──────┘
         │                 │                  │
         └─────────────────┴──────────────────┘
                           │
                  ┌────────▼─────────┐
                  │   PostgreSQL     │
                  │   (Primary DB)   │
                  └──────────────────┘
                           │
                  ┌────────▼─────────┐
                  │   Redis          │
                  │   (Cache/Queue)  │
                  └──────────────────┘

    External Systems:
    - GUN Platform (French Customs)
    - Revolut/Wise/SEPA (Payments)
    - Email/SMS providers
```

### Technology Stack

**Backend:**
- **Language:** Python 3.12+
- **Framework:** FastAPI (async, type-safe, auto docs)
- **ORM:** SQLAlchemy 2.0 (type-safe models)
- **Validation:** Pydantic v2 (JSON schema validation)
- **Task Queue:** Celery + Redis (async message processing)
- **Logging:** Loguru (structured logging)
- **Testing:** pytest + pytest-asyncio

**Frontend:**
- **Framework:** Next.js 14+ (App Router, React Server Components)
- **UI Library:** shadcn/ui + Tailwind CSS
- **Authentication:** Clerk (managed auth with organizations)
- **State Management:** Zustand or React Context
- **Forms:** React Hook Form + Zod validation
- **API Client:** TanStack Query (React Query)
- **i18n:** next-intl (English, French, Chinese initially)

**Database:**
- **Primary:** PostgreSQL 15+ (ACID compliance for financial data)
- **Cache/Queue:** Redis 7+ (message queues, session storage)

**Infrastructure:**
- **Hosting:** Render.com or Railway (simpler than AWS for MVP)
- **Frontend:** Vercel (Next.js optimized)
- **CDN:** Cloudflare (DDoS protection, caching)
- **Monitoring:** Sentry (error tracking), Prometheus + Grafana (metrics)
- **CI/CD:** GitHub Actions

**External Services:**
- **Email:** SendGrid or Resend
- **SMS:** Twilio
- **Payments:** Revolut Business API, Wise Platform, SEPA via bank

---

## PABLO EDI Integration

### Overview

PABLO (Projet d'Automatisation du Bordereau de vente à L'exportation en lIgne) is the French customs system for VAT refund validation. We must integrate via the GUN (Guichet Unique Numérique) platform.

### Integration Requirements

**Protocol:**
- REST API over HTTPS
- POST requests with JSON payloads
- Asynchronous processing (send message, receive ACK later)
- Message queue required for reliability

**Authentication:**
- OAuth 2.0 via GUN platform
- Certificate-based authentication
- API credentials per operator

**Message Formats:**
- All messages in JSON (UTF-8 encoding)
- Schema validation required (JSON Schema Definition - JSD)
- Field names in French (use Pydantic aliases for English internal models)

### Message Types

**Outbound (Operator → PABLO):**

| Message | Purpose | Frequency |
|---------|---------|-----------|
| A_E_C01 | Create BVE (normal) | Per transaction |
| A_E_P01 | Create BVE (backup/emergency) | Rare (system downtime) |
| A_E_S01 | Delete BVE (fix errors) | Occasional |
| A_E_U01 | EU Visa (BVE stamped in other EU country, >€50k) | Rare |
| A_AR_A02 | ACK clearance success | Daily (response to R_E_A01) |
| A_EC_A03 | ACK clearance failure | As needed |

**Inbound (PABLO → Operator):**

| Message | Purpose | Frequency |
|---------|---------|-----------|
| R_AR_C02 | BVE created successfully | Per transaction |
| R_EC_C03 | BVE creation failed | Per failed transaction |
| R_E_A01 | Clearance list (confirmed/cancelled BVEs) | Daily (J+1) |
| R_E_IS | Live status updates | Every 5 min (optional) |
| R_AR_S02 | BVE deleted successfully | As needed |
| R_EC_S03 | BVE deletion failed | As needed |

**Error Messages:**

| Code | Description | Action |
|------|-------------|--------|
| G001 | JSON schema validation failed | Fix payload, retry |
| G002 | PABLO system error | Retry with backoff |
| R_EC_C03 | Functional error (BVE-specific) | Review error code, fix data, retry |

### Architecture

```python
# Core components

1. GUNClient (HTTP client)
   - Authenticate with GUN platform
   - Send/receive JSON messages
   - Handle retries and timeouts

2. MessageQueue (Celery + Redis)
   - Queue outbound messages (A_E_C01, A_E_S01, etc.)
   - Process inbound messages (R_AR_C02, R_E_A01, etc.)
   - Retry failed messages
   - Dead letter queue for manual intervention

3. PabloService (Business logic)
   - Convert domain models to PABLO DTOs
   - Validate against JSON schemas
   - Handle message workflows

4. MessageStore (Database)
   - Audit trail of all messages
   - Track message status (pending/sent/acked/failed)
   - Support compliance audits
```

### Key Workflows

#### Create BVE Flow

```
1. Retailer creates tax-free form in portal
2. System validates data (Pydantic schemas)
3. Convert to PABLO format (French field names via aliases)
4. Validate against JSD (JSON Schema Definition)
5. Queue message A_E_C01
6. Worker sends to GUN → receives HTTP 200 (technical ACK)
7. Wait for functional ACK (R_AR_C02 or R_EC_C03)
8. If R_AR_C02: Mark BVE as "created", tourist can leave
9. If R_EC_C03: Log error, alert retailer, MUST retry after fixing
```

#### Clearance Flow (Nightly)

```
1. PABLO sends R_E_A01 at J+1 (list of confirmed/cancelled BVEs)
2. Webhook receives message
3. For each BVE:
   - Update status (confirmed/cancelled)
   - If confirmed: trigger refund processing
   - If cancelled: notify tourist (no refund)
4. Send A_AR_A02 ACK immediately
5. If no ACK sent, PABLO resends same list next night
```

### Data Models (Pydantic)

```python
from pydantic import BaseModel, Field
from datetime import datetime
from decimal import Decimal

class PabloTraveler(BaseModel):
    """Maps to PABLO 'voyageur' object"""
    passport_number: str = Field(..., alias="passeport")
    passport_expiry: str = Field(..., alias="date_expiration_passeport")
    last_name: str = Field(..., alias="nom_voyageur")
    first_name: str = Field(..., alias="prenom_voyageur")
    birth_date: str = Field(..., alias="date_naissance")
    address: str = Field(..., alias="adresse")
    residence_country: str = Field(..., alias="pays_residence")
    nationality: str = Field(..., alias="nationalite")

class PabloMerchandise(BaseModel):
    """Maps to PABLO 'marchandises' object"""
    description: str
    type: str
    brand: str = Field(..., alias="marque")
    identification_number: str = Field(..., alias="numero_identification")
    color: str = Field(..., alias="couleur")
    product_code: int = Field(..., alias="code_produit")
    quantity: int = Field(..., gt=0, alias="quantite")
    vat_rate: Decimal = Field(..., ge=0, le=100, alias="taux_tva")
    amount_incl_vat: Decimal = Field(..., gt=0, alias="montant_ttc")
    vat_amount: Decimal = Field(..., gt=0, alias="montant_tva")

class A_E_C01(BaseModel):
    """BVE Creation Message"""
    detaxe_id: str = Field(..., min_length=20, max_length=20, alias="identifiant_detaxe")
    issue_date: datetime = Field(..., alias="date_emission")
    traveler: PabloTraveler = Field(..., alias="voyageur")
    merchandise_list: list[PabloMerchandise] = Field(..., alias="marchandises")
    # ... transaction details

    def model_dump_pablo(self) -> dict:
        """Serialize with French field names for PABLO"""
        return self.model_dump(by_alias=True, exclude_none=True)
```

### Error Handling

**Retry Strategy:**
- Transient errors (network, G002): Exponential backoff, max 5 retries
- Permanent errors (G001, invalid data): No retry, alert dev team
- Functional errors (R_EC_C03): Review error code, some retriable

**Idempotency:**
- All message processing must be idempotent (PABLO may send duplicates)
- Use message IDs and Redis to track processed messages
- TTL: 7 days for duplicate detection

**Monitoring:**
- Log all messages (Loguru)
- Track metrics (message success/failure rates)
- Alert on critical errors (Sentry)
- Audit trail for compliance (PostgreSQL)

---

## Data Models

### Database Schema (PostgreSQL)

#### Core Tables

**retailers**
```sql
CREATE TABLE retailers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    clerk_org_id VARCHAR(255) UNIQUE,  -- Clerk organization ID (org_xxx)
    name VARCHAR(255) NOT NULL,
    legal_entity VARCHAR(255) NOT NULL,
    siret VARCHAR(14),  -- French business ID (optional per spec)
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(50),
    status VARCHAR(50) NOT NULL DEFAULT 'pending',  -- pending, active, suspended
    commission_rate DECIMAL(5,4) DEFAULT 0.15,  -- 15% default
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_retailers_clerk_org ON retailers(clerk_org_id);
CREATE INDEX idx_retailers_email ON retailers(email);
CREATE INDEX idx_retailers_status ON retailers(status);
```

**stores**
```sql
CREATE TABLE stores (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    retailer_id UUID NOT NULL REFERENCES retailers(id),
    name VARCHAR(255) NOT NULL,
    address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    country VARCHAR(2) DEFAULT 'FR',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_stores_retailer ON stores(retailer_id);
CREATE INDEX idx_stores_city ON stores(city);
```

**bves** (Bordereau de Vente à l'Exportation)
```sql
CREATE TABLE bves (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bve_number VARCHAR(20) UNIQUE NOT NULL,  -- 20-digit ID from PABLO
    retailer_id UUID NOT NULL REFERENCES retailers(id),
    store_id UUID NOT NULL REFERENCES stores(id),

    -- Status tracking
    status VARCHAR(50) NOT NULL DEFAULT 'created',
    -- created, sent_to_pablo, confirmed, cancelled, rejected

    -- Traveler info
    traveler_passport VARCHAR(50) NOT NULL,
    traveler_last_name VARCHAR(100) NOT NULL,
    traveler_first_name VARCHAR(100) NOT NULL,
    traveler_birth_date DATE NOT NULL,
    traveler_nationality VARCHAR(2) NOT NULL,
    traveler_residence_country VARCHAR(2) NOT NULL,
    traveler_email VARCHAR(255),  -- Optional, for notifications

    -- Financial details
    total_amount_incl_vat DECIMAL(10,2) NOT NULL,
    total_vat_amount DECIMAL(10,2) NOT NULL,

    -- PABLO integration
    pablo_message_id VARCHAR(100),  -- GUN message ID
    pablo_confirmed_at TIMESTAMP,
    pablo_cancelled_at TIMESTAMP,
    error_code VARCHAR(50),
    error_message TEXT,

    -- Timestamps
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),

    CONSTRAINT chk_bve_number_format CHECK (char_length(bve_number) = 20)
);

CREATE INDEX idx_bves_bve_number ON bves(bve_number);
CREATE INDEX idx_bves_retailer ON bves(retailer_id);
CREATE INDEX idx_bves_status ON bves(status);
CREATE INDEX idx_bves_created_at ON bves(created_at DESC);
```

**bve_items** (Merchandise)
```sql
CREATE TABLE bve_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bve_id UUID NOT NULL REFERENCES bves(id) ON DELETE CASCADE,

    description TEXT NOT NULL,
    type VARCHAR(100),
    brand VARCHAR(100),
    identification_number VARCHAR(100),  -- Serial number
    color VARCHAR(50),
    product_code BIGINT,

    quantity INT NOT NULL CHECK (quantity > 0),
    vat_rate DECIMAL(5,2) NOT NULL CHECK (vat_rate >= 0 AND vat_rate <= 100),
    amount_incl_vat DECIMAL(10,2) NOT NULL CHECK (amount_incl_vat > 0),
    vat_amount DECIMAL(10,2) NOT NULL CHECK (vat_amount > 0),

    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_bve_items_bve ON bve_items(bve_id);
```

**refunds**
```sql
CREATE TABLE refunds (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bve_id UUID NOT NULL REFERENCES bves(id) UNIQUE,

    -- Amounts (use DECIMAL for precision)
    total_vat DECIMAL(10,2) NOT NULL,
    refund_percentage DECIMAL(5,4) DEFAULT 0.85,  -- 85%
    refund_amount DECIMAL(10,2) NOT NULL,
    commission_amount DECIMAL(10,2) NOT NULL,

    -- Status
    status VARCHAR(50) NOT NULL DEFAULT 'pending_clearance',
    -- pending_clearance, cleared, cancelled, pending_payment_info,
    -- payment_queued, payment_processing, paid, payment_failed

    -- Payment details (encrypted in production)
    payment_method VARCHAR(50),  -- sepa, revolut, wise
    payment_details JSONB,  -- {iban, bic, account_holder} or {revolut_tag} etc.
    payment_provider_id VARCHAR(255),  -- Transaction ID from provider

    -- Timestamps
    cleared_at TIMESTAMP,
    payment_sent_at TIMESTAMP,
    paid_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_refunds_bve ON refunds(bve_id);
CREATE INDEX idx_refunds_status ON refunds(status);
CREATE INDEX idx_refunds_payment_method ON refunds(payment_method);
```

**pablo_messages** (Audit Trail)
```sql
CREATE TABLE pablo_messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    bve_id UUID REFERENCES bves(id),  -- Nullable for global errors
    message_type VARCHAR(20) NOT NULL,  -- A_E_C01, R_AR_C02, etc.
    direction VARCHAR(10) NOT NULL,  -- outbound, inbound

    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    -- pending, sent, acked, failed

    payload JSONB NOT NULL,  -- Full message content
    response JSONB,  -- Response from PABLO

    gun_message_id VARCHAR(100),  -- GUN platform message ID
    error_code VARCHAR(50),
    error_message TEXT,

    retry_count INT DEFAULT 0,
    last_retry_at TIMESTAMP,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_pablo_messages_bve ON pablo_messages(bve_id);
CREATE INDEX idx_pablo_messages_type ON pablo_messages(message_type);
CREATE INDEX idx_pablo_messages_status ON pablo_messages(status);
CREATE INDEX idx_pablo_messages_created ON pablo_messages(created_at DESC);
```

**users** (Synced from Clerk)
```sql
-- Users are managed by Clerk, this table syncs via webhooks
-- We store minimal data needed for our business logic

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    clerk_user_id VARCHAR(255) NOT NULL UNIQUE,  -- Clerk's user_xxx ID
    email VARCHAR(255) NOT NULL,

    -- Denormalized from Clerk for convenience
    first_name VARCHAR(100),
    last_name VARCHAR(100),

    -- Our internal fields
    is_active BOOLEAN DEFAULT TRUE,
    last_seen_at TIMESTAMP,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_clerk_id ON users(clerk_user_id);
CREATE INDEX idx_users_email ON users(email);

-- Retailer membership is handled via Clerk organizations
-- Each Clerk org maps to a retailer via retailers.clerk_org_id
```

### SQLAlchemy Models (Python)

```python
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
from sqlalchemy import ForeignKey, DECIMAL, JSON
from datetime import datetime, date
from decimal import Decimal
import uuid

class Base(DeclarativeBase):
    pass

class Retailer(Base):
    __tablename__ = "retailers"

    id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
    clerk_org_id: Mapped[str | None] = mapped_column(String(255), unique=True, index=True)  # Clerk org_xxx
    name: Mapped[str] = mapped_column(index=True)
    legal_entity: Mapped[str]
    siret: Mapped[str | None] = mapped_column(String(14))
    email: Mapped[str] = mapped_column(unique=True, index=True)
    phone: Mapped[str | None]
    status: Mapped[str] = mapped_column(default="pending", index=True)
    commission_rate: Mapped[Decimal] = mapped_column(DECIMAL(5, 4), default=Decimal("0.15"))

    created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    stores: Mapped[list["Store"]] = relationship(back_populates="retailer")
    bves: Mapped[list["BVE"]] = relationship(back_populates="retailer")

class BVE(Base):
    __tablename__ = "bves"

    id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
    bve_number: Mapped[str] = mapped_column(String(20), unique=True, index=True)
    retailer_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("retailers.id"), index=True)
    store_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("stores.id"))

    status: Mapped[str] = mapped_column(default="created", index=True)

    # Traveler
    traveler_passport: Mapped[str]
    traveler_last_name: Mapped[str]
    traveler_first_name: Mapped[str]
    traveler_birth_date: Mapped[date]
    traveler_nationality: Mapped[str] = mapped_column(String(2))
    traveler_residence_country: Mapped[str] = mapped_column(String(2))
    traveler_email: Mapped[str | None]

    # Financial
    total_amount_incl_vat: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))
    total_vat_amount: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))

    # PABLO
    pablo_message_id: Mapped[str | None]
    pablo_confirmed_at: Mapped[datetime | None]
    pablo_cancelled_at: Mapped[datetime | None]
    error_code: Mapped[str | None]
    error_message: Mapped[str | None]

    created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow, index=True)
    updated_at: Mapped[datetime] = mapped_column(default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    retailer: Mapped["Retailer"] = relationship(back_populates="bves")
    store: Mapped["Store"] = relationship()
    items: Mapped[list["BVEItem"]] = relationship(back_populates="bve", cascade="all, delete-orphan")
    refund: Mapped["Refund"] = relationship(back_populates="bve", uselist=False)

class Refund(Base):
    __tablename__ = "refunds"

    id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
    bve_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("bves.id"), unique=True, index=True)

    total_vat: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))
    refund_percentage: Mapped[Decimal] = mapped_column(DECIMAL(5, 4), default=Decimal("0.85"))
    refund_amount: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))
    commission_amount: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))

    status: Mapped[str] = mapped_column(default="pending_clearance", index=True)

    payment_method: Mapped[str | None] = mapped_column(index=True)
    payment_details: Mapped[dict | None] = mapped_column(JSON)
    payment_provider_id: Mapped[str | None]

    cleared_at: Mapped[datetime | None]
    payment_sent_at: Mapped[datetime | None]
    paid_at: Mapped[datetime | None]

    created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)
    updated_at: Mapped[datetime] = mapped_column(default=datetime.utcnow, onupdate=datetime.utcnow)

    # Relationships
    bve: Mapped["BVE"] = relationship(back_populates="refund")
```

---

## Refund Processing Engine

### Overview

The refund engine calculates tourist refunds, collects payment details, and processes payments via multiple providers (SEPA, Revolut, Wise).

### Refund Lifecycle

```
1. BVE created → Tourist leaves France with tax-free form
2. Customs stamps BVE at airport/border
3. PABLO sends clearance (R_E_A01) → status = confirmed/cancelled
4. If confirmed:
   a. Calculate refund (85-90% of VAT)
   b. Notify tourist to submit payment details
   c. Collect IBAN/Revolut/Wise info
   d. Queue payment
   e. Process via provider
   f. Track payment status
   g. Handle failures (retry)
```

### Refund Calculation

```python
from decimal import Decimal, ROUND_HALF_UP

class RefundCalculator:
    @staticmethod
    def calculate(
        total_vat: Decimal,
        refund_percentage: Decimal = Decimal("0.85")
    ) -> dict[str, Decimal]:
        """
        Calculate refund amounts with proper rounding

        Example:
            Total VAT: €100
            Refund (85%): €85.00
            Commission (15%): €15.00
        """
        refund_amount = (total_vat * refund_percentage).quantize(
            Decimal("0.01"),
            rounding=ROUND_HALF_UP
        )

        commission = (total_vat - refund_amount).quantize(
            Decimal("0.01"),
            rounding=ROUND_HALF_UP
        )

        return {
            "refund_amount": refund_amount,
            "commission": commission,
            "total_vat": total_vat,
            "refund_percentage": refund_percentage
        }
```

### Payment Provider Abstraction

```python
from abc import ABC, abstractmethod

class PaymentProvider(ABC):
    """Abstract payment provider interface"""

    @abstractmethod
    async def send_payment(
        self,
        amount: Decimal,
        currency: str,
        recipient: dict
    ) -> str:
        """Send payment, return transaction ID"""
        pass

    @abstractmethod
    async def check_status(self, transaction_id: str) -> str:
        """Check payment status (pending/completed/failed)"""
        pass

# Implementations for different providers
class RevolutProvider(PaymentProvider):
    """Revolut Business API"""
    # https://developer.revolut.com/docs/business/payments

class WiseProvider(PaymentProvider):
    """Wise Platform API"""
    # https://docs.wise.com/api-docs/api-reference/transfer

class SEPAProvider(PaymentProvider):
    """Direct SEPA transfer via bank"""
    # Generate SEPA XML, submit via EBICS or bank API
```

### Payment Processing Flow

```python
@celery_app.task(bind=True, max_retries=3)
async def process_payment(self, refund_id: str):
    """Process refund payment with retry logic"""

    refund = db.query(Refund).filter_by(id=refund_id).first()

    try:
        refund.status = "payment_processing"
        db.commit()

        provider = get_payment_provider(refund.payment_method)

        transaction_id = await provider.send_payment(
            amount=refund.refund_amount,
            currency="EUR",
            recipient=refund.payment_details
        )

        refund.payment_provider_id = transaction_id
        refund.payment_sent_at = datetime.utcnow()
        refund.status = "paid"
        refund.paid_at = datetime.utcnow()
        db.commit()

        await notify_tourist(refund.bve.traveler_email, "payment_sent", {...})

    except Exception as e:
        refund.status = "payment_failed"
        db.commit()

        if self.request.retries < 3:
            raise self.retry(exc=e, countdown=3600)  # Retry in 1 hour
        else:
            await alert_ops_team({"refund_id": refund_id, "error": str(e)})
```

### Tourist Payment Collection

**Supported Methods:**
1. **SEPA Bank Transfer** - IBAN + BIC (EU standard)
2. **Revolut** - Revolut tag (e.g., @username) or email
3. **Wise** - Email address
4. **Future:** PayPal, crypto, mobile wallets

**Validation:**
- IBAN: Validate format and checksum
- Email: Validate format
- Revolut tag: Validate format (@username)

---

## Frontend Architecture

### Site Structure

**Separate subdomains for different audiences:**

1. **detaxe.com** - Tourist portal (B2C)
2. **retailer.detaxe.com** - Retailer portal (B2B)
3. **admin.detaxe.com** - Operations dashboard (Internal)

### Technology Stack

- **Framework:** Next.js 14+ (App Router, React Server Components)
- **UI Library:** shadcn/ui + Tailwind CSS
- **Forms:** React Hook Form + Zod validation
- **API Client:** TanStack Query (React Query)
- **i18n:** next-intl (English, French, Chinese)
- **Deployment:** Vercel

### 1. detaxe.com (Tourist Portal)

**Key Pages:**
```
/                           → Marketing homepage
/track                      → Quick BVE lookup
/track/{bveNumber}          → Refund status tracker
/refund/{id}/payment        → Submit payment details
/how-it-works               → Explainer
/faq                        → FAQ
/for-retailers              → Redirect to retailer.detaxe.com
```

**Key Features:**
- No login required for tracking (just BVE number)
- Real-time status updates (WebSocket or polling)
- Multi-language support (EN, FR, ZH)
- Mobile-optimized (most tourists use phones)
- Email/SMS notifications

**Example: Refund Tracker**
```typescript
// Simple status checker - no login
export default function TrackRefund({ params }) {
  const { data: refund } = useQuery({
    queryKey: ['refund', params.bveNumber],
    queryFn: () => fetch(`/api/refunds/track/${params.bveNumber}`).then(r => r.json()),
    refetchInterval: 30000  // Poll every 30s
  });

  return (
    <div>
      <h1>Track Your Refund</h1>
      <RefundStatusStepper status={refund.status} />
      <p>Amount: €{refund.refundAmount}</p>
      {refund.status === 'pending_payment_info' && (
        <Button href={`/refund/${refund.id}/payment`}>
          Submit Payment Details
        </Button>
      )}
    </div>
  );
}
```

### 2. retailer.detaxe.com (Retailer Portal)

**Key Pages:**
```
/sign-in                    → Clerk sign-in (pre-built)
/sign-up                    → Clerk sign-up (pre-built)
/select-org                 → Select retailer/store (Clerk org switcher)
/dashboard                  → Overview (today's BVEs, stats)
/bve/create                 → Create tax-free form
/bve/{id}                   → View/print BVE
/bve/list                   → All BVEs (searchable table)
/stores                     → Manage locations
/analytics                  → Reports, insights
/settings                   → Account + org settings (Clerk components)
```

**Key Features:**
- Secure authentication via Clerk (pre-built UI)
- Organization switching (for users with multiple stores)
- Fast BVE creation (< 60 seconds)
- Print-optimized BVE forms (PDF-ready)
- Real-time dashboard updates
- Analytics (revenue, refund rates, tourist demographics)

**Clerk Integration Example:**
```typescript
// app/layout.tsx
import { ClerkProvider } from '@clerk/nextjs'

export default function RootLayout({ children }) {
  return (
    <ClerkProvider>
      <html><body>{children}</body></html>
    </ClerkProvider>
  )
}

// app/sign-in/[[...sign-in]]/page.tsx
import { SignIn } from '@clerk/nextjs'

export default function SignInPage() {
  return <SignIn afterSignInUrl="/dashboard" />
}

// app/dashboard/page.tsx
import { auth, currentUser } from '@clerk/nextjs/server'
import { redirect } from 'next/navigation'

export default async function Dashboard() {
  const { userId, orgId } = await auth()

  if (!userId) redirect('/sign-in')
  if (!orgId) redirect('/select-org')  // Must select a retailer

  const retailer = await getRetailerByClerkOrg(orgId)
  const todaysBVEs = await getBVEsForRetailer(retailer.id)

  return <DashboardView retailer={retailer} bves={todaysBVEs} />
}
```

**Example: Create BVE**
```typescript
export default function CreateBVE() {
  const { register, handleSubmit, formState: { errors } } = useForm({
    resolver: zodResolver(bveSchema)
  });

  const createBVE = useMutation({
    mutationFn: async (data) => {
      const res = await fetch('/api/bve/create', {
        method: 'POST',
        body: JSON.stringify(data)
      });
      return res.json();
    },
    onSuccess: (data) => {
      router.push(`/bve/${data.bve_id}?print=true`);
    }
  });

  return (
    <form onSubmit={handleSubmit(createBVE.mutate)}>
      <section>
        <h2>Traveler Information</h2>
        <Input label="Passport" {...register('traveler.passport')} />
        {/* ... more fields */}
      </section>

      <section>
        <h2>Items Purchased</h2>
        <MerchandiseList />  {/* Dynamic array of items */}
      </section>

      <div>
        <p>Total VAT: €{totalVAT}</p>
        <p>Estimated Refund (85%): €{totalVAT * 0.85}</p>
      </div>

      <Button type="submit">Create Tax-Free Form</Button>
    </form>
  );
}
```

### 3. admin.detaxe.com (Operations Dashboard)

**Key Features:**
- Real-time activity feed (all BVE creation, payments, errors)
- Error queue (failed BVEs needing manual review)
- Payment retry interface
- PABLO message log (full audit trail)
- Customer support interface (chat with tourists/retailers)
- System health monitoring

**Example: Error Queue**
```typescript
export default function ErrorQueue() {
  const { data: errors } = useQuery({
    queryKey: ['errors'],
    queryFn: () => fetch('/api/admin/errors').then(r => r.json()),
    refetchInterval: 10000
  });

  return (
    <div>
      <h2>BVEs Needing Attention ({errors.length})</h2>
      {errors.map(error => (
        <div key={error.id}>
          <p>BVE: {error.bveNumber}</p>
          <p>Error: {error.errorCode} - {error.errorMessage}</p>
          <Button onClick={() => retryBVE(error.id)}>Retry</Button>
        </div>
      ))}
    </div>
  );
}
```

### Internationalization (i18n)

**Strategy:**
- **Internal code/DB:** English (clean, international)
- **PABLO API:** French (via Pydantic aliases - automatic)
- **UI:** Multi-language (next-intl)

**Supported Languages (v1):**
- English (default)
- French (required for French retailers)
- Chinese (Simplified) - largest tourist demographic

**Implementation:**
```typescript
// translations/en.json
{
  "refund.status": "Refund Status",
  "refund.amount": "Refund Amount",
  "refund.pending": "Pending customs clearance"
}

// translations/fr.json
{
  "refund.status": "Statut du Remboursement",
  "refund.amount": "Montant du Remboursement",
  "refund.pending": "En attente de validation douanière"
}

// Usage
import { useTranslations } from 'next-intl';

export default function RefundStatus() {
  const t = useTranslations('refund');
  return <h1>{t('status')}</h1>;  // "Refund Status" or "Statut du Remboursement"
}
```

---

## Error Handling & Resilience

### Error Categories

1. **Global Errors (G001, G002)** - Reject entire message, PABLO system issues
2. **Functional Errors (R_EC_C03)** - BVE-specific validation failures
3. **Network Errors** - Timeouts, connection failures
4. **Payment Errors** - Payment provider failures

### Retry Strategy

```python
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(
    stop=stop_after_attempt(5),
    wait=wait_exponential(multiplier=1, min=4, max=60),
    retry=retry_if_exception_type((TimeoutError, PabloSystemError))
)
async def send_to_pablo(message: dict):
    """Send message with automatic retry on transient failures"""
    # HTTP call to GUN platform
```

**Rules:**
- ✅ Retry transient errors (network, G002, timeout)
- ❌ Don't retry permanent errors (G001, schema validation)
- ✅ Exponential backoff (4s, 8s, 16s, 32s, 60s)
- ✅ Max 5 retries, then dead letter queue
- ✅ Alert ops team after max retries

### Idempotency

**Critical for compliance:** PABLO may send duplicate messages (e.g., clearance list if ACK not received).

```python
async def process_clearance(clearance_message: dict):
    """Process R_E_A01 - must be idempotent"""

    message_id = clearance_message["message_id"]

    # Check if already processed (Redis cache, TTL 7 days)
    if await redis.exists(f"clearance_processed:{message_id}"):
        logger.info(f"Duplicate clearance {message_id}, skipping")
        return

    # Process BVEs
    for bve_data in clearance_message["bve_list"]:
        await update_bve_status(bve_data)

    # Mark as processed
    await redis.setex(f"clearance_processed:{message_id}", 604800, "1")

    # Send ACK
    await send_ack(A_AR_A02(message_id=message_id))
```

### Dead Letter Queue

Messages that fail after max retries go to DLQ for manual review:

```python
@celery_app.task(bind=True)
def send_bve_creation(self, bve_id: str):
    try:
        # ... send to PABLO
    except ValueError as e:
        # Schema error - don't retry
        logger.error(f"Schema error for BVE {bve_id}: {e}")
        raise Reject(e, requeue=False)  # → Dead letter queue
    except (TimeoutError, PabloSystemError):
        # Transient error - retry
        raise
```

### Monitoring & Alerts

**Logging (Loguru):**
```python
logger.add(
    "logs/pablo_{time}.log",
    rotation="100 MB",
    retention="1 year",  # Compliance requirement
    level="INFO"
)

logger.info(f"BVE {bve_number} sent to PABLO")
logger.error(f"BVE {bve_number} rejected: {error_code}")
```

**Error Tracking (Sentry):**
```python
import sentry_sdk

sentry_sdk.init(
    dsn="your-sentry-dsn",
    environment="production",
    traces_sample_rate=0.1
)

# Automatic error capture
# Manual events
sentry_sdk.capture_message(f"Payment failed: {refund_id}", level="error")
```

**Alerts:**
- Critical: Payment failures, PABLO connection down
- Warning: High error rate, slow response times
- Info: Daily summary, weekly reports

---

## Security & Compliance

### Authentication & Authorization

**Auth Provider: Clerk**

We use Clerk as our managed authentication provider. This handles:
- User authentication (email/password, OAuth)
- Session management (JWT tokens, refresh)
- Multi-factor authentication (TOTP, SMS)
- Organization management (retailers = organizations)
- Pre-built UI components
- Rate limiting on auth endpoints
- GDPR compliance tools

**Why Clerk:**
- Excellent Next.js integration
- Organizations feature maps perfectly to retailers (1 retailer = 1 org)
- Free tier: 10k MAU (sufficient for MVP)
- Removes ~30% of security implementation burden

**Retailer Portal (retailer.detaxe.com):**
```typescript
// Clerk middleware protects all /retailer routes
import { clerkMiddleware, createRouteMatcher } from '@clerk/nextjs/server'

const isProtectedRoute = createRouteMatcher(['/dashboard(.*)', '/bve(.*)'])

export default clerkMiddleware(async (auth, req) => {
  if (isProtectedRoute(req)) await auth.protect()
})
```

**Organization → Retailer Mapping:**
```typescript
// Each Clerk organization = one retailer in our database
// orgId from Clerk = retailer_id in PostgreSQL

import { auth } from '@clerk/nextjs/server'

export async function getRetailerForUser() {
  const { orgId } = await auth()
  if (!orgId) throw new Error('No retailer selected')

  // orgId is stored as external_auth_id in retailers table
  return db.query(Retailer).filter_by(external_auth_id=orgId).first()
}
```

**Role Management:**
- Clerk handles roles within organizations (owner, admin, member)
- Map to our permissions: owner=full access, admin=manage BVEs, member=view only

**Admin Dashboard (admin.detaxe.com):**
- Separate Clerk application (or use metadata to flag admin users)
- Additional IP whitelisting via Cloudflare Access (optional)
- Audit log of all admin actions

**Backend API Authentication:**
```python
# FastAPI - verify Clerk JWT tokens
from clerk_backend_api import Clerk

clerk = Clerk(bearer_auth=os.environ["CLERK_SECRET_KEY"])

async def get_current_user(authorization: str = Header(...)):
    """Verify Clerk JWT and extract user/org info"""
    token = authorization.replace("Bearer ", "")

    # Verify with Clerk
    session = clerk.sessions.verify(token)

    return {
        "user_id": session.user_id,
        "org_id": session.org_id,  # Maps to retailer_id
    }
```

**API Keys (for programmatic access):**
- For retailers who want API integration (POS systems)
- Generate API keys stored in database (hashed)
- Rate limiting via Redis

**Clerk Webhooks (User/Org Sync):**
```python
# Sync Clerk events to our database
# POST /api/webhooks/clerk

from svix.webhooks import Webhook

@app.post("/api/webhooks/clerk")
async def clerk_webhook(request: Request):
    payload = await request.body()
    headers = request.headers

    # Verify webhook signature
    wh = Webhook(os.environ["CLERK_WEBHOOK_SECRET"])
    event = wh.verify(payload, headers)

    match event["type"]:
        case "user.created" | "user.updated":
            await sync_user(event["data"])
        case "organization.created":
            await create_retailer_for_org(event["data"])
        case "organizationMembership.created":
            await add_user_to_retailer(event["data"])

async def sync_user(data: dict):
    """Sync Clerk user to our users table"""
    await db.execute(
        insert(User)
        .values(
            clerk_user_id=data["id"],
            email=data["email_addresses"][0]["email_address"],
            first_name=data.get("first_name"),
            last_name=data.get("last_name"),
        )
        .on_conflict_do_update(
            index_elements=["clerk_user_id"],
            set_={"email": data["email_addresses"][0]["email_address"]}
        )
    )
```

### Data Protection

**GDPR Compliance:**
- Tourist data retention: 7 years (French tax law)
- Right to access: API endpoint for data export
- Right to erasure: Anonymize after retention period
- Privacy policy and consent

**PCI-DSS (if handling card data):**
- Never store full card numbers
- Use payment providers' tokenization
- PCI-DSS SAQ (Self-Assessment Questionnaire)

**Encryption:**
- In transit: TLS 1.3 (HTTPS)
- At rest: PostgreSQL encryption, encrypted backups
- Sensitive fields: Payment details encrypted (Fernet or AES-256)

### PABLO Certification

**Requirements:**
1. GUN platform connection (SSO, API credentials)
2. Certification test scenarios (provided by DGDDI)
3. Attestation on honor (test execution report)
4. Audit by Service Régional d'Audit (SRA)
5. Final approval by Direction Générale

**Timeline:** 6-12 months
**Strategy:** Start certification in parallel with development

### Audit Trail

**All operations logged:**
- BVE creation, modification, deletion
- PABLO messages (sent/received)
- Refund calculations and payments
- User actions (admin operations)

**Storage:** PostgreSQL (pablo_messages table) + file logs (Loguru)
**Retention:** 7 years (compliance requirement)

---

## Deployment & DevOps

### Infrastructure

**Production Environment:**
```
Frontend:
- detaxe.com → Vercel (Next.js)
- retailer.detaxe.com → Vercel
- admin.detaxe.com → Vercel

Backend:
- API (FastAPI) → Render.com or Railway
- Celery workers → Render.com background workers
- Redis → Render.com Redis or Upstash
- PostgreSQL → Render.com PostgreSQL or Supabase

CDN/Security:
- Cloudflare (DDoS protection, caching, WAF)

Monitoring:
- Sentry (error tracking)
- Prometheus + Grafana (metrics)
- Uptime monitoring (Pingdom or UptimeRobot)
```

**Staging Environment:**
- Identical to production
- Connected to PABLO test environment

### CI/CD Pipeline (GitHub Actions)

```yaml
name: Deploy Backend

on:
  push:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-python@v4
        with:
          python-version: '3.12'
      - run: pip install -r requirements.txt
      - run: pytest tests/
      - run: mypy src/

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to Render
        run: curl -X POST ${{ secrets.RENDER_DEPLOY_HOOK }}
```

### Database Migrations

**Alembic (SQLAlchemy migrations):**
```bash
# Create migration
alembic revision --autogenerate -m "Add refunds table"

# Apply migration
alembic upgrade head

# Rollback
alembic downgrade -1
```

**Strategy:**
- Never destructive migrations in production
- Blue-green deployments for schema changes
- Backup before every migration

### Monitoring & Observability

**Metrics to Track:**
- BVE creation rate (per hour/day)
- PABLO message success rate
- Payment success rate
- API response times
- Error rates by type
- Refund processing time (creation → payment)

**Dashboards:**
- Business metrics (Grafana)
- Technical metrics (Prometheus)
- Error tracking (Sentry)
- Logs (Loguru → Grafana Loki or Papertrail)

### Backup & Disaster Recovery

**Database Backups:**
- Automated daily backups (PostgreSQL)
- Point-in-time recovery (PITR)
- Retention: 30 days

**Code:**
- Git repository (GitHub)
- Tagged releases

**Recovery Time Objective (RTO):** < 4 hours
**Recovery Point Objective (RPO):** < 1 hour

---

## Implementation Roadmap

### Phase 1: MVP (Months 1-3)

**Goal:** Launch with first 5-10 Paris luxury retailers

**Sprint 1 (Weeks 1-2): Foundation**
- [ ] Database schema (PostgreSQL)
- [ ] API foundation (FastAPI project structure)
- [ ] Authentication (JWT)
- [ ] Basic CRUD endpoints

**Sprint 2 (Weeks 3-4): PABLO Integration**
- [ ] Pydantic models for all PABLO messages
- [ ] GUN client (HTTP client with auth)
- [ ] Message queue (Celery + Redis)
- [ ] A_E_C01 (Create BVE) flow
- [ ] R_AR_C02 / R_EC_C03 handling

**Sprint 3 (Weeks 5-6): Retailer Portal**
- [ ] Next.js project setup
- [ ] Login page
- [ ] BVE creation form
- [ ] BVE list page
- [ ] Print-optimized BVE view

**Sprint 4 (Weeks 7-8): Refund Processing**
- [ ] R_E_A01 (Clearance) handling
- [ ] Refund calculation
- [ ] Payment provider integration (SEPA first)
- [ ] Payment queue

**Sprint 5 (Weeks 9-10): Tourist Portal**
- [ ] Refund tracker (no login)
- [ ] Payment details collection
- [ ] Email/SMS notifications
- [ ] Multi-language support (EN, FR)

**Sprint 6 (Weeks 11-12): Polish & Launch**
- [ ] Error handling improvements
- [ ] Admin dashboard (basic)
- [ ] Testing (unit + integration)
- [ ] Documentation
- [ ] Staging deployment
- [ ] Onboard first 5 retailers

### Phase 2: Scale (Months 4-6)

**Goal:** 20-30 retailers, refine product based on feedback

- [ ] A_E_S01 (Delete BVE) support
- [ ] A_E_P01 (Backup BVE) support
- [ ] Revolut payment integration
- [ ] Wise payment integration
- [ ] Advanced analytics for retailers
- [ ] Mobile app (React Native) for tourists
- [ ] Referral system
- [ ] Chinese language support

### Phase 3: Expand (Months 7-12)

**Goal:** Geographic expansion, additional features

- [ ] A_E_U01 (EU Visa) support
- [ ] R_E_IS (Live status) integration
- [ ] Instant refunds (advance money to tourists)
- [ ] API for third-party integrations
- [ ] POS system integrations (Square, Lightspeed)
- [ ] Expand to Nice, Lyon, Bordeaux

### Phase 4: Optimize (Year 2+)

**Goal:** Automation, efficiency, profitability

- [ ] ML-based fraud detection
- [ ] Automated customer support (chatbot)
- [ ] Dynamic pricing based on volume
- [ ] Multi-country support (other EU countries)
- [ ] White-label solution for other operators

---

## Success Metrics

### Business Metrics

**Retailer Acquisition:**
- Target: 20-30 luxury retailers by Month 6
- CAC (Customer Acquisition Cost): < €500
- Retailer retention rate: > 90%

**Tourist Experience:**
- Refund rate: 85-90% (vs 80% competitors)
- Time to payment: < 7 days (vs 14-30 days industry average)
- NPS (Net Promoter Score): > 50

**Financial:**
- GMV (Gross Merchandise Value): €1M by Month 6
- Revenue (commission): €100-150k by Month 6
- Gross margin: > 60% (after payment processing fees)

### Technical Metrics

**Reliability:**
- API uptime: > 99.5%
- PABLO message success rate: > 98%
- Payment success rate: > 95%

**Performance:**
- API response time: p95 < 500ms
- BVE creation time: < 60 seconds
- Refund processing time: < 24 hours after clearance

**Quality:**
- Test coverage: > 80%
- Zero critical security vulnerabilities
- PABLO certification: Pass all test scenarios

---

## Appendices

### A. PABLO Message Reference

See: `Pablo_Specifications_EDI_Operateurs_V5.md`

**Key Message Types:**
- A_E_C01: Create BVE
- A_E_P01: Create BVE (backup)
- A_E_S01: Delete BVE
- A_E_U01: EU Visa
- R_AR_C02: Success ACK
- R_EC_C03: Error ACK
- R_E_A01: Clearance list

### B. Payment Provider APIs

**Revolut Business:**
- Docs: https://developer.revolut.com/docs/business/payments
- API: REST, OAuth 2.0
- Fees: ~0.3% for SEPA

**Wise Platform:**
- Docs: https://docs.wise.com/api-docs/api-reference/transfer
- API: REST, API key
- Fees: ~0.5% for SEPA

**SEPA Direct:**
- Standard: ISO 20022 XML
- Via bank API or EBICS protocol

### C. Regulatory References

**PABLO:**
- Official specs: `Pablo_Specifications_EDI_Operateurs_V5.md`
- Operator certification: Contact DGDDI

**VAT Refund:**
- EU Directive 2008/9/EC
- French tax code

**Data Protection:**
- GDPR: Regulation (EU) 2016/679
- French data protection authority: CNIL

### D. Technology Documentation

**Backend:**
- FastAPI: https://fastapi.tiangolo.com
- SQLAlchemy: https://docs.sqlalchemy.org
- Pydantic: https://docs.pydantic.dev
- Celery: https://docs.celeryq.dev

**Frontend:**
- Next.js: https://nextjs.org/docs
- shadcn/ui: https://ui.shadcn.com
- TanStack Query: https://tanstack.com/query

---

## Document History

| Version | Date | Changes | Author |
|---------|------|---------|--------|
| 1.0 | 2025-12-18 | Initial design document | Team Detaxe |
| 1.1 | 2026-01-02 | Added Clerk for authentication, updated DB schema | Team Detaxe |

---

**End of Document**
