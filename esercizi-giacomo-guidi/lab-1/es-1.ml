(* Put into a list, called alkaline_earth_metals, the atomic numbers of the six alkaline earth metals: beryllium (4), magnesium (12), calcium (20), strontium (38), barium (56), and radium (88).*) 
let alkaline_earth_metals = [("beryllium", 4); ("magnesium",12); ("calcium", 20); ("strontium",38); ("barium",56); ("radium",88); ("chas", 22)];;

(*
Then
Write a function that returns the highest atomic number in alkaline_earth_metals. *)
let massimo a b = if ((snd a) > (snd b)) then a else b;;

let rec highNumber list elm = 
  if list==[] then elm else highNumber (List.tl list) (massimo elm (List.hd list))
  (*massimo num (List.hd list) || highNumber (List.tl list) num*)
  (*highNumber list num*);; 

let arm = highNumber alkaline_earth_metals ("", 0);;
Printf.printf "\nHeaviest element: (%s)(%d)\n" (fst arm) (snd arm);;

(*
Write a function that sorts alkaline_earth_metals in ascending order (from the lightest to the heaviest). *)
let compare_function a b = (snd a) - (snd b);;

let sorted_list = List.sort compare_function alkaline_earth_metals;;

let rec print_list = function
  | [] -> ()
  | (name, atomic_number) :: tail ->
      Printf.printf "%s %d\n" name atomic_number;
      print_list tail;;

let rec print_the_list list = 
  if List.length list == 1 then Printf.printf "err %s %d\n\n" (fst (List.hd list)) (snd (List.hd list)) 
  else Printf.printf "see %s %d\n" (fst (List.hd list)) (snd (List.hd list)) ;print_the_list (List.tl list);;

(*print_the_list sorted_list;;*)

(*
Put into a second list, called noble_gases, the noble gases: helium (2), neon (10), argon (18), krypton (36), xenon (54), and radon (86). *) 
let noble_gases = [("helium", (2)); ("neon", (10)); ("argon", (18)); ("krypton", (36)); ("xenon", (54)); ("radon", (86))];;

(*
Then
Write a function (or a group of functions) that merges the two lists and print the result as couples (name, atomic number) sorted in ascending order on the element names. *)
let merge list a b = if (compare_function a b >= 0) then a::list else b::list;;
let rec merge_list list_a list_b list =
  if (List.is_empty list_a) then List.rev_append list (List.rev list_b)
  else if (List.is_empty list_b) then List.rev_append list (List.rev list_a)
  else 
    let merged = merge list (List.hd list_a) (List.hd list_b) in
    merge_list (List.tl list_a) (List.tl list_b) merged;;

let merged_list = merge_list alkaline_earth_metals noble_gases [];;
Printf.printf "aaa\n";;
print_list merged_list;;