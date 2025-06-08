# 🗂️ Project Structure – FlowForge SaaS Automation Platform

```bash
FlowForge/
│
├── requirements.txt
├── .env                  # Environment variables (DB URL, secrets, Stripe, etc.)
│
├── src/                  # Main Django project and modular apps
│   │
│   ├── billing/          # Stripe billing, payments, and invoicing
│   │   ├── models.py     # Plans, Subscriptions, Invoices
│   │   ├── signals.py    # Stripe webhook handlers
│   │   ├── views.py      # Payment flow views
│   │   ├── urls.py
│   │   └── utils.py      # Stripe helpers
│   │
│   ├── blueprints/       # AI-powered blueprint generator
│   │   ├── models.py     # Blueprint, Versions, Exported files
│   │   ├── views.py
│   │   ├── tasks.py      # Celery: AI calls, PDF gen
│   │   ├── urls.py
│   │   ├── prompts.py    # Prompt templates & logic
│   │   ├── services.py   # GPT/OpenAI integrations
│   │   └── utils.py
│   │
│   ├── common/           # Shared utilities, mixins, and helpers
│   │   ├── decorators.py
│   │   ├── helpers.py
│   │   └── constants.py
│   │
│   ├── hubconfig/        # Project-level Django settings
│   │   ├── __init__.py
│   │   ├── settings.py
│   │   ├── urls.py
│   │   ├── wsgi.py
│   │   └── asgi.py
│   │
│   ├── local-cdn/        # Optional local CDN for assets (fonts, libs)
│   │
│   ├── staticfiles/      # Static: CSS, JS, logos, Mermaid, etc.
│   │
│   ├── styling/          # Tailwind CSS, custom themes, UI settings
│   │   ├── __init__.py 
│   │   ├── settings.py
│   │   ├── static_src/
│   │   ├── templates/     # Django templates (Tailwind + HTMX compatible)
│   │   └── apps.py 
│   │
│   │
│   ├── teams/            # Team collaboration, invites, roles
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   └── serializers.py
│   │
│   ├── users/            # Authentication, profiles, and permissions
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── serializers.py
│   │   └── forms.py
│   │
│   ├── workflows/        # Automation flow UI (drag-and-drop + logic)
│   │   ├── models.py
│   │   ├── views.py
│   │   ├── urls.py
│   │   ├── serializers.py
│   │   └── utils.py
│   │
│   └── manage.py
│
├── db.sqlite3            # SQLite for local dev (can be replaced by Postgres)
├── .gitignore
├── Dockerfile
├── project_structure.md  # 🗂️ This file
├── README.md             # 📘 Project Overview
└── .env.example          # Example environment variables
