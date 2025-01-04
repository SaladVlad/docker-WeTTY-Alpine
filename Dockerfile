# Use Alpine Linux as the base image for the smallest possible image size
FROM alpine:latest

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install required dependencies
RUN apk update && apk add --no-cache \
    bash \
    curl \
    openssh \
    git \
    libc6-compat \
    python3 \
    python3-dev \
    make \
    g++ \
    nodejs \
    npm && \
    ln -sf python3 /usr/bin/python && \
    npm install -g pnpm && \
    python3 -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install virtualenv && \
    apk add --no-cache py3-setuptools

# Activate the virtual environment and install Python packages
RUN /venv/bin/pip install setuptools

# Clone the WeTTY repository and install dependencies
RUN git clone https://github.com/butlerx/wetty.git /wetty && \
    cd /wetty && \
    pnpm install && \
    pnpm run build

# Clean up unnecessary files
RUN rm -rf /var/lib/apk/lists/* /root/.cache

# Debug information
RUN node -v && npm -v && pnpm -v
RUN ls -al /wetty/build

# Expose the ports
EXPOSE 3000

# Configure WeTTY to use bash shell
CMD ["node", "/wetty/build/main.js", "--base", "/bash", "--command", "/bin/bash", "--debug"]
