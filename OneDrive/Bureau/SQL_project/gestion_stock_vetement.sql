CREATE SCHEMA cours_sql;
SET search_path TO cours_sql;

--parent tables
-----categorie
CREATE TABLE CATEGORIE (
    id_categorie INT PRIMARY KEY,
    libelle_categorie VARCHAR(100) NOT NULL,
    description TEXT
);

-----fournisseur
CREATE TABLE FOURNISSEUR (
    id_fournisseur INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(100),
    adresse TEXT
);

--child tables
-------produit
CREATE TABLE PRODUIT (
    id_produit INT PRIMARY KEY,
    reference VARCHAR(50) NOT NULL UNIQUE,
    libelle VARCHAR(200) NOT NULL,
    prix_vente DECIMAL(10,2) NOT NULL,
    taille VARCHAR(10),
    couleur VARCHAR(30),
    id_categorie INT NOT NULL,
    CONSTRAINT fk_categorie FOREIGN KEY (id_categorie) REFERENCES CATEGORIE(id_categorie)
);

-------stock
CREATE TABLE STOCK (
    id_stock INT PRIMARY KEY,
    quantite_disponible INT DEFAULT 0,
    seuil_minimum INT DEFAULT 5,
    emplacement_rayon VARCHAR(50),
    id_produit INT NOT NULL,
    CONSTRAINT fk_produit_stock FOREIGN KEY (id_produit) REFERENCES PRODUIT(id_produit)
);

------commande
CREATE TABLE COMMANDE (
    id_commande INT PRIMARY KEY,
    date_commande DATE NOT NULL DEFAULT CURRENT_DATE,
    statut VARCHAR(50) DEFAULT 'En attente',
    montant_total DECIMAL(10,2),
    date_livraison_prev DATE,
    id_fournisseur INT NOT NULL,
    CONSTRAINT fk_fournisseur FOREIGN KEY (id_fournisseur) REFERENCES FOURNISSEUR(id_fournisseur)
);

------ligne_commande
CREATE TABLE LIGNE_COMMANDE (
    id_ligne INT PRIMARY KEY,
    quantite_commandee INT NOT NULL,
    prix_unitaire_achat DECIMAL(10,2) NOT NULL,
    quantite_recue INT DEFAULT 0,
    id_commande INT NOT NULL,
    id_produit INT NOT NULL,
    CONSTRAINT fk_commande FOREIGN KEY (id_commande) REFERENCES COMMANDE(id_commande),
    CONSTRAINT fk_produit_ligne FOREIGN KEY (id_produit) REFERENCES PRODUIT(id_produit)
);
------insert 
-------------insert categorie
INSERT INTO CATEGORIE (id_categorie, libelle_categorie, description) VALUES 
(1, 'Hauts', 'T-shirts, chemises, pulls, vestes'),
(2, 'Bas', 'Pantalons, jeans, jupes, shorts'),
(3, 'Chaussures', 'Baskets, escarpins, bottes, sandales'),
(4, 'Accessoires', 'Ceintures, sacs, bonnets, écharpes'),
(5, 'Sport', 'Tenues et équipements sportifs');

------------inset fournisseur
INSERT INTO FOURNISSEUR (id_fournisseur, nom, telephone, email, adresse) VALUES 
(1, 'ATLAS TEXTILE', '0522-441122', 'contact@atlas-textile.ma', 'Zone Industrielle, Casablanca'),
(2, 'MAROC MODE', '0537-882233', 'info@marocmode.ma', 'Rue des Tisserands, Fès'),
(3, 'FASHION IMPORT', '0539-771144', 'order@fashionimport.ma', 'Port Tanger Med, Tanger'),
(4, 'SPORT SUPPLY', '0528-993355', 'pro@sportsupply.ma', 'Avenue Mohammed VI, Agadir');

-----------insert produit
INSERT INTO PRODUIT (id_produit, reference, libelle, prix_vente, taille, couleur, id_categorie) VALUES 
(1, 'TS-BLC-M', 'T-shirt blanc col rond', 149, 'M', 'Blanc', 1),
(2, 'TS-BLC-L', 'T-shirt blanc col rond', 149, 'L', 'Blanc', 1),
(3, 'JN-BLU-42', 'Jean slim bleu délavé', 399, '42', 'Bleu', 2),
(4, 'JN-NR-40', 'Jean droit noir', 379, '40', 'Noir', 2),
(5, 'PL-GRS-M', 'Pull en laine gris', 299, 'M', 'Gris', 1),
(6, 'BK-BLC-42', 'Baskets blanches running', 549, '42', 'Blanc', 3),
(7, 'BK-NR-41', 'Baskets noires lifestyle', 499, '41', 'Noir', 3),
(8, 'CE-MRN-85', 'Ceinture cuir marron 85cm', 189, '85', 'Marron', 4),
(9, 'SP-LGG-M', 'Legging sport femme', 229, 'M', 'Noir', 5),
(10, 'SP-SHT-L', 'Short sport homme', 199, 'L', 'Gris', 5),
(11, 'VE-VRT-S', 'Veste légère verte', 459, 'S', 'Vert', 1),
(12, 'SC-BCL-UN', 'Sac à dos boucle', 349, 'UN', 'Beige', 4);

