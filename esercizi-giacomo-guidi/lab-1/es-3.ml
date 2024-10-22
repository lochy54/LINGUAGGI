(*Write the matrix datatype with the following operations:

A function zeroes to construct a matrix of size n×m filled with zeros.*)

type matrix = {
  n: int;
  m: int;
  values: float array array
};;

let rec zeros n m = 
  let matrvod = [] in
  match List.length matrvod with
    n * m -> matrvod
  | _ -> matrix {n: n; m: m; values: 0.} :: matrvod ; zeros (n-1) (m-1)
