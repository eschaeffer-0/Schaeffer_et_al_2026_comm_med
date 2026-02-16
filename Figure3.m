%% Figure3.m
% v.0.0.1 - minor, name change (ES: 02/15/2026)
% last (v.0.0.0 - initial commit, ES: 07/30/2025)
clc; clear all; close all;

% enter path to EEGLAB (e.g., /Users/name/code/eeglab2025.0.0)
path_to_eeglab = '';
addpath(genpath(fullfile(path_to_eeglab, 'functions')))

load('Figure3.mat')

% Figure 3a - violin plots of differences between PRE, STIM, POST
% stim_pre, etc. are difference in normalized SWA values (dim: subj x 1)
figure(1); clf; set(gcf, 'Position', [12 357 347 498])
hold on

all_d = [stim_pre*100 post_pre*100 post_stim*100];
all_d = all_d(:);
all_lab = [repmat({'a'},length(stim_pre),1) repmat({'b'},length(stim_pre),1) repmat({'c'},length(stim_pre),1)];
all_lab = all_lab(:);

vs = violinplot(all_d, all_lab);
vs(1).ViolinPlot.FaceColor = [0.4 0.4 0.4];
vs(1).ScatterPlot.MarkerEdgeColor = [0.6 0.6 0.6];
vs(1).ScatterPlot.MarkerFaceColor = [0.6 0.6 0.6];
vs(1).BoxPlot.FaceColor = [0.6 0.6 0.6];
vs(1).BoxPlot.EdgeColor = [0.6 0.6 0.6];
vs(1).WhiskerPlot.Color = [0.6 0.6 0.6];
vs(2).ViolinPlot.FaceColor = [0.63 0.63 0.63];
vs(2).ScatterPlot.MarkerEdgeColor = [0.7 0.7 0.7];
vs(2).ScatterPlot.MarkerFaceColor = [0.7 0.7 0.7];
vs(2).BoxPlot.FaceColor = [0.65 0.65 0.65];
vs(2).BoxPlot.EdgeColor = [0.65 0.65 0.65];
vs(2).WhiskerPlot.Color = [0.65 0.65 0.65];
vs(3).ViolinPlot.FaceColor = [0.23 0.23 0.23];
vs(3).ScatterPlot.MarkerEdgeColor = [0.5 0.5 0.5];
vs(3).ScatterPlot.MarkerFaceColor = [0.5 0.5 0.5];
vs(3).BoxPlot.FaceColor = [0.5 0.5 0.5];
vs(3).BoxPlot.EdgeColor = [0.5 0.5 0.5];
vs(3).WhiskerPlot.Color = [0.5 0.5 0.5];

for i = 1:3
    vs(i).ViolinPlot.EdgeColor = [0.2 0.2 0.2];
    vs(i).ViolinAlpha = {[0.2]};
    vs(i).ScatterPlot.LineWidth = 1;
    vs(i).ScatterPlot.SizeData = 30;
    vs(i).BoxWidth = 0.025;
    vs(i).WhiskerPlot.LineWidth = 1.5;
    vs(i).ShowMedian = 0;
    vs(i).ShowMean = 1;
    vs(i).MeanPlot.Color = [1 0 0];
    vs(i).MeanPlot.LineWidth = 2;
end
yline(0, 'linestyle', ':', 'linewidth', 2, 'color', [0.3 0.3 0.3])
xlim([0.5 3.5])
ylim([-10 15])
ylabel('\Delta %SWA')
xticklabels({'STIM-PRE', 'POST-PRE', 'POST-STIM'});
fontsize(gcf, 25, 'points')
set(gca, 'fontweight', 'bold')

% Figure 3b - topographies of differences between PRE, STIM, POST
comps = {'stim_pre', 'post_pre', 'post_stim'};

for iComp = 1:numel(comps)
    comp = comps{iComp};
 
    figure(iComp+1); clf; set(gcf, 'Position', [59+(30*iComp) 307 837 591], 'Visible', 'on')
    hold on
    topoplot(topo_data.(comp).contrast, chanInfo, 'headrad', 0.5,'plotrad',0.51,'numcontour',5,'maplimits',topo_data.(comp).lims);
    
    if size(topo_data.(comp).chclus,2) > 0
        d = zeros(1, numel(chanInfo));
        d(1,topo_data.(comp).chclus) = 0.0005;
        topoplot(d, chanInfo, 'style', 'blank', 'plotdisk', 'on', 'emarkercolors', {[1 1 1]}, 'headrad', 0.5,'plotrad',0.51,'numcontour',5,'maplimits',topo_data.(comp).lims);
    end
    cb = colorbar();
    ylabel(cb, 'T')
    colormap(brewermap([], '*RdBu'))
    title(upper(strrep(comp, '_', '-')))
    fontsize(gcf, 18, 'points')
    set(gca, 'fontweight', 'bold')
    set(gcf, 'Color', 'w');
end