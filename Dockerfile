FROM kong:0.13.1-alpine

ADD request-limit-validator /opt/babylon/plugins/request-limit-validator

WORKDIR /opt/babylon/plugins/request-limit-validator
RUN ls -R .
RUN luarocks make request-limit-validator-dev-1.rockspec

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

CMD ["/usr/local/openresty/nginx/sbin/nginx", "-c", "/usr/local/kong/nginx.conf", "-p", "/usr/local/kong/"]