function radarPlot2(MergeDat_new,model_name,method_name)
% unify all biases in one radar plot
% for new questions: input data is Accuracy
% model_name, method_name: string type
data = eval(strcat("MergeDat_new.",model_name,".",method_name));
data([27,29],:) = data([29,27],:); % avoid the overlap for better display
data.BiasProne = 1-data.ACC_bias;
angles = [linspace(0,2*pi,size(data,1)),0];
values = [data.BiasProne(1:29);data.BiasProne(1)]';

color = 'g';
if method_name == "Origin"
    color = 'r';
end

% radar plot
figure
% 边界线,error_rate of each bais rather than accuracy
polarplot(angles,values,'k-o','LineWidth',2,'MarkerFaceColor',color); 
% x = values.*cos(angles); x = [x,x(1)];
% y = values.*sin(angles); y = [y,y(1)];
% fill(x,y,'b','FaceAlpha',0.25)
% 
ax = gca;
ax.ThetaTick = rad2deg(angles(1:end-1));
ax.ThetaTickLabel = data.BiasName;
title("Errorate of Cognitive Bias: "+model_name+"+"+method_name)
% title(model_name)


end