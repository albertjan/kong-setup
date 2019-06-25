1. `docker-compose up postgres -d` remember the docker container name
2. `docker network ls` find the network name belonging to the postgres container
3. `./migrate network_name docker_container_name` this initialise the database for kong
4. `docker-compose up` should result in kong starting and the kong dashboard should be available at http://localhost:8080
5. go to API and add an api in the kong dashboard:
    - host: localhost
    - uris: /httpbin/get
    - methods: GET
    - upstream_url: http://httpbin/get
6. go to plugins and add the `request-transformer` plugin and in the append section under the headers section add `X-Testing: 'a-header-value'`
7. do a request to `http://localhost:8000/httpbin/get` to check if it works you should get something like this back:
```
{
  "args": {},
  "headers": {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "en-GB,en-US;q=0.9,en;q=0.8",
    "Connection": "keep-alive",
    "Dnt": "1",
    "Host": "localhost:8000",
    "Upgrade-Insecure-Requests": "1",
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36",
    "X-Forwarded-Host": "localhost",
    "X-Testing": "'a-header-value'"
  },
  "origin": "172.21.0.1",
  "url": "http://localhost/get"
}
```
8. if you copy the url from the `request` file you'll see the site will only list 100 query parameters while the request has 118.