function [data, bad_data] = remove_outliers(data)

for i_subj = 1:length(data)
    dum = data(i_subj).is_correct(:,5:10);
    data(i_subj).fC = nanmean(dum(:));
end
thresh = 0.55;
ind_good = [data.fC] >= thresh;
bad_data = data(~ind_good);
data = data(ind_good);