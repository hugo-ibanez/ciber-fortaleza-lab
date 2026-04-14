FROM python:3.10-slim
WORKDIR /app
COPY . /app
RUN pip install pybuilder
EXPOSE 5000
# Comando por defecto para mantener el contenedor vivo simulando la app
CMD ["python", "-m", "http.server", "5000"]