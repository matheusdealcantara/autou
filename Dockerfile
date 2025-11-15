FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# torna entrypoint executável
RUN chmod +x ./entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["./entrypoint.sh"]
CMD ["gunicorn", "autou.wsgi:application", "-b", "0.0.0.0:${PORT:-10000}", "--workers", "2"]