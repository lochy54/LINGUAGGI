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
Nei linguaggi di porgrammazione a paradigma funzionale il focus principale è sulle funzioni. In esso infatti le funzioni sono oggetti di prima classe e vengono pensate come funzioni matematiche.

Questa visione delle funzioni in formato matematico va a creare delle funzioni ben definite che non generano side-effect *(importante punto di forza)*.
### In generale
+ La ricorsione è usata come struttura di controllo primaria. In alcuni linguaggi, non esiste nessun altro costrutto di loop.
+ In questi linguaggi gli stati sono considerati immutabili.
+ I linguaggi funzionali puri evitano gli effetti collaterali, questo scoraggia l'uso di istruzioni a favore delle valutazioni di espressioni.
## Perchè un liguaggio funzionale?
+ Codice più veloce
+ Facile sviluppare e meno soggetto a bug.
+ Facile dimostrarne le proprietà formali.
## Idea di base
L'idea di base è modellare tutto come se fosse una funzione matematica. Ci sono solo 2 costrutori linguistici:
+ **astratto** *definire una funzione*
+ **applicato** *chiamare una funzione*
## Concetto no state
+ Nessun assegniamento.
+ Le variabili sono solo nomi.

**ES:** in $f(x) = x + 1$ il nome $f$ è inrilevante e può essere cambiato con $g(x)$.
## Le λ-expressions
1. Se $x$ è una variabile o una constante allora $x$ è una λ-expression.
2. Se $x$ è una variabile e $M$ è una λ-expression allora $λx.M$ è una λ-expression.
3. Se $M$, $N$ sono λ-expressions allora $(MN)$ è una λ-expression.
### Abstraction & Application
+ $λx.x + 1$ **ABSTRACITON** *definisce il successore*
+ $(λx.x + 1) \times 7$ **APPLICATION** *calcola il successore*
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
## Il pattern matching
Metodo usato per confrontare un elemento con un possibile pattern e dare un risultato.
I pattern possono contenere:
+ costanti, tuple, records, variant constructors e nomi di variabili.
+ Un **catchall pattern** che confronta tutti i valori *(_)*.
+ Un **sub-patterns** contenente alternative *(pat1 |pat2)*

### Quando ho un matche
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
In generale nei paradigmi funzionali è sempre meglio usare un pattern matcher rispetto ai costrutti if-else.

## Funzioni ricorsive
Una funzione è ricorsiva se chiama se stessa. Es: **Fattoriale**

$
5! = 5 \times 4 \times 3 \times 2 \times 1
$

$
5! = 5 \times 4! 
$

$
4! = 4 \times 3!
$

   $
   n! = 
   \begin{cases} 
   1 & \text{if } n = 0 \\
   n \times (n-1)! & \text{if } n > 0 
   \end{cases}
   $

Una chiamata ricorsiva può essere:
+ **Diretta**: una funzione chiama se stessa
+ **Indiretta** una funzione chiama un altra funzione che chiama la funzione principale
```ml
let rec fact(n) = if n<=1 then 1 else n*fact(n-1);;
let main() =
print_endline("fact( 5) : - "^string_of_int(fact(5)));
main();;
```
In generale le funzioni ricorsive sono più facili da comprendere e in alcuni casi ho problemi che sono nativamente ricorsivi.

Nello specifico invece il **problema principale della ricorsione è la creazione di tanti frame**. Un frame è un oggetto, simile ad un record di JAVA o ad una struct di Go, che contiene dei campi argomento e le indicazioni sui valori di ritorno che viene generato e posizionato in memoria ad ogni chiamata di funzione.

In una funzione ricorsiva molto grande dunque verrano generati una grande quantità di frame che possono impantanare il programma. La soluzione adottara da ocaml è il **tail recursing**, ovvero un metodo che viene applicato dal compilatore per rendere più semplice la gestione della ricorsione senza creare nuovi frame (molto meno tempo e memoria utilizzati).

## Datatype
ML è **fortemente** e **staticamente tippato** e il tipo di ogni istruzione è inferito dall'uso.

+ **Fortemente**  se dichiaro intero allora qualsiasi cosa che inserisco che non sia intero darà errore
+ **Staticamente** lo fa compile time

Dato che è fortemete tippato non posso avere problemi sui tipi.
Poichè non è presente la coercion, ho un simbolo diverso per ogni operazione con tipi di dato differente.

### Operatori
+ Costanti: `true` , `false`
+ Operatori razzionali: `==`, `<>`, `< >`, `<=`, `>=`
+ Operatori logici: `&&`, `||`, `not`

### Stringhe
Le stringhe sono native in OCaML e sono immutabili se non attraverso la trasformaizone in byte e l'uso della funzione set.
+ Concatenation operator `^`
+ Positional access `.[n]`
+ Esiste un modulo **String** con degli operatori

### List
Le liste sono sequenze di elementi omogenei con un proprio costruttore **(chiamato con `::`)** pensate per farci pattern matching sopra.
+ Concatenation operator `@` *(inefficente, conviene fare un aggiunta in testa e poi invertire la lista)*
+ Create con `[]`
+ Esiste un modulo **List** con degli operatori

## Tuples
Liste di tipi eterogenei con lunghezza fissata. Sono più efficenti di una lista.
+ Create con `()`
+ L'accesso avviene con il pattern matching

## Arrays
Liste di tipi omogenei con acesso diretto tramite indice.
+ create con `[||]`
+ Selezione con `.(indice)`, assegnazione con `.(indice) <- valore`
+ Esiste il modulo **Array** con più operazioni.

## Record
Sono coppie chiave valore, nativamente immutabili ma che permettono di aggiungere **mutable** alle singole coppie per renderle **mutabile**.
+ Accessibile con un nome
+ Eterogene
+ Creo un record usando type per poi definirlo come nuovo tipo
```ml
type person = { name : string; mutable age : int; }
let p = {name = "Walter"; age = 35} ;;
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
### Varianti  // arrivato qui a correggere
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
## Polymorphism in ML
Permette di usare valori di datatype diversi attraverso un interfaccia uniforme, contiene:
+ Una funzione che permette di essere lancitata su più datatype
+ Un datatype generalizzato 
```ml
let compose f g x = f (g x);;
```
### Hoc Polymorphism
+ Le funzioni hanno diverse implementazioni che dipendono dalla quantità di datatype e la loro combinazione
+ Esempio  **overloading**
### Parametric Polymorphism
+ Tutto il codice è scritto senza menzionare nessun datatype
### Subtype Polymorphism
+ Le funzionio usano in insieme ristretto di sottotipi usabili
+ Un caso particolare di parametric polymorphism

### OCaML supporta parametric polymorphism
Implementa funzioni senza type binding
$$
(\alpha \rightarrow \beta) \times (\theta \rightarrow \alpha) \times \theta \rightarrow \beta
$$
Il tipo è ristretto al tipo di apha e beta.
```exe
# let compose f g x = f (g x);;
val compose : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b = <fun>
# let compose' = compose (fun c -> int_of_char c) ;;
val compose' : ('_a -> char) -> '_a -> int = <fun>
```
Note _ è usato per inizzaializzare i weak-typed
### Compose è un weak-typed
Se non sappiamo esattamente quale è il tipo è **weak-typed**.
Il tipo verà  ristretto alle possibili datatype della funzione e successivamente prenderà il primo tipo disponibile
