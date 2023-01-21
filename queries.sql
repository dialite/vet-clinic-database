/*Queries that provide answers to the questions from all projects.*/

/* Find all animals whose name ends in "mon". */
SELECT * FROM animals WHERE name LIKE '%mon';
/* List the name of all animals born between 2016 and 2019. */
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
/* List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
/* List the date of birth of all animals named either "Agumon" or "Pikachu" */
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempt FROM animals WHERE weight_kg > 10.5;
/* Find all animals that are neutered. */
SELECT * FROM animals WHERE neutered = TRUE;
/* Find all animals not named Gabumon. */
 SELECT * FROM animals WHERE name <> 'Gabumons';
/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


/* transactions */
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;
SELECT species FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';
COMMIT;
SELECT species FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > 'JAN 1, 2022';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* queries */
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, escape_attempts FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- multi tables query using join
SELECT animals.name FROM animals INNER JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond ';

SELECT animals.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(species_id) AS animals_count FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT ANIMALS.NAME FROM ANIMALS INNER JOIN SPECIES ON ANIMALS.SPECIES_ID = SPECIES.ID INNER JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID WHERE SPECIES.NAME = 'Digimon' AND OWNERS.FULL_NAME = 'Jennifer Orwell';

SELECT ANIMALS.NAME FROM ANIMALS INNER JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID WHERE OWNERS.FULL_NAME = 'Dean Winchester' AND ANIMALS.ESCAPE_ATTEMPTS = 0;

SELECT OWNERS.FULL_NAME, COUNT(ANIMALS.*) FROM ANIMALS INNER JOIN OWNERS ON ANIMALS.OWNER_ID = OWNERS.ID GROUP BY OWNERS.FULL_NAME ORDER BY COUNT DESC LIMIT 1;


-- join table queries

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON vets.id = visits.vets_id WHERE vets.id = 1 ORDER BY date_of_visit DESC LIMIT 1

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) FROM animals JOIN visits ON animals.id = visits.animals_id 
JOIN vets ON vets.id = visits.vets_id WHERE vets.id = 3;

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets JOIN specializations ON vets.id = specializations.vet_id 
JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets ON vets.id = visits.vet_id WHERE vets.id = 3 AND visits.visit_date >=' April 1, 2020' AND visits.visit_date <='August 30, 2020';

-- What animal has the most visits to vets?
SELECT animals.name, COUNT(visits.*) FROM visits JOIN animals ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name FROM animals JOIN visits ON animals.id = visits.animal_id 
JOIN vets  ON vets.id = visits.vet_id WHERE vets.id = 2 ORDER BY visits.visit_date LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, animals.date_of_birth, animals.weight_kg, vets.name AS vets_name, vets.age, visits.visit_date FROM animals INNER JOIN
visits ON visits.animal_id = animals.id INNER JOIN vets ON vets.id = visits.vet_id ORDER BY visits.visits_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM animals INNER JOIN visits ON visits.animal_id = animals.id INNER JOIN vets ON vets.id = visits.vet_id
WHERE animals.species_id NOT IN(SELECT species_id FROM specializations WHERE vet_id = vets.id);

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name FROM animals INNER JOIN visits ON visits.animal_id = animals.id INNER JOIN vets ON vets.id = visits.vet_id 
INNER JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY species.name ORDER BY COUNT(visits.*) DESC LIMIT 1;







SELECT ANIMALS.NAME, VISITS.VISIT_DATE FROM ANIMALS INNER JOIN VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID WHERE VETS.NAME = 'Maisy Smith' ORDER BY VISITS.VISIT_DATE LIMIT 1;

SELECT ANIMALS.NAME AS ANIMAL_NAME, ANIMALS.DATE_OF_BIRTH, ANIMALS.WEIGHT_KG, VETS.NAME AS VETS_NAME, VETS.AGE, VISITS.VISIT_DATE FROM ANIMALS INNER JOIN  VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID ORDER BY VISITS.VISIT_DATE DESC LIMIT 1;

SELECT COUNT(*) FROM ANIMALS INNER JOIN VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID WHERE ANIMALS.SPECIES_ID NOT IN(SELECT SPECIES_ID FROM specializations WHERE VETS_ID = VETS.ID);

SELECT SPECIES.NAME FROM ANIMALS INNER JOIN VISITS ON VISITS.ANIMALS_ID = ANIMALS.ID INNER JOIN VETS ON VETS.ID = VISITS.VETS_ID INNER JOIN SPECIES ON  SPECIES.ID = ANIMALS.SPECIES_ID WHERE VETS.NAME = 'Maisy Smith' GROUP BY SPECIES.NAME ORDER BY COUNT(VISITS.*) DESC  LIMIT 1;
