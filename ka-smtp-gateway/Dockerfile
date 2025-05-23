FROM node:24-slim

# Installer pnpm globalement
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Copier les fichiers de dépendances séparément pour optimiser le cache Docker
COPY package.json pnpm-lock.yaml ./

# Installer les dépendances
RUN pnpm install --frozen-lockfile

# Copier le reste du code
COPY . .

EXPOSE 1025

CMD ["pnpm", "start"]