# Base Python image
ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Prevent .pyc files and enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libjpeg-dev \
    libcairo2 \
    curl \
    gnupg \
    ca-certificates \
    nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Optional: install Node.js (latest LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Set working directory
WORKDIR /code

# Copy project requirements and install them
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt

# Copy the entire source code
COPY ./src /code

# Add local CDN libraries (e.g., HTMX, Alpine.js)
RUN mkdir -p /code/theme/static/vendor && \
    curl -o /code/theme/static/vendor/htmx.min.js https://unpkg.com/htmx.org@1.9.2 && \
    curl -o /code/theme/static/vendor/alpine.min.js https://unpkg.com/alpinejs@3.13.1/dist/cdn.min.js

# Build Tailwind assets
WORKDIR /code/theme/static_src
RUN npm install && npm run build

# Return to main project dir for collectstatic
WORKDIR /code

# Pull vendor assets and collect static files
RUN python manage.py vendor_pull
RUN python manage.py collectstatic --noinput

# Environment variables
ARG DJANGO_SECRET_KEY
ENV DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY}

ARG DJANGO_DEBUG=0
ENV DJANGO_DEBUG=${DJANGO_DEBUG}

# Default project entry (update as needed)
ARG PROJ_NAME="hubconfig"

# Create startup script
RUN printf "#!/bin/bash\n" > ./paracord_runner.sh && \
    printf "RUN_PORT=\"\${PORT:-8000}\"\n\n" >> ./paracord_runner.sh && \
    printf "python manage.py migrate --no-input\n" >> ./paracord_runner.sh && \
    printf "gunicorn ${PROJ_NAME}.wsgi:application --bind \"0.0.0.0:\$RUN_PORT\"\n" >> ./paracord_runner.sh

RUN chmod +x paracord_runner.sh

# Final command
CMD ./paracord_runner.sh
