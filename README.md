# Jardins des alentours - README

Un projet web conçu avec Ruby on Rails afin de promouvoir la culture et la consommation de légumes hyperlocaux afin d'en faire bénéficier l'environnement.

## Table des matières

---

* [Installation](#installation)
* [Organisation du projet](#organisation-du-projet)
* [Utilisation](#utilisation)

## Installation

---

Le projet utilise Ruby on Rails, un framework web du langage Rails.
Ainsi, afin de faire fonctionner le projet, vous devez préalablement installer Ruby localement.
[Installation de Ruby (anglais)](https://www.ruby-lang.org/en/documentation/installation/ "Installation de Ruby (anglais)")

Dans le projet, utilisez la commande suivante pour installer les dépendances du projet :

  bundle install

Puis, afin d'installer les dépendances Javascript, utilisez la commande suivante :

  `yarn`

Le projet utilise une base de données Postgresql. Pour permettre au projet de se connecter à la base de données, veuillez ajouter le nom d'utilisateur et le mot de passe dans le fichier *config/database.yml*

  `username: *username*`

  `password: *password*`

Pour générer la base de données, veuillez utiliser les commandes suivantes :

  `rails db:create`

  `rails db:migrate`

  `rails db:seed`

Pour lancer les tests, utilisez la commande :

  `rails t`

Pour lancer le projet, utilisez la commande :

  `rails s`

Le site sera disponible à l'adresse localhost:3000

## Organisation du projet

---

Le projet de Jardins des alentours est structuré selon le design pattern Modèle-Vue-Contrôleur.

Les différentes routes sont disponibles dans le fichier *config/routes.rb*

Le dossier *app* contient les fichiers .scss, .js, les modèles, vues et contrôleurs du projet.

Les fichiers de traduction sont présents dans le dossier *config/locales*

Le dossier *db* contient les migrations, le schéma et le seed de la base de données.

## Utilisation

---

Le projet permet aux utilisateurs de rechercher des jardins dans leur entourage, de les voir sur une carte et d'en afficher le contenu. Si le jardinier a mis des produits du jardin à la vente, l'utilisateur peut entrer avec le jardinier en lui envoyant un message par la plateforme, qui sera acheminé au jardinier par courriel.

Il peut également consulter les communautés crées sur la culture des produits agricoles et en apprendre sur la culture de ceux-ci. Il peut consulter les questions et réponses de jardiniers au sujet de la culture.

L'utilisateur peut se connecter, et créer son propre jardin. Le jardin est localisé avec Geocoder afin d'être positionné sur la carte.

Il peut poser des questions dans une communauté et répondre aux questions des autres utilisateurs.

S'il a un compte avec un rôle administrateur, il peut accéder à la page */admin* et créer des communautés, des produits et bannir des adresses courriel.

Deux comptes sont créés par défaut dans le seed.

* john_doe@example.com avec le mot de passe test12345 (compte administrateur, en anglais)

* jane_dow@example.com avec le mot de passe test12345 (compte normal en français)
