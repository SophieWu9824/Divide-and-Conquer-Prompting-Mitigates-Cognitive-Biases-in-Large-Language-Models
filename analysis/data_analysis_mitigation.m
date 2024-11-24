
% Mitigation Data creation: 7 models
biasCoT_dat = "BiasDataCoT.xlsx";
bias_names = ["FramingEffect","AnchorEffect","ConfirmationBias",...
    "RepresentativeHeuristic","ConjunctionFallacy","EndowmentEffect",...
    "InsensitivityToSampleSize"];
model_names = ["GPT-3.5-Turbo","GPT-4","Llama3-8B","Llama3-70B",...
    "Atom-7B-Chat","Qwen-Turbo","Zhipu"];
id = [5,6,2,7,1,3,4];
sheet_names = sheetnames(biasCoT_dat);
% struct data merging all bias
strt = '"';biasDataCoT = {};
for bias_i = 1:size(sheet_names,1)
    eval(strcat("biasDataCoT.",bias_names(bias_i),"=","readtable(biasCoT_dat, 'Sheet',",...
        strt,string(sheet_names(bias_i)),strt,")"))
end

% load("biasDataCoT.mat")

%% framing effect
fram_statsCoT = grpstats(biasDataCoT.FramingEffect,"model",{'mean','sem'});
% [h,p,ci,tstats] = ttest(biasDataCoT.FramingEffect.gain,biasDataCoT.FramingEffect.loss);
for model_i = 1:size(model_names,2)
    temp_modelDat = biasDataCoT.FramingEffect(...
        biasDataCoT.FramingEffect.model==id(model_i),:);
    disp(model_names(model_i))
    [h,p,ci,tstats]=ttest(temp_modelDat.gain,temp_modelDat.loss)
end

%% anchor effect 
anch_statsCoT = grpstats(biasDataCoT.AnchorEffect,"model",{'mean','sem'});
[h,p,ci,tstats] = ttest(biasDataCoT.AnchorEffect.high,biasDataCoT.AnchorEffect.low);

for model_i = 1:size(model_names,2)
    temp_modelDat = biasDataCoT.AnchorEffect(...
        biasDataCoT.FramingEffect.model==id(model_i),:);
    disp(model_names(model_i))
    [h,p,ci,tstats]=ttest(temp_modelDat.high,temp_modelDat.low)
end

%% bar plot for all
barplot_bias2(biasDataCoT,model_names,bias_names,id)

