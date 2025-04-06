docker build ../ruby27 -t ruby27

docker run -it \
  --restart unless-stopped \
  -e POSTGRES_HOST=host.docker.internal \
  -e POSTGRES_DB=baby_dev \
  -e POSTGRES_USER=app \
  -e POSTGRES_PASSWORD=postgres \
  -e ELASTICSEARCH_URL=http://host.docker.internal:9200 \
  -e PG=postgresql://app:postgres@host.docker.internal:5432/baby_dev \
  -p 3000:3000 \
  -d \
  -v $HOME/.ssh/id_ed25519:/root/.ssh/id_ed25519 \
  -v $HOME/.ssh/known_hosts:/root/.ssh/known_hosts \
  --name baby \
  ruby27


