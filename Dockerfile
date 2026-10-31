FROM nginx:alpine

LABEL maintainer="Codyssey Practice"

COPY web/ /usr/share/nginx/html/

EXPOSE 80
