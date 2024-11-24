echo "entrypoint.sh started - Check that we have env vars "

find /usr/share/nginx/html \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i "s#http://localhost:3000#$API_URL#g"

echo "API_URL:$API_URL"

echo "entrypoint.sh finished ..."
exec "$@"
