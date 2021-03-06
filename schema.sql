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

ALTER TABLE animals
    ADD COLUMN species_id INT;
ALTER TABLE animals
    ADD CONSTRAINT fk_species
        FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals
    ADD COLUMN owners_id INT;
ALTER TABLE animals
    ADD CONSTRAINT fk_owners
        FOREIGN KEY (owners_id) REFERENCES owners (id);

create table vets
(
    id                 serial primary key,
    name               varchar(25),
    age                int,
    date_of_graduation date
);

create table specializations
(
    species_id int,
    vet_id     int,
    primary key (species_id, vet_id),
    constraint fk_species FOREIGN KEY (species_id) references species (id),
    constraint fk_vets FOREIGN KEY (vet_id) references vets (id)
);

create table visits
(
    id            serial primary key,
    animal_id     int,
    vet_id        int,
    date_of_visit date,
    constraint fk_animal FOREIGN KEY (animal_id) references animals (id),
    constraint fk_vets FOREIGN KEY (vet_id) references vets (id)
);

ALTER TABLE owners
    ADD COLUMN email VARCHAR(120);

create index animal_id_asc on visits (animal_id asc);
create index vet_id_idx on visits (vet_id asc);
create index owner_email_idx on owners(email asc);