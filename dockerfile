# Use a multi-stage build to minimize the final image size

# Stage 1: Build the Rust application
FROM rust:1.83-slim-bullseye AS builder

# Create a working directory inside the container
WORKDIR /app

# Copy the Cargo.toml and Cargo.lock files first for caching
COPY Cargo.toml Cargo.lock ./

# Copy the rest of the application code
COPY src ./src

# Download dependencies (this step is cached if the files haven't changed)
RUN cargo fetch

# Install curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Build the application in release mode
RUN cargo build --release

# Stage 2: Create the final image
FROM debian:bullseye-slim

# Install necessary runtime dependencies (if any)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/target/release /app/src

# Copy the environments
COPY ./public ./public

# Expose a port application needs
EXPOSE 5050

# Set the entrypoint for the container
CMD ["./src/static-server"]

