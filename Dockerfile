FROM node:18-alpine as builder
WORKDIR /app
COPY . .
RUN yarn install
RUN yarn build 

FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html 
RUN rm -rf ./*
COPY --from=builder /app/build . 

ENTRYPOINT ["nginx", "-g", "daemon off;"]