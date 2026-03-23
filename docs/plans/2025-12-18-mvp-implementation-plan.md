# Detaxe MVP - Implementation Plan

**Version:** 1.0
**Date:** 2025-12-18
**Timeline:** 12 weeks (3 months)
**Goal:** Launch with 5-10 Paris luxury retailers

---

## Overview

This plan breaks down Phase 1 (MVP) from the design document into actionable tasks. Each sprint is 2 weeks, with specific deliverables and acceptance criteria.

**Team:** 2-3 CS students (side project + summer intensive)

**Success Criteria:**
- ✅ PABLO operator certification in progress
- ✅ 5-10 luxury retailers onboarded
- ✅ End-to-end BVE creation → customs clearance → refund payment working
- ✅ Retailer and tourist portals live
- ✅ All critical PABLO message types supported

---

## Sprint 1: Foundation (Weeks 1-2)

**Goal:** Set up development environment, database, and API foundation

### Tasks

#### 1.1 Project Setup
**Effort:** 2 hours
**Dependencies:** None

- [ ] Initialize Git repository (already done ✅)
- [ ] Create project structure:
  ```
  detaxe/
  ├── backend/
  │   ├── src/
  │   │   ├── api/          # FastAPI routes
  │   │   ├── models/       # SQLAlchemy models
  │   │   ├── schemas/      # Pydantic schemas
  │   │   ├── services/     # Business logic
  │   │   ├── tasks/        # Celery tasks
  │   │   └── core/         # Config, DB, auth
  │   ├── tests/
  │   ├── alembic/          # Migrations
  │   ├── requirements.txt
  │   └── pyproject.toml
  ├── frontend/
  │   ├── apps/
  │   │   ├── tourist/      # detaxe.com
  │   │   ├── retailer/     # retailer.detaxe.com
  │   │   └── admin/        # admin.detaxe.com
  │   └── packages/         # Shared components
  ├── docs/
  └── docker-compose.yml
  ```
- [ ] Set up Python 3.12+ virtual environment
- [ ] Create `requirements.txt`:
  ```
  fastapi==0.108.0
  uvicorn[standard]==0.25.0
  sqlalchemy==2.0.23
  psycopg2-binary==2.9.9
  alembic==1.13.1
  pydantic==2.5.3
  pydantic-settings==2.1.0
  python-jose[cryptography]==3.3.0
  passlib[bcrypt]==1.7.4
  python-multipart==0.0.6
  celery==5.3.4
  redis==5.0.1
  loguru==0.7.2
  httpx==0.25.2
  tenacity==8.2.3
  pytest==7.4.3
  pytest-asyncio==0.21.1
  pytest-cov==4.1.0
  mypy==1.7.1
  ruff==0.1.8
  ```
- [ ] Set up `.env` template:
  ```
  DATABASE_URL=postgresql://user:pass@localhost:5432/detaxe
  REDIS_URL=redis://localhost:6379/0
  SECRET_KEY=your-secret-key-here
  GUN_API_URL=https://gun-platform.douane.gouv.fr/api
  GUN_CLIENT_ID=your-client-id
  GUN_CLIENT_SECRET=your-client-secret
  ```

**Acceptance Criteria:**
- Project structure created
- Dependencies installed
- Can run `python --version` (3.12+)

---

#### 1.2 Database Setup
**Effort:** 4 hours
**Dependencies:** 1.1

- [ ] Install PostgreSQL locally or use Docker:
  ```yaml
  # docker-compose.yml
  version: '3.8'
  services:
    postgres:
      image: postgres:15
      environment:
        POSTGRES_DB: detaxe
        POSTGRES_USER: detaxe
        POSTGRES_PASSWORD: detaxe123
      ports:
        - "5432:5432"
      volumes:
        - postgres_data:/var/lib/postgresql/data

    redis:
      image: redis:7
      ports:
        - "6379:6379"

  volumes:
    postgres_data:
  ```
- [ ] Start services: `docker-compose up -d`
- [ ] Initialize Alembic: `alembic init alembic`
- [ ] Configure Alembic `env.py` to use SQLAlchemy models
- [ ] Test connection: `psql -h localhost -U detaxe -d detaxe`

**Acceptance Criteria:**
- PostgreSQL and Redis running
- Can connect to database
- Alembic configured

---

#### 1.3 Core Database Models
**Effort:** 6 hours
**Dependencies:** 1.2

Create SQLAlchemy models in `backend/src/models/`:

- [ ] `base.py` - Base model class
  ```python
  from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column
  from datetime import datetime
  import uuid

  class Base(DeclarativeBase):
      pass

  class TimestampMixin:
      created_at: Mapped[datetime] = mapped_column(default=datetime.utcnow)
      updated_at: Mapped[datetime] = mapped_column(
          default=datetime.utcnow,
          onupdate=datetime.utcnow
      )
  ```

