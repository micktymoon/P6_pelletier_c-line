CREATE DATABASE ocPizza;
USE ocPizza;

CREATE TABLE Users (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    civilite ENUM('M', 'Mme') NOT NULL,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    numero_telephone VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE  TABLE Client (
    parent_id INT UNSIGNED NOT NULL,
    e_mail VARCHAR(320) NOT NULL,
    mot_de_passe VARCHAR(40) CHARACTER SET ascii NOT NULL,
    PRIMARY KEY (parent_id),
    FOREIGN KEY (parent_id) REFERENCES Users(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Adresse (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    client_id INT UNSIGNED NOT NULL,
    voie VARCHAR(150) NOT NULL,
    complement_adresse VARCHAR(150),
    code_postal VARCHAR(10) NOT NULL,
    ville VARCHAR(50) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (client_id) REFERENCES Client(parent_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Restaurant (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    adresse_voie VARCHAR(150) NOT NULL,
    adresse_complement VARCHAR(150),
    adresse_code_postal VARCHAR(10) NOT NULL,
    adresse_ville VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE  TABLE Employe (
    parent_id INT UNSIGNED NOT NULL,
    restaurant_id INT UNSIGNED NOT NULL,
    grade ENUM('manager', 'cuisinier', 'serveur', 'livreur') NOT NULL,
    PRIMARY KEY (parent_id),
    FOREIGN KEY (parent_id) REFERENCES Users(id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Paiement (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    type ENUM('sur_place', 'a_la_livraison', 'en_ligne') NOT NULL,
    date_paiement DATETIME NOT NULL,
    numero_facture VARCHAR(50) NOT NULL,
    mode_paiement ENUM('cb', 'espece', 'paypal', 'autre') NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Pizza (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE PizzaTaille (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    pizza_id INT UNSIGNED NOT NULL,
    taille ENUM('S', 'M', 'L') NOT NULL,
    prix DECIMAL(4, 2) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (pizza_id) REFERENCES Pizza(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Ingredient (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    unite ENUM('centilitre', 'gramme', 'unite') NOT NULL,
    PRIMARY KEY (id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Commande (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    restaurant_id INT UNSIGNED NOT NULL,
    paiement_id INT UNSIGNED,
    date_commande DATETIME NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(id),
    FOREIGN KEY (paiement_id) REFERENCES Paiement(id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CommandeWeb (
    parent_id INT UNSIGNED NOT NULL,
    adresse_id INT UNSIGNED NOT NULL,
    client_id INT UNSIGNED NOT NULL,
    statut ENUM('en_attente', 'en_preparation', 'preparee', 'en_livraison', 'livree', 'annulee') NOT NULL,
    PRIMARY KEY (parent_id),
    FOREIGN KEY (parent_id) REFERENCES Commande(id),
    FOREIGN KEY (adresse_id) REFERENCES Adresse(id),
    FOREIGN KEY (client_id) REFERENCES Client(parent_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE CommandeSurPlace (
    parent_id INT UNSIGNED NOT NULL,
    employe_id INT UNSIGNED NOT NULL,
    statut ENUM('en_attente', 'en_preparation', 'preparee', 'servi', 'annulee') NOT NULL,
    PRIMARY KEY (parent_id),
    FOREIGN KEY (parent_id) REFERENCES Commande(id),
    FOREIGN KEY (employe_id) REFERENCES Employe(parent_id)
    )
    ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE DetailCommande (
    pizza_taille_id INT UNSIGNED NOT NULL,
    commande_id INT UNSIGNED NOT NULL,
    quantite INT NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (pizza_taille_id, commande_id),
    FOREIGN KEY (pizza_taille_id) REFERENCES PizzaTaille(id),
    FOREIGN KEY (commande_id) REFERENCES Commande(id)
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