FROM node:alpine as builder 
WORKDIR '/opt'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build 

FROM nginx:stable
RUN apt update -y

RUN     chown -R nginx:nginx /var/cache/nginx && \
        chown -R nginx:nginx /var/log/nginx && \
        chown -R nginx:nginx /etc/nginx/conf.d
RUN     touch /var/run/nginx.pid && \
        chown -R nginx:nginx /var/run/nginx.pid

USER nginx

COPY --chown=nginx:nginx --from=builder /opt/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]

HEALTHCHECK --interval=10s --timeout=5s --retries=3 CMD curl -sS 127.0.0.1 || exit 1

EXPOSE 80
