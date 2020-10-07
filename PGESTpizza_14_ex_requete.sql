-- requète pour avoir les ingredients d'une pizza
SELECT Ingredient.nom, IngredientPizza.quantite, Ingredient.unite
FROM Ingredient
INNER JOIN IngredientPizza ON IngredientPizza.ingredient_id=Ingredient.id
INNER JOIN Pizza ON Pizza.id=IngredientPizza.pizza_id
WHERE Pizza.id = 5;

-- requète pour avoir les pizza dont il y a les ingredients en stock.

SELECT DISTINCT Pizza.nom
FROM Pizza
INNER JOIN IngredientPizza ON IngredientPizza.pizza_id = Pizza.id
INNER JOIN Stock ON Stock.ingredient_id = IngredientPizza.ingredient_id
INNER JOIN Restaurant ON Restaurant.id = Stock.restaurant_id
WHERE Restaurant.id = 1 AND Stock.quantite > 0;

-- requète pizza ayant des ingredient inf à 1 dans les stocks.

SELECT DISTINCT Pizza.nom
FROM Pizza
INNER JOIN IngredientPizza ON IngredientPizza.pizza_id = Pizza.id
INNER JOIN Stock ON Stock.ingredient_id = IngredientPizza.ingredient_id
INNER JOIN Restaurant ON Restaurant.id = Stock.restaurant_id
WHERE Restaurant.id = 1 AND Stock.quantite < 1;

-- retrouver le contenu de ma commande

SELECT Pizza.nom, DetailCommande.quantite
FROM Pizza
INNER JOIN PizzaTaille ON PizzaTaille.pizza_id = Pizza.id
INNER JOIN DetailCommande ON DetailCommande.pizza_taille_id = PizzaTaille.id
WHERE DetailCommande.commande_id = 1;

-- retrouver commande en attente dans un restaurant

SELECT Commande.id, Commande.restaurant_id, CommandeSurPlace.statut
FROM Commande
INNER JOIN CommandeSurPlace ON CommandeSurPlace.parent_id = Commande.id
WHERE CommandeSurPlace.statut = 'en_attente';

SELECT Commande.id, Commande.restaurant_id, CommandeWeb.statut
FROM Commande
INNER JOIN CommandeWeb ON CommandeWeb.parent_id = Commande.id
WHERE CommandeWeb.statut = 'en_attente';

-- retrouver les commandes en attente d'un client

SELECT parent_id
FROM CommandeWeb
WHERE client_id = 5 AND statut IN ('en_attente');

-- retrouver l'adresse d'une commande après livraison mm si le client à changé d'adresse.

SELECT Adresse.id, Adresse.client_id, Adresse.voie, Adresse.complement_adresse, Adresse.code_postal, Adresse.ville
FROM Adresse
INNER JOIN CommandeWeb ON CommandeWeb.adresse_id = Adresse.id
INNER JOIN Commande ON Commande.id = CommandeWeb.parent_id
WHERE Commande.id = 2;

-- retrouver le prix d'une pizza déjà payé après que le prix de la pizza ai changé.

SELECT DetailCommande.prix
FROM DetailCommande
INNER JOIN Commande ON Commande.id = DetailCommande.commande_id
WHERE Commande.id = 1 AND DetailCommande.pizza_taille_id = 1;
