
% plot comparisions of accuracy between different models: new questions

load("data\acc_prompting.mat")
data = acc_prompt_new;
model_names = ["GPT-4","GPT-3.5-Turbo","Qwen","Zhipu","Atom-7B-Chat"];
% method_names = data.Properties.VariableNames;
x = 1:5;
y_origin = table2array(data(:,1));
y_CoT = table2array(data(:,2));
y_RoT = table2array(data(:,3));
y_DR = table2array(data(:,4));
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
title('Performance on the new questions')

