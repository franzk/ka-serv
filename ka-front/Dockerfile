# === Dockerfile for FRONT (Vue.js + Nginx) ===

FROM node:23-slim AS build
WORKDIR /app

ARG VITE_KEYCLOAK_URL
ENV VITE_KEYCLOAK_URL=$VITE_KEYCLOAK_URL

# Install dependencies
COPY package*.json ./ 
RUN npm install       

# Copy source files and build the application
COPY . .              
COPY .env.prod .env
RUN npm run build

# Use Nginx to serve the built application
FROM nginx:1.27-alpine-slim
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
