#using heavy image with plenty tools like curl apt shell

FROM node:20
#we stay in default root(ERR1)
WORKDIR /app
#we copy all files(ERR2)
COPY app/package*.json ./
RUN npm install
COPY app/server.js .
EXPOSE 3000

CMD ["node", "server.js"]


