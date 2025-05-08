# Étape 1 - Construction
FROM python:3.9-slim as builder

WORKDIR /app
COPY requirements.txt .

RUN pip install --user -r requirements.txt

# Étape 2 - Runtime
FROM python:3.9-slim

WORKDIR /app

# Copie des dépendances installées
COPY --from=builder /root/.local /root/.local
COPY . .

# Garantit que les scripts dans .local sont utilisables
ENV PATH=/root/.local/bin:$PATH

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]