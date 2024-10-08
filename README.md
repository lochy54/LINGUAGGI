# ORGANIZZAZIONE
### Accedere alla pagina del corso
+ username: **lp**
+ password: **#2011#+LP**
### Gruppo:
+ [Luca Carone Polettini](https://github.com/lochy54)
+ [Bea Oldrati](https://github.com/Bea-Oldr)
+ [Giacomo Guidi](https://github.com/SirFuryy)
### Link Utili:
+ [imparare ocaml in y minuti](https://learnxinyminutes.com/docs/ocaml/)
+ [100 esercizi ottimi per ocaml](https://ocaml.org/exercises)
+ [imparare ocaml in y minuti in greco](https://learnxinyminutes.com/docs/el-gr/ocaml-gr/)
# I LINGUAGGI FUNZIONALI
## Cosa è un linguaggio di programmazione funzionale?
Partiamo dagli altri paradigmi di programmazione: i linguaggi imperativi pongono il loro focus principale sulla sequenezialità e semplicità del codice, mentre i linguaggi di programmazione orientati agli oggetti pongo il loro focus sulla rappresentazione del dato e sulla sua costruzione sotto forma di oggetto (P.S. Java per svecchiarsi sta adottando molti paradigmi funzionali).

Nei linguaggi di porgrammazione a paradigma funzionale invece il focus principale è sulle funzioni. In esso infatti le funzioni sono oggetti di prima classe e vengono pensate come funzioni matematiche, quindi tutto ciò che è fatto coi può essere fatto con le funzioni *(passare da una funzione ad un altra)*.

Questa visione delle funzioni in formato matematico, unita alla chiusura informatica, creano delle funzioni ben definite e che non generano side-effect *(importante punto di forza)*
+ La ricorsione è usata come struttura di controllo primaria. In alcuni linguaggi, non esiste nessun altro costrutto di loop.
+ C'è un focus sul list processing --> Di fatto non c'è nè l'assegnamento nè l'allocamento, ma solo la semplice ridenominazione di un valore/variabile/funzione.
In questi linguaggi infatti gli stati sono considerati immutabili. Una volta creato, può essere modificato solo ricreandone un altro chiamando una funzione. In questo ambito il focus sul list oricessing svolge il ruolo di scoraggiare l'uso dello stato esterno in favore della expression evaluation
+ Tutto ciò è permesso dall'idea che un qualsiasi valore è fisso e viene al più ridenominato *(si lo so perdonatemi la ripetitività, dopo verrà ridetto tutto, ma penso chiarisca meglio l'idea)*
+ Le liste sono spesso usate con ricorsione su sottoliste *(sostituto per i loops)*.
+ I linguaggi funzionali puri evitano gli effetti collaterali, questo scoraggia l'uso di istruzioni a favore delle valutazioni di espressioni.
## Perchè un liguaggio funzionale?
+ Codice più veloce, facile sviluppare e meno soggetto a bug.
+ Più facile dimostrarne le proprietà formali.
## Idea di base
L'idea di base è modellare tutto come se fosse una funzione matematica. Ci sono solo 2 costrutori linguistici:
+ **astratto** *definire una funzione*
+ **applicato** *chiamare una funzione*
## Concetto no state
+ Nessun assegniamento.
+ Le variabili sono solo nomi.

**ES:** in f(x) = x + 1 il nome f è inrilevante e può essere cambiato con g(x). Diventa : **x → x + 1**
## Le λ-expressions
1. Se x è una variabile o una constante allora x è una λ-expression.
2. Se x è una variabile e M è una λ-expression allora λx.M è una λ-expression.
3. Se M, N sono λ-expressions allora (MN) è una λ-expression.
### Abstraction & Application
+ λx.x + 1 **ABSTRACITON** *definisce il successore*
+ (λx.x + 1)7 **APPLICATION** *calcola il successore*
### Variabili libere e collegate
+ In λx.xy x è una **bound variable** e y è **unbound**.
+ In λx.λy.xy *(λxy.xy)* tutte le variabili sono **bound**.
+ In (λx.M)y tutte le occorrenze di x in M sono rimpiazzate da y *(M[x/y])* e diventa **M[x/y]** come risultato. Es : (λx.x + 1)7 → x + 1[x/7] → 7 + 1 → 8.
# OCaML
E' una implementazione di **ML** ma con funzionalità extra. OCaML contiene:
+ **interpreter** *(ocaml)*
+ **compiler** *(ocamlc)*

Le funzioni sono definite indipendentemente dal loro nome.
```ml
let succ = fun x -> x+1;;
let succ x = x+1;;
```
Le funzioni possono avere un alias.
```ml
let succ' = succ;;
```
Le chiamate sono un applicazione degli elementi di una funzione
```ml
succ 2;;
(fun x -> x+1) 2;;
```
```exe
[16:19]cazzola@surtur:~/lp/ml>ocaml
Objective Caml version 4.12.0
# let succ = fun x -> x+1;;
val succ : int -> int = <fun>
# succ 7;;
- : int = 8
# succ -1;;
Error: This expression has type int -> int
but an expression was expected of type int
```
## Scoping
Se uso un bind a un nome il vecchio valore viene nascosto
```ml
let y = 5;;
let y = 10;;
``` 
## In ML le funzioni sono first class citizens
Possono essere usate come valori e passate a funzioni più alte
```ml
let compose f g x = f (g x);;
let compose' (f, g) x = f (g x);;
```
## Le funzioni possono essere definite con il pattern matching.
```ml
match expression with
| pattern when boolean expression -> expression
| pattern when boolean expression -> expression
```
I pattern possono contenere:
+ costanti, tuple, records, variant constructors e nomi di variabili.
+ Un **catchall pattern** che confronta tutti i valori *(_)*.
+ Un **sub-patterns** contenente alternative *(pat1 |pat2)*

### Quando un pattern matches
+ La corrispondente espressione è ritornata.
+ La *(optional)* clausola **when** fa da "guardia" al maching, filtrando le richieste indesiderate
```ml
let invert x =
match x with
| true -> false
| false -> true ;;
let invert' = function
true -> false
| false -> true ;;
```
In generale nei paradigmi funzionali è sempre meglio usare un pattern matcher rispetto ai costrutti if-else

## Funzioni ricorsive
Una funzione è ricorsiva se chiama se stessa. Es: **Factorial**
$$
5! = 5 \times 4 \times 3 \times 2 \times 1
$$
$$
5! = 5 \times 4! 
$$
$$
4! = 4 \times 3!
$$
Definizione matematica:
   $$
   n! = 
   \begin{cases} 
   1 & \text{if } n = 0 \\
   n \times (n-1)! & \text{if } n > 0 
   \end{cases}
   $$
Una chiamata ricorsiva può essere
+ **Diretta**: una funzione chiama se stessa
+ **Indiretta** una funzione chiama un altra funzione che chiama la funzione principale
```ml
let rec fact(n) = if n<=1 then 1 else n*fact(n-1);;
let main() =
print_endline("fact( 5) : - "^string_of_int(fact(5)));
main();;
```
In generale le funzioni ricorsive sono più facili da comprendere e in alcuni casi ho problemi che sono nativamente ricorsivi.

Nello specifico invece il *problema principale della ricorsione è la creazione di tanti frame*. Un frame è un oggetto, simile ad un record di JAVA o ad una struct di Go, che contiene dei campi argomento e le indicazioni sui valori di ritorno che viene generato e posizionato in memoria ad ogni chiamata di funzione.

In una funzione ricorsiva molto grande dunque verrano generati una grande quantità di frame che possono impantanare il programma. La soluzione adottara da ocaml è il **tail recursing**, ovvero un metodo che viene applicato dal compilatore per rendere più semplice la gestione della ricorsione senza creare nuovi frame (molto meno tempo e memoria utilizzati)

## Datatype
ML è fortemente e staticamente tippato e il tipo di ogni istruzione è inferito dall'uso
+ **Fortemente** --> se dichiaro intero allora qualsiasi cosa che inserisco che non sia intero darà errore
+ **Staticamente** --> lo fa compile time

Dato che è fortemete tippato non posso avere problemi sui tipi.
```exe
# 1+2*3;;
- : int = 7
# let pi = 4.0 * atan 1.0;;
Error: This expression has type float but an expression was expected of type int
# let pi = 4.0 *. atan 1.0;;
val pi : float = 3.14159265358979312
```
+ Poichè non è presente la coercion, ho un simbolo diverso per ogni operazione con tipi di dato differente (int\*int, float\*float, int\*float). *Ad esempio aggiungo il punto per operazioni con i float*.

### Operatori
+ Costanti: true , false
+ Operatori logici: &&, ||, not
+ Operatori razzionali: ==, <> *(equal and not equa)*, < >, <=, >=
```exe
# true;;
- : bool = true
# true || false;;
- : bool = true
# 1<2;;
- : bool = true
# 2.5<>2.5;;
- : bool = false
```
### Stringhe
Le stringhe sono native in OCaML e sono immutabili se non attraverso la trasformaizone in byte e l'uso della funzione set
+ Concatenation operator ^
+ Positional access .[n]
+ Esiste un modulo **String** con degli operatori
```exe
let s1 = "walter" and s2 = "cazzola" ;;
val s1 : string = "walter"
val s2 : string = "cazzola"
# let s=s1^" "^s2;;
val s : string = "walter cazzola"
# s.[9];;
- : char = 'z'
# String.length(s);;
- : int = 14
# let b = Bytes.of_string s ;;
val b : bytes = Bytes.of_string "walter cazzola"
# Bytes.set b 0 'W'; Bytes.set b 7 'C';;
- : unit = ()
# let s = Bytes.to_string b;;
val s : string = "Walter Cazzola"
```
### List
Le liste sono sequenze di elementi omogenei con un proprio costruttore *(chiamato con ::)* pensate per farci pattern matching sopra.
+ Concatenation operator @ *(inefficente, conviene fare un aggiunta in testa e poi invertire la lista)*
+ create con le parentesi quadre[]
+ Esiste un modulo **List** con degli operatori
```exe
# [1; 1+1; 3];;
- : int list = [1; 2; 3]
# [1;'a';3.14];;
Error: This expression has type char but an expression was expected of type
int
# let l1 = [1;2;3] and l2 = [4;5;6];;
val l1 : int list = [1; 2; 3]
val l2 : int list = [4; 5; 6]
# l1@l2;;
- : int list = [1; 2; 3; 4; 5; 6]
(*aggiunta in testa ::*)
# let l1 = 0::l;;
val l1 : int list = [0; 1; 2; 3]
# List.nth l1
- : int = 2
# let a_list = [2; 7; 25; 3; 11; -1; 0; 7; 25; 25; 999; -25; 7];;
val a_list : int list = [2; 7; 25; 3; 11; -1; 0; 7; 25; 25; 999; -25; 7]
# let rec is_in l x = if l==[] then false else x==List.hd(l) || is_in (List.tl l) x;;
val is_in : 'a list -> 'a -> bool = <fun>
# is_in a_list 11;;
- : bool = true
# is_in a_list 12;;
- : bool = false
```
### Count
Conta gli elementi
```ml
let count x l =
let rec count tot x = function
[] -> tot
| h::tl -> if (h==x) then count (tot+1) x tl else count tot x tl
in count 0 x l
```
### Posizione
Trova la posizione di un elemento
```ml
let idx l x =
let rec idx2 l x acc =
if (List.hd l) == x then acc else idx2 (List.tl l) x (acc+1)
in idx2 l x 0;;
```
### Slice
Da un indice ad un altro *(hd e tl sono head e tail)*
```ml
let slice i j l =
let rec slice count res = function
hd::tl when count < i -> slice (count+1) res tl
| _ when count == j -> (List.rev res)
| hd::tl -> slice (count+1) (hd::res) tl
in slice 0 [] l ;;
```

## Tuples
Liste di tipi eterogenei con lunghezza fissata. Sono più efficenti di una lista.
+ create con le parentesi tonde()
+ l'accesso avviene con il pattern matching
```exe
# let a_tuple = (5, 'a', "a string", [1; 2; 3], 3.14);;
val a_tuple : int * char * string * int list * float =
(5, 'a', "a string", [1; 2; 3], 3.14)
# let a_pair = (1,"w");;
val a_pair : int * string = (1, "w")
# fst a_pair ;; (* works only on a pair *)
- : int = 1
# snd a_pair;; (* works only on a pair *)
- : string = "w"
# let a_triplet = ( "a", 0, true);;
val a_triplet : string * int * bool = ("a", 0, true)
# fst a_triplet;;
Error: This expression has type string * int * bool
but an expression was expected of type 'a * 'b
```
## Arrays
Liste di tipi omogenei con acesso diretto tramite indice.
+ create con [|1;3;4|]
+ Selezione con .(indice), assegnazione con .(indice) <- valore
```exe
# let an_array = [|1;2;3|];;
val an_array : int array = [|1; 2; 3|]
# an_array.(2);;
- : int = 3
# an_array.(1) <- 5;;
- : unit = ()
# an_array ;;
- : int array = [|1; 5; 3|]
```
Se uso il modulo **Array** ho più operazioni.
```exe
# let a = Array.make 5 0;;
val a : int array = [|0; 0; 0; 0; 0|]
# Array.concat [a; an_array] ;;
- : int array = [|0; 0; 0; 0; 0; 1; 5; 3|]
# let a_matrix = Array.make_matrix 2 3 'a' ;;
val a_matrix : char array array = [|[|'a'; 'a'; 'a'|]; [|'a'; 'a'; 'a'|]|]
# a_matrix.(1).(2) <- 'z';; (* .(1).(2) is equivalent to (1,2) *)
- : unit = ()
# a_matrix ;;
- : char array array = [|[|'a'; 'a'; 'a'|]; [|'a'; 'a'; 'z'|]|]
```
## Record
Sono coppie chiave valore, nativamente immutabili ma permettono di aggiungere mutable alle singole coppie per rendere quella coppia mutabile.
+ Accessibile con un nome
+ Eterogene
+ Creo un record usando type per definirlo come nuovo tipo
```exe
# type person = {name: string; mutable age: int};;
type person = { name : string; mutable age : int; }
# let p = {name = "Walter"; age = 35} ;;
val p : person = {name = "Walter"; age = 35}
# p.name;;
- : string = "Walter"
# p.age <- p.age+1;;
- : unit = ()
# p ;;
- : person = {name = "Walter"; age = 36}
# p.name <- "Walter Cazzola";;
Error: The record field label name is not mutable
```
### Aliasing
```exe
# type int_pair = int*int;;
type int_pair = int * int
# let a : int_pair = (1,3);;
val a : int_pair = (1, 3)
# fst a;;
- : int = 1
```
Qualsiasi tipo può avere un alias.
### Varianti
Un tipo variante contiene tutte le possibili variazioni del tipo.
```exe
# type int_option = Nothing | AnInteger of int ;;
type int_option = Nothing | AnInteger of` int
# Nothing;;
- : int_option = Nothing
# AnInteger 7;;
- : int_option = AnInteger 7
```
Possono essere usate nel Pattern Macching
```ml
type card = Card of regular | Joker
and regular = { suit : card_suit; name : card_name; }
and card_suit = Heart | Club | Spade | Diamond
and card_name = Ace | King | Queen | Jack | Simple of int;;
let value = function
Joker -> 0
| Card {name = Ace} -> 11
| Card {name = King} -> 10
| Card {name = Queen} -> 9
| Card {name = Jack} -> 8
| Card {name = Simple n} -> n ;;
```
## Moduli
I moduli sono utilizzati per realizzare dei datatype e collezzioni di funzioni.
Sono composti da:
+ Una parte pubblica opzionale che espone tipi ed operatori da definire nel modulo chiamata signature (è la parte astratta del modulo) (sig . . . end);
+ Una parte di cui implementiamo il modulo chiamata struct (è la parte concreta) (struct . . . end).

I modiuli possono essere astratti e quindi nascondere dettagli implementativi.

### Perche distinguere funzioni astratte e funzioni concrete? 
Perchè permette di avere più modi diversi di implementare un concetto in base a ciò che ci serve.

```ml
module A :
sig
...
end =
struct
...
end ;;
```
I moduli sono anche molto utili per organizzare grandi implementazioni suddividendo il codice in piccoli pezzi.

### Esempio di struttura di un modulo
```ml
module PrioQueue =
  struct
    type priority = int
    type char_queue = Empty | Node of priority * char * char_queue * char_queue
    exception QueueIsEmpty

    let empty = Empty

    let rec insert queue prio elt =
      match queue with
      Empty -> Node(prio, elt, Empty, Empty)
      | Node(p, e, left, right) ->
        if prio <= p
        then Node(prio, elt, insert right p e, left)
        else Node(p, e, insert right prio elt, left)
    
    let rec remove_top = function
      Empty -> raise QueueIsEmpty
      | Node(prio, elt, left, Empty) -> left
      | Node(prio, elt, Empty, right) -> right
      | Node(prio, elt, (Node(lprio, lelt, _, _) as left),
      (Node(rprio, relt, _, _) as right)) ->
        if lprio <= rprio
        then Node(lprio, lelt, remove_top left, right)
        else Node(rprio, relt, left, remove_top right)
    
    let extract = function
      Empty -> raise QueueIsEmpty
      |Node(prio, elt, _, _) as queue -> (prio, elt, remove_top queue)
  end;;
```

```exe
# #use "char_pqueue.ml" ;;
module PrioQueue :
sig
type priority = int
type char_queue =
Empty
| Node of priority * char * char_queue * char_queue
exception QueueIsEmpty
val empty : char_queue
val insert : char_queue -> priority -> char -> char_queue
val remove_top : char_queue -> char_queue
val extract : char_queue -> priority * char * char_queue
end
# let pq = empty ;;
val pq : PrioQueue.char_queue = Empty
# ♠let pq = insert pq 0 'a' ;;
val pq : PrioQueue.char_queue = Node (0, 'a', Empty, Empty)
# let pq = insert (insert pq 3 'c') (-7) 'w';;
val pq : PrioQueue.char_queue =
Node (-7, 'w', Node (0, 'a', Empty, Empty), Node (3, 'c', Empty, Empty))
# let pq = extract pq;;
val pq : PrioQueue.priority * char * PrioQueue.char_queue =
(-7, 'w', Node (0, 'a', Empty, Node (3, 'c', Empty, Empty)))
```
L'inrefaccia di un modulo può essere compilata separatamente
## Functors
I Functors sono funzioni da strutture a strutture, questo significa che:
+ la firma delle strutture di i/o sono fissate
+ I dettagli implementativi possono variare senza incidere su alcun modulo che lo usa

Le funzioni permettono di non avere dupicati e aumentata Ortogonalità dentro un **type safe** pakege
### Esempio implementativo 
is_balanced() controlla che una stringa abbia le parentesi bilanciate.
```ml
let is_balanced str =
let s = Stack.empty in try
String.iter
(fun c -> match c with
'(' -> Stack.push s c
| ')' -> Stack.pop s
| _ -> ()) str;
Stack.is_empty s
with Stack.EmptyStackException -> false
```
### Modulo
```ml
module type StackADT =
sig
type char_stack
exception EmptyStackException
val empty : char_stack
val push : char_stack -> char -> unit
val top : char_stack -> char
val pop : char_stack -> unit
val i
```
Se lalgoritmo fenisce con uno stack vuoto io ho una stringa bilanciata.
### Matcher factor
Il Matcher è un factor che collega il nostro algoritmo a uno stack di tipo di dato astratto
```ml
module Matcher (Stack : StackADT.StackADT) =
struct
let is_balanced str =
let s = Stack.empty in try
String.iter
(fun c -> match c with
'(' -> Stack.push s c
| ')' -> Stack.pop s
| _ -> ()) str;
Stack.is_empty s
with Stack.EmptyStackException -> false
end
```
