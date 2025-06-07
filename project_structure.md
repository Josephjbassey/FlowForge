# 🗂️ Project Structure – SaaS Automation Platform

```bash
saas_project/
│
├── manage.py
├── requirements.txt
├── .env                  # environment variables (API keys, DB, Stripe, etc.)
│
├── config/               # Django project settings
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   ├── wsgi.py
│   └── asgi.py
│
├── users/                # Custom user model + auth extensions
│   ├── models.py         # UserProfile, TeamMember, Roles
│   ├── views.py
│   ├── serializers.py    # if using DRF
│   ├── urls.py
│   └── forms.py
│
├── billing/              # Stripe + Subscription Management
│   ├── models.py         # Plans, Subscriptions, Invoices
│   ├── signals.py        # webhook handlers (stripe events)
│   ├── views.py          # payment endpoints, billing dashboard
│   ├── urls.py
│   └── utils.py          # Stripe API helpers
│
├── blueprints/           # Core AI Blueprint Generator app
│   ├── models.py         # Blueprint, BlueprintVersion, Export
│   ├── views.py          # Create blueprint, view blueprint, export PDF
│   ├── tasks.py          # Celery async tasks (AI call, PDF gen)
│   ├── urls.py
│   ├── serializers.py    # if using DRF
│   ├── prompts.py        # GPT prompt templates & logic
│   ├── services.py       # AI integration services (OpenAI/Claude calls)
│   └── utils.py          # helper functions (workflow parsing, validation)
│
├── workflows/            # Visualization and editing (frontend + backend)
│   ├── models.py         # WorkflowStep, WorkflowConnection
│   ├── views.py          # API endpoints for drag/drop UI
│   ├── urls.py
│   ├── serializers.py
│   └── utils.py          # e.g., Mermaid.js JSON converters
│
├── teams/                # Team collaboration, roles, permissions
│   ├── models.py         # Team, TeamMember, Role, Permissions
│   ├── views.py
│   ├── urls.py
│   └── serializers.py
│
├── common/               # Shared utilities, mixins, and decorators
│   ├── decorators.py     # permissions, throttle, etc.
│   ├── helpers.py        # common helper functions
│   └── constants.py
│
├── templates/            # Django templates (HTML + Tailwind CSS)
│
├── static/               # Static files: CSS, JS, images, Mermaid assets
│
└── celery.py             # Celery app configuration for async tasks
