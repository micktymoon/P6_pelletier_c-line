CREATE DATABASE ocPizza;
USE ocPizza;
CREATE  TABLE Client (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    e_mail VARCHAR(320) NOT NULL,
    numero_telephone VARCHAR(20) NOT NULL,
    mot_de_passe VARCHAR(40) CHARACTER SET ascii NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Restaurant (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    adresse_voie VARCHAR(50) NOT NULL,
    adresse_complement VARCHAR(50),
    adresse_code_postal VARCHAR(10) NOT NULL,
    adresse_ville VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Paiement (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    prix_total DECIMAL(5, 2) NOT NULL,
    type INT NOT NULL,
    date_paiement DATETIME NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Pizza (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(4, 2) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Ingredient (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Commande (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    date_commande DATETIME NOT NULL,
    statut INT NOT NULL,
    adresse_destinataire VARCHAR(50) NOT NULL,
    adresse_complement_destinataire VARCHAR(50),
    adresse_voie VARCHAR(50) NOT NULL,
    adresse_complement VARCHAR(50),
    adresse_code_postal VARCHAR(10) NOT NULL,
    adresse_ville VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE LigneCommande (
    pizza_id INT UNSIGNED NOT NULL,
    commande_id INT UNSIGNED NOT NULL,
    quantité INT NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (pizza_id, commande_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id),
    FOREIGN KEY (commande_id) REFERENCES Commande(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IngredientPizza (
    pizza_id INT UNSIGNED NOT NULL,
    ingredient_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (pizza_id, ingredient_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Stock (
    restaurant_id INT UNSIGNED NOT NULL,
    ingredient_id INT UNSIGNED NOT NULL,
    quantité INT NOT NULL,
    PRIMARY KEY (restaurant_id, ingredient_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;