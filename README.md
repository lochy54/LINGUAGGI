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

## Parole chiave: "in" e "and"
In ocaml sono presenti due parole chiave molto potenti:
+ "in" permette di definire consecutivamente più funzioni o ridenominazioni di funzioni/valori/costanti che verranno poi usate con quel nome nelle funzioni dalla più esterna alla più interna. Permette di identare meglio le chiamate annidate e di definire non esternamente tali funzioni.
+ "and" permette la dichiarazione multipla di funzioni senza dover utilizzare let e senza dover usare il costrutto in

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

Gli operatori possono anche essere creati manualmente, un po' come avviene su c, andandoli a definire come funzioni che eseguono un determinato calcolo. Essendo tutto una funzione in questo paradigma, esso è ampiamente fattibile
```ml
let (>:) a b = (snd a) - (snd b);;
let max a b = if (a >: b >= 0) then a else b
```
Come funziona? Definisco un nuovo operatore infisso, ovvero che vuole un valore posto davanti e uno posto dietro, inserendolo all'interno delle parentesi per identificarlo come operatore. A lui assegno una funzione, che userà dunque i parametri richiesti. Per chiamarlo non basterà altro che porlo al centro dei due parametri che vogliamo passargli, come nella seconda riga 

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
I **Functors** in OCaml sono funzioni che operano su moduli e producono altri moduli. In altre parole, un Functor è una funzione da una struttura di dati a un'altra. Questo significa che:
+ La firma delle strutture di input e output è fissata.
+ I dettagli implementativi possono variare senza influire sui moduli che li utilizzano.

I Functors consentono di evitare la duplicazione del codice e migliorano l'ortogonalità all'interno di un pacchetto **type-safe**.

### Esempio implementativo
Supponiamo di voler implementare una funzione `is_balanced()` che controlli se una stringa ha parentesi bilanciate:
```ml
let is_balanced str =
  let s = Stack.empty in
  try
    String.iter
      (fun c -> match c with
         | '(' -> Stack.push s c
         | ')' -> Stack.pop s
         | _ -> ()) str;
    Stack.is_empty s
  with Stack.EmptyStackException -> false
```
### Modulo di Stack
Definiamo un modulo che descriva la struttura di uno stack, che useremo con il nostro algoritmo:
```ml
module type StackADT =
sig
  type char_stack
  exception EmptyStackException
  val empty : char_stack
  val push : char_stack -> char -> unit
  val top : char_stack -> char
  val pop : char_stack -> unit
  val is_empty : char_stack -> bool
end
```
In questo modulo, se l'algoritmo termina con uno stack vuoto, allora la stringa è bilanciata.
### Matcher factor
Il Matcher collega il nostro algoritmo a uno stack astratto di tipo dato:

```ml
module Matcher (Stack : StackADT) =
struct
  let is_balanced str =
    let s = Stack.empty in
    try
      String.iter
        (fun c -> match c with
           | '(' -> Stack.push s c
           | ')' -> Stack.pop s
           | _ -> ()) str;
      Stack.is_empty s
    with Stack.EmptyStackException -> false
end
```
Questo **Functor Matcher** permette di utilizzare qualsiasi implementazione dello stack purché segua la struttura definita in `StackADT`.
## Polymorphism in ML
Il polimorfismo consente di scrivere funzioni e strutture dati generiche che possono operare su diversi tipi di dato utilizzando un'interfaccia comune.
### Esistono diversi tipi di polimorfismo

+ **Polimorfismo parametrico**: Consente di scrivere funzioni senza menzionare specificamente alcun tipo di dato.
```ml
let compose f g x = f (g x);;
```
Questo significa che la funzione può operare su qualsiasi tipo, purché i tipi si adattino.

+ **Polimorfismo ad hoc** (Overloading): Le funzioni hanno diverse implementazioni che dipendono dalla combinazione e dal tipo di dati.
+ **Polimorfismo di sottotipo**: Le funzioni possono operare su un insieme ristretto di tipi che appartengono a una gerarchia di sottotipi. È un caso particolare di polimorfismo parametrico.


### Polimorfismo parametrico in OCaml
OCaml supporta pienamente il polimorfismo parametrico, che consente di implementare funzioni generiche senza vincolare esplicitamente i tipi. Un esempio tipico è la funzione `compose`:
```ml
let compose f g x = f (g x);;
```
### Compose è un weak-typed
Quando non conosciamo esattamente il tipo di una funzione, questa viene considerata **weakly-typed**. I tipi verranno ristretti alle possibili combinazioni di tipi della funzione e successivamente risolti nel primo tipo disponibile.
```ml
# let compose f g x = f (g x);;
val compose : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b = <fun>

# let compose' = compose (fun c -> int_of_char c) ;;
val compose' : ('_a -> char) -> '_a -> int = <fun>
```
In questo esempio, il simbolo `_` viene utilizzato per indicare che il tipo è stato inizializzato come **weakly-typed**, e sarà risolto successivamente quando verrà utilizzato con un tipo specifico.

