# syntax=docker/dockerfile:1

FROM node:18-alpine
WORKDIR /app
COPY getting-started-app .
RUN yarn install --production
CMD ["node", "src/index.js"]
EXPOSE 3000
