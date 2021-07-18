(lang dune 2.0)

(name hrw-hashing)





(license ISC)

(authors
  "Nikos Leivadaris")

(maintainers
  "Nikos Leivadaris")

(generate_opam_files true)

(package
 (name hrw-hashing)
 (synopsis " highest random weight (HRW) hashing")
 (description " highest random weight (HRW) hashing")
 (depends
  (ocaml (>= 4.08.0))
  dune
  (alcotest :with-test)
  (odoc :with-doc)))
