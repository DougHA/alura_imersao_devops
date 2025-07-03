# 1. Imagem base
# Usamos uma imagem oficial do Python. A tag 'slim' é uma boa escolha por ser leve.
FROM python:3.10-slim

# 2. Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# 3. Instala as dependências
# Copiamos primeiro o requirements.txt e instalamos as dependências.
# Isso aproveita o cache de camadas do Docker: as dependências só serão reinstaladas
# se o arquivo requirements.txt for alterado, tornando os builds futuros mais rápidos.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copia o código da aplicação
COPY . .

# 5. Expõe a porta que a aplicação usará
EXPOSE 8000

# 6. Comando para iniciar a aplicação
# Usamos 0.0.0.0 para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
