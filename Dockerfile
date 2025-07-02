# 1. Use uma imagem base oficial do Python.
# A imagem 'slim' é uma boa escolha por ser menor que a padrão,
# mas ainda inclui as dependências comuns necessárias, evitando problemas de compilação
# que podem ocorrer com a 'alpine'.
FROM python:3.11-slim

# 2. Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copia o arquivo de dependências e as instala.
# Fazer isso em um passo separado aproveita o cache de camadas do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 4. Copia o restante do código da aplicação.
COPY . .

# 5. Expõe a porta em que a aplicação será executada.
EXPOSE 8000

# 6. Comando para iniciar a aplicação com Uvicorn.
# O host '0.0.0.0' torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

