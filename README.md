# Docker Container Setup for WeTTY

This README provides instructions on how to set up and run a Docker container that installs and configures WeTTY, a web-based terminal for accessing the shell in your browser. This is a standalone Alpine Linux instance, and you can do anything terminal-based inside the browser.

[Try it out](https://docker-wetty-alpine.onrender.com)

You can:
- Play Doom by running `DOOM/doom_ascii`
- See the rainbow matrix with `cmatrix | lolcat`
- Use `neofetch` to display system information
- Unzip files with `unzip`
- Download files with `wget`
- Edit files with the VIM editor

## Prerequisites

Ensure you have the following installed on your machine:

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)

## Dockerfile Overview

This Dockerfile sets up a container using **Alpine Linux** and installs the necessary dependencies to run **WeTTY**. The container is pre-configured to:

1. Install required packages like Python, Node.js, Git, and WeTTY dependencies.
2. Set up a Python virtual environment and install Python packages.
3. Clone the WeTTY repository and install its dependencies using **pnpm**.
4. Clean up unnecessary files to keep the image size small.
5. Expose port **3000** to access the web terminal.

## Setting Up the Docker Container

### Step 1: Clone the Repository

If you want to modify or track changes in the Dockerfile, first clone the repository with the following command:

```bash
git clone https://github.com/your/repository.git
cd your-repository
```

If you only want to build the Docker image without cloning the repository, you can proceed with the next step.

### Step 2: Build the Docker Image

To build the Docker image using the provided Dockerfile, use the following Docker command. This assumes you are in the same directory as the Dockerfile:

```bash
docker build -t wetty-docker .
```

- `-t wetty-docker`: This tag gives the image a name (`wetty-docker`), which you can use to reference the image later.

### Step 3: Run the Docker Container

Once the image is built, you can run the container with the following command:

```bash
docker run -d -p 3000:3000 --name wetty-container wetty-docker
```

- `-d`: Run the container in detached mode (in the background).
- `-p 3000:3000`: Exposes port **3000** from the container to port **3000** on your host machine. This will be the port where WeTTY is available in your browser.
- `--name wetty-container`: Assigns a name to the running container.
- `wetty-docker`: The name of the image to run.

### Step 4: Access the Web Terminal

Once the container is running, you can access the terminal through your browser by navigating to:

```
http://localhost:3000
```

You'll be prompted with a web-based terminal, where you can interact with your container's shell.

### Step 5: Stopping and Removing the Container

To stop the running container:

```bash
docker stop wetty-container
```

To remove the container after stopping it:

```bash
docker rm wetty-container
```

## Notes

- This Dockerfile automatically installs WeTTY and configures it to use **bash** as the default shell.
- The container exposes **port 3000** to allow access to the web terminal through the browser.
- The virtual environment (`/venv`) is set up with Python 3 and several Python dependencies, including `setuptools` and `virtualenv`.
- If you wish to use a different shell or command, modify the `CMD` line in the Dockerfile.

## Troubleshooting

- **Error: Could not connect to port 3000**  
    Ensure the container is running (`docker ps`) and that the port mapping (`-p 3000:3000`) is correctly set.

- **Error: No command found**  
    Verify that the necessary binaries are installed by using the apk package manager, or checking the Dockerfile commands for proper package installation.

## Conclusion

You have successfully built and deployed WeTTY using Docker! Enjoy accessing your terminal through the browser with full shell capabilities.

--- 
