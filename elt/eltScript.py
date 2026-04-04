import subprocess
import time


# Function that waits until a PostgreSQL service becomes available
def wait_for_postgres(host, max_retries=5, delay_seconds=5):
    """
    Wait for PostgreSQL to become available before continuing the ELT process.
    This prevents the script from failing if the database container is not ready yet.
    """
    retries = 0

    while retries < max_retries:
        try:
            # Check if PostgreSQL is accepting connections
            result = subprocess.run(
                ["pg_isready", "-h", host],
                check=True,
                capture_output=True,
                text=True
            )

            if "accepting connections" in result.stdout:
                print("Successfully connected to PostgreSQL!")
                return True

        except subprocess.CalledProcessError as e:
            print(f"Error connecting to PostgreSQL: {e}")

            retries += 1

            print(
                f"Retrying in {delay_seconds} seconds... (Attempt {retries}/{max_retries})"
            )

            time.sleep(delay_seconds)

    print("Max retries reached. Exiting.")
    return False


# Wait for the source database before starting the ELT process
if not wait_for_postgres(host="source_postgres"):
    exit(1)

print("Starting ELT script...")


# Configuration for the source PostgreSQL database
source_config = {
    'dbname': 'source_db',
    'user': 'manar',
    'password': 'secret',

    # Docker Compose service name used as hostname
    'host': 'source_postgres'
}


# Configuration for the destination PostgreSQL database
destination_config = {
    'dbname': 'destination_db',
    'user': 'manar',
    'password': 'secret',

    # Docker Compose service name used as hostname
    'host': 'destination_postgres'
}


# Command to dump the source database into a SQL file
dump_command = [
    'pg_dump',
    '-h', source_config['host'],
    '-U', source_config['user'],
    '-d', source_config['dbname'],
    '-f', 'data_dump.sql',

    # Prevent password prompt
    '-w'
]


# Set PGPASSWORD so pg_dump can authenticate automatically
subprocess_env = dict(PGPASSWORD=source_config['password'])


# Execute the dump command
subprocess.run(dump_command, env=subprocess_env, check=True)


# Command to load the dumped SQL file into the destination database
load_command = [
    'psql',
    '-h', destination_config['host'],
    '-U', destination_config['user'],
    '-d', destination_config['dbname'],

    # Print commands while executing
    '-a',

    '-f', 'data_dump.sql'
]


# Set password for the destination database
subprocess_env = dict(PGPASSWORD=destination_config['password'])


# Execute the load command
subprocess.run(load_command, env=subprocess_env, check=True)


print("Ending ELT script...")