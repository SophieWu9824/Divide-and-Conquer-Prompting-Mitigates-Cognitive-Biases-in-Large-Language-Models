% compare the accuracy between system1 and system2 biases
load("data\ACC.mat")
sys2_id = [5,16,18,20,21,22,25];
sys1_id = setdiff(1:29,sys2_id);
sys2_acc = [];
sys1_acc = [];
for model_i = 1:length(model_name)
    for method_j = 1:length(method_name)
        eval(strcat('data_temp = Accuracy.',model_name{model_i},'.',...
            method_name{method_j},'.bias_acc;'));
        data_temp = table2array(data_temp(:,3));
        dat_sys1 = mean(data_temp(sys1_id));
        dat_sys2 = mean(data_temp(sys2_id));
        sys2_acc(model_i,method_j) = dat_sys2;
        sys1_acc(model_i,method_j) = dat_sys1;
    end
end

Sys1ACC = array2table(sys1_acc,"RowNames",model_name,"VariableNames",method_name);
Sys2ACC = array2table(sys2_acc,"RowNames",model_name,"VariableNames",method_name);
id_change = [3,2,4,5,1];
Sys1ACC = Sys1ACC(id_change,:);
Sys2ACC = Sys2ACC(id_change,:);

% plot for each models: system1 vs. system2
model_nm = ["GPT-4","GPT-3.5-Turbo","Qwen","Zhipu","Atom-7B-Chat"];
method_nm = ["Base","CoT","RoT","D&C"];
figure
for i = 1:length(model_nm)
    subplot(1,5,i)
    data_temp1 = table2array(Sys1ACC(i,1:4));
    data_temp2 = table2array(Sys2ACC(i,1:4));
    plot(1:4,data_temp1,'-s','LineWidth',2);hold on;
    plot(1:4,data_temp2,'-o','LineWidth',2);
    title(model_nm(i))
    xticklabels(method_nm)
    ylabel("Accuracy")
    ylim([min([data_temp1,data_temp2])-0.05,max([data_temp1,data_temp2])+0.05])
    xlim([0.5,4.5])
    legend("System1","System2")

end

%% 
load("data\ACC_system12.mat")
Sys1_accall = table2array(mean(Sys1ACC,1));
Sys2_accall = table2array(mean(Sys2ACC,1));
b = bar([Sys1_accall(1:4)',Sys2_accall(1:4)'],'grouped');
b(1).FaceColor = [0.33,0.57,1];
b(2).FaceColor = [1,0.57,0.33];
ylim([0.5,0.75])
set(gca,'XTickLabel',method_nm)
ylabel("Accuracy")
legend("System1","System2")

% plot(1:4,Sys1_accall(1:4),'-s','LineWidth',2); hold on
% plot(1:4,Sys2_accall(1:4),'-o','LineWidth',2);



