FROM public.ecr.aws/docker/library/ruby:2.7.8-slim-bullseye


RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    file \
    g++ \
    git \
    gnupg \
    wget \
    imagemagick \
    libcurl4-gnutls-dev \
    libjemalloc2 \
    libmagickcore-dev \
    libmagickwand-dev \
    libpq-dev \
    make \
    nodejs \
    npm \
    openssh-client \
    patchelf \
    python \
    redis-tools \
    shared-mime-info \
    tzdata \
    zsh \
    fzf \
    ripgrep \
    vim && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


RUN (echo "deb http://apt.postgresql.org/pub/repos/apt/ bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list) && \
    (wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -) && \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends postgresql-client-16 && \
    patchelf --add-needed libjemalloc.so.2 /usr/local/bin/ruby && \
    apt-get purge patchelf -y

RUN npm install --global yarn@1.22.17 && \
    gem update --system 3.4.22 && gem install bundler

RUN git clone https://github.com/vchervanev/dotfiles.git /root/dotfiles && \
  cp -r /root/dotfiles/.  /root/ && \
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


ENV MALLOC_CONF="dirty_decay_ms:0,muzzy_decay_ms:0,narenas:2,background_thread:true,thp:never"
ENV NODE_OPTIONS="--max-old-space-size=8192 --huge-max-old-generation-size"

WORKDIR /code

CMD ["/bin/bash", "-c", "trap \"echo Shutting down; exit 0\" SIGTERM SIGINT SIGKILL; /bin/sleep infinity & wait"]
