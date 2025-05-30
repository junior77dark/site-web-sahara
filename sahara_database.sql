-- Table Categorie (Catégorisation des produits)
CREATE TABLE Categorie (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT DEFAULT NULL
);

-- Table Boutique (Chaque fournisseur peut en créer une)
CREATE TABLE Boutique (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rccm VARCHAR(50) UNIQUE NOT NULL
);

-- Table Produit (Ajout de la relation avec Categorie)
CREATE TABLE Produit (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(255) NOT NULL,
    description TEXT,
    prix DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    boutique_id INT NOT NULL,
    categorie_id INT NOT NULL,
    date_ajout TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (boutique_id) REFERENCES Boutique(id) ON DELETE CASCADE,
    FOREIGN KEY (categorie_id) REFERENCES Categorie(id) ON DELETE SET NULL
);

-- Table ProduitImage (Gestion des images des produits)
CREATE TABLE ProduitImage (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produit_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    FOREIGN KEY (produit_id) REFERENCES Produit(id) ON DELETE CASCADE
);

-- Table Commande (Utilisateur géré par Django)
CREATE TABLE Commande (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    date_commande TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statut ENUM('en attente', 'payée', 'expédiée', 'livrée') DEFAULT 'en attente',
    FOREIGN KEY (user_id) REFERENCES auth_user(id) ON DELETE CASCADE
);

-- Table OrderItem (Détails des produits commandés)
CREATE TABLE OrderItem (
    id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT NOT NULL,
    produit_id INT NOT NULL,
    quantite INT NOT NULL,
    prix_unitaire DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (commande_id) REFERENCES Commande(id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES Produit(id) ON DELETE CASCADE
);

-- Table Paiement (Gestion des transactions)
CREATE TABLE Paiement (
    id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT NOT NULL,
    mode ENUM('carte', 'paypal', 'virement') NOT NULL,
    montant DECIMAL(10,2) NOT NULL,
    statut ENUM('réussi', 'échoué') DEFAULT 'réussi',
    date_paiement TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (commande_id) REFERENCES Commande(id) ON DELETE CASCADE
);