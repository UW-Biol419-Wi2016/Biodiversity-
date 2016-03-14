<<<<<<< HEAD
% Bonita Yusaf, Fred Henry
% Observing Biodiversity trends in time
% March 2016

%% Setup data
[rID, cnt, rawC] = xlsread('2012 data\layers\cntry_rgn.csv');
cnt = cnt(2:end, 1);

[num, txt, raw12]= xlsread('2012 data\layers\hab_health.csv');
[hab12, htx12] = habitatRead(num, txt);

[num, txt, raw13]= xlsread('2013 data\layers\hab_health.csv');
[hab13, htx13] = habitatRead(num, txt);

[num, txt] = xlsread('2012 data\layers\hab_extent.csv');
[extent12, etx12] = habitatRead(num, txt);

[num, txt] = xlsread('2013 data\layers\hab_extent.csv');
[extent13, etx13] = habitatRead(num, txt);

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
    hab12(workingSet, 2) = i;
    
    workingSet = find(strcmp(habCount(i),etx12));
    extent12(workingSet, 2) = i;
    
    workingSet = find(strcmp(habCount(i),htx13));
    hab13(workingSet, 2) = i;
    
    workingSet = find(strcmp(habCount(i),etx13));
    extent13(workingSet, 2) = i;
end;

%% Look at data
% this first figure just looks at the distribution of habitats
figure;
hold on;

subplot(2,1,1);
histogram(categorical(htx12));
title('Habitat Distribution of 2012');

subplot(2,1,2);
histogram(categorical(htx13));
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

%% view habitat health vs extent change in region

% plots the health of habitats colored by region
figure;
hold on;
scatter(hab12(:,2), hab12(:,3), 10, hab12(:,1), 'o');
scatter(hab13(:,2), hab13(:,3), 10, hab13(:,1), '.');

% creates separate plots to look at the relative change in health and
% extent for each environment from 2012 to 2013
for i = 1:numel(habCount)
    figure;
    hold on;
    doit = find(hab12(:,2) == i);
    
    % not all of the habitats have health data
    if numel(doit) > 0
        % put the two plots next to each other
        subplot(1,2,1);
        hold on;
        plot([0,1], [0,1]); % line indicating no change
        scatter(hab12(doit,3), hab13(doit,3), 'r.');
        
        title(strcat('Health change of: ',habCount(i)));
        xlabel('2012 health');
        ylabel('2013 health');
        
        % will place extent change next to health
        subplot(1,2,2);
        hold on;
    end;
    
    % plot the relative change in extent from 2012 to 2013
    doit = find(extent12(:,2) == i);
    ex12tot = sum(extent12(doit,3));
    maxPlotting = max(extent13(doit,3) / ex12tot);
    
    plot([0,maxPlotting], [0,maxPlotting]); % no change
    scatter(extent12(doit,3) / ex12tot, extent13(doit,3) / ex12tot, 'r.');
    
    title(strcat('Extent change of: ', habCount(i)));
    xlabel('2012 extent (% 2012)');
    ylabel('2013 extent (% 2012)');
end;
=======
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

habscore_corr = corr(hab12(:,3), hab13(:,3));

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

trend_corr = corr(trend12(:,3),trend13(:,3));

% correlation between species diversity
figure;
plot(speciesdiversity(:,2), speciesdiversity13(:,2))

correlation = corr(speciesdiversity(:,2), speciesdiversity13(:,2));

%% Correlation between species status

% import data species status (12 and 13) as numerical matrix

sppstatus_corr = corr(sppstatus12(:,2), sppstatus13(:,2));

figure;
plot(sppstatus12(:,2), sppstatus13(:,2));
xlabel('2012')
ylabel('2013')
title('Species Status by region')
>>>>>>> origin/master
