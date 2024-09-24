# I LINGUAGGI FUNZIONALI
## Cosa è un linguaggio di programmazione funzionale?
+ Le funzioni sono oggetti di prima classe, quindi tutto ciò che è fatto coi può essere fatto con le funzioni *(passare da una funzione ad un altra)*.
+ La ricorsione è usata come struttura di controllo primaria. In alcuni linguaggi, non esiste nessun altro costrutto di loop.
+ C'è un focus su il list processing.
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

```ml
[16:19]cazzola@surtur:~/lp/ml>ocaml
Objective Caml version 4.12.0
# let main() = print_string("Hello World in ML Style.\n");;
val main : unit -> unit = <fun>
# main();;
Hello World in ML Style.
- : unit = ()
# ^D
```

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
# let y = 5;;
val y : int = 5
# let y = 10;;
val y : int = 10
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

