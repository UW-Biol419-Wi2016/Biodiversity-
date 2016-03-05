% Bonita Yusaf, Fred Henry
% Observing Biodiversity trends in time
% March 2016

%% Setup data
[rID, cnt, rawC] = xlsread('2012 data\layers\cntry_rgn.csv');
cnt = cnt(2:end, 1);

[num, txt, raw12]= xlsread('2012 data\layers\hab_health.csv');
[hab12, txt12] = habitatRead(num, txt);

[num, txt, raw13]= xlsread('2013 data\layers\hab_health.csv');
[hab13, txt13] = habitatRead(num, txt);

%% Look at data

figure;
hold on;
scatter(hab12(:,2), hab12(:,3), 20, hab12(:,1), 'o');
scatter(hab13(:,2), hab13(:,3), 20, hab13(:,1), '.');

title('Comparison of Habitat Healths Accross the World');
xlabel('Habitat');
ylabel('Health Score (0-1)');
legend('2012', '2013', 'Location', 'Best');