(*variabili e funzioni devono essere inizializzati con let*)
let inc x = x + 1 ;;
let a = 99 ;;
a = inc 2;;

(*Sono concessi l'uso degli apostrofi per chiamare variabili e funzioni, tendenzialmente li usiamo per variabili o funzioni temporanee di una variabile/funzione esterna*)
let foo = 1 ;;
let foo' = foo * 2 ;;

(*In ocaml non è necessario definire i tipi perchè li riconosce luiù
*)
let inc_int (x: int) : int = x + 1 ;;
let inc_int' x = x+1;;

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

(* Le istanazazioni possono essere unite attraverso il construtto "let ... in".
   E come assegnare valori multipli a più variabili nei linguaggi imperativi. *)
let x = 10 in let y = 20 in x + y ;;