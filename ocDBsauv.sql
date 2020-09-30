-- MySQL dump 10.13  Distrib 8.0.20, for Linux (x86_64)
--
-- Host: localhost    Database: ocPizza
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Adresse`
--

DROP TABLE IF EXISTS `Adresse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Adresse` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int unsigned NOT NULL,
  `voie` varchar(150) NOT NULL,
  `complement_adresse` varchar(150) DEFAULT NULL,
  `code_postal` varchar(10) NOT NULL,
  `ville` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `Adresse_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `Client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Adresse`
--

LOCK TABLES `Adresse` WRITE;
/*!40000 ALTER TABLE `Adresse` DISABLE KEYS */;
INSERT INTO `Adresse` VALUES (1,1,'20 rue de la maison verte',NULL,'75008','Paris'),(2,2,'5 rue de la Vallée',NULL,'75014','Paris'),(3,3,'9 avenue des Poirreaux',NULL,'75020','Paris'),(4,1,'50 rue de la maison bleue',NULL,'75008','Paris');
/*!40000 ALTER TABLE `Adresse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Client`
--

DROP TABLE IF EXISTS `Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Client` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `civilite` enum('M','Mme') NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `e_mail` varchar(320) NOT NULL,
  `numero_telephone` varchar(20) NOT NULL,
  `mot_de_passe` varchar(40) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Client`
--

LOCK TABLES `Client` WRITE;
/*!40000 ALTER TABLE `Client` DISABLE KEYS */;
INSERT INTO `Client` VALUES (1,'M','Banane','Jonas','j.banane@hotmail.fr','0601020304','banane93'),(2,'M','Zuki','Mika','m.zuki@hotmail.fr','0612345678','pgmdu77.'),(3,'M','Lee','Mira','m.lee@hotmail.fr','0611223344','blabla28');
/*!40000 ALTER TABLE `Client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Commande`
--

DROP TABLE IF EXISTS `Commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Commande` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int unsigned NOT NULL,
  `paiement_id` int unsigned DEFAULT NULL,
  `date_commande` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_id` (`restaurant_id`),
  KEY `paiement_id` (`paiement_id`),
  CONSTRAINT `Commande_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `Restaurant` (`id`),
  CONSTRAINT `Commande_ibfk_2` FOREIGN KEY (`paiement_id`) REFERENCES `Paiement` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Commande`
--

LOCK TABLES `Commande` WRITE;
/*!40000 ALTER TABLE `Commande` DISABLE KEYS */;
INSERT INTO `Commande` VALUES (1,3,NULL,'2020-09-27 11:50:00'),(2,1,1,'2020-09-27 12:30:00'),(3,2,2,'2020-09-27 12:45:00'),(4,3,NULL,'2020-09-27 13:50:00');
/*!40000 ALTER TABLE `Commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CommandeSurPlace`
--

DROP TABLE IF EXISTS `CommandeSurPlace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CommandeSurPlace` (
  `parent_id` int unsigned NOT NULL,
  `employe_id` int unsigned NOT NULL,
  `statut` enum('en_attente','en_preparation','preparee','servi','annulee') NOT NULL,
  PRIMARY KEY (`parent_id`),
  KEY `employe_id` (`employe_id`),
  CONSTRAINT `CommandeSurPlace_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `Commande` (`id`),
  CONSTRAINT `CommandeSurPlace_ibfk_2` FOREIGN KEY (`employe_id`) REFERENCES `Employe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CommandeSurPlace`
--

LOCK TABLES `CommandeSurPlace` WRITE;
/*!40000 ALTER TABLE `CommandeSurPlace` DISABLE KEYS */;
INSERT INTO `CommandeSurPlace` VALUES (1,1,'en_preparation');
/*!40000 ALTER TABLE `CommandeSurPlace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CommandeWeb`
--

DROP TABLE IF EXISTS `CommandeWeb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CommandeWeb` (
  `parent_id` int unsigned NOT NULL,
  `adresse_id` int unsigned NOT NULL,
  `client_id` int unsigned NOT NULL,
  `statut` enum('en_attente','en_preparation','preparee','en_livraison','livree','annulee') NOT NULL,
  PRIMARY KEY (`parent_id`),
  KEY `adresse_id` (`adresse_id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `CommandeWeb_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `Commande` (`id`),
  CONSTRAINT `CommandeWeb_ibfk_2` FOREIGN KEY (`adresse_id`) REFERENCES `Adresse` (`id`),
  CONSTRAINT `CommandeWeb_ibfk_3` FOREIGN KEY (`client_id`) REFERENCES `Client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CommandeWeb`
--

LOCK TABLES `CommandeWeb` WRITE;
/*!40000 ALTER TABLE `CommandeWeb` DISABLE KEYS */;
INSERT INTO `CommandeWeb` VALUES (2,1,1,'en_livraison'),(3,2,2,'livree'),(4,1,1,'en_attente');
/*!40000 ALTER TABLE `CommandeWeb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DetailCommande`
--

DROP TABLE IF EXISTS `DetailCommande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DetailCommande` (
  `pizza_id` int unsigned NOT NULL,
  `commande_id` int unsigned NOT NULL,
  `quantite` int NOT NULL,
  `taille` enum('S','M','L') NOT NULL,
  `prix` decimal(5,2) NOT NULL,
  PRIMARY KEY (`pizza_id`,`commande_id`),
  KEY `commande_id` (`commande_id`),
  CONSTRAINT `DetailCommande_ibfk_1` FOREIGN KEY (`pizza_id`) REFERENCES `Pizza` (`id`),
  CONSTRAINT `DetailCommande_ibfk_2` FOREIGN KEY (`commande_id`) REFERENCES `Commande` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DetailCommande`
--

LOCK TABLES `DetailCommande` WRITE;
/*!40000 ALTER TABLE `DetailCommande` DISABLE KEYS */;
INSERT INTO `DetailCommande` VALUES (1,1,1,'S',8.90),(4,3,1,'L',16.90),(5,1,4,'S',10.90),(6,1,1,'M',13.90),(7,2,2,'M',27.80);
/*!40000 ALTER TABLE `DetailCommande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employe`
--

DROP TABLE IF EXISTS `Employe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employe` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `restaurant_id` int unsigned NOT NULL,
  `civilite` enum('M','Mme') NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `numero_telephone` varchar(20) NOT NULL,
  `grade` enum('manager','cuisinier','serveur','livreur') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurant_id` (`restaurant_id`),
  CONSTRAINT `Employe_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `Restaurant` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employe`
--

LOCK TABLES `Employe` WRITE;
/*!40000 ALTER TABLE `Employe` DISABLE KEYS */;
INSERT INTO `Employe` VALUES (1,3,'Mme','Jardin','Anais','0627954368','serveur'),(2,3,'M','Tartanpion','Max','0654793158','manager'),(3,3,'M','Patate','Jack','0647958631','cuisinier'),(4,3,'Mme','Velo','Ema','0612358496','livreur');
/*!40000 ALTER TABLE `Employe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ingredient` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `unite` enum('centilitre','gramme','unite') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES (1,'sauce tomate','centilitre'),(2,'mozzarella','gramme'),(3,'olives noires','unite'),(4,'roquette','gramme'),(5,'anchois','gramme'),(6,'câpres','gramme'),(7,'jambon','unite'),(8,'champignons','gramme'),(9,'artichauds marinés','gramme'),(10,'chorizo','unite'),(11,'merguez','unite'),(12,'oignons rouges','unite'),(13,'piments vinaigrés','gramme'),(14,'viandes hachées','gramme'),(15,'boursin','gramme'),(16,'chèvre','gramme'),(17,'bleu','gramme'),(18,'raclette','gramme'),(19,'emmental','gramme');
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IngredientPizza`
--

DROP TABLE IF EXISTS `IngredientPizza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IngredientPizza` (
  `pizza_id` int unsigned NOT NULL,
  `ingredient_id` int unsigned NOT NULL,
  `quantite` int NOT NULL,
  PRIMARY KEY (`pizza_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `IngredientPizza_ibfk_1` FOREIGN KEY (`pizza_id`) REFERENCES `Pizza` (`id`),
  CONSTRAINT `IngredientPizza_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IngredientPizza`
--

LOCK TABLES `IngredientPizza` WRITE;
/*!40000 ALTER TABLE `IngredientPizza` DISABLE KEYS */;
INSERT INTO `IngredientPizza` VALUES (1,1,20),(1,2,100),(1,3,5),(1,4,20),(2,1,20),(2,2,100),(2,3,5),(2,5,100),(2,6,50),(3,1,20),(3,2,100),(3,3,5),(3,7,2),(3,8,50),(3,9,20),(4,1,20),(4,2,100),(4,10,6),(4,11,2),(4,12,1),(4,13,10),(5,1,20),(5,2,100),(5,8,50),(5,12,1),(5,14,100),(5,15,20),(6,1,20),(6,2,100),(6,7,2),(6,8,50),(7,1,20),(7,2,100),(7,16,20),(7,17,20),(7,18,20),(7,19,20);
/*!40000 ALTER TABLE `IngredientPizza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Paiement`
--

DROP TABLE IF EXISTS `Paiement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Paiement` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('sur_place','a_la_livraison','en_ligne') NOT NULL,
  `date_paiement` datetime NOT NULL,
  `numero_facture` varchar(50) NOT NULL,
  `mode_paiement` enum('cb','espece','paypal','autre') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Paiement`
--

LOCK TABLES `Paiement` WRITE;
/*!40000 ALTER TABLE `Paiement` DISABLE KEYS */;
INSERT INTO `Paiement` VALUES (1,'en_ligne','2020-09-27 12:30:00','F200927003','cb'),(2,'a_la_livraison','2020-09-27 13:15:00','F200927006','espece');
/*!40000 ALTER TABLE `Paiement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pizza`
--

DROP TABLE IF EXISTS `Pizza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pizza` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `prix` decimal(4,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pizza`
--

LOCK TABLES `Pizza` WRITE;
/*!40000 ALTER TABLE `Pizza` DISABLE KEYS */;
INSERT INTO `Pizza` VALUES (1,'margharita',9.50),(2,'napolitaine',9.90),(3,'quattro staggioni',10.90),(4,'matador',10.90),(5,'boursin',10.90),(6,'regina',10.90),(7,'5 fromages',10.90);
/*!40000 ALTER TABLE `Pizza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Restaurant`
--

DROP TABLE IF EXISTS `Restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Restaurant` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `adresse_voie` varchar(150) NOT NULL,
  `adresse_complement` varchar(150) DEFAULT NULL,
  `adresse_code_postal` varchar(10) NOT NULL,
  `adresse_ville` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Restaurant`
--

LOCK TABLES `Restaurant` WRITE;
/*!40000 ALTER TABLE `Restaurant` DISABLE KEYS */;
INSERT INTO `Restaurant` VALUES (1,'OC pizza Nord','12 rue du Général Leclerc',NULL,'75008','Paris'),(2,'OC pizza Sud','5 rue Geronimo',NULL,'75014','Paris'),(3,'OC pizza Est','8 rue des jardins',NULL,'75020','Paris'),(4,'OC pizza Ouest','20 rue de la Reine',NULL,'75006','Paris');
/*!40000 ALTER TABLE `Restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stock`
--

DROP TABLE IF EXISTS `Stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Stock` (
  `restaurant_id` int unsigned NOT NULL,
  `ingredient_id` int unsigned NOT NULL,
  `quantite` int NOT NULL,
  `unite` enum('boite','paquet','bouteille','sachet') NOT NULL,
  PRIMARY KEY (`restaurant_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `Stock_ibfk_1` FOREIGN KEY (`restaurant_id`) REFERENCES `Restaurant` (`id`),
  CONSTRAINT `Stock_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `Ingredient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stock`
--

LOCK TABLES `Stock` WRITE;
/*!40000 ALTER TABLE `Stock` DISABLE KEYS */;
INSERT INTO `Stock` VALUES (1,1,100,'bouteille'),(1,2,100,'paquet'),(1,3,80,'boite'),(1,4,50,'sachet'),(1,5,0,'boite'),(1,6,40,'boite'),(1,7,100,'paquet'),(1,8,100,'boite'),(1,9,50,'boite'),(1,10,80,'paquet'),(1,11,80,'paquet'),(1,12,80,'sachet'),(1,13,70,'boite'),(1,14,60,'paquet'),(1,15,40,'paquet'),(1,16,90,'paquet'),(1,17,90,'paquet'),(1,18,90,'paquet'),(1,19,90,'paquet'),(2,1,130,'bouteille'),(2,2,130,'paquet'),(2,3,100,'boite'),(2,4,80,'sachet'),(2,5,100,'boite'),(2,6,80,'boite'),(2,7,150,'paquet'),(2,8,150,'boite'),(2,9,70,'boite'),(2,10,100,'paquet'),(2,11,100,'paquet'),(2,12,100,'sachet'),(2,13,70,'boite'),(2,14,60,'paquet'),(2,15,40,'paquet'),(2,16,150,'paquet'),(2,17,150,'paquet'),(2,18,150,'paquet'),(2,19,150,'paquet'),(3,1,200,'bouteille'),(3,2,200,'paquet'),(3,3,200,'boite'),(3,4,80,'sachet'),(3,5,70,'boite'),(3,6,50,'boite'),(3,7,250,'paquet'),(3,8,250,'boite'),(3,9,70,'boite'),(3,10,100,'paquet'),(3,11,100,'paquet'),(3,12,100,'sachet'),(3,13,70,'boite'),(3,14,60,'paquet'),(3,15,40,'paquet'),(3,16,300,'paquet'),(3,17,300,'paquet'),(3,18,300,'paquet'),(3,19,300,'paquet'),(4,1,200,'bouteille'),(4,2,200,'paquet'),(4,3,200,'boite'),(4,4,80,'sachet'),(4,5,70,'boite'),(4,6,50,'boite'),(4,7,250,'paquet'),(4,8,250,'boite'),(4,9,70,'boite'),(4,10,100,'paquet'),(4,11,100,'paquet'),(4,12,100,'sachet'),(4,13,70,'boite'),(4,14,60,'paquet'),(4,15,40,'paquet'),(4,16,300,'paquet'),(4,17,300,'paquet'),(4,18,300,'paquet'),(4,19,300,'paquet');
/*!40000 ALTER TABLE `Stock` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-30 16:14:08
