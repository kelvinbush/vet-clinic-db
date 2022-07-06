/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
CREATE TABLE animals
(
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(25),
    date_of_birth   DATE NOT NULL DEFAULT CURRENT_DATE,
    escape_attempts INT,
    neutered        BOOLEAN,
    weight_kg       DECIMAL
);

ALTER TABLE animals
    ADD COLUMN species VARCHAR(25);

CREATE TABLE owners
(
    id        SERIAL PRIMARY KEY,
    full_name VARCHAR(25),
    age       INT
);

CREATE TABLE species
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(25)
);

ALTER TABLE animals
    DROP column species;

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals
    ADD CONSTRAINT fk_species
        FOREIGN KEY (species_id) REFERENCES species (id);