Installare ocaml è un casino. Se hai windows segui i seguenti passaggi:
Installa wsl (windows subsitem for linux) aprendo powershell o cmd e digitando
  wsl --install
ed impostando username e password che vi ricordate

Poi installate opam incollando questa stringa nella bash creata da wsl
   bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
  e ditegli una directory in cui installarla

A questo punto digitate il comando
  opam init
per inizializzare opam. Vi chiederà un iniziale configurazione su come chiamare l'environment di opam, ditegli l'opzione 5, ovvero quella con chiamata
  eval $(opam env)

Attenzione: potrebbe generare degli errori il non avere determinati pacchetti installati.
A me ad esempio richiedeva e ho dovuto installare:
  unzip
  bubblewrap
  make
  gcc

Anche solo uno di questi genera un errore che blocca l'inizializzazione. In caso ditegli di tornare indietro e ripetete la procedura.
