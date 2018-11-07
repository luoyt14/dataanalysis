clear;
close all;
clc;
data = xlsread('data.xlsx');
category = data(:,2);

sexratio = data(:,6);
anova1(sexratio,category)

sexratio = data(:,13);
anova1(sexratio,category)

sexratio = data(:,14);
anova1(sexratio,category)