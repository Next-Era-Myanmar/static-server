# Static Server with Docker Compose

This project sets up a lightweight static file server using Docker Compose. The server hosts static files from a local directory, making it accessible via HTTP.

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your system.
- [Docker Compose](https://docs.docker.com/compose/install/) installed.

## Setup Instructions

### 1. Directory Structure
Ensure your project directory has the following structure:

```plaintext
project-directory/
├── docker-compose.yml
├── public/
│   └── remote-widgets/  # Place your static files here
```

## Starting the Server

### Step 1: Navigate to the Directory
Open your terminal and navigate to the directory containing the `docker-compose.yml` file:

```bash
cd /path/to/your/project
```

### Step 2: Start the Server
Run the following command to start the static file server in detached mode:
```bash
docker compose up -d
```
- The server will host static files from the directory specified in the volumes section of docker-compose.yml.
- Access the server via http://localhost:5050/static/index.html (or the port you configured).

### Stopping the Server

To stop and remove the running server and related data, use:
```bash
docker compose down -v
```

### Restarting the Server

If you need to restart the server, run:
```bash
docker compose restart
```