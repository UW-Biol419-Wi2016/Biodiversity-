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

%% Correlating environment

% grab the largest number of habitats at once
if numel(unique(htx12)) > numel(unique(etx12))
    habCount = unique(htx12);
    othHab = unique(etx12);
else
    habCount = unique(etx12);
    othHab = unique(htx12);
end;

% ensure that you have all of the habitats
for i = 1:numel(othHab)
    if find(strcmp(habCount, othHab(i))) == []
        habCount = {habCount; othHab(i)};
    end;
end;

% normalize the habitat indices
for i = 1:numel(habCount)
    workingSet = find(strcmp(habCount(i),htx12));
    habitat12(workingSet, 2) = i;
    
    workingSet = find(strcmp(habCount(i),etx12));
    extent12(workingSet, 2) = i;
    
    workingSet = find(strcmp(habCount(i),htx13));
    habitat12(workingSet, 2) = i;
    
    workingSet = find(strcmp(habCount(i),etx13));
    extent13(workingSet, 2) = i;
end;
%% view habitat health vs extent change in region

figure;
hold on;
scatter(habitat12(:,2), habitat12(:,3), 10, habitat12(:,1), 'o');
scatter(habitat13(:,2), habitat13(:,3), 10, habitat13(:,1), '.');

for i = 1:numel(habCount)
    figure;
    hold on;
    doit = find(habitat12(:,2) == i);
    
    if numel(doit) > 0
        subplot(1,2,1);
        hold on;
        plot([0,1], [0,1], 'r');
        scatter(habitat12(doit,3), habitat13(doit,3));
        
        title(strcat('Health change of: ',habCount(i)));
        xlabel('2012 health');
        ylabel('2013 health');
        
        subplot(1,2,2);
        hold on;
    end;
    plot([0,.5], [0,.5], 'r');
    
    doit = find(extent12(:,2) == i);
    ex12tot = sum(extent12(doit,3));
    scatter(extent12(doit,3) / ex12tot, extent13(doit,3) / ex12tot);
    
    title(strcat('Extent change of: ', habCount(i)));
    xlabel('2012 extent (% 2012)');
    ylabel('2013 extent (% 2012)');
end;
