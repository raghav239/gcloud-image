# Use a large base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    python3 \
    python3-pip \
    curl \
    wget \
    unzip \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install additional large packages
RUN pip3 install numpy pandas scipy matplotlib scikit-learn keras tensorflow

# Add the CIFAR-10 dataset (about 170 MB, we will add multiple copies to reach ~1.5 GB)
RUN wget -O /app/cifar-10-python.tar.gz https://www.cs.toronto.edu/~kriz/cifar-10-python.tar.gz \
    && mkdir /app/cifar-10 \
    && tar -xzf /app/cifar-10-python.tar.gz -C /app/cifar-10 \
    && rm /app/cifar-10-python.tar.gz

# Simulate size by copying the dataset multiple times (not practical but demonstrates size)
RUN cp -r /app/cifar-10 /app/cifar-10-copy1 && \
    cp -r /app/cifar-10 /app/cifar-10-copy2 && \
    cp -r /app/cifar-10 /app/cifar-10-copy3 && \
    cp -r /app/cifar-10 /app/cifar-10-copy4

# Copy your application files into the image
COPY . /app

# Set the working directory
WORKDIR /app

# Install any other dependencies your app may need
RUN pip3 install -r requirements.txt

# Define the command to run your application
CMD ["python3", "your_script.py"]
