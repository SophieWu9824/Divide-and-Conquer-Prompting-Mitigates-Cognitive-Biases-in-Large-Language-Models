function radarPlot(data,method_name)
% unify all biases in one radar plot
data([27,29],:) = data([29,27],:);
angles = [linspace(0,2*pi,size(data,1)),0];
values = [data.BiasACC(1:29);data.BiasACC(1)]';

color = 'g';
if method_name == "Origin"
    color = 'r';
end

% radar plot
figure
% error_rate of each bais rather than accuracy: border line
polarplot(angles,1-values,'k-o','LineWidth',2,'MarkerFaceColor',color); 

ax = gca;
ax.ThetaTick = rad2deg(angles(1:end-1));
ax.ThetaTickLabel = data.BiasName;
title("CogBias Susceptivity: "+method_name)

saveas(gcf,['figure\methods\',method_name,'.png'])
close all
end