/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', 'Feb 3, 2020', 0, true, 10.23 );
INSERT INTO animals VALUES (2, 'Gabumon', 'Nov 15, 2018', 2, true, 8.0 );
INSERT INTO animals VALUES (3, 'Pikachu', 'Jan 7, 2021', 1, false, 15.04 );
INSERT INTO animals VALUES (4, 'Devimon', 'May 12, 2017', 5, true, 11.0 );
INSERT INTO animals VALUES (5, 'Charmander', 'Feb 8, 2020', 0, false, 11.0);
INSERT INTO animals VALUES (6, 'Plantmon', 'Nov 15, 2021', 2, true, 5.7);
INSERT INTO animals VALUES (7, 'Squirtle', 'Apr 02, 1993', 3, false, 12.13);
INSERT INTO animals VALUES (8, 'Angemon', 'Jun 12, 2005', 1, true, 45);
INSERT INTO animals VALUES (9, 'Boarmon', 'Jun 07, 2005', 7, true, 20.4);
INSERT INTO animals VALUES (10, 'Blossom', 'Oct 13, 1998', 3, true, 17.0);
INSERT INTO animals VALUES (11, 'Ditto', 'May 14, 2022', 4, true, 22.0);

INSERT INTO owners (full_name,age) VALUES ('Sam Smith', 34),('Jennifer Orwell', 19),('Bob', 45),('Melody Pond', 77),('Dean Winchester', 14),('Jodie Whittaker', 38);
INSERT INTO species (name) VALUES ('Pokemon'),('Digimon');

-- modify animals table with species_id
UPDATE animals SET species_id = (SELECT id FROM species WHERE NAME = 'Digimon') WHERE NAME LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE NAME = 'Pokemon') WHERE NAME NOT LIKE '%mon';

-- owner_identity
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name  = 'Sam Smith') WHERE name IN('Agumon'); 
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name  = 'Jennifer Orwell') WHERE name IN('Gabumon' , 'Pikachu'); 
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name  = 'Bob') WHERE name IN('Devimon', 'Plantmon'); 
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name  = 'Melody Pond ') WHERE name IN('Charmander', 'Squirtle', 'Blossom'); 
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name  = 'Dean Winchester') WHERE name IN('Angemon' , 'Boarmon'); 

--Table for vets
INSERT INTO VETS (NAME, AGE, DATE_OF_GRADUATION) VALUES ('William Tatche' , 45 , '2020-04-23');
INSERT INTO VETS (NAME, AGE, DATE_OF_GRADUATION) VALUES ('Maisy Smith' , 26 , '2019-01-17');
INSERT INTO VETS (NAME, AGE, DATE_OF_GRADUATION) VALUES ('Stephanie Mendez' , 64 , '1981-05-04');
INSERT INTO VETS (NAME, AGE, DATE_OF_GRADUATION) VALUES ('Jack Harkness' , 38 , '2008-06-08');

-- MODIFY data in specializations and visits
INSERT INTO specializations (species_id, vet_id)
SELECT s.id, v.id
FROM species s, vets v
WHERE s.name = 'Pokemon' AND v.name = 'William Tatcher';

INSERT INTO specializations (species_id, vet_id)
SELECT s.id, v.id
FROM species s, vets v
WHERE (s.name = 'Digimon' OR s.name = 'Pokemon') AND v.name = 'Stephanie Mendez';

INSERT INTO specializations (species_id, vet_id)
SELECT s.id, v.id
FROM species s, vets v
WHERE s.name = 'Digimon' AND v.name = 'Jack Harkness';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, '2020-05-24'
FROM animals a, vets v
WHERE a.name = 'Agumon' AND v.name = 'William Tatcher';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, '2020-07-22'
FROM animals a, vets v
WHERE a.name = 'Agumon' AND v.name = 'Stephanie Mendez';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, '2021-02-02'
FROM animals a, vets v
WHERE a.name = 'Gabumon' AND v.name = 'Jack Harkness';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, '2020-01-05'
FROM animals a, vets v
WHERE a.name = 'Pikachu' AND v.name = 'Maisy Smith';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, '2020-03-08'
FROM animals a, vets v
WHERE a.name = 'Pikachu' AND v.name = 'Maisy Smith';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, '2020-05-14'
FROM animals a, vets v
WHERE a.name = 'Pikachu' AND v.name = 'Maisy Smith';

INSERT INTO visits (animal_id, vet_id, visit_date)
SELECT a.id, v.id, '2021-05-04'
FROM animals a, vets v
WHERE a.name = 'Devimon' AND v.name = 'Stephanie Mendez';