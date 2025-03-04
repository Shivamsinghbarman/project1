# # start by pulling the ubuntu image
# FROM python:3.12.4

# # Install required dependencies for building PyAudio
# RUN apt-get update && apt-get install -y python3-distutils
# # Create Work directory
# WORKDIR /main

# # Copy the Code to Working Directory
# COPY . /main

# # Installing Requirements.txt
# RUN pip install --upgrade -r requirements.txt --no-cache-dir

# # Expose Port 80
# EXPOSE 8080

# # configure the container to run in an executed manner
# ENTRYPOINT [ "python" ]

# # Run the Pyscrapy API mainlication
# CMD ["main.py" ]
# Use Python 3.11 instead of 3.12 for better compatibility
FROM python:3.11

# Install system dependencies including PortAudio for PyAudio
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-distutils \
    portaudio19-dev \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy only the requirements file first
COPY requirements.txt /app/

# Upgrade pip, setuptools, and wheel BEFORE installing dependencies
RUN pip install --upgrade pip setuptools wheel

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . /app

# Expose the application port
EXPOSE 8080

# Configure entry point
ENTRYPOINT ["python"]

# Run the application
CMD ["app.py"]
