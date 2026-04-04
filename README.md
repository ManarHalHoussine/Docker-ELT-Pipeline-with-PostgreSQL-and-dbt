# Docker ELT Pipeline with PostgreSQL

This project demonstrates a simple ELT (Extract, Load, Transform) pipeline using Docker, PostgreSQL and Python.

The goal of this project is to simulate a small data pipeline where data is extracted from a source database and loaded into another database automatically using a Python script running inside a Docker container.

---

## Project Architecture

The system is composed of three containers:

- **source_postgres** → PostgreSQL database containing the initial data
- **destination_postgres** → PostgreSQL database where the data will be loaded
- **elt_script** → Python container responsible for performing the ELT process

Workflow:

Source Database → Python ELT Script → Destination Database

The Python script performs the following steps:

1. Waits for the source database to become available
2. Extracts the database using `pg_dump`
3. Loads the extracted data into the destination database using `psql`

---

## Technologies Used

- Docker
- Docker Compose
- PostgreSQL
- Python
- pg_dump / psql
