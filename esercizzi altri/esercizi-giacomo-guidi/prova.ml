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

(*** Pattern matching ***)

(* Il pattern matching è una tecnica simile all'istruzione switch nei linguaggi imperativi, 
   ma offre una potenza espressiva molto maggiore. 
   Sebbene possa sembrare complicato, si riduce essenzialmente al confronto di un argomento 
   con un valore esatto, un predicato o un costruttore di tipo. Il sistema di tipi è ciò 
   che lo rende così potente. *)

(** Matchare valori esatti.  **)
let is_zero x =   
   match x with   
   | 0 -> true   
   | _ -> false  (* Il carattere "_" indica qualsiasi altro valore. *)
;;

(* Puoi usare anche la keyword "function" per indicare un pattern matching, addirittura 
   senza dover indicare il nome del parametro. *)
let is_one = function
   | 1 -> true 
   | _ -> false
;;

is_zero 0 ;; (* true *)
let mamamaam = 2;;
is_one mamamaam ;; (* false *)

(* Fare matching sui predicati, aka "guarded pattern matching". *)
let abs x =
   match x with
   | x when x < 0 -> -x
   | _ -> x
;;

abs 5 ;; (* 5 *)
abs (-5) (* 5 again *)

(** Matching type constructors **)

type animal = Dog of string | Cat of string ;;

let say x =
   match x with
   | Dog x -> x ^ " says woof"
   | Cat x -> x ^ " says meow"
;;

say (Cat "Fluffy") ;; (* "Fluffy says meow". *)

(* Il pattern matching deve essere esaustivo *)
type color = Red | Blue | Green ;;
let what_color x = 
  match x with 
  | Red -> "color is red"
  | Blue -> "color is blue"
  (* Se non aggiungo il caso _ oppure un caso "Green" il compilatore mi darà un errore *)

   | _ -> "color is green"
;;

(* I match statement vengono controllati in ordine, quindi se un caso _ appeare per primo 
   nessun caso successivo verrà raggiunto *)

(** Attraversare le data structures con il pattern matching **)

(* Il pattern matching è stato pensato anche per permettere di attraversare agevolmente e 
   in modo ricorsivo le strutture dati. Nello specifico, possiamo scorrere una lista 
   (sia il tipo built-in sia una creata da noi) ed eseguirne tutte le operazioni che vogliamo
   sfruttando il costruttore cons (: :).
   Possiamo infatti, data una lista, definire un pattern matching ricorsivo, con un caso base che
   fungerà da stop alla ricorsione e un passo che suddivide in uno o più elementi di testa la 
   lista che gli viene passata, separando gli elementi con il suo costruttore, e chiamando poi
   ricorsivamente la funzione passandogli la coda rimanente. Questo è possibile per la visione 
   delle liste come testa e coda (head e tail) *)
let rec sum_list l =
   match l with
   | [] -> 0
   | head :: tail -> head + (sum_list tail)  (* sottobanco matcha la lista l (composta dagli 
   elementi in posizione 0,1,2,3,...) con la lista l' (composta dagli elementi 1,2,3,... della 
   lista l) + l'elemento 0 della lista l *)
;;

sum_list [1; 2; 3] ;; (* Evaluates to 6 *)

(* Esempio fatto con una lista creata dall'utente. *)

type int_list = Nil | Cons of int * int_list ;;
let rec sum_int_list l =
 match l with
     | Nil -> 0
     | Cons (head, tail) -> head + (sum_int_list tail)
;;

let t = Cons (1, Cons (2, Cons (3, Nil))) ;;
sum_int_list t ;;

(* Funzione per dire se una lista è ordinata *)
let rec is_sorted l = 
  match l with 
  | x :: y :: tail -> x <= y && is_sorted (y :: tail)
  | _ -> true
;;

is_sorted [1; 2; 3] ;; (* True *)
(* La potente inferenza di tipo di OCaml deduce che l è di tipo int list poiché 
   l'operatore <= viene utilizzato sugli elementi di l *)

(* Funzione per reversare una lista, funzionante su qualisasi tipo di lista *)
let rec rev (l: 'a list) : 'a list = 
 match l with 
 | [] -> []
 | x::tl -> (rev tl) @ [x]
;;

rev [1; 2; 3] ;; (* Gives [3; 2; 1] *)

