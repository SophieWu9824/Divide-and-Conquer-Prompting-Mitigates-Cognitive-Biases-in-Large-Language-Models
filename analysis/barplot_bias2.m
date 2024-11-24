% % mitigation plot
function barplot_bias2(biasDataCoT,model_names,bias_names,id)
% id = [5,6,2,7,1,3,4];
% 7 biases * 7 models
frame_dat = biasDataCoT.FramingEffect;
anchor_dat = biasDataCoT.AnchorEffect;
confirm_dat = biasDataCoT.ConfirmationBias;
represent_dat = biasDataCoT.RepresentativeHeuristic;
conjunc_dat = biasDataCoT.ConjunctionFallacy;
endow_dat = biasDataCoT.EndowmentEffect;
insen_dat = biasDataCoT.InsensitivityToSampleSize;

figure
% plot each bias one by one
colors = {'r','b','y'};

%% framing effect
subplot(4,2,1)
fram_stats = grpstats(frame_dat,"model",{'mean','sem'});
fram_stats = fram_stats(id,:);
hold on
numGroups = size(fram_stats,1);
numBars = 2; % gain & loss
groupWidth = min(0.5,numBars/(numBars+1));
means = table2array(fram_stats(:,[3,5]));
error = table2array(fram_stats(:,[4,6]));
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    bar(x,means(:,bar_i)',groupWidth/numBars,'DisplayName',model_names(bar_i),...
        'FaceColor',colors{bar_i});
end
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    errorbar(x,means(:,bar_i),error(:,bar_i),'k','LineStyle','none','CapSize',5,'LineWidth',1.5);
end
set(gca,'XTick',1:numGroups,'XTickLabel',model_names);
ylabel("Medicine Score")
yline(3.5,'--','LineWidth',0.5,'Color','k')
ylim([1,7])
legend("gain","loss")
title(bias_names(1))

%% anchor effect
subplot(4,2,2)
anchor_stats = grpstats(anchor_dat,"model",{'mean','sem'});
anchor_stats = anchor_stats(id,:);
hold on
numGroups = size(anchor_stats,1);
numBars = 2; % gain & loss
groupWidth = min(0.5,numBars/(numBars+1));
means = table2array(anchor_stats(:,[3,5]));
error = table2array(anchor_stats(:,[4,6]));
temp_colors = {'b','r'};
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    bar(x,means(:,bar_i)',groupWidth/numBars,'DisplayName',model_names(bar_i),...
        'FaceColor',temp_colors{bar_i});
end
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    errorbar(x,means(:,bar_i),error(:,bar_i),'k','LineStyle','none','CapSize',5,'LineWidth',1.5);
end
set(gca,'XTick',1:numGroups,'XTickLabel',model_names);
ylabel("Book Number")
legend("high","low")
title(bias_names(2))

%% confirmation bias
subplot(4,2,3)
confirm_dat = confirm_dat(id,:);
hold on
numGroups = size(confirm_dat,1);
numBars = 3; % accuracy, Prob_A, Prob_5
groupWidth = min(0.5,numBars/(numBars+1));
means = table2array(confirm_dat(:,[3,4,2]));
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    bar(x,means(:,bar_i)',groupWidth/numBars,'DisplayName',model_names(bar_i),...
        'FaceColor',colors{bar_i});
end
set(gca,'XTick',1:numGroups,'XTickLabel',model_names);
ylabel("Proportion")
yline(1/6,'--','LineWidth',0.5,'Color','k')
legend("with A","with 5","Accurate")
title(bias_names(3))

%% representative heuristic
subplot(4,2,4)
represent_dat = represent_dat(id,:);
hold on
numGroups = size(represent_dat,1);
numBars = 3; % Phone_A, Phone_B, Uncertain (not give certain response)
groupWidth = min(0.5,numBars/(numBars+1));
means = [table2array(represent_dat(:,[3,4])),1-represent_dat.AnswerRate];
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    bar(x,means(:,bar_i)',groupWidth/numBars,'DisplayName',model_names(bar_i),...
        'FaceColor',colors{bar_i});
end
set(gca,'XTick',1:numGroups,'XTickLabel',model_names);
ylabel("Proportion")
yline(0.5,'--','LineWidth',0.5,'Color','k')
legend("Phone A","Phone B","Uncertain")
title(bias_names(4))

%% Conjunction fallacy
subplot(4,2,5)
conjunc_dat = conjunc_dat(id,:);
hold on
numGroups = size(conjunc_dat,1);
numBars = 2; % general, specific
groupWidth = min(0.5,numBars/(numBars+1));
means = table2array(conjunc_dat(:,[3,4]));
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    bar(x,means(:,bar_i)',groupWidth/numBars,'DisplayName',model_names(bar_i),...
        'FaceColor',temp_colors{bar_i});
end
set(gca,'XTick',1:numGroups,'XTickLabel',model_names);
ylabel("Proportion")
yline(1/2,'--','LineWidth',0.5,'Color','k')
legend("specific","general")
title(bias_names(5))

%% endowment effect
subplot(4,2,6)
endow_dat = endow_dat(id,:);
hold on
numGroups = size(endow_dat,1);
numBars = 3; % old,new,either
groupWidth = min(0.5,numBars/(numBars+1));
means = table2array(endow_dat(:,[3,4,5]));
temp_colors = {'b','r','y'};
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    bar(x,means(:,bar_i)',groupWidth/numBars,'DisplayName',model_names(bar_i),...
        'FaceColor',temp_colors{bar_i});
end
set(gca,'XTick',1:numGroups,'XTickLabel',model_names);
ylabel("Proportion")
yline(0.5,'--','LineWidth',0.5,'Color','k')
legend("new coin","old coin","either")
title(bias_names(6))

%% insensitivity to sample size
subplot(4,2,7)
insen_dat = insen_dat(id,:);
hold on
numGroups = size(insen_dat,1);
numBars = 3; % bigger,smaller,either
groupWidth = min(0.5,numBars/(numBars+1));
means = table2array(insen_dat(:,[4,5,6]));
for bar_i = 1:numBars
    x = (1:numGroups)-groupWidth/2+(2*bar_i-1)*groupWidth/(2*numBars);
    bar(x,means(:,bar_i)',groupWidth/numBars,'DisplayName',model_names(bar_i),...
        'FaceColor',colors{bar_i});
end
set(gca,'XTick',1:numGroups,'XTickLabel',model_names);
ylabel("Proportion")
yline(0.5,'--','LineWidth',0.5,'Color','k')
legend("bigger hospital","smaller hospital","either")
title(bias_names(7))


end