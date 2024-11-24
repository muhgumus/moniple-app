FROM nginx:alpine
COPY dist/web /usr/share/nginx/html
COPY entrypoint.sh .
EXPOSE 80

CMD chmod +x ./entrypoint.sh; sync; ./entrypoint.sh; sync; nginx -g 'daemon off;'
