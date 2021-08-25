function data = load_data(data_files)

% Adapted analysis from Zajkowski et al., 2017, eLife
task_parameters = load('20210604_for_psytoolkit.mat'); % horizon_parameters

for i_subject = 1:length(data_files)
    file_ID = fopen(data_files(i_subject).name);
    [ raw_data{i_subject, 1} ] = textscan(file_ID, '%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
    
    data(i_subject).parameter_set = raw_data{i_subject, 1}{1, 2}(find(contains(raw_data{i_subject, 1}{1, 1}(:, 1),'set_parameters')==1), 1);
    param_set = data(i_subject).parameter_set;
    data(i_subject).game_schedule = task_parameters.horizon_parameters(param_set).games_schedule(:);
    data(i_subject).forced_choices = reshape(task_parameters.horizon_parameters(param_set).forced_choices(1:2:end), [4, length(data(i_subject).game_schedule), 1])';
    data(i_subject).points = [ task_parameters.horizon_parameters(param_set).L_points(:), task_parameters.horizon_parameters(param_set).R_points(:) ];
    data(i_subject).m1 = task_parameters.horizon_parameters(param_set).means(:, 1);
    data(i_subject).m2 = task_parameters.horizon_parameters(param_set).means(:, 2);
    num_non_trials = sum(contains(raw_data{i_subject, 1}{1, 1}(:, 1),'horizon_practice')) + sum(contains(raw_data{i_subject, 1}{1, 1}(:, 1),'set_parameters'));
    points = data(i_subject).points;
    for i_game = (num_non_trials+1):length(raw_data{i_subject, 1}{1, 1}) % exclude practice trials
        
        if data(i_subject).game_schedule((i_game - num_non_trials), 1) == 5
            data(i_subject).game_type(i_game - num_non_trials, 1)  = raw_data{i_subject, 1}{1, 1}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 1) = raw_data{i_subject, 1}{1, 2}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 2) = raw_data{i_subject, 1}{1, 3}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 3) = raw_data{i_subject, 1}{1, 4}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 4) = raw_data{i_subject, 1}{1, 5}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 5) = raw_data{i_subject, 1}{1, 6}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 6) = NaN;
            data(i_subject).choices(i_game - num_non_trials, 7) = NaN;
            data(i_subject).choices(i_game - num_non_trials, 8) = NaN;
            data(i_subject).choices(i_game - num_non_trials, 9) = NaN;
            data(i_subject).choices(i_game - num_non_trials, 10) = NaN;
            data(i_subject).RT(i_game - num_non_trials, 1) = NaN;%raw_data{i_subject, 1}{1, 7}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 2) = NaN;%raw_data{i_subject, 1}{1, 8}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 3) = NaN;%raw_data{i_subject, 1}{1, 9}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 4) = NaN;%raw_data{i_subject, 1}{1, 10}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 5) = raw_data{i_subject, 1}{1, 11}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 6) = NaN;
            data(i_subject).RT(i_game - num_non_trials, 7) = NaN;
            data(i_subject).RT(i_game - num_non_trials, 8) = NaN;
            data(i_subject).RT(i_game - num_non_trials, 9) = NaN;
            data(i_subject).RT(i_game - num_non_trials, 10) = NaN;
            
            data(i_subject).r(i_game - num_non_trials, 1) = points(1, data(i_subject).choices(i_game - num_non_trials, 1));
            data(i_subject).r(i_game - num_non_trials, 2) = points(2, data(i_subject).choices(i_game - num_non_trials, 2));
            data(i_subject).r(i_game - num_non_trials, 3) = points(3, data(i_subject).choices(i_game - num_non_trials, 3));
            data(i_subject).r(i_game - num_non_trials, 4) = points(4, data(i_subject).choices(i_game - num_non_trials, 4));
            data(i_subject).r(i_game - num_non_trials, 5) = points(5, data(i_subject).choices(i_game - num_non_trials, 5));
            data(i_subject).r(i_game - num_non_trials, 6:10) = NaN;
            
            points(1:5, :) = [];
        elseif data(i_subject).game_schedule((i_game - num_non_trials), 1) == 10
            data(i_subject).game_type(i_game - num_non_trials, 1) = raw_data{i_subject, 1}{1, 1}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 1) = raw_data{i_subject, 1}{1, 2}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 2) = raw_data{i_subject, 1}{1, 3}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 3) = raw_data{i_subject, 1}{1, 4}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 4) = raw_data{i_subject, 1}{1, 5}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 5) = raw_data{i_subject, 1}{1, 6}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 6) = raw_data{i_subject, 1}{1, 7}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 7) = raw_data{i_subject, 1}{1, 8}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 8) = raw_data{i_subject, 1}{1, 9}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 9) = raw_data{i_subject, 1}{1, 10}(i_game, 1);
            data(i_subject).choices(i_game - num_non_trials, 10) = raw_data{i_subject, 1}{1, 11}(i_game, 1);
            
            data(i_subject).RT(i_game - num_non_trials, 1) = NaN;%raw_data{i_subject, 1}{1, 12}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 2) = NaN;%raw_data{i_subject, 1}{1, 13}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 3) = NaN;%raw_data{i_subject, 1}{1, 14}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 4) = NaN;%raw_data{i_subject, 1}{1, 15}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 5) = raw_data{i_subject, 1}{1, 16}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 6) = raw_data{i_subject, 1}{1, 17}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 7) = raw_data{i_subject, 1}{1, 18}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 8) = raw_data{i_subject, 1}{1, 19}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 9) = raw_data{i_subject, 1}{1, 20}(i_game, 1);
            data(i_subject).RT(i_game - num_non_trials, 10) = raw_data{i_subject, 1}{1, 21}(i_game, 1);
            
            data(i_subject).r(i_game - num_non_trials, 1) = points(1, data(i_subject).choices(i_game - num_non_trials, 1));
            data(i_subject).r(i_game - num_non_trials, 2) = points(2, data(i_subject).choices(i_game - num_non_trials, 2));
            data(i_subject).r(i_game - num_non_trials, 3) = points(3, data(i_subject).choices(i_game - num_non_trials, 3));
            data(i_subject).r(i_game - num_non_trials, 4) = points(4, data(i_subject).choices(i_game - num_non_trials, 4));
            data(i_subject).r(i_game - num_non_trials, 5) = points(5, data(i_subject).choices(i_game - num_non_trials, 5));
            data(i_subject).r(i_game - num_non_trials, 6) = points(6, data(i_subject).choices(i_game - num_non_trials, 1));
            data(i_subject).r(i_game - num_non_trials, 7) = points(7, data(i_subject).choices(i_game - num_non_trials, 2));
            data(i_subject).r(i_game - num_non_trials, 8) = points(8, data(i_subject).choices(i_game - num_non_trials, 3));
            data(i_subject).r(i_game - num_non_trials, 9) = points(9, data(i_subject).choices(i_game - num_non_trials, 4));
            data(i_subject).r(i_game - num_non_trials, 10) = points(10, data(i_subject).choices(i_game - num_non_trials, 5));
            
            points(1:10, :) = [];
        end
                
    end
    
    % uncertainty condition
    data(i_subject).uncertainty_condition(:, 1) = sum((data(i_subject).choices(:, 1:4) == 2), 2);
    
    % z-score RT
    data(i_subject).RTz = (data(i_subject).RT - nanmean(data(i_subject).RT(:))) / nanstd(data(i_subject).RT(:));
    
    % running total of how many times each bandit is played
    data(i_subject).n1 = cumsum(data(i_subject).choices == 1, 2);
    data(i_subject).n2 = cumsum(data(i_subject).choices == 2, 2);
    
    % running total of reward from each bandit
    data(i_subject).R1 = cumsum(data(i_subject).r .* (data(i_subject).choices == 1), 2);
    data(i_subject).R2 = cumsum(data(i_subject).r .* (data(i_subject).choices == 2), 2);
    
    % running observed mean for each bandit
    data(i_subject).o1 = data(i_subject).R1 ./ data(i_subject).n1;
    data(i_subject).o2 = data(i_subject).R2 ./ data(i_subject).n2;
    
    % is choice objectively correct?
    data(i_subject).is_correct = repmat((data(i_subject).m1 > data(i_subject).m2), [1 10]) .* (data(i_subject).choices==1) + repmat((data(i_subject).m1 < data(i_subject).m2), [1 10]) .* (data(i_subject).choices==2);
    data(i_subject).is_correct(isnan(data(i_subject).choices)) = nan;
    
    % is choice a low observed mean choice? (RANDOM EXPLORATION)
    data(i_subject).low_mean = ...
        (data(i_subject).o1(:, 1:end-1) < data(i_subject).o2(:, 1:end-1)) .* (data(i_subject).choices(:, 2:end)==1) + ...
        (data(i_subject).o1(:, 1:end-1) > data(i_subject).o2(:, 1:end-1)) .* (data(i_subject).choices(:, 2:end)==2);
    data(i_subject).low_mean(data(i_subject).o1(:, 1:end-1) == data(i_subject).o2(:, 1:end-1)) = nan;
    data(i_subject).low_mean(isnan(data(i_subject).choices(:, 2:end))) = nan;
    % shift over so that trials line up for later
    data(i_subject).low_mean(:, 2:end+1) = data(i_subject).low_mean(:, 1:end);
    data(i_subject).low_mean(:,1) = nan;
    
    % is choice high info choice? (DIRECTED EXPLORATION)
    data(i_subject).high_info = (data(i_subject).n1(:,1:end-1) < data(i_subject).n2(:,1:end-1)) .* (data(i_subject).choices(:,2:end) == 1) ...
        + (data(i_subject).n1(:,1:end-1) > data(i_subject).n2(:,1:end-1)) .* (data(i_subject).choices(:, 2:end) == 2);
    data(i_subject).high_info(data(i_subject).n1(:,1:end-1) == data(i_subject).n2(:, 1:end-1)) = nan; % e.g., equal condition where no high-info choice
    data(i_subject).high_info(isnan(data(i_subject).choices(:, 2:end))) = nan; % horizon 1, no choice after 5 trials
    % shift over so trials line up for later
    data(i_subject).high_info(:, 2:end+1) = data(i_subject).high_info(:, 1:end);
    data(i_subject).high_info(:, 1) = nan;
    
    % is current choice same as the previous choice? (PERSEVERATION)
    data(i_subject).rep = [ nan(size(data(i_subject).choices, 1), 1), (data(i_subject).choices(:, 1:end-1) == data(i_subject).choices(:,2:end)) ];
    
end