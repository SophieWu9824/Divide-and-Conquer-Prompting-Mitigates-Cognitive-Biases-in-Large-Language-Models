% bar plot for the baseline accuracy in the case of seed and new questions
load("data\Merge_Seed.mat")
load("data\MergeData.mat")
load("data\ACC.mat")
model_names = ["GPT4","GPT-3.5-Turbo","Qwen","Zhipu","Atom-7B-Chat"];
seed_acc = table2array(MergeDat.Origin(30,3:7));
new_acc = [Accuracy.GPT4.Origin.all_acc,...
    Accuracy.GPT35.Origin.all_acc,...
    Accuracy.Qwen.Origin.all_acc,...
    Accuracy.Zhipu.Origin.all_acc,...
    Accuracy.Atom7B.Origin.all_acc];

figure;
bar([seed_acc',new_acc'],'grouped')
yline(0.5,'--k')
legend('seed ques','new ques','Location','best')
ylim([0,0.9])
xticklabels(model_names)
ylabel("Accuracy")