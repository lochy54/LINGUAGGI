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
Nei linguaggi di programmazione a paradigma funzionale, il focus principale è sulle funzioni. Le funzioni sono considerate oggetti di prima classe e vengono pensate come funzioni matematiche. Questa visione permette di creare funzioni ben definite che non generano effetti collaterali *(side-effects)*, un aspetto cruciale nei linguaggi funzionali puri.
### In generale
+ La ricorsione è usata come struttura di controllo primaria. In alcuni linguaggi, non esiste nessun altro costrutto di loop.
+ In questi linguaggi gli stati sono considerati immutabili.
+ I linguaggi funzionali puri evitano gli effetti collaterali, questo scoraggia l'uso di istruzioni a favore delle valutazioni di espressioni.
## Perché scegliere un linguaggio funzionale?
+ **Codice più veloce**: Ottimizzato per esecuzione rapida.
+ **Facile sviluppo e debug**: Il codice è meno soggetto a bug.
+ **Dimostrazione delle proprietà formali**: Semplice da verificare grazie alla natura matematica delle funzioni.
## Idea di base
L'idea centrale è modellare tutto come una funzione matematica. Ci sono solo due costruttori linguistici:
+ **Astrazione**: definire una funzione.
+ **Applicazione**: chiamare una funzione.
## Concetto di "No State"
+ Non esiste l'assegnazione.
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
Il pattern matching è un metodo per confrontare un elemento con un possibile pattern e restituire un risultato.I pattern possono contenere:
+ Un **catchall pattern** che confronta tutti i valori *(_)*.
+ Un **sub-patterns** contenente alternative *(pat1 |pat2)*
```ml
let invert x =
  match x with
  | true -> false
  | false -> true ;;
```
### Quando ho un matche
+ La corrispondente espressione è ritornata.
+ La *(optional)* clausola **when** fa da "guardia" al maching, filtrando le richieste indesiderate

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

Esempio di funzione ricorsiva in OCaml:
```ml
let rec fact n = if n <= 1 then 1 else n * fact (n - 1);;
```

Una chiamata ricorsiva può essere:
+ **Diretta**: una funzione chiama se stessa
+ **Indiretta** una funzione chiama un altra funzione che chiama la funzione principale

In generale le funzioni ricorsive sono più facili da comprendere e in alcuni casi ho problemi che sono nativamente ricorsivi.
### Tail Recursion

Il problema principale della ricorsione è la creazione di molti frame di memoria. La soluzione di OCaml è la tail recursion, che permette di ottimizzare la gestione della ricorsione senza creare nuovi frame.

## Datatype
ML è **fortemente** e **staticamente tippato** con inferenza di tipo automatica.

+ **Fortemente**  : inserire un tipo errato causa un errore.
+ **Staticamente** : inserire un tipo errato causa un errore.

Dato che è fortemete tippato non posso avere problemi sui tipi.
Poichè non è presente la **coercion**, ho un simbolo diverso per ogni operazione con tipi di dato differente.

### Operatori
+ Costanti: `true` , `false`
+ Operatori razzionali: `==`, `<>`, `< >`, `<=`, `>=`
+ Operatori logici: `&&`, `||`, `not`

### Stringhe
Le stringhe sono native in OCaML e sono immutabili se non attraverso la trasformaizone in `byte` e l'uso della funzione set.
+ Concatenation operator `^`
+ Positional access `.[n]`
+ Esiste un modulo **String** con degli operatori
```ocaml
let greeting = "Ciao";;
```
### List
Le liste sono sequenze di elementi omogenei con un proprio costruttore **(chiamato con `::`)** pensate per farci pattern matching sopra.
+ Concatenation operator `@` *(inefficente, conviene fare un aggiunta in testa e poi invertire la lista)*
+ Create con `[]`
+ Esiste un modulo **List** con degli operatori
```ml
let my_list = [1; 2; 3];;
```
## Tuples
Liste di tipi eterogenei con lunghezza fissa. Sono più efficenti di una lista.
+ Create con `()`
+ L'accesso avviene con il pattern matching
```ml
let my_tuple = (1, "hello", true);;
```
## Arrays
Liste di tipi omogenei con acesso diretto tramite indice.
+ create con `[||]`
+ Selezione con `.(indice)`, assegnazione con `.(indice) <- valore`
+ Esiste il modulo **Array** con più operazioni.
```ml
let my_array = [| 1; 2; 3 |];;
my_array.(0) <- 10;;
```
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
In OCaml, possiamo creare degli alias per i tipi utilizzando la parola chiave type. Gli alias di tipo sono una forma di abbreviazione che ci permette di dare un nome più descrittivo a tipi esistenti o a combinazioni di tipi, rendendo il codice più leggibile e comprensibile.
```ml
type int_pair = int * int;;
```
In questo esempio, stiamo creando un alias di tipo chiamato int_pair per rappresentare una coppia di numeri interi.




### Varianti
Un **tipo variante** è un tipo che può contenere diverse varianti, ognuna delle quali può avere una struttura differente. Questo tipo è molto utile per definire insiemi di valori con proprietà diverse.
```ocaml
type int_option = Nothing | AnInteger of int ;;
```
In questo esempio, `int_option` è un tipo variante che può assumere due valori:

+ Nothing che rappresenta l'assenza di un valore.
+ AnInteger of int che rappresenta un intero.

### Utilizzo nel Pattern Matching
```ml
type card = Card of regular | Joker
and regular = { suit : card_suit; name : card_name; }
and card_suit = Heart | Club | Spade | Diamond
and card_name = Ace | King | Queen | Jack | Simple of int;;

let value = function
  | Joker -> 0
  | Card {name = Ace} -> 11
  | Card {name = King} -> 10
  | Card {name = Queen} -> 9
  | Card {name = Jack} -> 8
  | Card {name = Simple n} -> n;;
```
## Moduli
I **moduli** in OCaml sono utilizzati per creare datatype e collezioni di funzioni, aiutando a strutturare e organizzare il codice. Sono composti da due parti principali:

1. **Signature**: la parte astratta del modulo, che espone tipi e operatori. Questa sezione descrive cosa è disponibile pubblicamente, ma non come è implementato.
   - Sintassi: `sig ... end`
   
2. **Struct**: la parte concreta del modulo, che contiene l'implementazione effettiva del codice.
   - Sintassi: `struct ... end`

I moduli possono essere astratti per nascondere i dettagli implementativi e mantenere un'interfaccia pulita e facile da usare.
### Perché distinguere funzioni astratte e funzioni concrete?
Separare le funzioni astratte dalle concrete permette di avere diverse implementazioni per uno stesso concetto, consentendo di scegliere quella più adatta alle proprie esigenze senza cambiare l'interfaccia esterna.
Questa separazione è utile anche per organizzare grandi implementazioni suddividendo il codice in piccoli moduli facilmente gestibili.

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
