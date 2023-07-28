# Menggunakan base image node:14
FROM node:14
# Membuat directory app, setting working directory
WORKDIR /usr/src/app
# Bundle source
COPY package*.json app.js ./
# Menginstal dependency
RUN npm install
# Expose port (for documentation)
EXPOSE 3000
# Run the app
CMD [ "node", "app.js"]