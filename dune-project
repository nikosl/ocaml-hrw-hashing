(lang dune 2.0)

(name hrw-hashing)
(license MIT)
(authors
  "Nikos Leivadaris")
(maintainers
  "Nikos Leivadaris")
(generate_opam_files true)
(package
 (name hrw-hashing)
 (synopsis "Highest random weight (HRW) hashing")
 (description "highest random weight (HRW) hashing")
 (homepage "")
 (bug_reports "")
 (depends
  (ocaml (>= 4.12.0))
  (core (>= v0.14.1))
  dune
  (alcotest :with-test)
  (odoc :with-doc)))
