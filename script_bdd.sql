CREATE DATABASE ocPizza;
USE ocPizza;
CREATE  TABLE Client (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    civilite ENUM('M', 'Mme') NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    e_mail VARCHAR(320) NOT NULL,
    numero_telephone VARCHAR(20) NOT NULL,
    mot_de_passe VARCHAR(40) CHARACTER SET ascii NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE  TABLE Employe (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    civilite ENUM('M', 'Mme') NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    numero_telephone VARCHAR(20) NOT NULL,
    grade ENUM('manager', 'cuisinier', 'serveur', 'livreur') NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Adresse (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    voie VARCHAR(50) NOT NULL,
    complement_adresse VARCHAR(50),
    code_postal VARCHAR(10) NOT NULL,
    ville VARCHAR(50) NOT NULL,
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
    type ENUM('sur_place', 'a_la_livraison', 'en_ligne') NOT NULL,
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
    unite ENUM('centilitre', 'gramme', 'unite') NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CommandeWeb (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    date_commande DATETIME NOT NULL,
    statut ENUM('en_attente', 'en_preparation', 'preparee', 'en_livraison', 'livree', 'servi') NOT NULL,
    prix_total DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CommandeSurPlace (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    date_commande DATETIME NOT NULL,
    statut ENUM('en_attente', 'en_preparation', 'preparee', 'en_livraison', 'livree', 'servi') NOT NULL,
    prix_total DECIMAL(5, 2) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DetailCommandeWeb (
    pizza_id INT UNSIGNED NOT NULL,
    commande_web_id INT UNSIGNED NOT NULL,
    quantite INT NOT NULL,
    taille ENUM('S', 'M', 'L') NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (pizza_id, commande_web_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id),
    FOREIGN KEY (commande_web_id) REFERENCES CommandeWeb(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DetailCommandeSurPlace (
    pizza_id INT UNSIGNED NOT NULL,
    commande_sur_place_id INT UNSIGNED NOT NULL,
    quantite INT NOT NULL,
    taille ENUM('S', 'M', 'L') NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (pizza_id, commande_sur_place_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id),
    FOREIGN KEY (commande_sur_place_id) REFERENCES CommandeSurPlace(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IngredientPizza (
    pizza_id INT UNSIGNED NOT NULL,
    ingredient_id INT UNSIGNED NOT NULL,
    quantite INT NOT NULL,
    PRIMARY KEY (pizza_id, ingredient_id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Stock (
    restaurant_id INT UNSIGNED NOT NULL,
    ingredient_id INT UNSIGNED NOT NULL,
    quantite INT NOT NULL,
    unite ENUM('boite', 'paquet', 'bouteille', 'sachet') NOT NULL,
    PRIMARY KEY (restaurant_id, ingredient_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;