/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic;
CREATE TABLE animals
(
    id              SERIAL PRIMARY KEY,
    name            VARCHAR(25),
    date_of_birth   DATE            NOT NULL DEFAULT CURRENT_DATE,
    escape_attempts INT,
    neutered        BOOLEAN,
    weight_kg       DECIMAL
);
