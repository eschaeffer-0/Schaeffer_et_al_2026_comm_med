%% Figure6.m
% v.0.0.1 - name change, re-org, method change (ES: 02/15/2026)
% last (v.0.0.0 - initial commit, ES: 07/30/2025)
clc; clear all; close all;

% enter path to EEGLAB (e.g., /Users/name/code/eeglab2025.0.0)
path_to_eeglab = '';
addpath(genpath(fullfile(path_to_eeglab, 'functions')))

load('Figure6.mat')

whichPowMetrics = {'delta_stim_pre_swa', 'delta_stim_pre_hi_sigma'};
powMetricLabels = {'\Delta %SWA STIM-PRE', '\Delta %High Sigma STIM-PRE'};

% Figure 6 (Left) - correlation plots for specific frequency bands
% Change in power v. change in overall REST-Q score
% using normalized power as in Fig 2b
for iComp = 1:numel(whichPowMetrics)
    whichPowMetric = whichPowMetrics{iComp};

    mdl = fitlm(correl_data.(whichPowMetric), correl_data.delta_overall_score);
    fprintf('%s R-squared = %g \n', whichPowMetric, round(mdl.Rsquared.Ordinary,4))

    figure(iComp); clf; set(gcf, 'Position', [14+(30*iComp) 427 443 350], 'Visible', 'on')
    plot(correl_data.(whichPowMetric), correl_data.delta_overall_score, 'o', 'MarkerSize', 14, 'Linewidth', 2, 'color', 'k')
    xline(0, ':', 'linewidth', 1.5)
    yline(0, ':', 'linewidth', 1.5)
    xlabel(powMetricLabels{iComp})
    ylabel(['\Delta Overall REST-Q Score'])
    fontsize(gcf, 18, 'points')
    set(gca, 'fontweight', 'bold')

    % Figure 6 (Right) - topographies of R-squared values
    figure(iComp+4); clf; set(gcf, 'Position', [59+(60*iComp) 307 837 591], 'Visible', 'on')
    hold on
    topoplot(topo_data.(whichPowMetric).r_squared, chanInfo, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', [0 0.5]);
    cb = colorbar();
    ylabel(cb, 'R-Squared')
    colormap(brewermap([], 'Oranges')) 
    title([powMetricLabels{iComp} ' v. \Delta Overall REST-Q Score'])
    fontsize(gcf, 18, 'points')
    set(gca, 'fontweight', 'bold')
    set(gcf, 'Color', 'w');
end