# Lightweight Python base image
FROM python:3.8-slim


# Install PostgreSQL client tools (pg_dump, psql, pg_isready)
RUN apt-get update && apt-get install -y postgresql-client-15


# Copy the ELT script into the container
COPY eltScript.py .


# Default command executed when the container starts
CMD ["python", "eltScript.py"]