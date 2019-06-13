genes = model.genes

for i = 1 : length (genes(1:100))
    disp(['I''m knocking out ' genes{i}]);
    modelDel = deleteModelGenes(model,genes{i});
    temp = optimizeCbModel(modelDel);
    FBA_growth_after_KO(i)= temp.f;
    disp (['The growth rate is ' num2str(FBA_growth_after_KO(i))]);
end