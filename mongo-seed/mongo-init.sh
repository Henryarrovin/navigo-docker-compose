#!/bin/bash
echo "Seeding MongoDB..."

mongoimport --username root --password root --authenticationDatabase admin \
  --db local-db --collection categories --file /mongo-seed/categories.json --jsonArray

mongoimport --username root --password root --authenticationDatabase admin \
  --db local-db --collection mapzones --file /mongo-seed/mapzones.json --jsonArray

mongoimport --username root --password root --authenticationDatabase admin \
  --db local-db --collection products --file /mongo-seed/products.json --jsonArray
