# Use Nginx as base image
FROM nginx:alpine

# Copy HTML file to nginx html directory
COPY index.html /usr/share/nginx/html/index.html
