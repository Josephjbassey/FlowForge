# FlowForge

**FlowForge** is an AI-first SaaS foundation for building intelligent business automation solutions. It leverages Django, Tailwind, Stripe, Celery, and OpenAI to help you rapidly launch, test, and scale automation-driven products.

The goal is to provide a reusable codebase and modular architecture that supports AI-driven workflows, business blueprint generation, team collaboration, and subscription billing out of the box.

---

## 🚀 Tech Stack

- **Django** — backend framework
- **Tailwind CSS** — utility-first CSS for frontend styling
- **Celery + Redis** — background task processing
- **Stripe** — payment processing & subscription billing
- **OpenAI API** — AI-generated workflow blueprints
- **HTMX + Alpine.js** — dynamic frontend behavior
- **SQLite** (dev) / **PostgreSQL** (prod) — database support

---

## 🗂 Project Structure

```text
FLOWFORGE/
│
├── src/
│   ├── billing/          # Stripe billing & subscription logic
│   ├── blueprints/       # AI-generated automation blueprints
│   ├── common/           # Utilities, decorators, shared logic
│   ├── hubconfig/        # Core Django settings and ASGI/Wsgi
│   ├── local-cdn/        # Local CDN support (HTMX, Alpine)
│   ├── staticfiles/      # Static asset files
│   ├── styling/          # Tailwind CSS themes and configs
│   ├── teams/            # Team roles, invites, collaboration
│   ├── users/            # User auth, Allauth templates, profiles
│   └── workflows/        # Workflow creation, editing, publishing
│
├── db.sqlite3            # Local development DB
├── manage.py             # Django entry point
├── .env                  # Environment variables
├── .gitignore
├── README.md
├── project_structure.md  # Detailed project breakdown
└── requirements.txt      # Python dependencies
````

---

## 🛠️ Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Josephjbassey/FlowForge.git
cd FlowForge
```

### 2. Create a Virtual Environment

**macOS/Linux:**

```bash
python3 -m venv venv
source venv/bin/activate
```

**Windows:**

```bash
python -m venv venv
.\venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### 4. Set Up Environment Variables

```bash
cp .env.example .env
```

Update `.env` with the following values:

```env
DEBUG=True
DJANGO_SECRET_KEY=your-secret-key
DATABASE_URL=sqlite:///db.sqlite3
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLIC_KEY=pk_test_...
OPENAI_API_KEY=sk-...
```

Generate a Django secret key:

```bash
python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

---

### 5. Run Migrations

```bash
python manage.py migrate
```

### 6. Create a Superuser

```bash
python manage.py createsuperuser
```

---

### 7. Build Tailwind Assets

```bash
python manage.py tailwind install
python manage.py tailwind build
```

---

### 8. Run Development Server

```bash
python manage.py runserver
```

Visit: [http://127.0.0.1:8000](http://127.0.0.1:8000)

---

## 🧠 Features (WIP)

* 🔐 Authentication via django-allauth
* 📄 AI-generated process blueprints
* 📦 Team collaboration and role management
* 💳 Subscription billing with Stripe
* 📊 Dashboard for automation analytics
* 🪄 Integration-ready: Zapier, Make, APIs

---

## 🧪 TODO / Coming Soon

* ✅ AI Blueprint Wizard (multi-step)
* ✅ Stripe Checkout Sessions
* ⏳ AI Chat Agent via OpenAI Assistants
* ⏳ PDF Export of Workflows
* ⏳ Redis + Celery queue integration

---

## 📘 References & Tools

* [Django Docs](https://docs.djangoproject.com/)
* [Tailwind CSS](https://tailwindcss.com/)
* [Stripe API](https://stripe.com/docs/api)
* [OpenAI API](https://platform.openai.com/docs)
* [HTMX](https://htmx.org/)

---

## 📄 License

MIT © 2025 Joseph Bassey — Built with ❤️ for the AI-first automation generation.

---

> “I LOVE BUSINESS RESEARCH AND TECHNOLOGY.” — FlowForge Manifesto
