

% the distribution of 29 cognitive biases in five LLMs

%% seed question
% difference between models' performance
file_path = "C:\Users\sophi\Desktop\AIPsyResearch\2_CognitiveBiases\2_LLMCogBias_Test\Data_RoT\";
sheet_name = sheetnames(file_path+"Data_pool_Q0.xlsx");
MergeDat = struct();
for i = 1:length(sheet_name)
    name_temp = sheet_name(i);
    dat = readtable(file_path+"Data_pool_Q0.xlsx",'Sheet',name_temp,'VariableNamingRule','preserve');
    % radarPlot(dat,sheet_name(i));
    eval(strcat('MergeDat.',name_temp,' = dat;'));
end

% model comparision plot
modelComPlot_seed(MergeDat);

%% 29*10 questions newly generated via GPT-4o
% GPT4 lacks RoT, DR, and DR data (need experiment)
file_path2 = "C:\Users\sophi\Desktop\AIPsyResearch\2_CognitiveBiases\2_LLMCogBias_Test\Data_RoT\AllMethods\";
files = dir(file_path2+'Merged_*.xlsx');
MergeDat_new = struct();
model_name = {'Atom7B','GPT35','GPT4','Qwen','Zhipu'};
% Direct Answer, Chain-of-Thought, Rationality-of-Thought, Division Rule,
% One-Shot
method_name = {'Origin','CoT','RoT','DR','OS'};
for i = 1:length(files)
    filename = fullfile(files(i).folder,files(i).name);
    sheet_name_new = sheetnames(filename);
    for j = 1:(length(sheet_name_new)-1)
        dat_new = readtable(filename,'Sheet',sheet_name_new(j),'VariableNamingRule','preserve');
        dat_new = dat_new(1:29,[1,2,5:2:23,24]);    
        dat_new.Properties.VariableNames(1:end) = ["ID","BiasName",...
            "Q1","Q2","Q3","Q4","Q5","Q6","Q7","Q8","Q9","Q10","ACC_bias"];
        eval(strcat("MergeDat_new.",model_name{i},".",sheet_name_new(j),'=dat_new;'))
    end
end

% % overall accuracy
Accuracy = struct();
temp_str = "'";
for i = 1:length(model_name)
    for j = 1:length(method_name)
        eval(strcat("Accuracy.",model_name{i},".",method_name{j},...
            "=ACCalculator(MergeDat_new,",temp_str,model_name{i},...
            temp_str,",",temp_str,method_name{j},temp_str,");"));
    end
end

%% radar plot for 29 bias with 290 new questions in each models
load("data\MergeData.mat")
for i = 1:length(model_name)
    for j = 1:length(method_name)
        radarPlot2(MergeDat_new,model_name{i},method_name{j});
        saveas(gcf,strcat('figure\',model_name{i},'_',method_name{j},'.png'))
    end

end

%% radar plot for 29 bias with all models pooled for each method
load("data\ACC.mat")
% final: 5 method, bias_prone for 29 bias, each method merges all models'
% performance in bias_acc
acc_Methods = struct();
for method_i =  1:length(method_name)
    acc_model = [];
    temp = [];data=[];
    for model_j = 1:length(model_name)
        eval(strcat('temp =  Accuracy.',model_name{model_j},'.',....
            method_name{method_i},'.bias_acc.ACC_bias;'));
        acc_model = [acc_model,temp];
    end
    eval(strcat('acc_Methods.',method_name{method_i},' = mean(acc_model,2);'));
    eval(strcat('data = acc_Methods.',method_name{method_i},';'));
    data = array2table(data,"VariableNames","BiasACC");
    data.BiasName = Accuracy.Atom7B.Origin.bias_acc.BiasName;
    radarPlot(data,method_name{method_i})

end


