# BaseImage
FROM mysql:8.0.17
# MySQLの設定ファイルをコピー
COPY my.cnf /etc/mysql/conf.d/
# ターミナル画面を見やすく変更
RUN echo 'export PS1="\n\[\033[35m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]\n[db] \$ "' >> ~/.bashrc