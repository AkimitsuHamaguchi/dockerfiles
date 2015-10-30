FROM mysql:5.6.27

# utf8サポート
RUN { \
    echo '[mysqld]'; \
    echo 'character-set-server = utf8'; \
    echo 'innodb_file_per_table = 1'; \
    echo 'innodb_file_format=barracuda'; \
    echo 'innodb_large_prefix'; \
    echo "sql_mode = ''"; \
} > /etc/mysql/conf.d/charset.cnf

# タイムゾーンの設定
RUN cp -p /usr/share/zoneinfo/Japan /etc/localtime





