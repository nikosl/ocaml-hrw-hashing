open Alcotest

let test_rendezvous_hash () =
  let sts = Hrw_hashing.create "A" in
  Hrw_hashing.add sts "n1";
  Hrw_hashing.add sts "n2";
  Hrw_hashing.add sts "n3";
  Hrw_hashing.add sts "n4";
  let c = Hrw_hashing.candidates sts "foo" in
  let actual = Hrw_hashing.candidates_to_id_list c in
  let expected = [ "n1"; "n4"; "n2"; "n3" ] in
  check (list string) "rendezvous hash" actual expected

let test_weight_rendezvous_hash () =
  let sts = Hrw_hashing.create "A" in
  Hrw_hashing.add sts ~weight:70. "n1";
  Hrw_hashing.add sts ~weight:80. "n2";
  Hrw_hashing.add sts ~weight:90. "n3";
  Hrw_hashing.add sts "n4";
  let c = Hrw_hashing.candidates_weight sts "foo" in
  let actual = Hrw_hashing.candidates_to_id_list c in
  let expected = [ "n4"; "n3"; "n2"; "n1" ] in
  check (list string) "weight rendezvous hash" actual expected

let suite =
  [
    ("rendezvous hash", `Quick, test_rendezvous_hash);
    ("weight rendezvous hash", `Quick, test_weight_rendezvous_hash);
  ]

let () = Alcotest.run "hrw-hashing" [ ("Hrw_hashing", suite) ]
