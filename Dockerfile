# syntax=docker/dockerfile:1

FROM node:23-alpine
WORKDIR /app
COPY getting-started-app .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000
