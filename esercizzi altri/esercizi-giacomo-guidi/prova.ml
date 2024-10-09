(*variabili e funzioni devono essere inizializzati con let*)
let inc x = x + 1 ;;
let a = 99 ;;
a = inc 2;;

(*Sono concessi l'uso degli apostrofi per chiamare variabili e funzioni, tendenzialmente li usiamo per variabili o funzioni temporanee di una variabile/funzione esterna*)
let foo = 1 ;;
let foo' = foo * 2 ;;

(*In ocaml non è necessario definire i tipi perchè li riconosce lui
   puoi comunque definirli attraverso (x: int) o (x: float) ecc...
*)
let inc_int (x: float) = x +. 1. ;;
let inc_float (x: int) : int = x + 1 ;; (* così gli definisco anche il tipo del valore di ritorno*)
let inc_int' x = x+1;;
let inc_int'' = function x -> x+1;;

(* Per fare funzioni ricorsive devo definirle attraverso la "rec" keyword. *)
let rec factorial n = if n = 0 then 1 else n * factorial (n-1) ;;
factorial 5;;

(* Per chiamare le funzioni generalmente non è necessario usare le parentesi per scrivere i parametri, basta lasciare lo spazio *)
let fact_5 = factorial 5 ;;

(* ...a meno che l'argomento non sia una espressione *)
let fact_4 = factorial (5-1) ;;
let sqr2 = factorial (-2) ;;    (*don't run*)

(* Ogni funzione deve avere almeno un argomento.
   Siccome alcune funzioni non vogliono argomenti, si può semplicemnte scrivere () che il compilatore riconoscerà come il tipo "unit" *)
let print_hello () = print_endline "hello world" ;;

(* Devi ovviamente scrivere () nelle chiamate a funzioni zerarie *)
print_hello () ;;

(* Puoi usare più espressioni all'interno del copro. L'ultima di queste diventa il return value. 
   Tutte le altre espressioni devono essere di tipo "unit" *)
   let print_and_return x =
      print_endline (string_of_int x);
      x
  ;;

(* Le istanazazioni possono essere unite attraverso il construtto "let ... in".
   E come assegnare valori multipli a più variabili nei linguaggi imperativi. *)
   let x = 10 in let y = 20 in x + y ;;

(* Puoi usare anche il construtto "let ... and ... in". È utile per le funzioni ricorsive che
   si chiamano a vicenda. Se provi a farlo con il costrutto "let ... in", il compilatore si lamenterà di valori non definiti. *)
let rec
   is_even = function
   | 0 -> true
   | n -> is_odd (n-1)
   and
   is_odd = function
   | 0 -> false
   | n -> is_even (n-1);;

(* Puoi definire nuovi operatori o ridefinirne di esistenti chiamando let e l'operatore 
   tra parentesi. Solo alcuni simboli possono essere usati.
   Puoi determinare l'associatività e le regole di precedenza dell'operazione mediante il primo 
   simbolo dell'operatore *)
let (+) a b = a - b ;; 

(* Esempio: operatori unari devono inizia con il simbolo "~" *)
let (~/) x = 1.0 /. x ;;
~/4.0 (* = 0.25 *);;

(* Esempio: operatori binari devono iniziare con uno dei simboli: + - * / < > @ ^ | & *)
let (++) a b = a ^ b ;;

(*Appunti veloci su liste
   Puoi accedere ad elementi individuali delle liste con la funzione List.nth *)
let my_list = [1; 2; 3] ;;
List.nth my_list 1 ;;

(* Ci sono funzioni di alto livello nella libreria List che semplificano il lavoro: map and filter. *)
List.map (fun x -> x * 2) [1; 2; 3] ;;
List.filter (fun x -> x mod 2 = 0) [1; 2; 3; 4] ;;