- [ ] `retailer.py` - Retailer and Store models
  ```python
  from sqlalchemy import String, DECIMAL, Boolean, ForeignKey
  from sqlalchemy.orm import Mapped, mapped_column, relationship
  from decimal import Decimal
  import uuid
  from .base import Base, TimestampMixin

  class Retailer(Base, TimestampMixin):
      __tablename__ = "retailers"

      id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
      name: Mapped[str] = mapped_column(String(255), index=True)
      legal_entity: Mapped[str] = mapped_column(String(255))
      siret: Mapped[str | None] = mapped_column(String(14))
      email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
      phone: Mapped[str | None] = mapped_column(String(50))
      status: Mapped[str] = mapped_column(String(50), default="pending", index=True)
      commission_rate: Mapped[Decimal] = mapped_column(DECIMAL(5, 4), default=Decimal("0.15"))

      # Relationships
      stores: Mapped[list["Store"]] = relationship(back_populates="retailer")
      bves: Mapped[list["BVE"]] = relationship(back_populates="retailer")

  class Store(Base, TimestampMixin):
      __tablename__ = "stores"

      id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
      retailer_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("retailers.id"), index=True)
      name: Mapped[str] = mapped_column(String(255))
      address: Mapped[str]
      city: Mapped[str] = mapped_column(String(100), index=True)
      postal_code: Mapped[str] = mapped_column(String(20))
      country: Mapped[str] = mapped_column(String(2), default="FR")
      is_active: Mapped[bool] = mapped_column(default=True)

      retailer: Mapped["Retailer"] = relationship(back_populates="stores")
  ```

- [ ] `bve.py` - BVE and BVEItem models
  ```python
  from sqlalchemy import String, DECIMAL, ForeignKey, Date, Text
  from sqlalchemy.orm import Mapped, mapped_column, relationship
  from decimal import Decimal
  from datetime import datetime, date
  import uuid
  from .base import Base, TimestampMixin

  class BVE(Base, TimestampMixin):
      __tablename__ = "bves"

      id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
      bve_number: Mapped[str] = mapped_column(String(20), unique=True, index=True)
      retailer_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("retailers.id"), index=True)
      store_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("stores.id"))

      status: Mapped[str] = mapped_column(String(50), default="created", index=True)

      # Traveler info
      traveler_passport: Mapped[str] = mapped_column(String(50))
      traveler_last_name: Mapped[str] = mapped_column(String(100))
      traveler_first_name: Mapped[str] = mapped_column(String(100))
      traveler_birth_date: Mapped[date]
      traveler_nationality: Mapped[str] = mapped_column(String(2))
      traveler_residence_country: Mapped[str] = mapped_column(String(2))
      traveler_email: Mapped[str | None] = mapped_column(String(255))

      # Financial
      total_amount_incl_vat: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))
      total_vat_amount: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))

      # PABLO
      pablo_message_id: Mapped[str | None] = mapped_column(String(100))
      pablo_confirmed_at: Mapped[datetime | None]
      pablo_cancelled_at: Mapped[datetime | None]
      error_code: Mapped[str | None] = mapped_column(String(50))
      error_message: Mapped[str | None] = mapped_column(Text)

      # Relationships
      retailer: Mapped["Retailer"] = relationship(back_populates="bves")
      store: Mapped["Store"] = relationship()
      items: Mapped[list["BVEItem"]] = relationship(back_populates="bve", cascade="all, delete-orphan")
      refund: Mapped["Refund"] = relationship(back_populates="bve", uselist=False)

  class BVEItem(Base, TimestampMixin):
      __tablename__ = "bve_items"

      id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
      bve_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("bves.id", ondelete="CASCADE"), index=True)

      description: Mapped[str] = mapped_column(Text)
      type: Mapped[str | None] = mapped_column(String(100))
      brand: Mapped[str | None] = mapped_column(String(100))
      identification_number: Mapped[str | None] = mapped_column(String(100))
      color: Mapped[str | None] = mapped_column(String(50))
      product_code: Mapped[int | None]

      quantity: Mapped[int]
      vat_rate: Mapped[Decimal] = mapped_column(DECIMAL(5, 2))
      amount_incl_vat: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))
      vat_amount: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))

      bve: Mapped["BVE"] = relationship(back_populates="items")
  ```

- [ ] `refund.py` - Refund model
  ```python
  from sqlalchemy import String, DECIMAL, ForeignKey, JSON
  from sqlalchemy.orm import Mapped, mapped_column, relationship
  from decimal import Decimal
  from datetime import datetime
  import uuid
  from .base import Base, TimestampMixin

  class Refund(Base, TimestampMixin):
      __tablename__ = "refunds"

      id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
      bve_id: Mapped[uuid.UUID] = mapped_column(ForeignKey("bves.id"), unique=True, index=True)

      total_vat: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))
      refund_percentage: Mapped[Decimal] = mapped_column(DECIMAL(5, 4), default=Decimal("0.85"))
      refund_amount: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))
      commission_amount: Mapped[Decimal] = mapped_column(DECIMAL(10, 2))

      status: Mapped[str] = mapped_column(String(50), default="pending_clearance", index=True)

      payment_method: Mapped[str | None] = mapped_column(String(50), index=True)
      payment_details: Mapped[dict | None] = mapped_column(JSON)
      payment_provider_id: Mapped[str | None] = mapped_column(String(255))

      cleared_at: Mapped[datetime | None]
      payment_sent_at: Mapped[datetime | None]
      paid_at: Mapped[datetime | None]

      bve: Mapped["BVE"] = relationship(back_populates="refund")
  ```

