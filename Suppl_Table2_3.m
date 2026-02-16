%% Suppl_Table2_3.m
% v.0.0.0 - initial commit (ES: 02/15/2026)
% last ()
clc; clear all; close all;

load('Figure5.mat')

% uncomment to use data for Suppl Table 3
%load('Suppl_Table3.mat')

% Suppl_Table2_3 - Statistics for Figure 5
bandName = {'Theta', 'Alpha', 'LoSpin', 'HiSpin', 'Beta', 'Gamma'};
bandRanges = {[4 8], [8 12], [9 12], [12 16], [16 25], [25 40]};
nBands = numel(bandRanges);

stim_ts = []; post_ts = [];
stim_ps = []; post_ps = [];
for iBand = 1:nBands
    lb = bandRanges{iBand}(1);
    ub = bandRanges{iBand}(2);

    f_inds = find(f_ax > lb & f_ax <= ub);

    pre_short = mean(pre(:,f_inds),2);
    stim_short = mean(stim(:,f_inds),2);
    post_short = mean(post(:,f_inds),2);
    
    [~,p,~,stats] = ttest(stim_short, pre_short);
    stim_ps = [stim_ps p];
    stim_ts = [stim_ts stats.tstat];
    
    [~,p,~,stats] = ttest(post_short, pre_short);
    post_ps = [post_ps p];
    post_ts = [post_ts stats.tstat];
end

[h, crit_p, adj_ci_cvrg, adj_p] = fdr_bh([stim_ps post_ps], 0.05, 'dep', 'yes');
fprintf('STIM-PRE \n')
[stim_ts' stim_ps' adj_p(1:nBands)']

fprintf('POST-PRE \n')
[post_ts' post_ps' adj_p(nBands+1:nBands*2)']
