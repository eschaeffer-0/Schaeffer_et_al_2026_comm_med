%% Table1.m
% v.0.0.0 - initial commit (ES: 07/30/2025)
% last ()

clc; clear all; close all;

load('Table1.mat')

% Table1 - sample demographics
fprintf('TES-TI Age N: %g mu: %g sd: %g \n', length(demographics.testi.ages), round(mean(demographics.testi.ages),1), round(std(demographics.testi.ages),1))
fprintf('TES Age N: %g mu: %g sd: %g \n', length(demographics.tes.ages), round(mean(demographics.tes.ages),1), round(std(demographics.tes.ages),1))

[H1, p, w] = swtest(demographics.testi.ages, 0.05);
[H2, p, w] = swtest(demographics.tes.ages, 0.05);
if H1 == 1 | H2 == 1
    fprintf('TES-TI agess and/or TES ages are not normally distributed \n')
    fprintf('Using Wilcoxon rank sum test \n')
    [p,~,stats] = ranksum(demographics.testi.ages, demographics.tes.ages);
    fprintf('TES-TI v. TES AGE ranksum=%g p=%g \n', round(stats.ranksum,1), round(p,3))
else
    fprintf('TES-TI agess and TES ages are normally distributed \n')
    fprintf('Using Independent Samples T-test \n')
    [~,p,~,stats] = ttest2(demographics.testi.ages, demographics.tes.ages);
    fprintf('TES-TI v. TES AGE T=%g p=%g \n', stats.tstat, p)
end

fprintf('\n')
fprintf('TES-TI Perc F %g \n', round(sum(demographics.testi.sex) / length(demographics.testi.sex) * 100,1))
fprintf('TES Perc F %g \n', round(sum(demographics.tes.sex) / length(demographics.tes.sex) * 100,1))

sexes = [demographics.tes.sex' demographics.testi.sex'];
groups = [ones(1,length(demographics.tes.sex)) ones(1,length(demographics.testi.sex))*2];

[table, chi2val, p] = crosstab(sexes, groups);
fprintf('TES-TI v. TES SEX Chi-Square=%g p=%g \n', round(chi2val,2), round(p,3))