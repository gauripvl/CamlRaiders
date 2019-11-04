(* TODO *)

open Sprite

(** The type of elements. *)
module type Player = sig
  type t
  include Sprite.t with type t := t
end

(** A [Set] contains elements, which must be comparable. *)
module type Set = sig

  (** [Elt] is a module representing the type of elements
      in the set and functions on them. *)
  module Elt : ElementSig

  (** [elt] is the type of elements in the set. *)
  type elt = Elt.t

  (** [t] is the type of sets. *)
  type t

end

(** [MakeSetOfDictionary] implements a set as a dictionary.
    The keys of the dictionary represent the elements of the set.  
    The values of the dictionary are irrelevant. *)
module Make :   
  functor (E : ElementSig)
    -> functor (DM : DictionaryMaker)
    -> Set with module Elt = E

