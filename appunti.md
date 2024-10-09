## Lezione 2

+ frame p un record/struct con campi argomento e valoiri di rutorno.Il frame è organizzato per saeppere sempre dove dar tornare i dati

+ Prpblema della ricordsione (creazione di tanti frame) --> risolto con tail recurising
Metodo che viene applicato dal compilatore per rendere più semplice la gestione della ricorsione senza creare nuovi frame (molto meno tempo e memoria utilizzati)

+ Nel paradigma funzionale è sconsigliato il metodo if else, emglio usare il pattern matching

+ ML è fortemente (se dichiaro intero allora qualsiasi cosa che inserisco che non sia intero darà errore) e staticamente (lo fa compile time) tipato. QUesto permette di inferire direttamente sui tipi senza specificarli direttamente (lo capisce lui da solo)

+ Non c'è la coercion (o qualcosa del genere) (ad esempio esistono tipi diversi di moltiplicazione per moltiplicazione tra interi, tra float o mixati)

+ Appunto sui booleani: il diverso si fa con <> e non con !=

+ Operazioni con le stringhe (native in ocaml ed immutabili se non attraverso la trasformaizone in byte e l'uso della funzione set)
^ oer concaterare dfue styringhe
.[n] per accedere ad uno specifico carattere di una stringa

+ Liste --> sequenza di elementi omogenei con un proprio costruttore (chiamato con ::) pensate per farci pattern matching sopra. La concatenazione è fatta molto male e conviene fare un aggiunta in testa e poi invertire la lista (create con le parentesi quadre[])

+ Come fare slicing e cerca index: dopop

+ Tuple --> eterogenee e di lunghezza fissata (creata con le parentesi tonde()) sono più efficenti delle liste (e sono eterogenee) (l'accesso avviene con il pattern matching)

+ Gli array sono liste ad accessi diretto, omogenee e considerate come liste mutabili (create con [|1;3;4|] robda assurda).
Selezione con .(indice), assegnazione con .(indice) <- valore
Si possono fare array innestati

+ record --> sono coppie chiave valore, nativamente immutabili ma permettono di aggiungere mutable alle singole coppie per rendere quella coppia mutabile. SOno eterogenei. Creo un record usando type per definirlo come nuovo tipo

+ Aliasing e varinat

## Lezione 3
Perche distinguere? Perchè permette di avere più modi diversi di implementare un concetto in base a ciò che ci serve. In ocaml si usano i moduli e sono comporsti d due èarti: 
    uan parte pubblica oopzionelae che espone tipi ed operatori defitni nel modulo chiamata signature (è la parte astratta del modulo)
    una parte di cui implementiamo il modil0 chiamata struct (è la parte concreta)

Possiamo definire nella struct tipi e funzioni, poi una volta importato il modulo è facile usarlo
Nella sig invece definiamo che cosa volgiamo in modo sastratto, poi una volta importayta possiamo unirla mediante funxzione specifica alla sua impelementazione

Passiamo ai funtori: sono degli isomorfismi tra le strutture. Servono per evitare delle duplicazioni attraverso delle minime variazioni. L'ide a è quella di superare la differenza tra tipo di dati diversi per usare un modulo


## Lezione 4
Polimorfismo --> andiamo a defeinite da un type cn un interfaccia uniforme ed indipendente dal datatype che puo essere usata su tipi differenti
tipi generici che divenartno polimorfi (eterogeneo)
ocaml lo supporta nativamente
tipologie 
+ ad hoc, cambiano i tipi degli argomenti di ba funzione, cambia la composizione, stesso onme, stesso aspetto, diversa implementazuoone. Si trasforma un overloading
+ paremtrico, non specifichiamio i tipi, codice usato in maniera trasparente. paradigmi funzionali o orientati agli oggetti (generici)
+ per sottotipo gerarchia di oggetti che sono collegati da inerithance in java sono classi figlie, oppure cge implemenetayo i neterfaccie

in ocamlnon c'è type binding

esiste un tipo, non so wuale sia, ma appena ce n'è uno diventamio --> weaked type. Non posso cambiarlo una volta identificato

## Lezione 5
capire map, filter e reduce
capire pattern matching strutturale 
....
reduce si chiama fold e nasconde un problema: biogna scegliere il giusto operatore, poichè potrebbero facilemtne esserci operatori non commutativi o associativi (problemi legati alle algebre matematiche) --> pensare bene a come fare la fold [left/right]
Quest si propaga anche alla reduce

quando abbiamo un parametro opzionale, esso assume un valore di default, non con l'ultima istanza avuta (questo possiamo suppore succeda quando non lo mettiamo (essendo opzionale))

.((f h)) perchè? perchè .() esterno serve a puntare una posizione dell'array, le parentesi () interne servono per chiudere l'associatività dei parametri e calcolare l'intero

funzione con numero vaariabile di argomenti
definisco funzione arg

Le astrazioni vogliono solo tipi astratti, non tipi generici


### Parole chiave: "in" e "and"
In ocaml sono presenti due parole chiave molto potenti:
+ "in" permette di definire consecutivamente più funzioni o ridenominazioni di funzioni/valori/costanti che verranno poi usate con quel nome nelle funzioni dalla più esterna alla più interna. Permette di identare meglio le chiamate annidate e di definire non esternamente tali funzioni.
+ "and" permette la dichiarazione multipla di funzioni senza dover utilizzare let e senza dover usare il costrutto in



Gli operatori possono anche essere creati manualmente, un po' come avviene su c, andandoli a definire come funzioni che eseguono un determinato calcolo. Essendo tutto una funzione in questo paradigma, esso è ampiamente fattibile
```ml
let (>:) a b = (snd a) - (snd b);;
let max a b = if (a >: b >= 0) then a else b
```
Come funziona? Definisco un nuovo operatore infisso, ovvero che vuole un valore posto davanti e uno posto dietro, inserendolo all'interno delle parentesi per identificarlo come operatore. A lui assegno una funzione, che userà dunque i parametri richiesti. Per chiamarlo non basterà altro che porlo al centro dei due parametri che vogliamo passargli, come nella seconda riga 
