# Étape 1 : Utiliser une image Node.js pour la construction
FROM node:16-alpine AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de package
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier tout le code source
COPY . .

# Construire l'application
RUN npm run build

# Étape 2 : Utiliser une image Nginx pour servir l'application
FROM nginx:stable-alpine

# Copier les fichiers générés par Vue.js dans le répertoire de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande de démarrage de Nginx
CMD ["nginx", "-g", "daemon off;"]
