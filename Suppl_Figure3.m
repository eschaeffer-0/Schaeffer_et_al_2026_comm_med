%% Suppl_Figure3.m
% v.0.0.0 - initial commit (ES: 02/15/2026)
% last ()
clc; clear all; close all;

% enter path to EEGLAB (e.g., /Users/name/code/eeglab2025.0.0)
path_to_eeglab = '';
addpath(genpath(fullfile(path_to_eeglab, 'functions')))

load('Suppl_Figure3.mat')

% Suppl_Figure3a Left - violin plots of differences between PRE, STIM, POST
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

% Suppl_Figure3a Right - topographies of differences between PRE, STIM, POST
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

% Suppl_Figure3b Left - topography of differences between TES-TI and TES stim
figure(5); clf; set(gcf, 'Position', [59 307 837 591], 'Visible', 'on')
hold on
topoplot(topo_data.testi_v_tes.contrast, chanInfo, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', [-2.5 2.5]);

if size(topo_data.testi_v_tes.chclus,2) > 0
    d = zeros(1, numel(chanInfo));
    d(1,topo_data.testi_v_tes.chclus) = 0.0005;
    topoplot(d, chanInfo, 'style', 'blank', 'plotdisk', 'on', 'emarkercolors', {[1 1 1]}, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', [-2.5 2.5]);
end
cb = colorbar();
ylabel(cb, 'T')
colormap(brewermap([], '*RdBu'))
title('TES-TI v. TES')
fontsize(gcf, 18, 'points')
set(gca, 'fontweight', 'bold')
set(gcf, 'Color', 'w');

% Suppl_Figure3b Right - violin plots of differences between TESTI and TES stim
% stim values are normalized SWA (dim: subj x 1)
figure(6); clf; set(gcf, 'Position', [12 357 347 498], 'Visible', 'on')
hold on
all_d = [testi_stim*100; tes_stim*100];
all_d = all_d(:);
all_lab = [repmat({'a'},length(testi_stim),1); repmat({'b'},length(tes_stim),1)];
all_lab = all_lab(:);
vs = violinplot(all_d, all_lab);
for i = 1:2
    vs(i).ViolinPlot.FaceColor = [0.1 0.1 0.1];
    vs(i).ScatterPlot.MarkerEdgeColor = [0.5 0.5 0.5];
    vs(i).ScatterPlot.MarkerFaceColor = [0.5 0.5 0.5];
    vs(i).BoxPlot.FaceColor = [0.5 0.5 0.5];
    vs(i).BoxPlot.EdgeColor = [0.5 0.5 0.5];
    vs(i).WhiskerPlot.Color = [0.5 0.5 0.5];
    vs(i).ViolinPlot.EdgeColor = [0.2 0.2 0.2];
    vs(i).ViolinAlpha = {[0.28]};
    vs(i).ScatterPlot.LineWidth = 1;
    vs(i).ScatterPlot.SizeData = 30;
    vs(i).BoxWidth = 0.025;
    vs(i).WhiskerPlot.LineWidth = 1.5;
    vs(i).ShowMedian = 0;
    vs(i).ShowMean = 1;
    vs(i).MeanPlot.Color = [1 0 0];
    vs(i).MeanPlot.LineWidth = 2;
end
xlim([0.5 2.5])
ylim([90 115])
ylabel('%SWA')
xticklabels({'TES-TI', 'TES'})
fontsize(gcf, 25, 'points')
set(gca, 'fontweight', 'bold')

% Suppl_Figure3c Left - topographies of differences between EARLY and LATE stim
% for TES-TI
figure(7); clf; set(gcf, 'Position', [80 307 837 591], 'Visible', 'on')
hold on
topoplot(topo_data.early_v_late.contrast, chanInfo, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', [-4 4]);

if size(topo_data.early_v_late.chclus,2) > 0
    d = zeros(1, numel(chanInfo));
    d(1,topo_data.early_v_late.chclus) = 0.0005;
    topoplot(d, chanInfo, 'style', 'blank', 'plotdisk', 'on', 'emarkercolors', {[1 1 1]}, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', [-4 4]);
end
cb = colorbar();
ylabel(cb, 'T')
colormap(brewermap([], '*RdBu'))
title('LATE v. EARLY')
fontsize(gcf, 18, 'points')
set(gca, 'fontweight', 'bold')
set(gcf, 'Color', 'w');

% Suppl_Figure3c Right - violin plots of differences between EARLY and LATE stim
% for TES-TI
% early_v_late_stim values are normalized SWA (dim: subj x 1)
figure(8); clf; set(gcf, 'Position', [100 357 240 498], 'Visible', 'on')
hold on
all_d = [early_v_late_testi_stim*100];
all_d = all_d(:);
all_lab = [repmat({'a'},length(early_v_late_testi_stim),1)];
all_lab = all_lab(:);
vs = violinplot(all_d, all_lab);
for i = 1
    vs(i).ViolinPlot.FaceColor = [0.1 0.1 0.1];
    vs(i).ScatterPlot.MarkerEdgeColor = [0.5 0.5 0.5];
    vs(i).ScatterPlot.MarkerFaceColor = [0.5 0.5 0.5];
    vs(i).BoxPlot.FaceColor = [0.5 0.5 0.5];
    vs(i).BoxPlot.EdgeColor = [0.5 0.5 0.5];
    vs(i).WhiskerPlot.Color = [0.5 0.5 0.5];
    vs(i).ViolinPlot.EdgeColor = [247/255 111/255 0]; % orange
   % vs(i).ViolinPlot.EdgeColor = [1/255 160/255 116/255]; % turquoise
    vs(i).ViolinPlot.LineWidth = 2;
    vs(i).ViolinAlpha = {[0.28]};
    vs(i).ScatterPlot.LineWidth = 1;
    vs(i).ScatterPlot.SizeData = 30;
    vs(i).BoxWidth = 0.025;
    vs(i).WhiskerPlot.LineWidth = 1.5;
    vs(i).ShowMedian = 0;
    vs(i).ShowMean = 1;
    vs(i).MeanPlot.Color = [1 0 0];
    vs(i).MeanPlot.LineWidth = 2;
end
xlim([0.5 1.5])
ylim([-10 12])
ylabel('\Delta %SWA')
yline(0, 'linestyle', ':', 'linewidth', 2, 'color', [0.3 0.3 0.3])
xticklabels({'TES-TI'})
title('LATE - EARLY')
fontsize(gcf, 25, 'points')
set(gca, 'fontweight', 'bold')
