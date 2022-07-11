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

select animals.name
from animals
         join visits on animals.id = visits.animal_id
         join vets on vets.id = visits.vet_id
where vets.name = 'William Tatcher'
order by visits.date_of_visit desc
limit 1;

select count(distinct animal_id)
from visits
         join vets v on v.id = visits.vet_id
where v.name = 'Stephanie Mendez';

select vets.name as name, s2.name as specialization
from vets
         left join specializations s on vets.id = s.vet_id
         left join species s2 on s2.id = s.species_id;

select animals.name
from animals
         join visits v on animals.id = v.animal_id
         join vets v2 on v2.id = v.vet_id
where v2.name = 'Stephanie Mendez'
  and v.date_of_visit >= '2020-04-01'
  and v.date_of_visit <= '2020-08-30';

select animals.name, count(v.animal_id) as count
from animals
         join visits v on animals.id = v.animal_id
group by animal_id, animals.name
order by count DESC
LIMIT 1;

select animals.name
from animals
         join visits v on animals.id = v.animal_id
         join vets v2 on v2.id = v.vet_id
where v2.name = 'Maisy Smith'
ORDER BY v.date_of_visit
limit 1;

select animals.name as animal_name, v2.name as vet_name, v.date_of_visit as visit_date
from animals
         join visits v on animals.id = v.animal_id
         join vets v2 on v2.id = v.vet_id
order by v.date_of_visit desc
limit 1;

select count(v)
from animals
         join visits v on animals.id = v.animal_id
         join vets v2 on v2.id = v.vet_id
         left join specializations s on v2.id = s.vet_id
where s.vet_id is null;

select s.name, count(s.name) as count
from animals
         join species s on s.id = animals.species_id
         join visits v on animals.id = v.animal_id
         join vets v2 on v2.id = v.vet_id
where v2.name = 'Maisy Smith'
group by s.name
order by count desc
limit 1;

explain analyze
SELECT COUNT(*)
FROM visits
where animal_id = 4;

explain analyze
SELECT *
FROM visits
where vet_id = 2;

explain analyze
SELECT *
FROM owners
where email = 'owner_18327@mail.com';


