% Bonita Yusaf, Fred Henry
% Observing Biodiversity trends in time
% March 2016

%% Setup data
[rID, cnt] = xlsread('2012 data\layers\rgn_global.csv');
cnt = cnt(2:end, 1);

rArea12 = xlsread('2012 data\layers\rgn_area.csv');
rArea13 = xlsread('2013 data\layers\rgn_area.csv');

[num, txt]= xlsread('2012 data\layers\hab_health.csv');
[hab12, txt12] = habitatRead(num, txt);

[num, txt]= xlsread('2013 data\layers\hab_health.csv');
[hab13, txt13] = habitatRead(num, txt);

%% Look at data
% this first figure just looks at the distribution of habitats
figure;
hold on;

subplot(2,1,1);
histogram(categorical(txt12));
title('Habitat Distribution of 2012');

subplot(2,1,2);
histogram(categorical(txt13));
title('Habitat Distribution of 2013');


% the second graph compares the relative healths of the habitats
% the marks are colored based on region
figure;
hold on;
scatter(hab12(:,2), hab12(:,3), 20, hab12(:,1), 'o');
scatter(hab13(:,2), hab13(:,3), 20, hab13(:,1), '.');

title('Comparison of Habitat Healths Accross the World');
xlabel('Habitat');
ylabel('Health Score (0-1)');
legend('2012', '2013', 'Location', 'Best');

% the last figure compares the healths between 2012 and 2013
% the added line is to better show deviations changes
figure;
hold on;
plot([0,1],[0,1]);
plot(hab12(:,3), hab13(:,3), 'r.');

title('Change in Habitat Healths from 2012 to 2013');
xlabel('2012 Habitat Health');
ylabel('2013 Habitat Health');

%% Correlate the data 
%Bonita

% To look at the correlation between the habitat health scores
figure;
scatter(hab12(:,3), hab13(:,3));
xlabel('Health Scores 2012')
ylabel('Health Scores 2013')
title('Habitat Health Scores by Region')

%% To look at the correlation between habitat trend 

[num12, txt12t, rawtrend12] = xlsread('2012 data\layers\hab_trend.csv');
[num13, txt13t, rawtrend13] = xlsread('2013 data\layers\hab_trend13.csv');

[trend12,txttrend12] = habitatRead(num12, txt12t);
[trend13,txttrend13] = habitatRead(num13, txt13t);

figure;
scatter(trend12(:,3),trend13(:,3));
xlabel('Trend 2012')
ylabel('Trend 2013')
title('Habitat Trends by Region')
