# Detaxe Platform - Audit Preparation Guide

**Version:** 1.0
**Date:** 2026-01-16
**Purpose:** Comprehensive preparation for DGDDI certification and SRA audit

---

## Table of Contents

1. [Compliance Matrix](#1-compliance-matrix)
2. [Certification Test Scenarios](#2-certification-test-scenarios)
3. [Documentation Standards](#3-documentation-standards)
4. [Audit Checklist](#4-audit-checklist)

---

## 1. Compliance Matrix

### 1.1 Message Types Compliance

| Message | Description | PABLO Spec | Implementation Status | Code Reference | Test Coverage | Notes |
|---------|-------------|------------|----------------------|----------------|---------------|-------|
| **A_E_C01** | BVE Creation | §PROCESSUS 'CRÉATION BVE' | 🟡 Designed | `src/pablo/messages/a_e_c01.py` | ⬜ Pending | MVP Priority |
| **A_E_P01** | BVE Creation (Backup) | §PROCESSUS 'CRÉATION BVE DE SECOURS' | 🔴 Not Started | - | ⬜ Pending | **REQUIRED for certification** |
| **A_E_S01** | BVE Deletion | §PROCESSUS 'SUPPRESSION LISTE DE BVE' | 🟡 Designed | `src/pablo/messages/a_e_s01.py` | ⬜ Pending | Phase 2 |
| **A_E_U01** | EU Visa (≥€50k) | §PROCESSUS 'VISA UE LISTE DE BVE' | 🔴 Not Started | - | ⬜ Pending | Phase 3 |
| **A_AR_A02** | Clearance ACK (Success) | §PROCESSUS 'APUREMENT LISTE BVE' | 🟡 Designed | `src/pablo/messages/a_ar_a02.py` | ⬜ Pending | MVP Priority |
| **A_EC_A03** | Clearance ACK (Failure) | §PROCESSUS 'APUREMENT LISTE BVE' | 🟡 Designed | `src/pablo/messages/a_ec_a03.py` | ⬜ Pending | MVP Priority |
| **R_AR_C02** | BVE Created ACK | §PROCESSUS 'CRÉATION BVE' | 🟡 Designed | `src/pablo/handlers/r_ar_c02.py` | ⬜ Pending | MVP Priority |
| **R_EC_C03** | BVE Creation Error | §PROCESSUS 'CRÉATION BVE' | 🟡 Designed | `src/pablo/handlers/r_ec_c03.py` | ⬜ Pending | MVP Priority |
| **R_AR_S02** | BVE Deleted ACK | §PROCESSUS 'SUPPRESSION LISTE DE BVE' | 🔴 Not Started | - | ⬜ Pending | Phase 2 |
| **R_EC_S03** | BVE Deletion Error | §PROCESSUS 'SUPPRESSION LISTE DE BVE' | 🔴 Not Started | - | ⬜ Pending | Phase 2 |
| **R_E_A01** | Clearance List | §PROCESSUS 'APUREMENT LISTE BVE' | 🟡 Designed | `src/pablo/handlers/r_e_a01.py` | ⬜ Pending | MVP Priority |
| **R_AR_U02** | EU Visa ACK | §PROCESSUS 'VISA UE LISTE DE BVE' | 🔴 Not Started | - | ⬜ Pending | Phase 3 |
| **R_EC_U03** | EU Visa Error | §PROCESSUS 'VISA UE LISTE DE BVE' | 🔴 Not Started | - | ⬜ Pending | Phase 3 |
| **R_E_IS** | Live Status Updates | §PROCESSUS 'INFORMATION STATUTS BVE' | 🔴 Not Started | - | ⬜ Pending | Optional (on request) |

**Legend:** 🟢 Complete | 🟡 Designed/In Progress | 🔴 Not Started | ⬜ Not Tested | ✅ Tested

---

### 1.2 Technical Requirements Compliance

| Requirement | PABLO Spec Reference | Status | Implementation | Evidence Required |
|-------------|---------------------|--------|----------------|-------------------|
| **GUN Platform Connection** | §LES ACTEURS - Gun | 🔴 | - | SSO certificate, API credentials |
| **REST API (HTTPS POST)** | §PRINCIPES DES ÉCHANGES | 🟡 | FastAPI endpoints | API documentation |
| **JSON Format (UTF-8)** | §ENCODAGE DES FICHIERS JSON | 🟡 | Pydantic models | Schema validation tests |
| **JSD Schema Validation** | §DÉFINITION DES SCHÉMAS JSON | 🔴 | - | Validation test results |
| **Asynchronous Processing** | §PRINCIPES DES ÉCHANGES | 🟡 | Celery + Redis | Architecture diagram |
| **Webhook Endpoint** | §PRINCIPES DES ÉCHANGES | 🟡 | `/api/webhooks/pablo` | Endpoint documentation |
| **Message Idempotency** | §MESSAGE D'APUREMENT | 🟡 | Redis dedup | Test evidence |
| **Audit Trail** | Implicit requirement | 🟡 | `pablo_messages` table | DB schema + sample logs |
| **7-Year Log Retention** | Compliance requirement | 🔴 | - | Retention policy document |

---

### 1.3 Data Validation Compliance

| Field | Validation Rule | PABLO Spec | Status | Implementation |
|-------|-----------------|------------|--------|----------------|
| **identifiant_detaxe** | 20 digits exactly | JSD | 🟡 | Pydantic validator |
| **date_emission** | ISO 8601 with timezone | JSD | 🟡 | Pydantic datetime |
| **passeport** | Non-empty string | JSD | 🟡 | Pydantic validator |
| **date_expiration_passeport** | DD/MM/YYYY format | JSD | 🟡 | Custom validator |
| **date_naissance** | DD/MM/YYYY format | JSD | 🟡 | Custom validator |
| **pays_residence** | 2-letter ISO code, non-EU | JSD + business rule | 🔴 | Need eligible countries CSV |
| **nationalite** | 2-letter ISO code | JSD | 🔴 | Need eligible nationalities CSV |
| **montant_total_ttc** | ≥ €100.01 | Business rule | 🔴 | **Critical - add validation** |
| **montant_tva** | Positive decimal | JSD | 🟡 | Pydantic validator |
| **taux_tva** | Valid French VAT rate | Business rule | 🔴 | Need rate validation |
| **code_produit** | Valid product code | Business rule | 🔴 | Need product codes CSV |

---

### 1.4 Business Process Compliance

| Process | PABLO Requirement | Status | Implementation | Gap |
|---------|-------------------|--------|----------------|-----|
| **Immediate BVE Transmission** | "transmettre sans délai" | 🟡 | Celery task queue | Need SLA monitoring |
| **Mandatory Retry on R_EC_C03** | "devra être renvoyé après correction" | 🟡 | Retry logic designed | Need auto-retry mechanism |
| **Daily Clearance Processing** | "transmis quotidiennement...J+1" | 🟡 | Cron job planned | Need scheduling |
| **Immediate ACK on R_E_A01** | "répondre sans délai" | 🟡 | Webhook handler | Need performance test |
| **Backup BVE Procedure** | A_E_P01 for system downtime | 🔴 | Not implemented | **Required for cert** |
| **€50k+ EU Visa** | A_E_U01 for high-value | 🔴 | Not implemented | Phase 3 |
| **Live Status (Optional)** | R_E_IS every 5 minutes | 🔴 | Not implemented | Optional feature |

---

### 1.5 Security & Compliance Matrix

| Requirement | Regulation | Status | Evidence |
|-------------|------------|--------|----------|
| **GDPR Compliance** | EU 2016/679 | 🟡 | Privacy policy draft |
| **Data Retention (7 years)** | French tax law | 🔴 | Need retention policy |
| **Passport Data Protection** | GDPR Art. 9 | 🔴 | Need encryption spec |
| **Audit Logging** | DGDDI requirement | 🟡 | `pablo_messages` table |
| **Access Control** | Best practice | 🟡 | Clerk authentication |
| **TLS 1.3** | GUN requirement | 🟡 | Cloudflare config |
| **Certificate Authentication** | GUN SSO | 🔴 | Need certificate |

---

## 2. Certification Test Scenarios

The DGDDI provides a "cahier de tests" (test book) with scenarios to execute. Below are the expected test categories based on the PABLO specification.

### 2.1 BVE Creation Scenarios (A_E_C01)

#### TC-C01: Normal BVE Creation
```
Scenario: Create a valid BVE with all required fields
Given: A tourist with valid passport from eligible country
And: Purchase total ≥ €100.01 TTC
When: Retailer submits BVE via A_E_C01
Then: Receive R_AR_C02 with BVE number
And: BVE status = "created" in database
And: Full message logged in pablo_messages
```

**Test Data:**
```json
{
  "creation_bve": {
    "identifiant_detaxe": "12345678901234567890",
    "date_emission": "2026-01-16T10:00:00.000+01:00",
    "voyageur": {
      "passeport": "AB1234567",
      "date_expiration_passeport": "15/06/2030",
      "nom_voyageur": "SMITH",
      "prenom_voyageur": "John",
      "date_naissance": "15/03/1985",
      "adresse": "123 Main St, New York, NY 10001",
      "pays_residence": "US",
      "nationalite": "US"
    },
    "schema_commercial": {
      "type_schema": 1,
      "detail_schema": {
        "vendeurs_md": {
          "vendeur_detaxe": {
            "identifiant_vendeur": "12345678901234",
            "nom_vendeur": "Boutique Paris"
          },
          "numero_ticket": "TKT-2026-001",
          "date_recu": "2026-01-16T09:30:00.000+01:00",
          "marchandises": [
            {
              "description": "Sac à main cuir",
              "type": "Maroquinerie",
              "marque": "Louis Vuitton",
              "numero_identification": "LV-123456",
              "couleur": "Noir",
              "code_produit": 42022100,
              "quantite": 1,
              "taux_tva": 20.00,
              "montant_ttc": 1500.00,
              "montant_tva": 250.00
            }
          ]
        }
      }
    },
    "transaction": {
      "montant_remboursement": 212.50,
      "montant_total_tva": 250.00,
      "montant_total_ttc": 1500.00,
      "mode_paiement": 1,
      "detail_paiement": "CB VISA",
      "mode_remboursement": 1,
      "detail_remboursement": "SEPA"
    }
  }
}
```

---

#### TC-C02: BVE Creation with Multiple Items
```
Scenario: Create BVE with 5+ merchandise items
Given: Tourist with multiple purchases from same retailer
When: Submit A_E_C01 with array of marchandises
Then: All items included in created BVE
And: Total amounts correctly summed
```

---

#### TC-C03: BVE Creation - Invalid Passport Country (Rejection)
```
Scenario: Reject BVE for EU resident
Given: Tourist with passport from EU country (e.g., "DE")
When: Retailer submits A_E_C01
Then: Receive R_EC_C03 with error code
And: BVE NOT created in database
And: Error logged for manual review
```

**Expected Error:** Country not eligible for détaxe

---

#### TC-C04: BVE Creation - Below Minimum Amount (Rejection)
```
Scenario: Reject BVE below €100.01 threshold
Given: Purchase total = €99.99 TTC
When: Retailer submits A_E_C01
Then: Receive R_EC_C03 with error code
And: Error message indicates minimum threshold
```

---

#### TC-C05: BVE Creation - Invalid JSON Schema (G001)
```
Scenario: Global error for malformed JSON
Given: A_E_C01 with missing required field (e.g., no "voyageur")
When: Message sent to PABLO
Then: Receive G001 global error
And: Entire message rejected (not processed)
```

---

#### TC-C06: BVE Creation - Duplicate BVE Number
```
Scenario: Reject duplicate identifiant_detaxe
Given: BVE "12345678901234567890" already exists in PABLO
When: Retailer submits A_E_C01 with same identifiant_detaxe
Then: Receive R_EC_C03 with duplicate error code
```

---

#### TC-C07: BVE Creation - Expired Passport
```
Scenario: Reject BVE with expired passport
Given: date_expiration_passeport in the past
When: Retailer submits A_E_C01
Then: Receive R_EC_C03 with passport error
```

---

### 2.2 Backup BVE Scenarios (A_E_P01)

#### TC-P01: Backup BVE Creation
```
Scenario: Create BVE from paper attestation (system downtime recovery)
Given: Attestation number retrieved from Pablo-Opérateurs during outage
And: Paper form completed with tourist
When: System recovers, submit A_E_P01 with attestation data
Then: Receive R_AR_P02 confirmation
And: BVE linked to original attestation number
```

**Critical:** This scenario MUST be implemented and tested before certification.

---

### 2.3 BVE Deletion Scenarios (A_E_S01)

#### TC-S01: Normal BVE Deletion
```
Scenario: Delete BVE due to data error (before visa)
Given: BVE exists in PABLO with status "created"
And: BVE has NOT been visaed/confirmed
When: Operator sends A_E_S01 with BVE number
Then: Receive R_AR_S02 confirmation
And: BVE status = "deleted" in PABLO
```

---

#### TC-S02: Delete Non-Existent BVE (Rejection)
```
Scenario: Attempt to delete BVE that doesn't exist
Given: BVE number "99999999999999999999" not in PABLO
When: Operator sends A_E_S01
Then: Receive R_EC_S03 with "BVE not found" error
```

---

#### TC-S03: Delete Already Confirmed BVE (Rejection)
```
Scenario: Cannot delete BVE after customs confirmation
Given: BVE has status "confirmed" (already visaed)
When: Operator sends A_E_S01
Then: Receive R_EC_S03 with "cannot delete confirmed BVE" error
```

---

### 2.4 Clearance (Apurement) Scenarios

#### TC-A01: Process Clearance List (Success)
```
Scenario: Receive and acknowledge daily clearance
Given: PABLO sends R_E_A01 with 10 confirmed + 2 cancelled BVEs
When: Operator webhook receives message
Then: Update each BVE status in database
And: Trigger refund processing for confirmed BVEs
And: Send A_AR_A02 acknowledgment immediately
And: Log full message content
```

---

#### TC-A02: Idempotent Clearance Processing
```
Scenario: Handle duplicate clearance message
Given: R_E_A01 received and processed yesterday
And: Same message_id resent (ACK not received by PABLO)
When: Operator webhook receives duplicate
Then: Detect duplicate via Redis cache
And: Skip reprocessing (idempotent)
And: Send A_AR_A02 again
```

---

#### TC-A03: Partial Clearance Failure
```
Scenario: Some BVEs in clearance list fail validation
Given: R_E_A01 with 10 BVEs, 2 have invalid data
When: Processing clearance
Then: Process 8 valid BVEs successfully
And: Send A_AR_A02 for successful BVEs
And: Send A_EC_A03 for failed BVEs with error codes
```

---

### 2.5 EU Visa Scenarios (A_E_U01) - €50k+

#### TC-U01: EU Visa for High-Value BVE
```
Scenario: Submit BVE visaed in another EU country
Given: BVE with montant_total_ttc ≥ €50,000
And: Visaed by German customs (not French)
And: Within 6 months + current month
When: Operator sends A_E_U01 with EU visa details
Then: Receive R_AR_U02 confirmation
And: BVE status updated with EU visa info
```

---

#### TC-U02: EU Visa - BVE Too Old (Rejection)
```
Scenario: Reject EU visa beyond 6-month limit
Given: BVE created 8 months ago
When: Operator sends A_E_U01
Then: Receive R_EC_U03 with "deadline exceeded" error
```

---

### 2.6 Error Handling Scenarios

#### TC-E01: G001 Global Schema Error
```
Scenario: Handle malformed JSON structure
Given: Message with invalid JSON syntax
When: Sent to PABLO via GUN
Then: Receive G001 error response
And: No retry (permanent error)
And: Alert development team
```

---

#### TC-E02: G002 System Error
```
Scenario: Handle PABLO system unavailability
Given: PABLO system experiencing issues
When: Any message sent
Then: Receive G002 error response
And: Queue message for retry with exponential backoff
And: Max 5 retries over 1 hour
And: Move to dead letter queue if all retries fail
```

---

#### TC-E03: Network Timeout
```
Scenario: Handle GUN platform timeout
Given: GUN platform not responding within 30 seconds
When: Sending A_E_C01
Then: Timeout exception caught
And: Retry with exponential backoff
And: Log timeout event
```

---

### 2.7 Live Status Scenarios (R_E_IS) - Optional

#### TC-IS01: Receive Live Status Updates
```
Scenario: Process real-time status changes
Given: Operator has requested live status feature
When: PABLO sends R_E_IS every 5 minutes
Then: Update BVE statuses in near-real-time
And: No ACK required (informational only)
```

---

## 3. Documentation Standards

### 3.1 Required Documentation Structure

```
docs/
├── compliance/
│   ├── AUDIT_PREPARATION_GUIDE.md      # This document
│   ├── COMPLIANCE_MATRIX.xlsx          # Detailed Excel version
│   ├── TEST_EXECUTION_REPORT.md        # Attestation sur l'honneur
│   └── certificates/
│       ├── gun_sso_certificate.pem
│       └── api_credentials.json
│
├── technical/
│   ├── ARCHITECTURE.md                 # System architecture
│   ├── API_DOCUMENTATION.md            # OpenAPI/Swagger export
│   ├── DATABASE_SCHEMA.md              # ERD + table definitions
│   ├── MESSAGE_FLOWS.md                # Sequence diagrams
│   ├── SECURITY_ARCHITECTURE.md        # Auth, encryption, access control
│   └── DISASTER_RECOVERY.md            # Backup, restore, RTO/RPO
│
├── operational/
│   ├── INTERNAL_CONTROLS.md            # Written procedures
│   ├── STAFF_TRAINING.md               # Training records
│   ├── ESCALATION_PROCEDURES.md        # Error handling process
│   ├── RECONCILIATION_PROCESS.md       # BVE ↔ Payment matching
│   └── COMPLAINT_HANDLING.md           # Customer complaints process
│
├── data/
│   ├── eligible_countries.csv          # Non-EU countries list
│   ├── eligible_nationalities.csv      # Eligible nationalities
│   ├── product_codes.csv               # Valid product codes
│   ├── payment_modes.csv               # Payment method codes
│   └── reimbursement_modes.csv         # Refund method codes
│
└── legal/
    ├── PRIVACY_POLICY.md               # GDPR compliance
    ├── DATA_RETENTION_POLICY.md        # 7-year retention
    ├── TERMS_OF_SERVICE.md             # Retailer agreement
    └── AUDIT_TRAIL_POLICY.md           # Logging requirements
```

---

### 3.2 Test Execution Report (Attestation sur l'honneur)

This is the critical document submitted for certification. Use this template:

```markdown
# ATTESTATION SUR L'HONNEUR - Certification PABLO

**Opérateur:** Detaxe SAS
**SIREN:** [Your SIREN]
**Numéro TVA intracommunautaire:** FR[XX][SIREN]
**Date de certification:** [Date]
**Version logiciel:** v1.0.0
**Environnement de test:** https://staging.detaxe.com

---

## Déclaration

Je soussigné(e), [Nom du représentant légal], en qualité de [Titre],
atteste sur l'honneur avoir exécuté les scénarios de certification PABLO
conformément au cahier de tests fourni par la DGDDI.

---

## Résultats des Scénarios

| ID Scénario | Description | Exécuté | Résultat | Justification si non exécuté |
|-------------|-------------|---------|----------|------------------------------|
| TC-C01 | Création BVE normale | ✅ Oui | ✅ Succès | - |
| TC-C02 | Création BVE multi-articles | ✅ Oui | ✅ Succès | - |
| TC-C03 | Rejet pays UE | ✅ Oui | ✅ Succès | - |
| TC-C04 | Rejet montant insuffisant | ✅ Oui | ✅ Succès | - |
| TC-C05 | Erreur G001 | ✅ Oui | ✅ Succès | - |
| TC-P01 | BVE de secours | ✅ Oui | ✅ Succès | - |
| TC-S01 | Suppression BVE | ✅ Oui | ✅ Succès | - |
| TC-A01 | Apurement liste | ✅ Oui | ✅ Succès | - |
| TC-U01 | Visa UE ≥50k€ | ❌ Non | - | Fonctionnalité Phase 3, validation pré-envoi bloque les BVE <50k€ |

---

## Preuves d'Exécution

Chaque scénario exécuté est documenté avec:
- Capture d'écran de la requête envoyée
- Capture d'écran de la réponse reçue
- Log applicatif correspondant
- Timestamp d'exécution

Les preuves sont disponibles dans: `/docs/compliance/test_evidence/`

---

## Engagement

Je m'engage à ce que la version logicielle certifiée (v1.0.0) soit
identique à celle déployée en production.

Je reconnais qu'une attestation falsifiée peut entraîner la suppression
de l'agrément d'opérateur de détaxe conformément au décret n°2017-1825
du 28 décembre 2017.

Fait à [Ville], le [Date]

Signature: ________________________

[Nom du représentant légal]
[Titre]
```

---

### 3.3 How to Document Each Component

#### 3.3.1 Message Flow Documentation

For each PABLO message type, document:

```markdown
## Message A_E_C01 - Création BVE

### Purpose
Create a new BVE (Bordereau de Vente à l'Exportation) in the PABLO system.

### Trigger
- Retailer completes tax-free form in retailer portal
- Form passes all client-side validation
- User clicks "Submit" button

### Flow Diagram
```
[Retailer Portal] → [API Gateway] → [PABLO Service] → [Message Queue]
                                                            ↓
                                                      [GUN Platform]
                                                            ↓
                                                        [PABLO]
                                                            ↓
                                                    [R_AR_C02 or R_EC_C03]
                                                            ↓
                                                      [Webhook Handler]
                                                            ↓
                                                    [Update BVE Status]
```

### Request Schema
- File: `src/pablo/schemas/a_e_c01.json`
- Pydantic Model: `src/pablo/models/creation_bve.py`

### Response Handling
| Response | Action | Code Reference |
|----------|--------|----------------|
| R_AR_C02 | Mark BVE as "sent_to_pablo" | `handlers/r_ar_c02.py:45` |
| R_EC_C03 | Log error, notify retailer | `handlers/r_ec_c03.py:32` |
| G001 | Alert dev team, no retry | `handlers/global_error.py:15` |
| G002 | Retry with backoff | `handlers/global_error.py:28` |

### Audit Logging
All messages logged to `pablo_messages` table with:
- Full request payload
- Full response payload
- Timestamps
- Retry count
- Error codes (if any)

### Test Coverage
- Unit tests: `tests/unit/test_a_e_c01.py`
- Integration tests: `tests/integration/test_bve_creation.py`
- Certification scenarios: TC-C01 through TC-C07
```

---

#### 3.3.2 Internal Control Procedure Documentation

```markdown
## Procedure: BVE Error Resolution

### Document Control
- Version: 1.0
- Effective Date: 2026-01-XX
- Owner: Operations Manager
- Review Frequency: Annual

### Purpose
Define the process for handling BVE creation failures (R_EC_C03 responses).

### Scope
Applies to all R_EC_C03 errors received from PABLO.

### Roles & Responsibilities
| Role | Responsibility |
|------|----------------|
| System | Automatic retry for transient errors |
| Operations Team | Manual review of permanent errors |
| Retailer | Correct data and resubmit if requested |

### Procedure

#### Step 1: Error Classification
1. System receives R_EC_C03 from PABLO
2. Parse error code from response
3. Classify error:
   - **Transient** (G002, network): Auto-retry
   - **Data Error** (validation): Flag for manual review
   - **Permanent** (duplicate, invalid country): Do not retry

#### Step 2: Automatic Handling
```python
if error.is_transient:
    schedule_retry(bve_id, delay=exponential_backoff())
elif error.is_data_error:
    create_support_ticket(bve_id, error)
    notify_retailer(bve_id, "Data correction needed")
else:
    mark_bve_rejected(bve_id, error.code)
    notify_retailer(bve_id, error.message)
```

#### Step 3: Manual Review (Data Errors)
1. Operations agent reviews error in admin dashboard
2. Contacts retailer if data correction needed
3. Retailer corrects data in portal
4. System resubmits A_E_C01
5. Agent closes ticket when R_AR_C02 received

#### Step 4: Escalation
- If error unresolved after 24 hours → Escalate to Technical Lead
- If pattern of errors from one retailer → Review retailer training

### Metrics
- Track: Time to resolution, errors per retailer, error types
- Report: Weekly to management

### Related Documents
- Error Code Reference: `docs/technical/ERROR_CODES.md`
- Retailer Training Guide: `docs/operational/RETAILER_TRAINING.md`
```

---

#### 3.3.3 CSV Reference Data Documentation

```markdown
## Reference Data: Eligible Countries

### File Location
`/data/eligible_countries.csv`

### Format
```csv
country_code,country_name,eligible,notes
US,United States,true,
CA,Canada,true,
GB,United Kingdom,true,Post-Brexit
CH,Switzerland,true,EFTA
FR,France,false,EU member
DE,Germany,false,EU member
```

### Update Procedure
1. Monitor DGDDI communications for country changes
2. Update CSV file
3. Commit with descriptive message
4. Deploy to all environments
5. Document change in CHANGELOG.md

### Validation
- On application startup, load CSV and validate:
  - All codes are 2-letter ISO 3166-1 alpha-2
  - No duplicates
  - At least 100 eligible countries

### Last Updated
- Date: 2026-01-XX
- By: [Name]
- Reason: Initial creation based on DGDDI list
```

---

### 3.4 Evidence Collection for Audit

For each test scenario, collect:

```
test_evidence/
├── TC-C01_normal_bve_creation/
│   ├── request.json              # Exact JSON sent
│   ├── response.json             # Exact JSON received
│   ├── screenshot_portal.png     # UI screenshot
│   ├── database_before.sql       # DB state before
│   ├── database_after.sql        # DB state after
│   ├── application_log.txt       # Relevant log entries
│   └── timestamp.txt             # Execution time
│
├── TC-C03_invalid_country/
│   ├── request.json
│   ├── response.json             # R_EC_C03 with error
│   ├── error_notification.png    # Retailer notification
│   └── timestamp.txt
│
└── TC-A01_clearance_processing/
    ├── incoming_r_e_a01.json     # Received from PABLO
    ├── outgoing_a_ar_a02.json    # ACK sent back
    ├── bve_status_updates.sql    # All status changes
    ├── refund_triggers.json      # Refunds initiated
    └── timestamp.txt
```

---

## 4. Audit Checklist

### 4.1 Pre-Audit Preparation (1 month before)

#### Administrative
- [ ] K-bis extract (< 3 months old)
- [ ] Intra-community VAT number proof
- [ ] Casier judiciaire n°3 for all representatives
- [ ] Company statutes
- [ ] Insurance certificates (professional liability)
- [ ] Bank statements (last 6 months)
- [ ] Business plan with financial projections

#### Technical
- [ ] GUN platform SSO certificate obtained
- [ ] API credentials provisioned
- [ ] Staging environment connected to PABLO test
- [ ] All JSD schemas downloaded and implemented
- [ ] All message types tested against PABLO test environment
- [ ] Test execution report (attestation) completed
- [ ] Architecture documentation finalized

#### Compliance
- [ ] Eligible countries CSV prepared
- [ ] Eligible nationalities CSV prepared
- [ ] Product codes CSV prepared
- [ ] Payment modes CSV prepared
- [ ] Reimbursement modes CSV prepared
- [ ] Data retention policy documented
- [ ] Privacy policy published
- [ ] Internal control procedures written

#### Operational
- [ ] Staff training records compiled
- [ ] Escalation procedures documented
- [ ] Complaint handling process defined
- [ ] Reconciliation process documented
- [ ] Error resolution procedures written

---

### 4.2 Day of Audit

#### Documents Ready
- [ ] All compliance binders organized
- [ ] Test evidence folders accessible
- [ ] Demo environment running
- [ ] Admin dashboard accessible for demo

#### Personnel Available
- [ ] Technical lead (for architecture questions)
- [ ] Operations manager (for procedures questions)
- [ ] Finance representative (for financial questions)
- [ ] Legal representative (for compliance questions)

#### Demo Preparation
- [ ] Test retailer account created
- [ ] Test tourist data prepared
- [ ] Full BVE lifecycle ready to demonstrate
- [ ] Error scenarios ready to demonstrate
- [ ] Audit log query ready

---

### 4.3 Post-Audit Actions

- [ ] Address any findings or recommendations
- [ ] Submit additional documentation if requested
- [ ] Schedule follow-up if needed
- [ ] Update procedures based on feedback
- [ ] Prepare for production deployment

---

## Appendix A: Error Codes Reference

| Code | Type | Description | Action |
|------|------|-------------|--------|
| G001 | Global | JSON schema validation failed | Fix payload, do not retry automatically |
| G002 | Global | PABLO system error | Retry with exponential backoff |
| E001 | Functional | Invalid identifiant_detaxe format | Fix BVE number format |
| E002 | Functional | Duplicate BVE | Do not retry |
| E003 | Functional | Invalid country code | Verify eligible countries |
| E004 | Functional | Expired passport | Contact tourist for valid passport |
| E005 | Functional | Amount below threshold | Cannot process, inform retailer |
| E006 | Functional | BVE not found (for deletion) | Verify BVE number |
| E007 | Functional | Cannot delete confirmed BVE | BVE already processed |

*Note: Full error code list available in `Annexe-1-Formats-de-donnees.ods#Code_error`*

---

## Appendix B: Contact Information

| Entity | Contact | Purpose |
|--------|---------|---------|
| DGDDI Certification | dg-fid1@douane.finances.gouv.fr | Certification questions |
| GUN Support | [From GUN documentation] | Technical platform issues |
| SRA (Regional Audit) | [Assigned during process] | Audit scheduling |

---

**Document History**

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-16 | Claude | Initial creation |
