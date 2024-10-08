
# Guida per installare OCaml su Windows

Installare OCaml su Windows può risultare complicato. Segui i passaggi qui sotto per facilitare il processo.

## 1. Installare WSL (Windows Subsystem for Linux)

Apri **Powershell** o **cmd** e digita:

```bash
wsl --install
```

Durante l'installazione ti verrà richiesto di impostare un username e una password, che dovrai ricordare.

## 2. Installare Opam

Una volta configurato WSL, apri la **bash** e incolla il seguente comando per installare Opam:

```bash
bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
```

Quando richiesto, indica una directory in cui installare Opam.

## 3. Inizializzare Opam

Dopo l'installazione, digita il seguente comando per inizializzare Opam:

```bash
opam init
```

Opam ti chiederà come configurare l'environment. Scegli l'opzione 5, che esegue:

```bash
eval $(opam env)
```

### Attenzione agli errori

L'inizializzazione potrebbe fallire se mancano alcuni pacchetti essenziali. Ad esempio, potresti dover installare:

- `unzip`
- `bubblewrap`
- `make`
- `gcc`
- `bzip2`

Se anche uno solo di questi pacchetti manca, l'inizializzazione di Opam potrebbe bloccarsi. In tal caso, elimina gli avanzamenti (te lo propone direttamente lui) e ripeti la procedura.

## 4. Verificare l'installazione

Dopo aver installato i pacchetti necessari, esegui il comando:

```bash
eval $(opam env)
```

## 5. Installare i tool utili di OCaml

Assicurati di aver installato almeno `bzip2`, poi esegui il seguente comando per installare alcuni tool utili per OCaml:

```bash
opam install ocaml-lsp-server odoc ocamlformat utop
```

Se durante l'esecuzione si verificano errori, puoi interrompere il processo con `ctrl+c` e ripetere il comando.

## 6. Installare ocamlc

Per installare ocamlc, obbligatorio per buildare, affianco alla directory opam dove avete installato opam, runnate
```bash
sudo apt install ocaml
```
Ora potete runnare ocamlc

## 6. Configurare VSCode

Se non hai riscontrato errori durante i passaggi precedenti, tutto dovrebbe essere andato a buon fine.

Ora apri **VSCode** e utilizza il pulsante per il **Remote Development** (sotto le impostazioni) *(nota a volte bisogna installare l'estenzsione di VSCode)* per selezionare WSL come ambiente di lavoro.

## 7. Scelta dell'ambiente WSL

Durante questa fase, potresti vedere diverse opzioni di ambiente (come Docker o altri container). Seleziona **Ubuntu su WSL** o il sistema operativo Linux che hai installato.

## 8. Verifica dell'installazione in VSCode

Una volta aperto VSCode in WSL, verifica che Opam sia stato installato correttamente digitando:

```bash
opam
```

Se tutto funziona correttamente, potrai iniziare a lavorare con OCaml in VSCode!

## 9. Installa ocaml

Una volata finito tutto esegui il comando 
```bash
sudo apt install ocaml
```
fattio ciò potrai compilare ed eseguire i tuoi file **.ml**