- [ ] `user.py` - User model
  ```python
  from sqlalchemy import String, Boolean, ForeignKey
  from sqlalchemy.orm import Mapped, mapped_column, relationship
  from datetime import datetime
  import uuid
  from .base import Base, TimestampMixin

  class User(Base, TimestampMixin):
      __tablename__ = "users"

      id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
      email: Mapped[str] = mapped_column(String(255), unique=True, index=True)
      password_hash: Mapped[str] = mapped_column(String(255))

      role: Mapped[str] = mapped_column(String(50), default="retailer")
      retailer_id: Mapped[uuid.UUID | None] = mapped_column(ForeignKey("retailers.id"), index=True)

      first_name: Mapped[str | None] = mapped_column(String(100))
      last_name: Mapped[str | None] = mapped_column(String(100))
      phone: Mapped[str | None] = mapped_column(String(50))

      is_active: Mapped[bool] = mapped_column(default=True)
      last_login_at: Mapped[datetime | None]

      retailer: Mapped["Retailer"] = relationship()
  ```

- [ ] `pablo_message.py` - PABLO message audit trail
  ```python
  from sqlalchemy import String, ForeignKey, JSON, Text, Integer
  from sqlalchemy.orm import Mapped, mapped_column, relationship
  from datetime import datetime
  import uuid
  from .base import Base, TimestampMixin

  class PabloMessage(Base, TimestampMixin):
      __tablename__ = "pablo_messages"

      id: Mapped[uuid.UUID] = mapped_column(primary_key=True, default=uuid.uuid4)
      bve_id: Mapped[uuid.UUID | None] = mapped_column(ForeignKey("bves.id"), index=True)

      message_type: Mapped[str] = mapped_column(String(20), index=True)
      direction: Mapped[str] = mapped_column(String(10))  # outbound/inbound
      status: Mapped[str] = mapped_column(String(50), default="pending", index=True)

      payload: Mapped[dict] = mapped_column(JSON)
      response: Mapped[dict | None] = mapped_column(JSON)

      gun_message_id: Mapped[str | None] = mapped_column(String(100))
      error_code: Mapped[str | None] = mapped_column(String(50))
      error_message: Mapped[str | None] = mapped_column(Text)

      retry_count: Mapped[int] = mapped_column(default=0)
      last_retry_at: Mapped[datetime | None]

      bve: Mapped["BVE"] = relationship()
  ```

- [ ] Create initial migration: `alembic revision --autogenerate -m "Initial schema"`
- [ ] Apply migration: `alembic upgrade head`

**Acceptance Criteria:**
- All models created
- Migration applied successfully
- Can query tables: `SELECT * FROM retailers;`

---

#### 1.4 FastAPI Application Setup
**Effort:** 4 hours
**Dependencies:** 1.3

- [ ] Create `backend/src/main.py`:
  ```python
  from fastapi import FastAPI
  from fastapi.middleware.cors import CORSMiddleware
  from loguru import logger
  import sys

  # Configure Loguru
  logger.remove()
  logger.add(
      sys.stdout,
      format="<green>{time:YYYY-MM-DD HH:mm:ss}</green> | <level>{level: <8}</level> | <cyan>{name}</cyan>:<cyan>{function}</cyan> - <level>{message}</level>",
      level="INFO"
  )
  logger.add(
      "logs/detaxe_{time}.log",
      rotation="100 MB",
      retention="1 year",
      level="DEBUG"
  )

  app = FastAPI(
      title="Detaxe API",
      description="VAT Refund Platform API",
      version="1.0.0"
  )

  # CORS
  app.add_middleware(
      CORSMiddleware,
      allow_origins=["http://localhost:3000", "https://detaxe.com", "https://retailer.detaxe.com"],
      allow_credentials=True,
      allow_methods=["*"],
      allow_headers=["*"],
  )

  @app.get("/")
  async def root():
      return {"status": "ok", "message": "Detaxe API"}

  @app.get("/health")
  async def health():
      return {"status": "healthy"}

  if __name__ == "__main__":
      import uvicorn
      uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
  ```

- [ ] Create `backend/src/core/database.py`:
  ```python
  from sqlalchemy import create_engine
  from sqlalchemy.orm import sessionmaker
  from ..models.base import Base
  import os

  DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://detaxe:detaxe123@localhost:5432/detaxe")

  engine = create_engine(DATABASE_URL, echo=True)
  SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

  def get_db():
      db = SessionLocal()
      try:
          yield db
      finally:
          db.close()
  ```

- [ ] Create `backend/src/core/config.py`:
  ```python
  from pydantic_settings import BaseSettings

  class Settings(BaseSettings):
      database_url: str
      redis_url: str
      secret_key: str
      gun_api_url: str
      gun_client_id: str
      gun_client_secret: str

      class Config:
          env_file = ".env"

  settings = Settings()
  ```

