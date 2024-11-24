% compare the performance of four kinds of prompting methods (including the
% baseline standard prompt)
% average all models and all bias types
load("data\ACC.mat")
load("data\Merge_Seed.mat")
acc_prompt_seed = [];
acc_prompt_new = [];
for model_i = 1:length(model_name)

    for method_j = 1:(length(method_name)-1)
        eval(strcat('dat_temp = Accuracy.',model_name{model_i},'.',...
            method_name{method_j},'.all_acc;'));
        acc_prompt_new(model_i,method_j) = dat_temp;
        eval(strcat('dat_temp = MergeDat.',method_name{method_j},'(30,3:7);'));
        acc_prompt_seed(1:5,method_j) = table2array(dat_temp)';
    end
    
end
% seed questions
acc_prompt_seed = array2table(acc_prompt_seed,"RowNames",model_name(1,[3,2,4,5,1]),"VariableNames",method_name(1:4));
acc_prompts_seed = mean(acc_prompt_seed,1);
% new questions
acc_prompt_new = array2table(acc_prompt_new,"RowNames",model_name,"VariableNames",method_name(1:4));
acc_prompt_new = acc_prompt_new([3,2,4,5,1],:);
acc_prompts_new = mean(acc_prompt_new,1);
data_seed = table2array(acc_prompts_seed);
data_new = table2array(acc_prompts_new);
% bar plot
figure
hold on

b = bar([data_seed',data_new'],'grouped');
b(1).FaceColor = [0.33,0.57,1];
b(2).FaceColor = [1,0.57,0.33];

ylim([0.5,0.75])
method_nm = ["Base","CoT","RoT","D&C"];
xticks([1,2,3,4])
xticklabels(method_nm)
% set(gca,'XTickLabel',method_nm)
ylabel("Accuracy")
legend("seed ques","new ques")

