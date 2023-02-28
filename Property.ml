module Property = struct
  type 'a t = 'a -> bool

  let alwaysTrue : 'a t = fun _ -> true

  let alwaysFalse : 'a t = fun _ -> false
end
