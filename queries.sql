/*Queries that provide answers to the questions from all projects.*/

SELECT *
from animals
WHERE name LIKE '%mon';
SELECT *
from animals
WHERE date_of_birth > '2015-12-31'
  and date_of_birth < '2020-01-01';
SELECT *
from animals
WHERE neutered = true
  and escape_attempts < 3;
SELECT date_of_birth
from animals
WHERE name = 'Agumon'
   or name = 'Pikachu';
SELECT name, escape_attempts
from animals
WHERE weight_kg > 10.5;
SELECT *
from animals
WHERE neutered = true;
SELECT *
from animals
WHERE name NOT LIKE 'Gabumon';
SELECT *
from animals
WHERE weight_kg >= 10.4
  and weight_kg <= 17.3;

BEGIN;
UPDATE animals
set species = 'unspecified'
where species IS NULL;
ROLLBACK;

BEGIN;
UPDATE animals
set species = 'digimon'
where name LIKE '%mon';
COMMIT;

BEGIN;
UPDATE animals
set species = 'pokemon'
where species IS NULL;
COMMIT;

BEGIN;
DELETE
from animals;
ROLLBACK;

BEGIN;
DELETE
from animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_savepoint;
UPDATE animals
set weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT delete_savepoint;
UPDATE animals
set weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

/* Queries to answer questions below*/
SELECT count(*)
from animals;
SELECT count(*)
from animals
WHERE escape_attempts < 1;
SELECT AVG(weight_kg)
FROM animals;

SELECT neutered, Max(escape_attempts)
FROM animals
GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;
SELECT species, AVG(escape_attempts)
FROM animals
GROUP BY species, date_of_birth
HAVING date_of_birth >= '1990-01-01'
   AND date_of_birth <= '2000-12-31';

SELECT *
FROM animals
         INNER JOIN owners o on o.id = animals.owners_id
WHERE owners_id = 4;

SELECT *
FROM animals
         INNER JOIN species s on s.id = animals.species_id
WHERE species_id = 1;

SELECT *
FROM animals
         RIGHT JOIN owners o on o.id = animals.owners_id;

SELECT species.name, COUNT(species_id)
FROM animals
         JOIN species ON species_id = species.id
WHERE species.name = 'Pokemon'
   OR species.name = 'Digimon'
group by species.name;

SELECT *
FROM owners
         JOIN animals ON owners.id = animals.owners_id
WHERE full_name = 'Jennifer Orwell'
  AND species_id = 2;

SELECT owners.full_name,
       animals.name
FROM owners
         JOIN animals ON owners.id = animals.owners_id
WHERE full_name = 'Dean Winchester'
  AND escape_attempts = 0;

SELECT full_name,
       COUNT(animals) as animals_owned
FROM animals
         JOIN owners ON animals.owners_id = owners.id
GROUP BY owners.full_name
ORDER BY animals_owned DESC
LIMIT 1;