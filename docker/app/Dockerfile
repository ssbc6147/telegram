# BaseImage
FROM centos:7

# set ruby version to be installed
ARG RUBY_VER="2.6.3"
ARG BUNDLE_VER="2.0.1"
ARG NODE_VER="10.16.3"

# package update & install
# Dockerは文を実行するたびにイメージのレイヤーを作成されてしまうので ; でワンライナーにする \ で次行に続く
RUN yum -y update; \
  yum -y install git bzip2 gcc-c++ make openssl-devel readline-devel zlib-devel \
  sqlite-devel mysql-devel ImageMagick \
  autoconf curl wget glibc-headers libyaml-devel; \
  yum -y install man nano less which; \
  yum clean all

# install rbenv & ruby-build
RUN git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv; \
  git clone https://github.com/sstephenson/ruby-build.git /usr/local/rbenv/plugins/ruby-build; \
  echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh; \
  echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh; \
  echo 'eval "$(rbenv init --no-rehash -)"' >> /etc/profile.d/rbenv.sh

# install ruby & bundler
RUN source /etc/profile.d/rbenv.sh; \
  rbenv install ${RUBY_VER}; \
  rbenv global ${RUBY_VER}; \
  gem install bundler -v ${BUNDLE_VER}

# install nodenv & node-build
RUN git clone https://github.com/nodenv/nodenv.git /usr/local/nodenv; \
  git clone https://github.com/nodenv/node-build.git /usr/local/nodenv/plugins/node-build; \
  echo 'export NODENV_ROOT="/usr/local/nodenv"' >> /etc/profile.d/nodenv.sh; \
  echo 'export PATH="${NODENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/nodenv.sh; \
  echo 'eval "$(nodenv init --no-rehach -)"' >> /etc/profile.d/nodenv.sh

# install node & bundler
RUN source /etc/profile.d/nodenv.sh; \
  nodenv install ${NODE_VER}; \
  nodenv global ${NODE_VER}

# setting time & langage & timezone
ENV TZ=Japan
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja

# camp ver.
RUN  echo ':set encoding=utf-8' > ~/.vimrc; \
  echo 'export PS1="\[\033[35m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]\n[app] \$ "' >> ~/.bashrc

# setting docker
# build時の環境変数を指定
ARG WORK_DIR
RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR