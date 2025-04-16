# === Dockerfile pour le FRONT (Vue.js + Nginx) ===
# ks-front/Dockerfile
FROM node:23-slim AS build
WORKDIR /app
COPY . .
RUN npm install && npm run build

FROM nginx:1.27-alpine-slim
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
