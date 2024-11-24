function model_ACC = ACCalculator(MergeDat,model_name,method_name)
% model_name and method_name: string type
model_ACC = struct();
data = eval(strcat("MergeDat.",model_name,".",method_name));
acc_bias = data(:,[1,2,end]);
acc_items = mean(table2array(data(:,3:end)),1);
acc_all = mean(table2array(data(:,3:end)),"all");
eval(strcat("model_ACC.bias_acc","=acc_bias;"));
eval(strcat("model_ACC.items_acc","=acc_items;"));
eval(strcat("model_ACC.all_acc","=acc_all;"));

end