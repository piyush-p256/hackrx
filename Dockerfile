FROM python:3.10-slim-buster

WORKDIR /app
COPY . /app

# 👇 FIX STARTS HERE: use archived Debian repo and install deps
RUN sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list && \
    apt-get update -o Acquire::Check-Valid-Until=false && \
    apt-get install -y awscli ffmpeg libsm6 libxext6 unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 5000

CMD ["python3", "app.py"]