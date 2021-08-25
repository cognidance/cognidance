%% clearance
clear all; clc; close all;

%% PROTOCOL adapted Waltz et al. (2020), Computational Psychiatry and Wilson et al. (2014), Experimental Psychology.

% 72 GAMES
% 5 or 10 BANDIT TRIALS EACH (horizon 1 or 6)
% First 4 options are FORCED CHOICE (unequal condition [1 3] or equal condition [2 2]),
% Self-paced:
%   9 games = horizon 1 + unequal [3 1] condition
%+  9 games = horizon 6 + unequal [3 1] condition
%+  9 games = horizon 1 + unequal [1 3] condition
%+  9 games = horizon 6 + unequal [1 3] condition
%+  18 games = horizon 1 + equal [2 2] condition
%+  18 games = horizon 6 + equal [2 2] condition
%=  72 games total
% Each bandit rewards POINTS sampled from a Gaussian distribution with:
% - MEAN 1: 40 or 60
% - MEAN 2: +/- (20, 12, 4) (one of the bandits will always have a higher average reward)
% - Means were pseudorandomly chosen in a counterbalanced manner.
% Zajkowski2017 means: 4, 8, 12, 20. Wilson2014: 4, 8, 12, 20, 30. Warren2017: 0, 5, 10
% - STANDARD DEVIATION: 8 (constant)

number_of_games = 72;
number_of_options = 2;
stand_dev = 8;
horizon_1 = 5;
horizon_6 = 10;

