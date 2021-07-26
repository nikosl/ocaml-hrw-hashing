open Core

type site = { id : string; weight : float }

type sites = { id : string; mutable available : (string * site) list }

module type WeightS = sig
  type t = { id : string; obj : string }

  val candidates : sites -> string -> (int * site) list

  val candidates_weight : sites -> string -> (float * site) list

  include Hashable.S with type t := t

  include Comparable.S with type t := t
end

module Weight : WeightS

val create : string -> sites

val add : sites -> ?weight:float -> string -> unit

val remove : sites -> string -> unit

val get : sites -> string -> site option

val candidates : sites -> string -> (int * site) list
(** [candidates] return a list of candidates for the given object *)

val candidates_weight : sites -> string -> (float * site) list
(** [candidates_weight] return a list of candidates for the given object based on each candidate [weight] *)

val candidates_to_id_list : ('a * site) list -> string list