- [ ] Test server: `python backend/src/main.py`
- [ ] Visit `http://localhost:8000/docs` (Swagger UI)

**Acceptance Criteria:**
- FastAPI server runs
- Swagger docs accessible
- `/health` endpoint returns 200

---

#### 1.5 Authentication System
**Effort:** 6 hours
**Dependencies:** 1.4

- [ ] Create `backend/src/core/security.py`:
  ```python
  from passlib.context import CryptContext
  from jose import JWTError, jwt
  from datetime import datetime, timedelta
  from fastapi import Depends, HTTPException, status
  from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
  from .config import settings

  pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
  security = HTTPBearer()

  def hash_password(password: str) -> str:
      return pwd_context.hash(password)

  def verify_password(plain_password: str, hashed_password: str) -> bool:
      return pwd_context.verify(plain_password, hashed_password)

  def create_access_token(data: dict, expires_delta: timedelta = timedelta(hours=24)):
      to_encode = data.copy()
      expire = datetime.utcnow() + expires_delta
      to_encode.update({"exp": expire})
      encoded_jwt = jwt.encode(to_encode, settings.secret_key, algorithm="HS256")
      return encoded_jwt

  def decode_access_token(token: str):
      try:
          payload = jwt.decode(token, settings.secret_key, algorithms=["HS256"])
          return payload
      except JWTError:
          raise HTTPException(
              status_code=status.HTTP_401_UNAUTHORIZED,
              detail="Could not validate credentials"
          )

  async def get_current_user(credentials: HTTPAuthorizationCredentials = Depends(security)):
      token = credentials.credentials
      payload = decode_access_token(token)
      user_id = payload.get("sub")
      if user_id is None:
          raise HTTPException(status_code=401, detail="Invalid token")
      return user_id
  ```

- [ ] Create `backend/src/api/auth.py`:
  ```python
  from fastapi import APIRouter, Depends, HTTPException
  from sqlalchemy.orm import Session
  from pydantic import BaseModel, EmailStr
  from ..core.database import get_db
  from ..core.security import hash_password, verify_password, create_access_token
  from ..models.user import User

  router = APIRouter(prefix="/auth", tags=["auth"])

  class LoginRequest(BaseModel):
      email: EmailStr
      password: str

  class LoginResponse(BaseModel):
      access_token: str
      token_type: str = "bearer"

  @router.post("/login", response_model=LoginResponse)
  async def login(request: LoginRequest, db: Session = Depends(get_db)):
      user = db.query(User).filter(User.email == request.email).first()

      if not user or not verify_password(request.password, user.password_hash):
          raise HTTPException(status_code=401, detail="Invalid credentials")

      if not user.is_active:
          raise HTTPException(status_code=403, detail="User account is inactive")

      access_token = create_access_token(data={"sub": str(user.id), "role": user.role})

      return LoginResponse(access_token=access_token)
  ```

- [ ] Add to `main.py`:
  ```python
  from .api import auth
  app.include_router(auth.router)
  ```

- [ ] Test with curl:
  ```bash
  # Create test user first (in psql or via script)
  curl -X POST http://localhost:8000/auth/login \
    -H "Content-Type: application/json" \
    -d '{"email":"test@example.com","password":"test123"}'
  ```

**Acceptance Criteria:**
- Can login with valid credentials
- Receive JWT token
- Invalid credentials rejected

---

### Sprint 1 Deliverables

✅ Development environment set up
✅ PostgreSQL database with all tables
✅ FastAPI application running
✅ Authentication working
✅ All models tested via migrations

**Demo:** Show API docs, create user, login, receive token

---

## Sprint 2: PABLO Integration (Weeks 3-4)

**Goal:** Implement PABLO EDI message creation and handling

### Tasks

#### 2.1 Pydantic Schemas for PABLO Messages
**Effort:** 8 hours
**Dependencies:** 1.3

Create schemas in `backend/src/schemas/pablo.py`:

- [ ] Base types and enums
- [ ] `PabloTraveler` (with French field aliases)
- [ ] `PabloMerchandise` (with French field aliases)
- [ ] `PabloTransaction` (with French field aliases)
- [ ] `A_E_C01` (Create BVE request)
- [ ] `R_AR_C02` (Success response)
- [ ] `R_EC_C03` (Error response)
- [ ] Validation methods (IBAN format, date formats, etc.)

**Acceptance Criteria:**
- All schemas typed and validated
- Can serialize to JSON with French field names
- Unit tests pass

---

#### 2.2 GUN HTTP Client
**Effort:** 6 hours
**Dependencies:** 2.1

Create `backend/src/services/gun_client.py`:

- [ ] OAuth2 authentication with GUN platform
- [ ] HTTP client with retry logic (using tenacity)
- [ ] POST message method
- [ ] Error handling (G001, G002, network errors)
- [ ] Logging with Loguru

**Acceptance Criteria:**
- Can authenticate with GUN (test credentials)
- Can send POST request
- Retries on transient failures
- Logs all requests/responses

---

#### 2.3 Message Queue Setup
**Effort:** 4 hours
**Dependencies:** 1.2