In una funzione weakly-typed il suo tipo non è completamente definito fino a quando non viene utilizzata. Questo tipo verrà ristretto a seconda dei tipi specifici passati alla funzione durante l'esecuzione.
Una volata associato un tipo quello sarà permanente.
## Currying
Currying è una tecnica utilizzata per trasformare una funzione che prende più argomenti in una serie di funzioni che prendono un singolo argomento. Questo permette di "parzializzare" una funzione, cioè di fornire un argomento alla volta.

$f(x,y)= y/x \rightarrow f(2)= y/2 \rightarrow f(2)(3) = 3/2 $
Posso scriverlo come 
$f(x,y)= y/x \rightarrow g(2)= f(2,y)=y/2 \rightarrow g(3) = 3/2 $

In pratica, la funzione viene trasformata in una serie di funzioni che prendono un argomento alla volta.
```ml
let f x y = y /. x ;;  (* Definizione di una funzione con due argomenti *)
let g = f 2. ;;        (* Applicazione parziale della funzione f con x = 2 *)
```
### Usando parametri nominali
In OCaml, possiamo anche definire funzioni utilizzando parametri nominali, che ci permettono di esplicitare i nomi dei parametri quando si chiama la funzione:
```ml
let compose ~f ~g x = f (g x) ;;  (* Funzione con parametri nominali *)
let compose' = compose ~g:(fun x -> x ** 3.) ;;  (* Applicazione parziale *)
```  
Il **Currying** è utile quando sappiamo che uno dei parametri della nostra funzione è fissato o quando non abbiamo tutti gli argomenti disponibili contemporaneamente.
## Pattern Map, filter and reduce
Pattern sono fondamentale nella programmazione funzionale:
+ Applica una funzione su tutti gli elementi del mio argomento **map**
```ml
let rec map f = function
h::l1 -> f h::map f l1
| _ -> [];;
```

+ Filtrare degli elementi del mio argomento **filter**
```ml
let rec filter p = function
[] -> []
| h::l -> if p h then h :: filter p l else filter p l
```

+ Riduce gli elementi ad un singolo valore **reduce**
```ml
let rec reduce acc op = function
[] -> acc
| h::tl -> reduce (op acc h) op tl ;;
```

### Altri pattern definiti usando map e reduce
Possiamo definire altri pattern utili usando `map` e `reduce`, come ad esempio: 
+ **exist**: Ritorna `true` se almeno un elemento della lista soddisfa il predicato.
```ml
let exists p l = reduce false (||) (map p l);
```
+ **forall**: Ritorna `true` se tutti gli elementi della lista soddisfano il predicato.
```ml
let forall p l = reduce true (&&) (map p l);;
```
## Folding
Nella programmazione funzionale, il folding è il processo di ridurre una lista (o un'altra struttura di dati) a un singolo valore iterando attraverso di essa e combinando i suoi elementi usando una funzione binaria. Esistono due tipi principali di fold:
+ **Fold sinistro** (fold_left): Questa operazione combina gli elementi da sinistra a destra. Inizia con il primo elemento della lista e lo combina con i risultati della combinazione ricorsiva degli altri elementi. 
  + $((((((0 + 1) + 2) + 3) + 7) + 25) + 4)$

+ **Fold destro** (fold_right): Questa operazione funziona in modo opposto, combinando gli elementi della lista da destra a sinistra. Inizia dall'ultimo elemento della lista e lo combina con i risultati della combinazione ricorsiva degli altri elementi.
  + $0 + (1 + (2 + (3 + (7 + (25 + 4)))))$

Se una funzione non ha una base matematica il folding lo definisco io con fold_left o fold_right.
```ml
let l = [1.;2.;3.;4.;5.] ;;
List.fold_right (/.) l 1. ;;
List.fold_left (/.) 1. l ;;
```
## Funzioni con Numero Variabile di Argomenti  //arrivato qui
 Implementazione di base che permette di accumulare i valori passati come argomenti utilizzando una funzione chiamata arg che accetta due valori e una funzione finale che elabora il risultato:
 ```ml
let arg x = fun y rest -> rest (op x y) ;;
let stop x = x;;
let f g = g init;;
 ```
Questa struttura è flessibile e permette di eseguire operazioni in modo iterativo:
```ml
f (arg 1) (arg 2) (arg 7) stop;;  (* Restituisce: [1; 2; 7] *)
```
### Utilizzo di Functor per la Generalizzazione
Per superare le limitazioni della definizione di funzioni con argomenti variabili, viene introdotto un functor, che permette di creare moduli flessibili e riutilizzabili per diverse operazioni.

```ml
module type OpVarADT =
sig
type a and b and c
val op: a -> b -> c
val init : c
end

module VarArgs (OP : OpVarADT.OpVarADT) =
struct
let arg x = fun y rest -> rest (OP.op x y) ;;
let stop x = x;;
let f g = g OP.init;;
end
```
### Problema
Un tipo generico come 'a list non può corrispondere alla firma OpVarADT perché nessuno dei tipi è definito come parametrico:
