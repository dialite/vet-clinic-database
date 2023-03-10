/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT PRIMARY KEY, 
    name VARCHAR(100),
    date_of_birth date,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    species VARCHAR;
);
ALTER TABLE animals ADD COLUMN species VARCHAR(100);

-- Create owners and species tables
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
);

-- Alter animals table
ALTER TABLE animals
ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE animals DROP COLUMN species;

--Add column species_id which is a foreign key referencing the species table
ALTER TABLE animals ADD species_id INT,
ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id INT,
ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  age INTEGER,
  date_of_graduation DATE
);

-- Species, vet many to many relationship
CREATE TABLE specializations (
    species_id INTEGER REFERENCES species (id),
    vet_id INTEGER REFERENCES vets (id),
    PRIMARY KEY (species_id, vet_id)
);

-- Animal, vet many to many relationship
CREATE TABLE visits (
    animal_id INTEGER REFERENCES animals (id),
    vet_id INTEGER REFERENCES vets (id),
    visit_date TIMESTAMP NOT NULL,
    PRIMARY KEY (animal_id, vet_id, visit_date)
);