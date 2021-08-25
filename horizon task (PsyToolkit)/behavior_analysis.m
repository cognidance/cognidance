%%                Adapted from Zajkowski, Kossut, and Wilson. (2017), eLife             %%

clear;clc;close all;

%% prep
maindir = pwd; addpath(maindir);
cd 'data';
defaultPlotParameters

should_i_save = 1;   % =0 if should not save. 

%% load data, omit low accuracy
data_files = dir('subject*.txt');
subj_data = load_data(data_files);
cd(maindir);

% omit low accuracy
[subj_data, subj_outliers] = remove_outliers(subj_data);

%% Figure 1: Reward-information confound
for i_subj = 1:length(subj_data) % for each subject
    
    diff_n = subj_data(i_subj).n2 - subj_data(i_subj).n1;
    diff_o = subj_data(i_subj).o2 - subj_data(i_subj).o1;
    game = subj_data(i_subj).game_schedule; % schedule of horizons
    is_horizon1 = (game == 5);
    is_horizon6 = (game == 10);
    
    for i = 4:10
        rr1(i-3, 1, i_subj) = corr(diff_n(is_horizon1, i), diff_o(is_horizon1, i));
        rr6(i-3, 1, i_subj) = corr(diff_n(is_horizon6, i), diff_o(is_horizon6, i));
    end
    
end

rr1(2,:) = nan;
rr6(end,:) = nan;

figure(1); clf;
set(gcf, 'position', [588   576   400   250]);

ax = easy_gridOfEqualFigures([0.2 0.1], [0.2 0.03]);
axes(ax(1)); hold on;
plot([0 7], [0 0], 'k--', 'linewidth', 1)

M1 = nanmean(rr1,3);
S1 = nanstd(rr1,[],3)/sqrt(size(rr1,3));
M6 = nanmean(rr6,3);
S6 = nanstd(rr6,[],3)/sqrt(size(rr6,3));
e = plot(M1, 'marker', 'x','color', AZblue);
e(:,2) = plot(M6, 'linestyle', '-','marker', '+', 'color', AZred);
e = e';
%set(e(1,:), 'color', AZblue);
%set(e(2,:), 'color', AZred);
%set(e(:,1), 'linestyle', '-','marker', '+')
%set(e(:,2), 'linestyle', '--','marker', 'x')
set(e, 'markersize', 10, 'linewidth', 1)

set(ax, 'xtick', [1:6], 'xlim', [0.5 6.5], 'tickdir', 'out')
xlabel('free-trial number')
ylabel({'correlation between' 'reward and information'})
legend(e([1 2]), ...
    {'horizon 1', 'horizon 6'}, ...
    'location', 'southeast')

%% Figure 2: Model-free analysis of the first free-choice trial

game_length = [5 10];
for i_subj = 1:length(subj_data)
    for j = 1:length(game_length)
        i_horizon = strcmp(subj_data(i_subj).game_type, 'horizon_game');
        
        ind = (subj_data(i_subj).game_schedule == game_length(j)) & i_horizon; % split horizon 1 from 6 games (respectively, by loop j)
        p_high_info(j, i_subj, 1) = nanmean(subj_data(i_subj).high_info(ind, 5));
        ind = (subj_data(i_subj).game_schedule == game_length(j)) & (subj_data(i_subj).n2(:, 4) ~= subj_data(i_subj).n1(:,4)) & i_horizon;
        p_repeat13(j, i_subj, 1) = nanmean(subj_data(i_subj).rep(ind, 5));
        
        ind = (subj_data(i_subj).game_schedule == game_length(j)) & (subj_data(i_subj).n2(:, 4) == subj_data(i_subj).n1(:,4)) & i_horizon;
        p_low_mean(j, i_subj, 1) = nanmean(subj_data(i_subj).low_mean(ind, 5));
        p_repeat(j, i_subj, 1) = nanmean(subj_data(i_subj).rep(ind, 5));
        p_right(j, i_subj, 1) = nanmean(subj_data(i_subj).choices(ind, 5) == 2);
        
    end
end

clear X l l2 t m s e
figure(2); %clf;
set(gcf, 'position', [211   137   600   250])
dw = 0.02;
DW = 0.12;
ax = easy_gridOfEqualFigures([0.2 0.1], [0.2 0.03]);
i = 0;
i=i+1; X(:,i) = p_high_info(1,:,1); % X(:, 1)
behavioral_data.p_high_info_h1 = X(:,i);

i=i+1; X(:,i) = p_high_info(2,:,1); % X(:, 2)
behavioral_data.p_high_info_h6 = X(:,i);

i=i+1; X(:,i) = p_low_mean(1,:,1); % X(:, 3)
behavioral_data.p_low_mean_h1 = X(:,i);

i=i+1; X(:,i) = p_low_mean(2,:,1); % X(:, 4)
behavioral_data.p_low_mean_h6 = X(:,i);

i=i+1; X(:,i) = p_right(1,:,1); % X(:, 5)
behavioral_data.p_right_h1 = X(:,i);

i=i+1; X(:,i) = p_right(2,:,1); % X(:, 6)
behavioral_data.p_right_h6 = X(:,i);

vName{1} = 'horizon 1';
vName{2} = 'horizon 6';


axes(ax(1)); hold on;
xx = 1:size(X,2);

