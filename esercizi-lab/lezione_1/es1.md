Put into a list, called alkaline_earth_metals, the atomic numbers of the six alkaline earth metals: beryllium (4), magnesium (12), calcium (20), strontium (38), barium (56), and radium (88). Then

Write a function that returns the highest atomic number in alkaline_earth_metals.
Write a function that sorts alkaline_earth_metals in ascending order (from the lightest to the heaviest).

```ml
let alkaline_earth_metals = 
  ("beryllium", 4)::("magnesium", 12)::("calcium", 20)::
  ("strontium", 28)::("barium", 56)::("radium", 88)::[]
;;

let massimo a b = 
  if (snd a) > (snd b) then a else b
;;

let sorting a b = (snd a) - (snd b)
;;

let heaviest list = 
  List.fold_left massimo (List.hd list) (List.tl list)
;;

let order list = 
  List.sort sorting list
;;

let rec print_list = function
  | [] -> ()
  | (name, num)::t -> 
      Printf.printf "(%s, %d)\n" name num;
      print_list t
;;

let main () =
  (* Sort the metals and print them *)
  let sorted_metals = order alkaline_earth_metals in
  Printf.printf "Sorted list of alkaline earth metals:\n";
  print_list sorted_metals;

  (* Find the heaviest metal and print it *)
  let heaviest_metal = heaviest alkaline_earth_metals in
  Printf.printf "\nHeaviest element: (%s, %d)\n" (fst heaviest_metal) (snd heaviest_metal)
;;


main ();;
```