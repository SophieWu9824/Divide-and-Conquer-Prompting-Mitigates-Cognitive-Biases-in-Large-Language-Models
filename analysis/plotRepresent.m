function plotRepresent(biasData)
for i = 1:7
    rnd_x(i,1) = rand()*0.1;
    rnd_y(i,1) = rand()*0.1;
end
colors = [
    0.6350, 0.0780, 0.1840;  % 深红色
    0.4660, 0.6740, 0.1880;  % 绿色
    0.3010, 0.7450, 0.9330;  % 天蓝色
    0.9290, 0.6940, 0.1250;  % 橙色
    0.4940, 0.1840, 0.5560;  % 紫色
    0.8500, 0.3250, 0.0980;  % 红橙色
    0.0000, 0.4470, 0.7410;  % 蓝色
];
scatter(biasData.RepresentativeHeuristic.Phone_A-rnd_x,...
    biasData.RepresentativeHeuristic.Phone_B+rnd_y,100,....
    colors,'LineWidth',2)

end