module Generator :
  sig
    (** Type du générateur pseudo-aléatoire de données de type 'a *)
    type 'a t

    (** Renvoie une nouvelle valeur aléeatoire
      * @param gen générateur pseudo-aléatoire
      * @return    nouvelle valeur aléatoire en utilisant `gen`
      *)
    val next : 'a t -> 'a

    (** Générateur constant
      * @param x valeur
      * @return  générateur de l'unique valeur `x`
      *)
    val const : 'a -> 'a t

    (* GENERATEURS DE TYPES DE BASE *)
 
    (** Générateur pseudo-aléatoire de booléens
      * @param prob probabilité de la valeur `true`
      * @return     générateur pseudo-aléatoire de valeurs booléennes
      *)
    val bool : float -> bool t

    (** Générateur pseudo-aléatoire d'entiers
      * @param a borne inférieure
      * @param b borne supérieure
      * @return  générateur pseudo-aléatoire de valeurs entières entre `a` et `b` inclus
      *)
    val int : int -> int -> int   t

    (** Générateur pseudo-aléatoire d'entiers positifs ou nuls
      * @param n borne supérieure
      * @return  générateur pseudo-aléatoire de valeurs entières entre 0 et `n` inclus
      *)
    val int_nonneg : int -> int   t

    (** Générateur pseudo-aléatoire de flottants
      * @param x borne supérieure
      * @param y borne supérieure
      * @return  générateur pseudo-aléatoire de valeurs flottantes entre `x` et `y` inclus
      *)
    val float : float -> float -> float t

    (** Générateur pseudo-aléatoire de flottants positifs ou nuls
      * @param x borne supérieure
      * @return  générateur pseudo-aléatoire de valeurs flottantes entre 0 et `x` inclus
      *)
    val float_nonneg : float -> float t

    (** Générateur pseudo-aléatoire de caractères *)
    val char : char t

    (** Générateur pseudo-aléatoire de caractères alphanumériques *)
    val alphanum : char t

    (* GENERATEURS DE CHAINE DE CARACTERE *)

    (** Générateur de chaînes de caractères
      * @param n   longueur maximale de la chaîne de caractère
      * @param gen générateur pseudo-aléatoire de caractères
      * @return    générateur pseudo-aléatoire de chaînes de caractères dont chaque caractéré est généré avec `gen`
      *)
    val string : int -> char t -> string t

    (* GENERATEURS DE LISTES *)

    (** Générateur de listes
      * @param n   longueur maximale de la liste
      * @param gen générateur pseudo-aléatoire d'éléments
      * @return    générateur pseudo-aléatoire de listes dont chaque élément est généré avec `gen`
      *)
    val list : int -> 'a t -> ('a list) t

    (* TRANSFORMATIONS *)

    (** Générateur pseudo-aléatoire de couples
      * @param fst_gen générateur pseudo-aléatoire de la première coordonnée
      * @param snd_gen générateur pseudo-aléatoire de la deuxième coordonnée
      * @return        générateur pseudo-aléatoire du couple
      *)
    val combine : 'a t -> 'b t -> ('a * 'b) t

    (** Applique un post-traitement à un générateur pseudo-aléatoire
      * @param f   post-traitement à appliquer à chaque valeur générée
      * @param gen générateur pseudo-aléatoire
      * @return    générateur pseudo-aléatoire obtenu en appliquant `f` à chaque valeur générée par `gen`
      *)
    val map : ('a -> 'b) -> 'a t -> 'b t

    (** Applique un filtre à un générateur pseudo-aléatoire
      * @param p   filtre à appliquer à chaque valeur générée
      * @param gen générateur pseudo-aléatoire
      * @return    générateur pseudo-aléatoire ne générant des valeurs de `gen` que si elles vérifient `p`
      *)
    val filter : ('a -> bool) -> 'a t -> 'a t

    (** Applique un post-traitement dépendant d'un filtre à un générateur pseudo-aléatoire
      * @param p   filtre à appliquer à chaque valeur générée
      * @param f   couple des post-traitements à appliquer à chaque valeur générée
      * @param gen générateur pseudo-aléatoire
      * @return    générateur pseudo-aléatoire obtenu en appliquant `fst f` pour toute valeur vérifiant `p`
      *                                                          et `snd f` pour toute valeur ne le vérifiant pas
      *)
    val partitioned_map : ('a -> bool) -> (('a -> 'b) * ('a -> 'b)) -> 'a t -> 'b t
  end =
  struct
    (* TODO : Implémenter le type et tous les éléments de la signature *)
    
    (* Le type générique 'a t représente un générateur qui prend un état aléatoire de type Random.State.t et renvoie une valeur de type 'a *)
    type 'a t = Random.State.t -> 'a

    (* La fonction generate utilise un générateur et un état aléatoire pour générer une valeur. *)
    let generate (gen : 'a t) (state : Random.State.t) : 'a =
      gen state

    (* Générateur pour le type bool *)
    let bool : bool t = fun state ->
      Random.State.bool state

    (* Générateur pour le type int *)
    let int : int t = fun state ->
      Random.State.int state (1 lsl 30)

    (* Générateur pour le type float *)
    let float : float t = fun state ->
      Random.State.float state 1.

    (* Générateur pour le type char *)
    let char : char t = fun state ->
      Char.chr (Random.State.int state 256)

    (* Générateur de chaînes de longueur len avec la fonction string *)
    let string (len : int) : string t = fun state ->
      let buffer = Bytes.create len in
      for i = 0 to len - 1 do
        Bytes.set buffer i (char state)
      done;
      Bytes.to_string buffer

    (* La fonction list prend un générateur gen et une longueur len et renvoie un générateur de listes de longueur len *)
    let list (gen : 'a t) (len : int) : 'a list t =
      let rec loop acc remaining_length =
        if remaining_length <= 0 then acc
        else loop ((gen state) :: acc) (remaining_length - 1)
      in
      fun state -> loop [] len

    (* Fonctions de transformation pour filtrer les valeurs générées (filter) et pour appliquer une fonction de transformation à chaque élément généré (map) *)
    
    let filter (gen : 'a t) (predicate : 'a -> bool) : 'a t =
      let rec loop () =
        let x = gen state in
        if predicate x then x else loop ()
      in
      loop

    let map (gen : 'a t) (f : 'a -> 'b) : 'b t =
      fun state -> f (gen state)

  end ;;
