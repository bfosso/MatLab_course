initCobraToolbox
load('iJO1366_ecoli.mat')

%%
%%Question 1 - Oxygen import is set to 0%

model = changeObjective(model,'Ec_biomass_iJO1366_core_53p95M');
model = changeRxnBounds(model,'EX_o2(e)',0,'l');
disp('The answer for question 1 is')
FBAsolution = optimizeCbModel(model,'max')

%%
%%Question 2 - Metabolic modification to stop growth%

model = changeRxnBounds(model,'EX_glc(e)',0,'l');
disp('The answer for question 2 is')
FBAsolution = optimizeCbModel(model,'max')

%%
%%Question 3 - Glucose uptake removed and glutamine supplemented%

model = changeRxnBounds(model,'EX_glc(e)',0,'l');
model = changeRxnBounds(model,'EX_gln-L(e)',-10,'l');
disp('The answer for question 3 is')
FBAsolution = optimizeCbModel(model,'max')

%%
%%Question 4 - Acetate supplementation%

model = changeRxnBounds(model,'EX_ac(e)',-10,'1');
disp('The answer for question 4 is')
FBAsolution = optimizeCbModel(model,'max')

%%
%%Question 5 - List all exchange reactions with negeative lower bounds%

%load('iJO1366_ecoli.mat')
indices_exchange_reactions = strmatch('EX_',model.rxns);
exchange_reactions = model.rxns(indices_exchange_reactions);
names_exchange_reactions = model.rxnNames(indices_exchange_reactions);
lb_exchange_reactions = model.lb(indices_exchange_reactions);
disp('The answer for question 5 is')
model.rxnNames(lb_exchange_reactions < 0)

%%
%%Question 6 - oxygen uptake graph, values -100 to 0%

obj_vector = zeros(101,1);
z = 1;
ix_oxygen = find(strcmp('EX_o2(e)',model.rxns));

for i = 0:100;
    model.lb(ix_oxygen) = -i;
    solution = optimizeCbModel(model);
    obj_vector(i+1) = solution.f;
end

figure
scatter (0:100,obj_vector,'.')
xlabel('Maximum oxygen uptake');
ylabel('Biomass');


%%
%Question 7 - Genes%
load('iJO1366_ecoli.mat')
number_of_genes = numel(model.genes)
genes = model.genes;
FBA_growth_after_KO = zeros(length(model.genes),1);
for i = 1 : length(model.genes)
    modelDel = deleteModelGenes(model,genes{i});
    temp = optimizeCbModel(modelDel);
    FBA_growth_after_KO(i) = temp.f;
end

Essential_genes = find(FBA_growth_after_KO < 0.0001); %we find the genes such that, when they are KO, the value of biomass is lower than 0.0001 (a very low threshold)
disp('Genes required for cell growth')
model.genes(Essential_genes)