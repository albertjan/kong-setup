docker run --rm \
    --net  kong-max-query-params_default \
    --link kong-max-query-params_postgres_1:kong-database \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=kong-database" \
    -e "KONG_PG_USER=kong" \
    -e "KONG_PG_PASSWORD=password" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    "kong:0.13.1-alpine" kong migrations up --v
