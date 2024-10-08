(*Write a function that given a pure number returns a conversion table for it among any of the 8 scales*)
type temperature = {
  name: string;
  value: float
};;

let convert_in_celsius temp = 
  match temp.name with
  | "fahrenheit" -> (temp.value -. 32.0) *. 5.0 /. 9.0 
  | "kelvin" -> temp.value -. 273.5
  | "rankine" -> (temp.value -. 491.67) *. 5.0 /. 9.0
  | "delisle" -> 100. -. temp.value *. 2.0 /. 3.0
  | "newton" -> 100. *. temp.value /. 33.
  | "reaumur" -> 5. *. temp.value /. 4.
  | "romer" -> 40. *. (temp.value -. 7.5) /. 21.
  | _ -> -1000.0;;

let convert_in_fahrenheit temp = 
  match temp.name with
  | "celsius" -> (temp.value *. 9.0 /. 5.0) +. 32.0
  | "kelvin" -> (temp.value -. 273.15) *. 9.0 /. 5.0 +. 32.0
  | "rankine" -> temp.value -. 459.67
  | "delisle" -> 212.0 -. temp.value *. 6.0 /. 5.0
  | "newton" -> temp.value *. 60.0 /. 11.0 +. 32.0
  | "reaumur" -> temp.value *. 9.0 /. 4.0 +. 32.0
  | "romer" -> temp.value *. 24.0 /. 7.0 +. 32.0
  | _ -> -1000.0;;

let convert_in_kelvin temp = 
  match temp.name with
  | "celsius" -> temp.value +. 273.15
  | "fahrenheit" -> (temp.value -. 32.0) *. 5.0 /. 9.0 +. 273.15
  | "rankine" -> temp.value *. 5.0 /. 9.0
  | "delisle" -> 373.15 -. temp.value *. 2.0 /. 3.0
  | "newton" -> temp.value *. 100.0 /. 33.0 +. 273.15
  | "reaumur" -> temp.value *. 5.0 /. 4.0 +. 273.15
  | "romer" -> temp.value *. 40.0 /. 21.0 +. 273.15
  | _ -> -1000.0;;

let convert_in_rankine temp = 
  match temp.name with
  | "celsius" -> (temp.value +. 273.15) *. 9.0 /. 5.0
  | "fahrenheit" -> temp.value +. 459.67
  | "kelvin" -> temp.value *. 9.0 /. 5.0
  | "delisle" -> 671.67 -. temp.value *. 6.0 /. 5.0
  | "newton" -> temp.value *. 60.0 /. 11.0 +. 491.67
  | "reaumur" -> temp.value *. 9.0 /. 4.0 +. 491.67
  | "romer" -> temp.value *. 24.0 /. 7.0 +. 491.67
  | _ -> -1000.0;;

let convert_in_delisle temp = 
  match temp.name with
  | "celsius" -> (100.0 -. temp.value) *. 3.0 /. 2.0
  | "fahrenheit" -> 212.0 -. temp.value *. 6.0 /. 5.0
  | "kelvin" -> 373.15 -. temp.value *. 2.0 /. 3.0
  | "rankine" -> 671.67 -. temp.value *. 6.0 /. 5.0
  | "newton" -> 33.0 -. temp.value *. 50.0 /. 11.0
  | "reaumur" -> 80.0 -. temp.value *. 8.0 /. 4.0
  | "romer" -> 60.0 -. temp.value *. 40.0 /. 21.0
  | _ -> -1000.0;;

let convert_in_newton temp = 
  match temp.name with
  | "celsius" -> temp.value *. 33.0 /. 100.0
  | "fahrenheit" -> (temp.value -. 32.0) *. 11.0 /. 60.0
  | "kelvin" -> (temp.value -. 273.15) *. 33.0 /. 100.0
  | "rankine" -> (temp.value -. 491.67) *. 11.0 /. 60.0
  | "delisle" -> 33.0 -. temp.value *. 50.0 /. 11.0
  | "reaumur" -> temp.value *. 33.0 /. 80.0
  | "romer" -> temp.value *. 33.0 /. 60.0
  | _ -> -1000.0;;

let convert_in_reaumur temp = 
  match temp.name with
  | "celsius" -> temp.value *. 4.0 /. 5.0
  | "fahrenheit" -> (temp.value -. 32.0) *. 4.0 /. 9.0
  | "kelvin" -> (temp.value -. 273.15) *. 4.0 /. 5.0
  | "rankine" -> (temp.value -. 491.67) *. 4.0 /. 9.0
  | "delisle" -> 80.0 -. temp.value *. 8.0 /. 5.0
  | "newton" -> temp.value *. 80.0 /. 33.0
  | "romer" -> temp.value *. 32.0 /. 21.0
  | _ -> -1000.0;;

let convert_in_romer temp = 
  match temp.name with
  | "celsius" -> temp.value *. 21.0 /. 40.0 +. 7.5
  | "fahrenheit" -> (temp.value -. 32.0) *. 7.0 /. 24.0
  | "kelvin" -> (temp.value -. 273.15) *. 21.0 /. 40.0 +. 7.5
  | "rankine" -> (temp.value -. 491.67) *. 7.0 /. 24.0 +. 7.5
  | "delisle" -> 60.0 -. temp.value *. 40.0 /. 21.0
  | "newton" -> temp.value *. 60.0 /. 33.0 +. 7.5
  | "reaumur" -> temp.value *. 21.0 /. 32.0 +. 7.5
  | _ -> -1000.0;;

let convert temp scale = 
  match scale with
  | "celsius" -> {name = scale; value = convert_in_celsius temp}
  | "fahrenheit" -> {name = scale; value = convert_in_fahrenheit temp}
  | "kelvin" -> {name = scale; value = convert_in_kelvin temp}
  | "rankine" -> {name = scale; value = convert_in_rankine temp}
  | "delisle" -> {name = scale; value = convert_in_delisle temp}
  | "newton" -> {name = scale; value = convert_in_newton temp}
  | "reaumur" -> {name = scale; value = convert_in_reaumur temp}
  | "romer" -> {name = scale; value = convert_in_romer temp}
  | _ -> temp;;

  Printf.printf "celsius, fahrenheit, kelvin, rankine, delisle, newton, reaumur, romer";;
  
let stampa value =
