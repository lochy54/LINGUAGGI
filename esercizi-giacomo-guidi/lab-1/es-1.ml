(* Put into a list, called alkaline_earth_metals, the atomic numbers of the six alkaline earth metals: beryllium (4), magnesium (12), calcium (20), strontium (38), barium (56), and radium (88).*) 
let alkaline_earth_metals = [("beryllium", 4); ("magnesium",12); ("calcium", 20); ("strontium",38); ("barium",56); ("radium",88)];;

(*
Then
Write a function that returns the highest atomic number in alkaline_earth_metals. *)
let massimo a b = if ((snd a) > (snd b)) then a else b;;

let rec highNumber list elm = 
  if list==[] then elm else highNumber (List.tl list) (massimo elm (List.hd list))
  (*massimo num (List.hd list) || highNumber (List.tl list) num*)
  (*highNumber list num*);; 

let arm = highNumber alkaline_earth_metals ("", 0);;
Printf.printf "Heaviest element: (%s)(%d)\n\n" (fst arm) (snd arm);;

(*
Write a function that sorts alkaline_earth_metals in ascending order (from the lightest to the heaviest). *)
let compare_function a b = (snd a) - (snd b);;

let sorted_list = List.sort compare_function alkaline_earth_metals;;



let rec print_list = function
  | [] -> ()
  | (name, atomic_number) :: tail ->
      Printf.printf "%s %d\n" name atomic_number;
      print_list tail;;

Printf.printf "Sorted list of alkaline earth metals:\n";
print_list sorted_list;;

(*
Put into a second list, called noble_gases, the noble gases: helium (2), neon (10), argon (18), krypton (36), xenon (54), and radon (86). *) 
let noble_gases = [("helium", (2)); ("neon", (10)); ("argon", (18)); ("krypton", (36)); ("xenon", (54)); ("radon", (86))];;

(*
Then
Write a function (or a group of functions) that merges the two lists and print the result as couples (name, atomic number) sorted in ascending order on the element names. *)
let sorted_list = List.merge compare_function alkaline_earth_metals noble_gases in
 Printf.printf "\nSorted list of alkaline earth metals:\n";
 print_list sorted_list;;