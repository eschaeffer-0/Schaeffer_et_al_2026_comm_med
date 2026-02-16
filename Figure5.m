%% Figure5.m
% v.0.0.1 - minor, name change (ES: 02/15/2026)
% last (v.0.0.0 - initial commit, ES: 07/30/2025)
clc; clear all; close all;

% enter path to EEGLAB (e.g., /Users/name/code/eeglab2025.0.0)
path_to_eeglab = '';
addpath(genpath(fullfile(path_to_eeglab, 'functions')))

load('Figure5.mat')

% Figure 5a,c - spectra for STIM v. PRE, POST v. PRE
% pre, stim, post data are PSD values (dim: subj x freq)

% Inset - full spectra
% mean across subj, then log scale
pre_mu = 10*log10(mean(pre,1));
stim_mu = 10*log10(mean(stim,1));
post_mu = 10*log10(mean(post,1));

for iComp = 1:2
    figure(iComp); clf; set(gcf, 'Position', [42+(30*iComp) 570 442 552], 'Visible', 'on')
    hold on
    
    plot(f_ax, pre_mu, 'color', [0.8 0.8 0.8], 'linewidth', 4)
    
    if iComp == 1
        plot(f_ax, stim_mu, 'color', [0.2 0.2 0.2], 'linewidth', 4, 'linestyle', ':')
        legend('PRE', 'STIM')
    else
        plot(f_ax, post_mu, 'color', [0.5 0.5 0.5], 'linewidth', 4, 'linestyle', ':')
        legend('PRE', 'POST')
    end
    
    xlim([0 40])
    ylim([-18 26])
    ylabel('PSD (dB / Hz)')
    xlabel('Frequency (Hz)')
    fontsize(gcf, 20, 'points')
    set(gca, 'fontweight', 'bold')
end

% Main - difference
% log scale and add constant to make all vals
% positive before taking the difference
post_mu = 10*log10(post) + 25;
stim_mu = 10*log10(stim) + 25;
pre_mu = 10*log10(pre) + 25;

for iComp = 1:2
    figure(iComp+2); clf; set(gcf, 'Position', [70+(30*iComp) 570 642 652], 'Visible', 'on')
    hold on

    if iComp == 1
        diff = stim_mu - pre_mu;
        val = 0.6;
        c1 = 0.25;
        c2 = 0.35;
        title_str = 'STIM-PRE';
    else
        diff = post_mu - pre_mu;
        val = 0.8;
        c1 = 0.5;
        c2 = 0.6;
        title_str = 'POST-PRE';
    end

    n = size(diff,1);
    sem = std(diff,0,1) / sqrt(n);

    mu_diff = mean(diff,1);

    hi = mu_diff + sem;
    lo = mu_diff - sem;

    % fill area between upper and lower
    fill([f_ax fliplr(f_ax)], [hi fliplr(lo)], [val val val], ...
        'EdgeColor', 'none', 'FaceAlpha', 0.5);  

    plot(f_ax, mu_diff, 'color', [c1 c1 c1], 'linewidth', 3)
    plot(f_ax, mu_diff + sem, 'color', [c2 c2 c2], 'linewidth', 2)
    plot(f_ax, mu_diff - sem, 'color', [c2 c2 c2], 'linewidth', 2)
    yline(0, 'linestyle', '--', 'linewidth', 3)

    xlim([0 40])
    ylim([-0.8 0.9])
    ylabel('\Delta PSD (\Delta dB / Hz)')
    xlabel('Frequency (Hz)')
    title(title_str)
    fontsize(gcf, 20, 'points')
    set(gca, 'fontweight', 'bold')
end

% Figure 5b - topographies of STIM-PRE differences for specific freq bands
% using normalized power as in Fig 3b
comps = {'theta', 'beta'};
all_lims = {[-6 6], [-4 4]};
for iComp = 1:numel(comps)
    comp = comps{iComp};
 
    figure(iComp+4); clf; set(gcf, 'Position', [59+(30*iComp) 307 837 591], 'Visible', 'on')
    hold on
    topoplot(topo_data.stim_pre.(comp).contrast, chanInfo, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', all_lims{iComp});
    
    if size(topo_data.stim_pre.(comp).chclus,2) > 0
        d = zeros(1, numel(chanInfo));
        d(1,topo_data.stim_pre.(comp).chclus) = 0.0005;
        topoplot(d, chanInfo, 'style', 'blank', 'plotdisk', 'on', 'emarkercolors', {[1 1 1]}, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', all_lims{iComp});
    end
    cb = colorbar();
    ylabel(cb, 'T')
    colormap(brewermap([], '*RdBu'))
    title(['STIM - PRE ', upper(comp)])
    fontsize(gcf, 18, 'points')
    set(gca, 'fontweight', 'bold')
    set(gcf, 'Color', 'w');
end

% Figure 5d - topographies of POST-PRE differences for specific freq bands
% using normalized power as in Fig 3b
comps = {'theta', 'sigma'};
all_lims = {[-6 6], [-4 4]};
for iComp = 1:numel(comps)
    comp = comps{iComp};
 
    figure(iComp+6); clf; set(gcf, 'Position', [59+(60*iComp) 307 837 591], 'Visible', 'on')
    hold on
    topoplot(topo_data.post_pre.(comp).contrast, chanInfo, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', all_lims{iComp});
    
    if size(topo_data.post_pre.(comp).chclus,2) > 0
        d = zeros(1, numel(chanInfo));
        d(1,topo_data.post_pre.(comp).chclus) = 0.0005;
        topoplot(d, chanInfo, 'style', 'blank', 'plotdisk', 'on', 'emarkercolors', {[1 1 1]}, 'headrad', 0.5,'plotrad',0.51,'numcontour',4,'maplimits', all_lims{iComp});
    end
    cb = colorbar();
    ylabel(cb, 'T')
    colormap(brewermap([], '*RdBu'))
    title(['POST - PRE ', upper(comp)])
    fontsize(gcf, 18, 'points')
    set(gca, 'fontweight', 'bold')
    set(gcf, 'Color', 'w');
end