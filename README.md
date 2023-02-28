# API-PT-Scala
Mise en place d'une API simplifiée de property testing en respectant des consignes données.

https://drive.google.com/drive/folders/19XkhCKPRUI48UU0uR6-OvVnpnCnjKRQ1?usp=share_link

Je vais commencer par implémenter les éléments de chaque module en utilisant les fichiers fournis dans le lien que vous avez partagé.

Pour le module Property, j'implémenterai les cas particuliers qui sont toujours vrais ou toujours faux. J'utiliserai comme indication que le paramètre du type générique est le type des éléments sur lesquels portent la propriété.

Pour le module Generator, je vais d'abord définir le type générique et ensuite j'appliquerai le générateur pour générer une valeur. Ensuite, je vais créer les générateurs de types de base tels que booléen, entier, flottant, etc. Je vais également créer des générateurs pour les chaînes et les listes, ainsi que pour les transformations, filtrage, etc. Pour cela, je vais m'inspirer du module Random existant et utiliser ses générateurs pour construire les générateurs de types de base demandés.

Pour le module Reduction, je vais d'abord définir le type générique comme étant le type sur lequel porte la stratégie. Ensuite, je vais implémenter les stratégies pour les types de base tels que int, float, etc. et pour les chaînes et les listes. Je vais également implémenter la transformation : couplage. Je vais m'assurer que je ne propose jamais la valeur donnée en paramètre et essayer de lier une stratégie au générateur correspondant. Il est important de noter que si je ne implémente pas la stratégie vide, cela impliquera une non-validation de tous les tests du module suivant (Test).

Enfin, pour le module Test, je vais définir le type générique comme étant le type des paramètres de la propriété à tester. Ensuite, je vais créer un test en vérifiant une propriété et en recherchant un contre-exemple simple si possible. Enfin, je vais lancer plusieurs tests.

Je vais m'assurer que toutes les modifications que j'apporterai ne changeront pas la signature des valeurs et fonctions déjà implémentées. J'ajouterai de nouveaux éléments intermédiaires pour implémenter les éléments demandés, et j'ajouterai également de nouvelles fonctionnalités si nécessaire.

Pour m'assurer que mon code est fonctionnel, je ferai des tests sur celui-ci en respectant les règles de programmation fonctionnelle, c'est-à-dire en n'utilisant pas de variables et en n'utilisant pas de boucles, conditionnelles ou non.

Enfin, je proposerai une ou plusieurs fonctionnalités supplémentaires ainsi que d'autres exemples d'utilisation.
