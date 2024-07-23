# syntax=docker/dockerfile:1

FROM node:22-alpine
WORKDIR /app
COPY getting-started-app .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000