- [ ] Configure Celery in `backend/src/core/celery_app.py`
- [ ] Redis as broker and result backend
- [ ] Create task decorator and app instance
- [ ] Test task execution

**Acceptance Criteria:**
- Celery worker starts: `celery -A src.core.celery_app worker`
- Can enqueue and execute test task
- Tasks logged to Loguru

---

#### 2.4 BVE Creation Flow
**Effort:** 10 hours
**Dependencies:** 2.1, 2.2, 2.3

Implement full BVE creation workflow:

- [ ] Create `backend/src/services/bve_service.py`
  - `create_bve()` - Business logic
  - `generate_bve_number()` - 20-digit unique ID
  - `validate_bve_data()` - Pre-flight checks

- [ ] Create `backend/src/tasks/pablo_tasks.py`
  - `send_bve_creation.delay(bve_id)` - Celery task
  - Convert BVE model to A_E_C01 schema
  - Send to GUN via client
  - Update BVE status based on response
  - Handle retries

- [ ] Create API endpoint `backend/src/api/bve.py`
  - `POST /api/bve` - Create BVE
  - Validate input (Pydantic)
  - Save to database
  - Queue PABLO task
  - Return BVE ID

**Acceptance Criteria:**
- Can create BVE via API
- BVE saved to database
- Message queued for PABLO
- Worker sends A_E_C01
- Receives R_AR_C02 or R_EC_C03
- BVE status updated

---

#### 2.5 Webhook for PABLO Responses
**Effort:** 6 hours
**Dependencies:** 2.4

Create webhook to receive async responses from PABLO:

- [ ] `POST /api/webhooks/pablo` endpoint
- [ ] Authenticate webhook (verify signature or token)
- [ ] Parse message type (R_AR_C02, R_EC_C03, etc.)
- [ ] Update BVE status in database
- [ ] Store message in pablo_messages audit table
- [ ] Handle duplicates (idempotency)

**Acceptance Criteria:**
- Webhook receives POST from PABLO (test)
- Parses message correctly
- Updates BVE status
- Logs to audit table

---

### Sprint 2 Deliverables

✅ PABLO message schemas (Pydantic)
✅ GUN HTTP client with retry logic
✅ Celery task queue configured
✅ BVE creation API endpoint
✅ A_E_C01 sent to PABLO
✅ R_AR_C02/R_EC_C03 handled

**Demo:** Create BVE via API, show PABLO message sent, show response handled

---

## Sprint 3: Retailer Portal (Weeks 5-6)

**Goal:** Build retailer-facing web application

### Tasks

#### 3.1 Next.js Project Setup
**Effort:** 3 hours
**Dependencies:** None

- [ ] Initialize Next.js: `npx create-next-app@latest frontend/apps/retailer`
- [ ] Configure Tailwind CSS
- [ ] Install dependencies:
  ```json
  {
    "dependencies": {
      "next": "^14.0.0",
      "react": "^18.2.0",
      "react-dom": "^18.2.0",
      "react-hook-form": "^7.48.0",
      "@hookform/resolvers": "^3.3.0",
      "zod": "^3.22.0",
      "@tanstack/react-query": "^5.12.0",
      "next-intl": "^3.0.0"
    }
  }
  ```
- [ ] Set up shadcn/ui: `npx shadcn-ui@latest init`
- [ ] Create basic layout with header/sidebar
- [ ] Configure API base URL

**Acceptance Criteria:**
- Next.js dev server runs: `npm run dev`
- Can access `http://localhost:3000`
- shadcn/ui components work

---

#### 3.2 Login Page
**Effort:** 4 hours
**Dependencies:** 3.1

- [ ] Create `/login` page
- [ ] Login form (email + password)
- [ ] Form validation with Zod
- [ ] Submit to `/api/auth/login`
- [ ] Store JWT in httpOnly cookie or localStorage
- [ ] Redirect to dashboard on success

**Acceptance Criteria:**
- Can login with test credentials
- Token stored
- Redirected to dashboard
- Error messages shown for invalid credentials

---

#### 3.3 Dashboard Page
**Effort:** 6 hours
**Dependencies:** 3.2

Create `/dashboard` page:

