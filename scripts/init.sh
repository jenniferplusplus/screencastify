dcFile="$(realpath "$(dirname "$(realpath "$0")")"/..)/docker-compose.yml"

echo "Init MongoDB"
docker-compose -f "$dcFile" up -d mongo
docker-compose -f "$dcFile" exec mongo mongosh mongodb://localhost/screencastify -f /scripts/mongo.js
docker-compose -f "$dcFile" stop mongo

echo
echo "Build app image"
docker-compose -f "$dcFile" build

echo
echo "Build service containers"
docker-compose -f "$dcFile" up --no-start