try_again = 1;
number_of_attempts = 0;
number_of_versions = 1;
for i = 1:number_of_versions
    while try_again == 1
        for options_i = 1:number_of_options
            
            % OPTION 1 [for 72 games]
            % horizon 1: 18 games * 5 trials
            points_mean40_horizon1(:, :, options_i) = normrnd(40, stand_dev, [9, horizon_1]);
            points_mean60_horizon1(:, :, options_i) = normrnd(60, stand_dev, [9, horizon_1]);
            % horizon 6: 18 games * 10 trials
            points_mean40_horizon6(:, :, options_i) = normrnd(40, stand_dev, [9, horizon_6]);
            points_mean60_horizon6(:, :, options_i) = normrnd(60, stand_dev, [9, horizon_6]);
            
            % OPTION 2 [for 72 games]
            points_mean60_horizon1_0plus(:, :, options_i) = normrnd(60, stand_dev, [1, horizon_1]); % 60 + 0
            points_mean60_horizon6_0plus(:, :, options_i) = normrnd(60, stand_dev, [1, horizon_6]); % 60 + 0
            % (60 MINUS) horizon 1: 12 games * 5 trials
            points_mean40_horizon1_60minus(:, :, options_i) = normrnd(40, stand_dev, [1, horizon_1]); % 60 - 20
            points_mean48_horizon1_60minus(:, :, options_i) = normrnd(48, stand_dev, [1, horizon_1]); % 60 - 12
            points_mean52_horizon1_60minus(:, :, options_i) = normrnd(52, stand_dev, [1, horizon_1]); % 60 - 8
            points_mean56_horizon1_60minus(:, :, options_i) = normrnd(56, stand_dev, [1, horizon_1]); % 60 - 4
            % (60 MINUS) horizon 6: 12 games * 10 trials
            points_mean40_horizon6_60minus(:, :, options_i) = normrnd(40, stand_dev, [1, horizon_6]); % 60 - 20
            points_mean48_horizon6_60minus(:, :, options_i) = normrnd(48, stand_dev, [1, horizon_6]); % 60 - 12
            points_mean52_horizon6_60minus(:, :, options_i) = normrnd(52, stand_dev, [1, horizon_6]); % 60 - 8
            points_mean56_horizon6_60minus(:, :, options_i) = normrnd(56, stand_dev, [1, horizon_6]); % 60 - 4
            % (60 PLUS) horizon 1: 12 games * 5 trials
            points_mean80_horizon1_60plus(:, :, options_i) = normrnd(80, stand_dev, [1, horizon_1]); % 60 + 20
            points_mean72_horizon1_60plus(:, :, options_i) = normrnd(72, stand_dev, [1, horizon_1]); % 60 + 12
            points_mean68_horizon1_60plus(:, :, options_i) = normrnd(68, stand_dev, [1, horizon_1]); % 60 + 8
            points_mean64_horizon1_60plus(:, :, options_i) = normrnd(64, stand_dev, [1, horizon_1]); % 60 + 4
            % (60 PLUS) horizon 6: 12 games * 10 trials
            points_mean80_horizon6_60plus(:, :, options_i) = normrnd(80, stand_dev, [1, horizon_6]); % 60 + 20
            points_mean72_horizon6_60plus(:, :, options_i) = normrnd(72, stand_dev, [1, horizon_6]); % 60 + 12
            points_mean68_horizon6_60plus(:, :, options_i) = normrnd(68, stand_dev, [1, horizon_6]); % 60 + 8
            points_mean64_horizon6_60plus(:, :, options_i) = normrnd(64, stand_dev, [1, horizon_6]); % 60 + 4
            
            points_mean40_horizon1_0plus(:, :, options_i) = normrnd(40, stand_dev, [1, horizon_1]); % 40 + 0
            points_mean40_horizon6_0plus(:, :, options_i) = normrnd(40, stand_dev, [1, horizon_6]); % 40 + 0
            % (40 MINUS) horizon 1: 12 games * 5 trials
            points_mean20_horizon1_40minus(:, :, options_i) = normrnd(20, stand_dev, [1, horizon_1]); % 40 - 20
            points_mean28_horizon1_40minus(:, :, options_i) = normrnd(28, stand_dev, [1, horizon_1]); % 40 - 12
            points_mean32_horizon1_40minus(:, :, options_i) = normrnd(32, stand_dev, [1, horizon_1]); % 40 - 8
            points_mean36_horizon1_40minus(:, :, options_i) = normrnd(36, stand_dev, [1, horizon_1]); % 40 - 4
            % (40 MINUS) horizon 6: 12 games * 10 trials
            points_mean20_horizon6_40minus(:, :, options_i) = normrnd(20, stand_dev, [1, horizon_6]); % 40 - 20
            points_mean28_horizon6_40minus(:, :, options_i) = normrnd(28, stand_dev, [1, horizon_6]); % 40 - 12
            points_mean32_horizon6_40minus(:, :, options_i) = normrnd(32, stand_dev, [1, horizon_6]); % 40 - 8
            points_mean36_horizon6_40minus(:, :, options_i) = normrnd(36, stand_dev, [1, horizon_6]); % 40 - 4
            % (40 PLUS) horizon 1: 12 games * 5 trials
            points_mean60_horizon1_40plus(:, :, options_i) = normrnd(60, stand_dev, [1, horizon_1]); % 40 + 20
            points_mean52_horizon1_40plus(:, :, options_i) = normrnd(52, stand_dev, [1, horizon_1]); % 40 + 12
            points_mean48_horizon1_40plus(:, :, options_i) = normrnd(48, stand_dev, [1, horizon_1]); % 40 + 8
            points_mean44_horizon1_40plus(:, :, options_i) = normrnd(44, stand_dev, [1, horizon_1]); % 40 + 4
            % (40 PLUS) horizon 6: 12 games * 10 trials
            points_mean60_horizon6_40plus(:, :, options_i) = normrnd(60, stand_dev, [1, horizon_6]); % 40 + 20
            points_mean52_horizon6_40plus(:, :, options_i) = normrnd(52, stand_dev, [1, horizon_6]); % 40 + 12
            points_mean48_horizon6_40plus(:, :, options_i) = normrnd(48, stand_dev, [1, horizon_6]); % 40 + 8
            points_mean44_horizon6_40plus(:, :, options_i) = normrnd(44, stand_dev, [1, horizon_6]); % 40 + 4
        end
        
        % Opt1means=60,40 versus Opt2means=Opt1+/-20, 12, 8, 4, 0
        horizon_6_points(:, :, 1) = [ ...
            points_mean60_horizon6(:, :, 1); ... % base means
            points_mean40_horizon6(:, :, 1); ...
            points_mean60_horizon6_0plus(:, :, 1); ... % 60 -+ 0/20/12/8/4
            points_mean40_horizon6_60minus(:, :, 1); ...
            points_mean48_horizon6_60minus(:, :, 1); ...
            points_mean52_horizon6_60minus(:, :, 1); ...
            points_mean56_horizon6_60minus(:, :, 1); ...
            points_mean80_horizon6_60plus(:, :, 1); ...
            points_mean72_horizon6_60plus(:, :, 1); ...
            points_mean68_horizon6_60plus(:, :, 1); ...
            points_mean64_horizon6_60plus(:, :, 1); ...
            points_mean40_horizon6_0plus(:, :, 1); ... % vs 40 -+ 0/20/12/8/4
            points_mean20_horizon6_40minus(:, :, 1); ...
            points_mean28_horizon6_40minus(:, :, 1); ...
            points_mean32_horizon6_40minus(:, :, 1); ...
            points_mean36_horizon6_40minus(:, :, 1); ...
            points_mean60_horizon6_40plus(:, :, 1); ...
            points_mean52_horizon6_40plus(:, :, 1); ...
            points_mean48_horizon6_40plus(:, :, 1); ...
            points_mean44_horizon6_40plus(:, :, 1); ...
            ];
        
        horizon_6_points(:, :, 2) = [ ...
            points_mean60_horizon6_0plus(:, :, 2); ... % 60 -+ 0/20/12/8/4
            points_mean40_horizon6_60minus(:, :, 2); ...
            points_mean48_horizon6_60minus(:, :, 2); ...
            points_mean52_horizon6_60minus(:, :, 2); ...
            points_mean56_horizon6_60minus(:, :, 2); ...
            points_mean80_horizon6_60plus(:, :, 2); ...
            points_mean72_horizon6_60plus(:, :, 2); ...
            points_mean68_horizon6_60plus(:, :, 2); ...
            points_mean64_horizon6_60plus(:, :, 2); ...
            points_mean40_horizon6_0plus(:, :, 2); ... % 40 -+ 0/20/12/8/4
            points_mean20_horizon6_40minus(:, :, 2); ...
            points_mean28_horizon6_40minus(:, :, 2); ...
            points_mean32_horizon6_40minus(:, :, 2); ...
            points_mean36_horizon6_40minus(:, :, 2); ...
            points_mean60_horizon6_40plus(:, :, 2); ...
            points_mean52_horizon6_40plus(:, :, 2); ...
            points_mean48_horizon6_40plus(:, :, 2); ...
            points_mean44_horizon6_40plus(:, :, 2); ...
            points_mean60_horizon6(:, :, 2); ... % base means
            points_mean40_horizon6(:, :, 2); ...
            
            ];
        
        horizon_1_points(:, :, 1) = [ ...
            points_mean60_horizon1(:, :, 1); ... % base means
            points_mean40_horizon1(:, :, 1); ...
            points_mean60_horizon1_0plus(:, :, 1); ... % 60 -+ 0/20/12/8/4
            points_mean40_horizon1_60minus(:, :, 1); ...
            points_mean48_horizon1_60minus(:, :, 1); ...
            points_mean52_horizon1_60minus(:, :, 1); ...
            points_mean56_horizon1_60minus(:, :, 1); ...
            points_mean80_horizon1_60plus(:, :, 1); ...
            points_mean72_horizon1_60plus(:, :, 1); ...
            points_mean68_horizon1_60plus(:, :, 1); ...
            points_mean64_horizon1_60plus(:, :, 1); ...
            points_mean40_horizon1_0plus(:, :, 1); ... % 40 -+ 0/20/12/8/4
            points_mean20_horizon1_40minus(:, :, 1); ...
            points_mean28_horizon1_40minus(:, :, 1); ...
            points_mean32_horizon1_40minus(:, :, 1); ...
            points_mean36_horizon1_40minus(:, :, 1); ...
            points_mean60_horizon1_40plus(:, :, 1); ...
            points_mean52_horizon1_40plus(:, :, 1); ...
            points_mean48_horizon1_40plus(:, :, 1); ...
            points_mean44_horizon1_40plus(:, :, 1); ...
            ];
        
        horizon_1_points(:, :, 2) = [ ...
            points_mean60_horizon1_0plus(:, :, 2); ... % 60 -+ 0/20/12/8/4
            points_mean40_horizon1_60minus(:, :, 2); ...
            points_mean48_horizon1_60minus(:, :, 2); ...
            points_mean52_horizon1_60minus(:, :, 2); ...
            points_mean56_horizon1_60minus(:, :, 2); ...
            points_mean80_horizon1_60plus(:, :, 2); ...
            points_mean72_horizon1_60plus(:, :, 2); ...
            points_mean68_horizon1_60plus(:, :, 2); ...
            points_mean64_horizon1_60plus(:, :, 2); ...
            points_mean40_horizon1_0plus(:, :, 2); ... % 40 -+ 0/20/12/8/4
            points_mean20_horizon1_40minus(:, :, 2); ...
            points_mean28_horizon1_40minus(:, :, 2); ...
            points_mean32_horizon1_40minus(:, :, 2); ...
            points_mean36_horizon1_40minus(:, :, 2); ...
            points_mean60_horizon1_40plus(:, :, 2); ...
            points_mean52_horizon1_40plus(:, :, 2); ...
            points_mean48_horizon1_40plus(:, :, 2); ...
            points_mean44_horizon1_40plus(:, :, 2); ...
            points_mean60_horizon1(:, :, 2); ... % base means
            points_mean40_horizon1(:, :, 2); ...
            ];
        num_out_of_range = length(find(horizon_6_points > 99)) + length(find(horizon_1_points > 99)) + length(find(horizon_6_points < 0)) + length(find(horizon_1_points < 0));
        horizon_6_points(find(horizon_6_points > 99)) = 99;
        horizon_1_points(find(horizon_1_points > 99)) = 99;
        horizon_6_points(find(horizon_6_points < 0)) = 0;
        horizon_1_points(find(horizon_1_points < 0)) = 0;
        
        horizon_points = cell(number_of_games, 1);
        for i=1:length(horizon_6_points(:, :, 1))
            horizon_points{i, 1} = horizon_6_points(i, :, 1);
            horizon_points{i, 2} = horizon_6_points(i, :, 2);
            horizon_points{i+length(horizon_6_points(:, :, 1)), 1} ...
                = horizon_1_points(i, :, 1);
            horizon_points{i+length(horizon_6_points(:, :, 2)), 2} ...
                = horizon_1_points(i, :, 2);
        end
        
        means_6_points(:, :, 1) = [ (ones(9, 10) * 60); (ones(9, 10) * 40); ...
            (ones(1, 10) * 60); (ones(1, 10) * 40); (ones(1, 10) * 48); ...
            (ones(1, 10) * 52); (ones(1, 10) * 56); (ones(1, 10) * 80); ...
            (ones(1, 10) * 72); (ones(1, 10) * 68); (ones(1, 10) * 64); ...
            (ones(1, 10) * 40); (ones(1, 10) * 20); (ones(1, 10) * 28); ...
            (ones(1, 10) * 32); (ones(1, 10) * 36); (ones(1, 10) * 60); ...
            (ones(1, 10) * 52); (ones(1, 10) * 48); (ones(1, 10) * 44) ...
            ];
        means_6_points(:, :, 2) = [ (ones(1, 10) * 60); (ones(1, 10) * 40); ...
            (ones(1, 10) * 48); (ones(1, 10) * 52); (ones(1, 10) * 56); ...
            (ones(1, 10) * 80); (ones(1, 10) * 72); (ones(1, 10) * 68); ...
            (ones(1, 10) * 64); (ones(1, 10) * 40); (ones(1, 10) * 20); ...
            (ones(1, 10) * 28); (ones(1, 10) * 32); (ones(1, 10) * 36); ...
            (ones(1, 10) * 60); (ones(1, 10) * 52); (ones(1, 10) * 48); ...
            (ones(1, 10) * 44); (ones(9, 10) * 60); (ones(9, 10) * 40) ...
            ];
        means_1_points(:, :, 1) = [ (ones(9, 5) * 60); (ones(9, 5) * 40); ...
            (ones(1, 5) * 60); (ones(1, 5) * 40); (ones(1, 5) * 48); ...
            (ones(1, 5) * 52); (ones(1, 5) * 56); (ones(1, 5) * 80); ...
            (ones(1, 5) * 72); (ones(1, 5) * 68); (ones(1, 5) * 64); ...
            (ones(1, 5) * 40); (ones(1, 5) * 20); (ones(1, 5) * 28); ...
            (ones(1, 5) * 32); (ones(1, 5) * 36); (ones(1, 5) * 60); ...
            (ones(1, 5) * 52); (ones(1, 5) * 48); (ones(1, 5) * 44) ...
            ];
        means_1_points(:, :, 2) = [ (ones(1, 5) * 60); (ones(1, 5) * 40); ...
            (ones(1, 5) * 48); (ones(1, 5) * 52); (ones(1, 5) * 56); ...
            (ones(1, 5) * 80); (ones(1, 5) * 72); (ones(1, 5) * 68); ...
            (ones(1, 5) * 64); (ones(1, 5) * 40); (ones(1, 5) * 20); ...
            (ones(1, 5) * 28); (ones(1, 5) * 32); (ones(1, 5) * 36); ...
            (ones(1, 5) * 60); (ones(1, 5) * 52); (ones(1, 5) * 48); ...
            (ones(1, 5) * 44); (ones(9, 5) * 60); (ones(9, 5) * 40) ...
            ];
        
        horizon_means = cell(number_of_games, 1);
        for i=1:length(horizon_6_points(:, :, 1))
            horizon_means{i, 1} = means_6_points(i, :, 1);
            horizon_means{i, 2} = means_6_points(i, :, 2);
            horizon_means{i+length(means_6_points(:, :, 1)), 1} ...
                = means_1_points(i, :, 1);
            horizon_means{i+length(means_6_points(:, :, 1)), 2} ...
                = means_1_points(i, :, 2);
        end
        
        % Randomize games and points
        games_schedule = [ 6*ones(1, 36), ones(1, 36) ];
        rand_permutations_array = randperm(number_of_games); % array that randomizes schedule and points
        games_schedule_for_psytoolkit = games_schedule(rand_permutations_array); % randomized schedule
        
        horizon_points = horizon_points(rand_permutations_array, 1:2);
        horizon_means = horizon_means(rand_permutations_array, 1:2);
        
        % Prepare strings for PsyToolkit
        opt1_points_string = [];opt2_points_string = []; % initializing
        opt1_trueMeans_string = [];opt2_trueMeans_string = [];
        opt1_intendedMeans_string = [];opt2_intendedMeans_string = [];
        for i = 1:number_of_games
            opt1_points_string = [ opt1_points_string, horizon_points{i, 1}(1,:) ];
            opt2_points_string = [ opt2_points_string, horizon_points{i, 2}(1,:) ];
            opt1_trueMeans_string = [ opt1_trueMeans_string, mean(horizon_points{i, 1}(1,:)) ];
            opt2_trueMeans_string = [ opt2_trueMeans_string, mean(horizon_points{i, 2}(1,:)) ];
            opt1_intendedMeans_string = [ opt1_intendedMeans_string, mean(horizon_means{i, 1}(1,:)) ];
            opt2_intendedMeans_string = [ opt2_intendedMeans_string, mean(horizon_means{i, 2}(1,:)) ];
        end
        [~,optL_p,~,optL_stats] = ttest(opt1_intendedMeans_string, opt1_trueMeans_string);
        [~,optR_p,~,optR_stats] = ttest(opt2_intendedMeans_string, opt2_trueMeans_string);
        
        
        optL_stats.p = optL_p;
        optL_stats.note = ['Compares left INTENDED MEANS w/ ACTUAL MEANS after sampling.'];
        optR_stats.p = optR_p;
        optR_stats.note = ['Compares right INTENDED MEANS w/ ACTUAL MEANS after sampling'];
        % Forced-choice permutations:
        % [2 2]: LLRR, RRLL, LRLR, RLRL, LRRL, RLLR (#1-6)
        % [3 1]: LLLR, LLRL, LRLL, RLLL (#7-10)
        % [1 3]: RRRL, RRLR, RLRR, LRRR (#11-14)
        equal_info_condition = [ 1 2 3 4 5 6 1 2 3 4 5 6 1 2 3 4 5 6 ]; % Each horizon needs 18 equal informative conditions...
        unequal_info_condition = [ 8 9 10 11 12 13 14 7 8 9 10 11 12 13 14 7 11 14 ]; % ... and 18 unequal conditions.
        % NOTE: unequal unbalanced, repeats permutation 11 and 14; these are RRRL and LRRR forced choice conditions.
        force_choice_conditions = [ equal_info_condition(randperm(18)), unequal_info_condition(randperm(18)), unequal_info_condition(randperm(18)), equal_info_condition(randperm(18)) ];
        force_choice_conditions = force_choice_conditions(rand_permutations_array); % randomized forced-choice conditions
        
        % Prepare conditions as scheduled by "force_choice_conditions_for_psytoolkit"
        force_choice_conditions_for_psytoolkit = [];
        for i = 1:size(force_choice_conditions, 2)
            if force_choice_conditions(1, i) == 1 % EQUAL CONDITIONS [1-6]
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'l ', 'l ', 'r ', 'r ']; % LLRR
            elseif force_choice_conditions(1, i) == 2
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'r ', 'r ', 'l ', 'l ']; % RRLL
            elseif force_choice_conditions(1, i) == 3
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'l ', 'r ', 'l ', 'r ']; % LRLR
            elseif force_choice_conditions(1, i) == 4
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'r ', 'l ', 'r ', 'l ']; % RLRL
            elseif force_choice_conditions(1, i) == 5
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'l ', 'r ', 'r ', 'l ']; % LRRL
            elseif force_choice_conditions(1, i) == 6
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'r ', 'l ', 'l ', 'r ']; % RLLR
            elseif force_choice_conditions(1, i) == 7 % UNEQUAL CONDITIONS [7-14]
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'l ', 'l ', 'l ', 'r ']; % LLLR
            elseif force_choice_conditions(1, i) == 8
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'l ', 'l ', 'r ', 'l ']; % LLRL
            elseif force_choice_conditions(1, i) == 9
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'l ', 'r ', 'l ', 'l ']; % LRLL
            elseif force_choice_conditions(1, i) == 10
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'r ', 'l ', 'l ', 'l ']; % RLLL
            elseif force_choice_conditions(1, i) == 11
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'r ', 'r ', 'r ', 'l ']; % RRRL
            elseif force_choice_conditions(1, i) == 12
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'r ', 'r ', 'l ', 'r ']; % RRLR
            elseif force_choice_conditions(1, i) == 13
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'r ', 'l ', 'r ', 'r ']; % RLRR
            elseif force_choice_conditions(1, i) == 14
                force_choice_conditions_for_psytoolkit = [force_choice_conditions_for_psytoolkit, 'l ', 'r ', 'r ', 'r ']; % LRRR
            end
        end
        
        forced_choices = reshape(force_choice_conditions_for_psytoolkit(1:2:end), [4, number_of_games, 1])';
        running_means = nan(number_of_games, 4, 2);
        obs_points = nan(number_of_games, 4, 2);
        for i_game = 1:number_of_games
            for i_trial = 1:size(forced_choices, 2)
                if forced_choices(i_game, i_trial) == 'l'
                    obs_points(i_game, i_trial, 1) = round(horizon_points{i_game, 1}(i_trial));
                    running_means(i_game, i_trial, 1) = nanmean(obs_points(i_game, :, 1));
                elseif forced_choices(i_game, i_trial) == 'r'
                    obs_points(i_game, i_trial, 2) = round(horizon_points{i_game, 2}(i_trial));
                    running_means(i_game, i_trial, 2) = nanmean(obs_points(i_game, :, 2));
                end
            end
        end
        obs_means = nanmean(obs_points, 2); % after forced choice trials
        
        
        %% %%%%%%%%%%%%%%%%%%%%%% PsyToolkit Parameters %%%%%%%%%%%%%%%%%%%%%%%%
        horizon_parameters.games_schedule = games_schedule_for_psytoolkit + 4;
        horizon_parameters.forced_choices = force_choice_conditions_for_psytoolkit;
        horizon_parameters.L_points = round(opt1_points_string);
        horizon_parameters.R_points = round(opt2_points_string);
        horizon_parameters.means = [opt1_intendedMeans_string', opt2_intendedMeans_string']; %horizon_parameters.obs_means = running_means;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%  Reward-Informativeness confound
        defaultPlotParameters
        
        % forced observations (first 4 trials)
        rew = nan(number_of_games, 4);
        for i = 1:number_of_games
            
            rew(i, 1:4) = (round(horizon_points{i, 1}(1, 1:4)) .* (forced_choices(i, :) == 'l')) + ...
                (round(horizon_points{i, 2}(1, 1:4)) .* (forced_choices(i, :) == 'r'));
            
        end
        
        % running total of how many times each bandit is played
        n1 = cumsum(forced_choices == 'l', 2);
        n2 = cumsum(forced_choices == 'r', 2);
        
        % running total of reward from each bandit
        R1 = cumsum(rew .* (forced_choices == 'l'), 2);
        R2 = cumsum(rew .* (forced_choices == 'r'), 2);
        
        % running observed mean for each bandit
        o1 = R1 ./ n1;
        o2 = R2 ./ n2;
        
        diff_n = n2 - n1;
        diff_o = o2 - o1;
        game = horizon_parameters.games_schedule'; % schedule of horizons
        is_horizon1 = (game == 5);
        is_horizon6 = (game == 10);
        
        i = 4; % correlation preceding trial 5 (the first free choice)
        rr1(i-3, 1, 1) = corr(diff_n(is_horizon1, i), diff_o(is_horizon1, i));
        rr6(i-3, 1, 1) = corr(diff_n(is_horizon6, i), diff_o(is_horizon6, i));
        
        %rr1(2,:) = nan;
        %rr6(end,:) = nan;
        
        if (abs(optL_stats.tstat) <= 0.1) && (abs(optR_stats.tstat) <= 0.1) && (num_out_of_range == 0) && (abs(rr1(1)) < 0.01) && (abs(rr6(1)) < 0.01)
            try_again = 0;
            plot_parameters('INTENDED', games_schedule_for_psytoolkit, opt1_intendedMeans_string, opt2_intendedMeans_string);
            plot_parameters('ACTUAL', games_schedule_for_psytoolkit, opt1_trueMeans_string, opt2_trueMeans_string);
        end
        number_of_attempts = number_of_attempts + 1;
        
    end
    number_of_attempts;
    horizon_parameters(i_set, 1).optL_stats = optL_stats;
    horizon_parameters(i_set, 1).optR_stats = optR_stats;
    horizon_parameters(i_set, 1).number_of_attempts = number_of_attempts;
    horizon_parameters(i_set, 1).number_out_of_range = num_out_of_range;
    horizon_parameters(i_set, 1).irconf_h1 = rr1;
    horizon_parameters(i_set, 1).irconf_h6 = rr6;
    
end
%save('20210516_for_psytoolkit', 'horizon_parameters');

%% ANALYSIS from Waltz et al. (2020), Computational Psychiatry.

% similar model-analysis as Zajkowski et al. (2017)

% ACCURACY = frequency that high generative mean was chosen
% PAYMENT = proportion to total points earner

% MODEL-FREE ANALYSES:
% directed exploration = change in p(high info chosen) in unequal [1 3] condition between Horizon 1 and Horizon 6.
% random exploration = change in p(low mean chosen) in equal [2 2] condition between Horizon 1 and Horizon 6.
% baseline uncertainty seeking = p(high info chosen) in horizon 1
% baseline behavioral variability = p(low mean chosen) in horizon 1

% repeated-measures ANOVA 1:
% within-subjects factor = choice (trial) number
% between-subjects factor = diagnostic group
% DVs = accuracies & response times

% repeated-measures ANOVA 2:
% within-subjects factor = horizon
% between-subjects factor = diagnostic group
% DVs = directed & random exploration

% MODEL-BASED ANALYSIS = Kalman-filter model (Kalman, 1960)
% supplementary material (with details) referenced but unavailable?