---------------insert stocke
INSERT INTO STOCK (id_stock, quantite_disponible, seuil_minimum, emplacement_rayon, id_produit) VALUES 
(1, 45, 10, 'A-01', 1),
(2, 30, 10, 'A-02', 2),
(3, 8, 5, 'B-01', 3),
(4, 3, 5, 'B-02', 4),
(5, 22, 8, 'A-03', 5),
(6, 15, 6, 'C-01', 6),
(7, 4, 6, 'C-02', 7),
(8, 50, 10, 'D-01', 8),
(9, 18, 8, 'E-01', 9),
(10, 12, 8, 'E-02', 10),
(11, 6, 5, 'A-04', 11),
(12, 20, 10, 'D-02', 12);

---------------insert commande
INSERT INTO COMMANDE (id_commande, date_commande, statut, montant_total, date_livraison_prev, id_fournisseur) VALUES 
(201, '2024-01-10', 'LIVREE', 4480, '2024-01-20', 1),
(202, '2024-02-05', 'LIVREE', 2990, '2024-02-15', 2),
(203, '2024-03-01', 'EN_COURS', 8760, '2024-03-15', 3),
(204, '2024-03-10', 'EN_ATTENTE', 3580, '2024-03-25', 1),
(205, '2024-03-12', 'LIVREE', 2148, '2024-03-22', 4);

---------------ligne_commande
INSERT INTO LIGNE_COMMANDE (id_ligne, quantite_commandee, prix_unitaire_achat, quantite_recue, id_commande, id_produit) VALUES 
(1, 50, 89, 50, 201, 1),
(2, 30, 89, 30, 201, 2),
(3, 20, 239, 20, 201, 3),
(4, 15, 199, 15, 202, 5),
(5, 10, 299, 10, 202, 11),
(6, 30, 329, 20, 203, 6),
(7, 25, 299, 0, 203, 7),
(8, 20, 114, 0, 203, 8),
(9, 20, 179, 0, 204, 1),
(10, 15, 179, 0, 204, 2),
(11, 20, 139, 20, 205, 9),
(12, 15, 119, 15, 205, 10);

-------LISTE DE TOUS PRODUIT LES PRODUITS AVEC LEUR CATEGORIE
SELECT 
    p.libelle, 
    p.prix_vente, 
    p.taille, 
    p.couleur, 
    c.libelle_categorie
FROM PRODUIT p
INNER JOIN CATEGORIE c ON p.id_categorie = c.id_categorie
ORDER BY c.libelle_categorie, p.libelle;

---------PRODUITS DONT LE STOCK ET SOUS LE SEUIL MINIMUM
SELECT 
    p.reference, 
    p.libelle, 
    s.quantite_disponible, 
    s.seuil_minimum, 
    s.emplacement_rayon
FROM PRODUIT p
INNER JOIN STOCK s ON p.id_produit = s.id_produit
WHERE s.quantite_disponible < s.seuil_minimum;

-------COMMANDE FOURNISSEUR AVEC LE NOMDU FOURNISSEUR

SELECT 
    f.nom AS nom_fournisseur, 
    c.date_commande, 
    c.statut, 
    c.montant_total, 
    c.date_livraison_prev
FROM COMMANDE c
INNER JOIN FOURNISSEUR f ON c.id_fournisseur = f.id_fournisseur
ORDER BY c.date_commande DESC;

--------NOMBRE DE PRODUIT PAR CATEGORIE

SELECT 
    c.libelle_categorie, 
    COUNT(p.id_produit) AS nb_produits
FROM CATEGORIE c
INNER JOIN PRODUIT p ON c.id_categorie = p.id_categorie
GROUP BY c.libelle_categorie
ORDER BY nb_produits DESC;

--------VALEUR TOTAL DU STOCK PAR CATEGORIE
  

SELECT 
    c.libelle_categorie, 
    SUM(p.prix_vente * s.quantite_disponible) AS valeur_stock
