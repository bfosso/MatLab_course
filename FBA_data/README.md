Questa cartella contiene il materiale per il tutorial in *MatLab* riguardante la **Flux Balance Analysis (FBA)**.  
La presentazione introduttiva è scaricabile utilizzando il seguente [**LINK**](https://drive.google.com/open?id=1ek5q6gPeHc9OsQLrHw2RAU00rl5uz-2N).  
```
cp /usr/local/MATLAB/R2017B/toolbox/cobratoolbox/test/models/mat(iJ01366.mat Scrivania
```

Di seguito le righe di codice **MatLab** da utilizzare

```
% inizializziamo il cobratoolbox
initCobraToolbox()

% carichiamo il modello di Echerichia coli iJ01366
load('/usr/local/MATLAB/R2017b/toolbox/cobratoolbox/test/models/mat/iJ01366.mat')

%nel workspace rinominare l'oggetto iJ01366 in model

% Adesso andiamo a vedere quello che nel modello è l'obbiettivo dell'FBA di default
ix_obj = find(model.c==1)
% Identifichiamo il nome della reazione settata come obbiettivo della FBA di default
model.rxns(ix_obj)
model.rxnNames(ix_obj)

% Predizione del tasso di crescita cellulare
FBA_solution = optimizeCbModel(model)

% stampiamo i flussi delle reazioni
FBA_solution.x

% stampiamo i flussi del vettore biomassa
FBA_solution.x(ix_obj)

% proviamo a vedere quanto glucosio è stato consumato
ix_glucose = find(strcmp('EX_glc(e)',model.rxns))
model.lb(ix_glucose)

% Modifichiamo l'import del glucosio a -5 mmol/(h gdW) e facciamo rigirare il modello
model.lb(ix_glucose) = -5;
FBA_solution_2 = optimizeCbModel(model)

% identifichiamo i nomi delle reazioni di scambio ed i relativi lower e upper bound
indices_ex_rxns = strmatch('EX_',model.rxns);
ex_rxns = model.rxns(indices_ex_rxns);
names_ex_rxns = model.rxnNames(indices_ex_rxns);
lb_ex_rxns = model.lb(indices_ex_rxns);
ub_ex_rxns = model.ub(indices_ex_rxns);


```