set(ax, 'xlim', [0.5 2.5])
axes(ax(1)); hold on;
m(1,1) = nanmean(X(:,1)); s(1,1) = nanstd(X(:,1))/sqrt(size(X,1)); % p(high_info, horizon1)
m(2,1) = nanmean(X(:,2)); s(2,1) = nanstd(X(:,2))/sqrt(size(X,1)); % p(high_info, horizon6)
m(1,2) = nanmean(X(:,3)); s(1,2) = nanstd(X(:,3))/sqrt(size(X,1)); % p(low_mean, horizon1)
m(2,2) = nanmean(X(:,4)); s(2,2) = nanstd(X(:,4))/sqrt(size(X,1)); % p(low_mean, horizon6)
[~, p_phigh, ~, stats_phigh ] = ttest(X(:,1), X(:,2));
[~, p_plow, ~, stats_plow ] = ttest(X(:,3), X(:,4));

e = errorbar(m, s);
ylabel('probability of choice')
xlabel('horizon condition')
t = text(0, 0, 'exploration + horizon');
if p_phigh < 0.05
    t_phigh = text(0.65, (m(1,1) + m(2,1))/2, '*', 'FontSize', 34, 'Color', 'black');
end
if p_plow < 0.05
    t_plow = text(2.3, (m(1,2) + m(2,2))/2, '*', 'FontSize', 34, 'Color', 'black');
end

leg = legend(e([2 1]), {'low mean choice (random exploration)', 'high info choice (directed exploration)'}, ...
    'orientation', 'vertical', 'location', 'north');

%tt = text(1.5, 0.565, '*');
ll = plot([0.84 0.72 0.72 0.84]+0.05, [m(1,1) m(1,1) m(2,1) m(2,1)]);
ll(2) = plot([2.2 2.32 2.32 2.2]-0.1, [m(1,2) m(1,2) m(2,2) m(2,2)]);

set(t, 'fontsize', 18, 'units', 'normalized', 'position', [0.5 1], ...
    'horizontalAlignment', 'center', 'fontweight', 'bold')
set(ax(1), 'xticklabel', {vName{1:2}} ,'ylim', [0  1])
set(ax, 'view', [0 90], 'xtick', xx, ...
    'tickdir', 'out', 'ytick', [0:0.1:1]);
set(e, 'marker', '.', 'markersize', 30, 'linestyle', '-')
set(e(:,1), 'color', AZblue)
set(e(:,2), 'color', AZred)
f = 0.6;

set(ll, 'color', 'k', 'linewidth', 1)

%% Figure 3: Model-free analysis of all trials
clear p_highInfo p_lowMean p_repeat p_repeat13 p_repeat22
game_length = [5 10];
for i_subj = 1:length(subj_data)
    for j = 1:length(game_length)
        for t = 1:6
            i_horizon = strcmp(subj_data(i_subj).game_type, 'horizon_game');
            
            i_horizon = i_horizon;
            ind = (subj_data(i_subj).game_schedule == game_length(j)) & i_horizon;
            p_high_info(j, t, 1, i_subj) = nanmean(subj_data(i_subj).high_info(ind, t+4));
            p_low_mean(j, t, 1,i_subj) = nanmean(subj_data(i_subj).low_mean(ind, t+4));
            p_repeat(j, t, 1, i_subj) = nanmean(subj_data(i_subj).rep(ind, t+4));
            
        end
    end
end

figure(3); %clf;
%set(gcf, 'position', [588   576   600   500]);
%ax = easy_gridOfEqualFigures([0.1 0.18 0.1], [0.16 0.18 0.02]);

set(gcf, 'position', [211   137   600   250])
ax = easy_gridOfEqualFigures([0.2  0.2], [0.14 0.17 0.05]);


axes(ax(1)); hold on;
xlim([0.5 6.5])
M = nanmean(p_high_info,4);
S = nanstd(p_high_info,[],4)/sqrt(length(subj_data));
e = errorbar(M(:,:,1)', S(:,:,1)');
xlabel('trial number')
ylabel('p(high info)')
title('"directed"')
leg = legend(e(:), {'horizon 1'  'horizon 6' });
%set(leg, 'position', [0.2658    0.7610    0.2425    0.1150])

axes(ax(2)); hold on;
xlim([0.5 6.5])
M = nanmean(p_low_mean,4);
S = nanstd(p_low_mean,[],4)/sqrt(length(subj_data));
e(2,:) = errorbar(M(:,:,1)', S(:,:,1)');
xlabel('trial number')
ylabel('p(low mean)')
title('"random"')

set(e(1, 1), 'color', AZblue)
set(e(2, 1), 'color', AZblue*0.5+0.5*[1 1 1])
set(e(1, :), 'marker', '+')
set(e(2, :), 'marker', 'x')
set(e, 'markersize', 10);%, 'marker', '.')
set(ax(1:2), 'ylim', [0 0.8], 'ytick', [0:0.2:0.8], 'xlim', [0.5 6.5], 'xtick', [1:6])

set(ax, 'tickdir', 'out')

set(e, 'markersize', 30, 'marker', '.')

if should_i_save == 1
    for i = 1:length(subj_data)
        behavioral_data.rt{i, 1} = subj_data(i).RT;
        behavioral_data.accuracy(i, 1) = subj_data(i).fC;
    end
   save('horizon_results.mat', 'behavioral_data'); 
end
