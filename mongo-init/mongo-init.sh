#!/bin/bash
echo "⏳ Waiting for MongoDB to be ready..."
until mongosh --host mongo --eval "db.stats()" >/dev/null 2>&1; do
  sleep 1
done
echo "✅ MongoDB is up!"

echo "📁 Creating collections..."
mongosh --host mongo -u root -p root --authenticationDatabase admin local-db --eval '
  db.createCollection("products");
  db.createCollection("categories");
  db.createCollection("mapzones");
'

echo "📦 Importing products.json..."
mongoimport --host mongo -u root -p root --authenticationDatabase admin \
  --db local-db --collection products --file /docker-entrypoint-initdb.d/products.json --type json --jsonArray

echo "📦 Importing categories.json..."
mongoimport --host mongo -u root -p root --authenticationDatabase admin \
  --db local-db --collection categories --file /docker-entrypoint-initdb.d/categories.json --type json --jsonArray

echo "📦 Importing mapzones.json..."
mongoimport --host mongo -u root -p root --authenticationDatabase admin \
  --db local-db --collection mapzones --file /docker-entrypoint-initdb.d/mapzones.json --type json --jsonArray

echo "✅ Initialization complete."
