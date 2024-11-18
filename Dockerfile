# Step 1: Base image
FROM nginx:latest

# Step 2: Copy the static website files to the NGINX html directory
COPY app /usr/share/nginx/html

# Step 3: Copy a custom NGINX configuration file to enable HTTPS
COPY nginx.conf /etc/nginx/nginx.conf

# Step 4: Generate a self-signed certificate
RUN apt-get update && apt-get install -y openssl && \
    mkdir -p /etc/ssl/certs && \
    mkdir -p /etc/ssl/private && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/selfsigned.key \
        -out /etc/ssl/certs/selfsigned.crt \
        -subj "/C=US/ST=Example/L=Example/O=Example/OU=IT Department/CN=localhost"

# Expose HTTP and HTTPS ports
EXPOSE 80 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
