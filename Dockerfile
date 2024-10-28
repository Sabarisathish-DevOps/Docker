FROM node:18-alpine AS base

RUN apk add --no-cache git
RUN apk --no-cache add --virtual builds-deps build-base python3

WORKDIR /app
COPY package.json ./

RUN npm i --legacy-peer-deps

COPY . .

RUN npm run build


# Final stage
FROM node:18-alpine

WORKDIR /app
COPY --from=base /app/dist ./dist
COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/package.json ./package.json


EXPOSE 5102
ENV HOSTNAME "0.0.0.0"

CMD ["node", "dist/main.js"]
