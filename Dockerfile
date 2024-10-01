# Use the official Nginx base image
FROM nginx:alpine

# Install required packages for gcloud
RUN apk add --no-cache \
    curl \
    bash \
    python3 \
    py3-pip \
    && pip3 install --upgrade pip setuptools \
    && curl -sSL https://sdk.cloud.google.com | bash \
    && echo "source /root/google-cloud-sdk/path.bash.inc" >> /root/.bashrc \
    && echo "source /root/google-cloud-sdk/completion.bash.inc" >> /root/.bashrc

# Expose port 80
EXPOSE 80

# Set the default command
CMD ["nginx", "-g", "daemon off;"]
