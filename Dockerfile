# Set the Python version as a build-time argument
ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Set environment variables for Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV PATH="/opt/venv/bin:$PATH"

# Create and activate virtual environment
RUN python -m venv /opt/venv

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    libjpeg-dev \
    libcairo2 \
    curl \
    gnupg \
    ca-certificates

# Install Node.js (for Tailwind support)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Create app directory
RUN mkdir -p /code
WORKDIR /code

# Copy project files
COPY ./src /code

# Copy requirements and install
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install -r /tmp/requirements.txt

# Optional: copy local CDN (e.g., /static/vendor/)
COPY ./static /code/static

# Tailwind Build Step
WORKDIR /code/theme/static_src
RUN npm install && npm run build

# Back to main directory for Django commands
WORKDIR /code

# Set environment variables
ARG DJANGO_SECRET_KEY
ENV DJANGO_SECRET_KEY=${DJANGO_SECRET_KEY}

ARG DJANGO_DEBUG=0
ENV DJANGO_DEBUG=${DJANGO_DEBUG}

# Django static and vendor
RUN python manage.py vendor_pull
RUN python manage.py collectstatic --noinput

# Set project name for Gunicorn
ARG PROJ_NAME="hubconfig"

# Start script
RUN printf "#!/bin/bash\n" > ./paracord_runner.sh && \
    printf "RUN_PORT=\"\${PORT:-8000}\"\n\n" >> ./paracord_runner.sh && \
    printf "python manage.py migrate --no-input\n" >> ./paracord_runner.sh && \
    printf "gunicorn ${PROJ_NAME}.wsgi:application --bind \"0.0.0.0:\$RUN_PORT\"\n" >> ./paracord_runner.sh
RUN chmod +x paracord_runner.sh

CMD ["./paracord_runner.sh"]