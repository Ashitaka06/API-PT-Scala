(** 
Supposons que nous avons une fonction sum qui calcule la somme des éléments d'une liste d'entiers. 
Nous voulons vérifier que sum renvoie toujours un entier positif ou nul. 
Voici comment cela peut être fait avec le module Property : 
**)

let prop_sum_positive : int list Property.t =
  fun lst -> sum lst >= 0

(**
Ici, nous avons créé une propriété prop_sum_positive qui est vraie si la somme des éléments de la liste est positive ou nulle.
**)

let () =
  let prop = Property.combine Property.always_true prop_sum_positive in
  Test.check prop

(**
Nous avons ensuite combiné cette propriété avec la propriété toujours vraie Property.always_true en utilisant la fonction Property.combine. 
Cela garantit que la propriété combinée est toujours vraie. 
Nous avons finalement vérifié cette propriété en utilisant la fonction Test.check.
**)
