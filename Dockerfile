# Use Ubuntu 20.04 as base image
FROM ubuntu:20.04

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install required dependencies
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    openssh-server \
    npm \
    ca-certificates \
    git && \
    # Install pnpm globally
    npm install -g pnpm && \
    # Install Node.js 18.x
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    # Clone the WeTTY repository
    git clone https://github.com/butlerx/wetty.git /wetty && \
    # Set working directory to /wetty
    cd /wetty && \
    # Install dependencies using pnpm
    pnpm install && \
    # Build WeTTY from source (using the correct build command)
    pnpm run build && \
    # Clean up
    rm -rf /var/lib/apt/lists/*

# Debug information
RUN node -v && npm -v && pnpm -v
RUN ls -al /wetty/build

# Expose the ports
EXPOSE 3000

# Configure WeTTY to use bash shell
CMD ["node", "wetty/build/main.js", "--base", "/bash", "--command", "/bin/bash", "--debug"]
