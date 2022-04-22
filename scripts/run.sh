projectPath="$(realpath $(dirname $(realpath "$0"))/..)"
dfFile="$projectPath/docker-compose.yml"

# Check if containers exist already, and init if not
container=$(docker ps --filter name=screencastify_app -a -q)
if [ -z "$container" ]; then
    echo "Service container not found"
    sh "$projectPath/scripts/init.sh"
fi

docker-compose -f "$dfFile" start
