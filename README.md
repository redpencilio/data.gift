# data.gift

Stack to host data on data.gift based on mu.semte.ch.

## Boot up the system

Boot the system using docker-compose.

    cd /path/to/mu-project
    docker-compose up

You can shut down using `docker-compose stop` and remove everything using `docker-compose rm`.

## URL standard

Data on data.gift is hosted per user on a subdomain `<user>.data.gift`.

URLs are compliant with the following guidelines:
* `/vocabularies/:name/:version`: semantic vocabularies
* `/vocabularies/:name`: redirects to the latest version of a semantic vocabulary
* `/contexts/:name/:version/context.json`: [JSON-LD contexts](https://json-ld.org/)
* `/contexts/:name/context.json`: redirects to the latest version of a [JSON-LD contexts](https://json-ld.org/)
* `/:resource-type/:id`: data resources (e.g. `/accounts/8bbf734e-967a-4c59-9923-0b104dc42f92`)

## Roadmap
* Upgrade to dispatcher supporting content negotion
