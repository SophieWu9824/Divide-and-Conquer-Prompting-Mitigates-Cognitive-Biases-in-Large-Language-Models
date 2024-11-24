function modelComPlot_seed(dataMerge)
% load("data\Merge_Seed.mat")
% plot comparisions of accuracy between different models
% model_names = dataMerge.Origin.Properties.VariableNames(3:7);
model_names = ["GPT-4","GPT-3.5-Turbo","Qwen","Zhipu","Atom-7B-Chat"];

x = 1:5;
y_origin = table2array(dataMerge.Origin(30,3:7));
y_CoT = table2array(dataMerge.CoT(30,3:7));
y_RoT = table2array(dataMerge.RoT(30,3:7));
y_DR = table2array(dataMerge.DR(30,3:7));
plot(x,y_origin,'-o','LineWidth',2,'DisplayName','Base'); hold on
plot(x,y_CoT,'-x','LineWidth',2,'DisplayName','CoT')
plot(x,y_RoT,'-s','LineWidth',2,'DisplayName','RoT')
plot(x,y_DR,'-*','LineWidth',2,'DisplayName','D&C')
legend show
set(gca,'XTick',1:5,'XTickLabel',model_names)
% xticklabels(model_names)
ylabel('Accuracy')
xlim([0.5,5.5])
ylim([0.2,0.9])
% title('Performance of models under different prompting methods')
title('Performance on the seed questions')

end
