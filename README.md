# data.gift

Stack to host data on [data.gift](data.gift) based on [mu.semte.ch](mu.semte.ch).

## Boot up the system

Boot the system using docker-compose.

    cd /path/to/data.gift
    docker-compose up

You can shut down using `docker-compose stop` and remove everything using `docker-compose rm`.

## URL standard

Data on data.gift is hosted per user on a subdomain `<user>.data.gift`.

URLs are compliant with the following guidelines:
* Semantic vocabularies
  * `/vocabularies/:name/:version`
  * `/vocabularies/:name`: redirects to the latest version of a semantic vocabulary
* [JSON-LD contexts](https://json-ld.org/)
  * `/contexts/:name/:version/context.json`: 
  * `/contexts/:name/context.json`: redirects to the latest version of a context
* Resources
  * `/:resource-type/:id`: data resources (e.g. `/accounts/8bbf734e-967a-4c59-9923-0b104dc42f92`)

## Roadmap
* Upgrade to dispatcher supporting content negotiation
