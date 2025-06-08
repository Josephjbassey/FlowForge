# Set Python version as a build-time argument
ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Set virtual environment
RUN python -m venv /opt/venv
ENV PATH=/opt/venv/bin:$PATH

# Upgrade pip
RUN pip install --upgrade pip

# Python settings
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
    git \
    nodejs \
    npm \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV NPM_BIN_PATH=/usr/bin/npm
ENV DJANGO_SETTINGS_MODULE=hubconfig.settings

# Create app directory
RUN mkdir -p /code
WORKDIR /code

# Install Python dependencies
COPY requirements.txt /tmp/requirements.txt
COPY ./src /code
RUN pip install -r /tmp/requirements.txt

# Tailwind build (optional: wrap in try block if fragile)
RUN python manage.py tailwind install
RUN python manage.py tailwind build

# Collect static files
RUN python manage.py vendor_pull
RUN python manage.py collectstatic --noinput

# Environment args
ARG DJANGO_SECRET_KEY
ENV DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY}

ARG DJANGO_DEBUG=0
ENV DJANGO_DEBUG=${DJANGO_DEBUG}

# Default project name
ARG PROJ_NAME="hubconfig"

# Runtime script
RUN printf "#!/bin/bash\n" > ./paracord_runner.sh && \
    printf "RUN_PORT=\"\${PORT:-8000}\"\n\n" >> ./paracord_runner.sh && \
    printf "python manage.py migrate --no-input\n" >> ./paracord_runner.sh && \
    printf "gunicorn ${PROJ_NAME}.wsgi:application --bind \"0.0.0.0:\$RUN_PORT\"\n" >> ./paracord_runner.sh && \
    chmod +x paracord_runner.sh

# Clean up
RUN apt-get remove --purge -y \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Start container
CMD ./paracord_runner.sh
