# Docker ELT Pipeline with PostgreSQL and dbt

This project demonstrates a simple **ELT (Extract, Load, Transform) data pipeline** using **Docker, PostgreSQL, Python, and dbt**.

The pipeline simulates a small data engineering workflow where data is extracted from a source database, loaded into a destination database, and transformed using **dbt models**.

---

# Project Architecture

The system is composed of four containers:

- **source_postgres** → PostgreSQL database containing the raw data  
- **destination_postgres** → PostgreSQL database where the data is loaded  
- **elt_script** → Python container responsible for extracting and loading the data  
- **dbt** → Transformation layer that builds analytics models from the loaded data  

Pipeline flow:
