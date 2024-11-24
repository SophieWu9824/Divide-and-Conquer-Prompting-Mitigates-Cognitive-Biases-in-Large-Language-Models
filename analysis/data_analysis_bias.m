
% Data creation: 7 models
bias_dat = "BiasData.xlsx";
bias_names = ["FramingEffect","AnchorEffect","ConfirmationBias",...
    "RepresentativeHeuristic","ConjunctionFallacy","EndowmentEffect",...
    "InsensitivityToSampleSize"];
model_names = ["GPT-3.5-Turbo","GPT-4","Llama3-8B","Llama3-70B",...
    "Atom-7B-Chat","Qwen-Turbo","Zhipu"];
id = [5,6,2,7,1,3,4];
sheet_names = sheetnames(bias_dat);
% struct data merging all bias
biasData = {}; strt = '"';
for bias_i = 1:size(sheet_names,1)
    eval(strcat("biasData.",bias_names(bias_i),"=","readtable(bias_dat, 'Sheet',",...
        strt,string(sheet_names(bias_i)),strt,")"))
end

% load("biasDat.mat")

%%  framing effect
fram_stats = grpstats(biasData.FramingEffect,"model",{'mean','sem'});
% [h,p,ci,tstats] = ttest(biasData.FramingEffect.gain,biasData.FramingEffect.loss);
for model_i = 1:size(model_names,2)
    temp_modelDat = biasData.FramingEffect(...
        biasData.FramingEffect.model==id(model_i),:);
    disp(model_names(model_i))
    [h,p,ci,tstats]=ttest(temp_modelDat.gain,temp_modelDat.loss)
end

%% anchor effect
anch_stats = grpstats(biasData.AnchorEffect,"model",{'mean','sem'});
[h,p,ci,tstats] = ttest(biasData.AnchorEffect.high,biasData.AnchorEffect.low);

for model_i = 1:size(model_names,2)
    temp_modelDat = biasData.AnchorEffect(...
        biasData.FramingEffect.model==id(model_i),:);
    disp(model_names(model_i))
    [h,p,ci,tstats]=ttest(temp_modelDat.high,temp_modelDat.low)
end


%% bar plot for all 
barplot_bias1(biasData,model_names,bias_names,id)

