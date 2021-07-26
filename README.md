# hrw-hashing

Highest random weight (HRW) hashing.[^1]

## Installation

### Using Opam

```bash
opam install https://github.com/nikosl/ocaml-hrw-hashing
```

## Usage

### In OCaml

```ocaml
let () =
  let sts = Hrw_hashing.create "A" in
  Hrw_hashing.add sts "n1";
  Hrw_hashing.add sts "n2";
  Hrw_hashing.add sts "n3";
  Hrw_hashing.add sts "n4";
  let c = Hrw_hashing.candidates sts "key" in
  let ids = Hrw_hashing.candidates_to_id_list c in
  List.iter (Printf.printf "%s\n") ids
```

[^1]: [Rendezvous hashing](https://en.wikipedia.org/wiki/Rendezvous_hashing)
