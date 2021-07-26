(**
 * Copyright (c) 2021 Nikos Leivadaris
 * 
 * This software is released under the MIT License.
 * https://opensource.org/licenses/MIT
 *)

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

module Weight : WeightS = struct
  module T = struct
    type t = { id : string; obj : string } [@@deriving compare, sexp, hash]
  end

  include T

  let candidates s o =
    let to_weight (id, n) =
      let h = T.hash { id; obj = o } in
      (h, n)
    in
    s.available |> List.map ~f:to_weight
    |> List.sort ~compare:(fun (h1, _) (h2, _) -> Int.compare h1 h2)
    |> List.rev

  let candidates_weight s o =
    let to_weight (id, n) =
      let h = T.hash { id; obj = o } in
      let h' = Float.of_int h in
      let m = Float.of_int Int.max_value in
      let open Float in
      let score = log (h' / m) in
      (-n.weight / score, n)
    in
    s.available
    |> List.map ~f:to_weight
    |> List.sort ~compare:(fun (h1, _) (h2, _) -> Float.compare h1 h2)
    |> List.rev

  include Hashable.Make (T)
  include Comparable.Make (T)
end

let create id = { id; available = [] }

let add s ?(weight = 100.) id =
  let equal x y = String.equal x y in
  s.available <- List.Assoc.add s.available ~equal id { id; weight }

let remove s id =
  let equal x y = String.equal x y in
  s.available <- List.Assoc.remove s.available ~equal id

let get s id =
  let equal x y = String.equal x y in
  List.Assoc.find s.available ~equal id

let candidates s obj = Weight.candidates s obj

let candidates_weight s obj = Weight.candidates_weight s obj

let candidates_to_id_list (c : ('a * site) list) : string list =
  c |> List.fold ~init:[] ~f:(fun acc (_, n) -> n.id :: acc) |> List.rev