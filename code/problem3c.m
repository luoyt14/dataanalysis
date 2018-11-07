clear;
close all;
clc;
data = xlsread('data.xlsx');
age = data(:,7);
category = data(:,2);
anova1(age,category)