- [ ] Protected route (check auth)
- [ ] Stats cards (today's BVEs, pending refunds, total revenue)
- [ ] Recent BVEs table
- [ ] Quick actions (Create BVE button)
- [ ] Fetch data from API with React Query

**Acceptance Criteria:**
- Dashboard loads after login
- Shows stats (mocked data OK for now)
- Can navigate to other pages

---

#### 3.4 Create BVE Form
**Effort:** 12 hours
**Dependencies:** 3.3

Create `/bve/create` page:

- [ ] Multi-section form:
  1. Traveler information (passport, name, DOB, nationality)
  2. Merchandise list (dynamic array)
  3. Payment details
  4. Review and submit
- [ ] Form validation (Zod schemas matching backend)
- [ ] Auto-calculate totals (VAT, refund estimate)
- [ ] Submit to `POST /api/bve`
- [ ] Handle loading/error states
- [ ] Redirect to BVE detail page on success

**Acceptance Criteria:**
- Form renders with all fields
- Validation works (try invalid data)
- Can add/remove merchandise items
- Submits successfully
- Redirects to BVE detail

---

#### 3.5 BVE Detail & Print View
**Effort:** 6 hours
**Dependencies:** 3.4

Create `/bve/[id]` page:

- [ ] Fetch BVE by ID from API
- [ ] Display all BVE details (traveler, items, totals)
- [ ] Show status badge (created, confirmed, etc.)
- [ ] Print button → `/bve/[id]/print`
- [ ] Print view (print-optimized CSS)
- [ ] QR code with BVE number
- [ ] PDF-ready layout

**Acceptance Criteria:**
- BVE details load
- Can click print button
- Print view looks professional
- Browser print dialog works

---

#### 3.6 BVE List Page
**Effort:** 6 hours
**Dependencies:** 3.5

Create `/bve/list` page:

- [ ] Table with all BVEs for retailer
- [ ] Columns: BVE number, date, tourist name, amount, status
- [ ] Search/filter by BVE number, date range, status
- [ ] Pagination (10/25/50 per page)
- [ ] Click row → navigate to detail page

**Acceptance Criteria:**
- Lists all BVEs
- Search works
- Filter works
- Pagination works

---

### Sprint 3 Deliverables

✅ Retailer portal (Next.js) deployed
✅ Login page working
✅ Dashboard with stats
✅ Create BVE form (full flow)
✅ BVE detail page
✅ BVE list with search/filter
✅ Print-ready BVE view

**Demo:** Login as retailer, create BVE, view list, print BVE

---

## Sprint 4: Refund Processing (Weeks 7-8)

**Goal:** Handle PABLO clearance and process refunds

### Tasks

#### 4.1 Clearance Message Handler
**Effort:** 8 hours
**Dependencies:** Sprint 2

Implement R_E_A01 (clearance list) handling:

- [ ] Create schema for R_E_A01 (Pydantic)
- [ ] Webhook endpoint: `POST /api/webhooks/pablo/clearance`
- [ ] Parse list of BVEs (confirmed/cancelled)
- [ ] Update BVE status in database
- [ ] Create Refund record for confirmed BVEs
- [ ] Send A_AR_A02 ACK back to PABLO
- [ ] Handle duplicates (idempotency with Redis)

**Acceptance Criteria:**
- Receives R_E_A01 webhook
- Updates BVE statuses
- Creates refund records
- Sends ACK

---

#### 4.2 Refund Calculation Service
**Effort:** 4 hours
**Dependencies:** 4.1

Create `backend/src/services/refund_calculator.py`:

- [ ] `calculate()` method using Decimal
- [ ] Input: total_vat, refund_percentage (default 0.85)
- [ ] Output: refund_amount, commission_amount
- [ ] Proper rounding (ROUND_HALF_UP)
- [ ] Unit tests

**Acceptance Criteria:**
- Calculations accurate to 2 decimal places
- Unit tests pass (various amounts)
- No floating point errors

---

#### 4.3 Tourist Notification Service
**Effort:** 6 hours
**Dependencies:** 4.1

Create notification system:

- [ ] Email service (SendGrid or Resend)
- [ ] SMS service (Twilio)
- [ ] Template system (Jinja2)
- [ ] Notification types:
  - BVE created (optional)
  - Refund cleared (ready for payment)
  - Payment sent
  - Payment failed
- [ ] Multi-language templates (EN, FR)

**Acceptance Criteria:**
- Can send email
- Can send SMS
- Templates render correctly
- Multi-language works

---

#### 4.4 Payment Provider Abstraction
**Effort:** 8 hours
**Dependencies:** 4.2

Create payment provider interface:

- [ ] Abstract base class `PaymentProvider` in `backend/src/services/payment/base.py`
- [ ] `SEPAProvider` implementation (placeholder for now)
- [ ] Provider factory method
- [ ] Payment status tracking
- [ ] Error handling

**Acceptance Criteria:**
- Can instantiate provider
- Interface defined clearly
- SEPA provider (stub) works

---

#### 4.5 Payment Processing Queue
**Effort:** 8 hours
**Dependencies:** 4.3, 4.4

Create payment processing task:

- [ ] Celery task: `process_payment(refund_id)`
- [ ] Load refund from database
- [ ] Get payment provider
- [ ] Send payment
- [ ] Update refund status
- [ ] Retry logic (max 3 retries)
- [ ] Alert ops team on final failure
- [ ] Send notification to tourist on success

**Acceptance Criteria:**
- Task executes
- Refund status updated
- Retries on failure
- Notifications sent

---

### Sprint 4 Deliverables

✅ Clearance message handling (R_E_A01)
✅ Refund calculation service
✅ Tourist notifications (email/SMS)
✅ Payment provider abstraction
✅ Payment processing queue

**Demo:** Simulate clearance, show refund created, show payment processed

---

## Sprint 5: Tourist Portal (Weeks 9-10)

**Goal:** Build tourist-facing refund tracker

### Tasks

#### 5.1 Tourist Portal Setup
**Effort:** 2 hours
**Dependencies:** 3.1

- [ ] Initialize Next.js: `frontend/apps/tourist`
- [ ] Same tech stack as retailer portal
- [ ] Different branding/theme (consumer-focused)
- [ ] Landing page structure

**Acceptance Criteria:**
- Tourist portal runs on separate port
- Different styling than retailer portal

---

#### 5.2 Landing Page
**Effort:** 4 hours
**Dependencies:** 5.1

Create homepage:

- [ ] Hero section (value proposition)
- [ ] BVE number search box (prominent)
- [ ] How it works section (3-4 steps)
- [ ] FAQ accordion
- [ ] Footer (contact, legal)
- [ ] Multi-language toggle (EN, FR, ZH)

**Acceptance Criteria:**
- Landing page looks professional
- Search box functional
- Language switcher works

---

#### 5.3 Refund Tracker
**Effort:** 8 hours
**Dependencies:** 5.2

Create `/track/[bveNumber]` page:

- [ ] API endpoint: `GET /api/refunds/track/{bveNumber}`
  - Public endpoint (no auth)
  - Returns refund status, amount, dates
- [ ] Status stepper component (visual progress)
- [ ] Refund details card
- [ ] Call-to-action based on status:
  - Pending clearance: "Waiting for customs"
  - Cleared: "Submit payment details" button
  - Paid: "Refund completed ✓"
- [ ] Real-time updates (poll every 30s)

**Acceptance Criteria:**
- Can track refund by BVE number
- Status shown clearly
- CTA appears when needed

---

#### 5.4 Payment Details Form
**Effort:** 8 hours
**Dependencies:** 5.3

Create `/refund/[id]/payment` page:

- [ ] Payment method selector (SEPA, Revolut, Wise)
- [ ] Dynamic form based on method:
  - SEPA: IBAN, BIC, account holder name
  - Revolut: Revolut tag or email
  - Wise: Email
- [ ] Validation (IBAN format, email format)
- [ ] Submit to `POST /api/refunds/{id}/payment-details`
- [ ] Confirmation screen

**Acceptance Criteria:**
- Can select payment method
- Form validates correctly
- Submits successfully
- Confirmation shown

---

#### 5.5 Multi-language Support
**Effort:** 6 hours
**Dependencies:** 5.1-5.4

- [ ] Set up next-intl
- [ ] Create translation files:
  - `locales/en.json`
  - `locales/fr.json`
  - `locales/zh.json`
- [ ] Translate all UI text
- [ ] Language switcher in header
- [ ] Detect browser language (default)

**Acceptance Criteria:**
- Can switch languages
- All text translated
- Browser language detected

---

### Sprint 5 Deliverables

✅ Tourist portal deployed
✅ Landing page with search
✅ Refund tracker (no login needed)
✅ Payment details submission
✅ Multi-language support (EN, FR, ZH)

**Demo:** Search BVE number, see status, submit payment details

---

## Sprint 6: Polish & Launch (Weeks 11-12)

**Goal:** Testing, refinement, deployment, onboard first retailers

### Tasks

#### 6.1 Error Handling Improvements
**Effort:** 6 hours
**Dependencies:** All sprints

- [ ] Sentry integration (backend + frontend)
- [ ] Global error handler in FastAPI
- [ ] Error boundary in React
- [ ] User-friendly error messages
- [ ] Retry logic for all critical paths

**Acceptance Criteria:**
- Errors logged to Sentry
- User sees helpful messages (not stack traces)
- Critical operations retry automatically

---

#### 6.2 Admin Dashboard (Basic)
**Effort:** 8 hours
**Dependencies:** All sprints

Create minimal admin dashboard:

- [ ] Initialize Next.js: `frontend/apps/admin`
- [ ] Login (admin role only)
- [ ] Live activity feed (recent BVEs, payments)
- [ ] Error queue (failed BVEs)
- [ ] Retry button for failed operations
- [ ] PABLO message log (audit trail)

**Acceptance Criteria:**
- Admin can log in
- See recent activity
- Retry failed operations

---

#### 6.3 Testing
**Effort:** 12 hours
**Dependencies:** All sprints

Write tests:

- [ ] Backend unit tests (pytest)
  - Models (CRUD operations)
  - Services (BVE creation, refund calculation)
  - PABLO schemas (validation)
- [ ] Backend integration tests
  - API endpoints
  - Database transactions
  - Celery tasks
- [ ] Frontend tests (Jest + React Testing Library)
  - Form validation
  - Component rendering
- [ ] E2E tests (Playwright - optional)
  - Create BVE flow
  - Track refund flow

**Acceptance Criteria:**
- Unit test coverage > 70%
- All critical paths tested
- CI passes

---

#### 6.4 Documentation
**Effort:** 6 hours
**Dependencies:** All sprints

- [ ] API documentation (auto-generated via FastAPI)
- [ ] Developer README (setup instructions)
- [ ] User guide for retailers (how to create BVE)
- [ ] User guide for tourists (how to track refund)
- [ ] Operations runbook (troubleshooting)

**Acceptance Criteria:**
- Docs complete
- New developer can set up project from README
- Users understand how to use platform

---

#### 6.5 Deployment
**Effort:** 8 hours
**Dependencies:** 6.1-6.4

Deploy to production:

- [ ] Set up Render.com or Railway account
- [ ] Deploy backend (FastAPI + Celery workers)
- [ ] Deploy PostgreSQL database
- [ ] Deploy Redis
- [ ] Deploy frontend to Vercel:
  - detaxe.com (tourist portal)
  - retailer.detaxe.com (retailer portal)
  - admin.detaxe.com (admin dashboard)
- [ ] Configure DNS (Cloudflare)
- [ ] Set up SSL certificates
- [ ] Configure environment variables
- [ ] Set up monitoring (Sentry, uptime checks)
- [ ] Create database backup schedule

**Acceptance Criteria:**
- All services deployed
- HTTPS working
- Monitoring active
- Can access all portals

---

#### 6.6 Retailer Onboarding
**Effort:** 10 hours
**Dependencies:** 6.5

Onboard first 5 retailers:

- [ ] Create onboarding checklist
- [ ] Create retailer accounts manually
- [ ] Train retailers on creating BVEs
- [ ] Provide support during first week
- [ ] Collect feedback
- [ ] Fix bugs discovered during onboarding

**Acceptance Criteria:**
- 5 retailers onboarded
- Each creates at least 1 test BVE
- Feedback documented

---

### Sprint 6 Deliverables

✅ Error handling and monitoring (Sentry)
✅ Basic admin dashboard
✅ Test suite (unit + integration)
✅ Documentation complete
✅ Production deployment
✅ First 5 retailers onboarded

**Demo:** Full end-to-end flow in production

---

## Post-MVP Tasks

### High Priority (Weeks 13-16)

- [ ] A_E_S01 (Delete BVE) support
- [ ] A_E_P01 (Backup BVE) support for system downtime
- [ ] Revolut payment integration
- [ ] Wise payment integration
- [ ] Advanced retailer analytics
- [ ] Performance optimization (caching, query optimization)

### Medium Priority (Months 4-6)

- [ ] Mobile app (React Native) for tourists
- [ ] R_E_IS (Live status updates) integration
- [ ] Referral system (tourists refer retailers)
- [ ] POS system integration (Square, Lightspeed)
- [ ] A_E_U01 (EU Visa) support
- [ ] Multi-factor authentication

### Future (6+ months)

- [ ] Instant refunds (advance money to tourists)
- [ ] ML-based fraud detection
- [ ] Automated chatbot support
- [ ] Expand to other French cities
- [ ] Expand to other EU countries

---

## Risk Management

### Technical Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| PABLO certification delayed | High | Medium | Start process immediately, parallel to development |
| GUN API downtime | High | Low | Implement backup BVE creation (A_E_P01) |
| Payment provider failures | Medium | Medium | Multiple provider support, retry logic |
| Database performance issues | Medium | Low | Proper indexing, connection pooling |
| Security vulnerabilities | High | Low | Regular audits, dependency updates |

### Business Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| Slow retailer adoption | High | Medium | Focus on high-value luxury retailers first |
| Competitor response | Medium | Medium | Move fast, build relationships |
| Regulatory changes | High | Low | Monitor DGDDI announcements, flexible architecture |
| Insufficient working capital | High | Medium | Start with payment providers that don't require advance |

---

## Success Metrics (End of Sprint 6)

### Must Have
- ✅ PABLO certification application submitted
- ✅ 5-10 retailers onboarded
- ✅ 50+ BVEs created
- ✅ At least 10 BVEs fully processed (creation → clearance → payment)
- ✅ 99% uptime
- ✅ Zero critical security issues

### Nice to Have
- 10+ retailers onboarded
- 100+ BVEs created
- Tourist NPS > 50
- Retailer satisfaction > 80%

---

## Team Roles & Responsibilities

**Person 1 (Backend Lead):**
- Database schema & migrations
- FastAPI endpoints
- PABLO integration
- Payment processing
- DevOps & deployment

**Person 2 (Frontend Lead):**
- Retailer portal (Next.js)
- Tourist portal (Next.js)
- UI/UX design
- Multi-language support
- Admin dashboard

**Person 3 (Full-stack):**
- Support both backend and frontend
- Testing (unit + integration)
- Documentation
- Retailer onboarding & support
- Bug fixes

**Madagascar Team (Post-launch):**
- Customer support (email/chat)
- Manual BVE data entry (if needed)
- Error queue monitoring
- Refund processing assistance

---

## Daily Workflow

**During Side Project (School Year):**
- 2-3 hours/day (evenings)
- 1 standup per week (30 min)
- Code reviews via GitHub
- Track progress in Linear or GitHub Projects

**During Summer Intensive:**
- 8 hours/day
- Daily standup (15 min)
- Pair programming for complex tasks
- Weekly demo to each other

---

## End of Plan

**Next Steps:**
1. Review this plan as a team
2. Set up GitHub Projects board with all tasks
3. Assign Sprint 1 tasks
4. Start coding! 🚀

**Questions?**
- Clarify any unclear tasks
- Adjust timeline if needed
- Add missing tasks discovered during implementation

**Good luck building Detaxe!** 💪