FROM CATEGORIE c
INNER JOIN PRODUIT p ON c.id_categorie = p.id_categorie
INNER JOIN STOCK s ON p.id_produit = s.id_produit
GROUP BY c.libelle_categorie
ORDER BY valeur_stock DESC;

-------FOURNISSEURS AYANT RECU PLUS D'UNE COMMANDE

SELECT nom, COUNT(*) AS nb_commandes
FROM FOURNISSEUR f
JOIN COMMANDE c ON f.id_fournisseur = c.id_fournisseur
GROUP BY nom
HAVING COUNT(*) > 1; -- CORRECT : On filtre le résultat du calcul

------LIVRAISON PARTIELLES-ARTICLES MON ENCORE RECUS

SELECT 
    f.nom AS nom_fournisseur, 
    p.libelle, 
    lc.quantite_commandee AS qte_commandee, 
    lc.quantite_recue AS qte_recue, 
    (lc.quantite_commandee - lc.quantite_recue) AS qte_restante
FROM LIGNE_COMMANDE lc
INNER JOIN PRODUIT p ON lc.id_produit = p.id_produit
INNER JOIN COMMANDE c ON lc.id_commande = c.id_commande
INNER JOIN FOURNISSEUR f ON c.id_fournisseur = f.id_fournisseur
WHERE lc.quantite_recue < lc.quantite_commandee;

--------PRODUIT LE PLUS CHER ET LE MOINS CHER PAR CATEGORIE
SELECT 
    c.libelle_categorie, 
    MIN(p.prix_vente) AS prix_min, 
    MAX(p.prix_vente) AS prix_max,
    (MAX(p.prix_vente) - MIN(p.prix_vente)) AS ecart_prix
FROM CATEGORIE c
INNER JOIN PRODUIT p ON c.id_categorie = p.id_categorie
GROUP BY c.libelle_categorie
ORDER BY ecart_prix DESC;

------------Alerte de rupture : produits sous seuil avec fournisseur habituel

SELECT 
    p.reference, 
    p.libelle, 
    s.quantite_disponible, 
    s.seuil_minimum, 
    f.nom AS dernier_fournisseur
FROM PRODUIT p
INNER JOIN STOCK s ON p.id_produit = s.id_produit
INNER JOIN LIGNE_COMMANDE lc ON p.id_produit = lc.id_produit
INNER JOIN COMMANDE c ON lc.id_commande = c.id_commande
INNER JOIN FOURNISSEUR f ON c.id_fournisseur = f.id_fournisseur
WHERE s.quantite_disponible < s.seuil_minimum
AND c.id_commande = (SELECT MAX(id_commande) FROM LIGNE_COMMANDE WHERE id_produit = p.id_produit);

-------------Taux de livraison par commande fournisseur

SELECT 
    f.nom AS nom_fournisseur, 
    c.date_commande, 
    c.statut, 
    ROUND((SUM(lc.quantite_recue) / SUM(lc.quantite_commandee)) * 100, 1) AS taux_livraison
FROM FOURNISSEUR f
INNER JOIN COMMANDE c ON f.id_fournisseur = c.id_fournisseur
INNER JOIN LIGNE_COMMANDE lc ON c.id_commande = lc.id_commande
GROUP BY f.nom, c.date_commande, c.statut, c.id_commande
ORDER BY c.date_commande DESC;

------Créer une vue : tableau de bord du stock

CREATE VIEW v_tableau_bord_stock AS
SELECT 
    p.reference, 
    p.libelle, 
    p.couleur, 
    p.taille, 
    c.libelle_categorie, 
    s.quantite_disponible, 
    s.seuil_minimum,
    CASE 
        WHEN s.quantite_disponible < s.seuil_minimum THEN 'OUI'
        ELSE 'NON'
    END AS alerte
FROM PRODUIT p
INNER JOIN STOCK s ON p.id_produit = s.id_produit
INNER JOIN CATEGORIE c ON p.id_categorie = c.id_categorie;

--------Mise à jour du stock après réception

-----A. Mettre à jour le statut (Texte)

UPDATE COMMANDE 
SET statut = 'LIVREE' 
WHERE id_commande = 203;

-----B. Mettre à jour la quantité reçue (Colonnes)

UPDATE LIGNE_COMMANDE 
SET quantite_recue = quantite_commandee 
WHERE id_commande = 203;

-----C. Mise à jour du stock (Calcul Arithmétique)

UPDATE STOCK s
INNER JOIN LIGNE_COMMANDE lc ON s.id_produit = lc.id_produit
SET s.quantite_disponible = s.quantite_disponible + lc.quantite_commandee
WHERE lc.id_commande = 203;


