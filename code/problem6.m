clear;
close all;
clc;
data = xlsread('data.xlsx');

%% Simple random sampling
fvalue1 = zeros(1,10);
for k = 1:10
    num = randsample(2040,204);
    data_sim = data(num,:);
    category = data_sim(:,2);
    age = data_sim(:,7);
    [p,tb1]=anova1(age,category);
    fvalue1(k)=tb1{2,5};
end
mean_f1 = mean(fvalue1);
std_f1 = std(fvalue1);

%% Stratified random sampling
fvalue2 = zeros(1,10);
for k = 1:10
    label1 = find(data(:,2)==1);
    num1 = randsample(length(label1), ceil(length(label1)/10));
    label2 = find(data(:,2)==2);
    num2 = label2(1)+randsample(length(label2), ceil(length(label2)/10))-1;
    label3 = find(data(:,2)==3);
    num3 = label3(1)+randsample(length(label3), ceil(length(label3)/10))-1;
    label4 = find(data(:,2)==4);
    num4 = label4(1)+randsample(length(label4), ceil(length(label4)/10))-1;
    label5 = find(data(:,2)==5);
    num5 = label5(1)+randsample(length(label5), ceil(length(label5)/10))-1;
    Num = [num1;num2;num3;num4;num5];
    data_sim = data(Num,:);
    category = data_sim(:,2);
    age = data_sim(:,7);
    [p,tb1]=anova1(age,category);
    fvalue2(k)=tb1{2,5};
end
mean_f2 = mean(fvalue2);
std_f2 = std(fvalue2);

%% System random sampling
fvalue3 = zeros(1,10);
nnum = zeros(1,204);
for k=1:10
    nnum(1) = randi(2040);
    for v=2:204
        nnum(v) = mod(nnum(v-1) + 10,2040);
    end
    data_sim = data(nnum,:);
    category = data_sim(:,2);
    age = data_sim(:,7);
    [p,tb1]=anova1(age,category);
    fvalue3(k)=tb1{2,5};
end
mean_f3 = mean(fvalue3);
std_f3 = std(fvalue3);
