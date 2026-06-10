# Use a lightweight Ubuntu/Debian base image that includes a bash shell
FROM ubuntu:22.04

# Prevent interactive prompts during installation phase
ENV DEBIAN_FRONTEND=noninteractive

# Install core application prerequisites: fortune, cowsay, and netcat
RUN apt-get update && apt-get install -y \
    fortune-mod \
    cowsay \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Add utility paths to the system environment path variable
ENV PATH="${PATH}:/usr/games"

# Set up a clean working directory inside the container
WORKDIR /app

# Copy the Wisecow script from your local clone into the image
COPY wisecow.sh .

# Ensure the main application script is granted execution permissions
RUN chmod +x wisecow.sh

# Expose the network port the application listens on (default web traffic port)
EXPOSE 4499

# Execute the application script when the container initializes
CMD ["./wisecow.sh"]
