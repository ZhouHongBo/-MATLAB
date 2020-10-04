% Script to generate the paper's figure "Charting3rd" and "Charting5th"

chosenAP = 3; % ѡ�ĸ�AP�����ݣ���Χ[1, 10]

close all;
addpath('db','files','ids','ips');

ap24 = chosenAP * 2 - 1;
ap5 = chosenAP * 2;
barWidth = 0.25;

data = loadContentSpecific('db', 2, [2, 4, 6, 8], 1); % ����ѵ����
data.rss(data.rss==100) = nan;

% 2.4gƵ��
[M, S, pos] = getMeanAndStd(data.rss(:,ap24),data.coords); % ��֤��û��
drawRssBars(pos(:,1), pos(:,2), barWidth, M(:,:), S(:,:), ['AP', num2str(chosenAP), ' 2.4g']);
set(gca,'XDir','reverse'); %��x�᷽������Ϊ����(���ҵ������)

% 5gƵ��
[M, S, pos] = getMeanAndStd(data.rss(:,ap5),data.coords); % 12 samples considered per location
drawRssBars(pos(:,1), pos(:,2), barWidth, M(:,:), S(:,:), ['AP', num2str(chosenAP), ' 5g']);
set(gca,'XDir','reverse'); %��x�᷽������Ϊ����(���ҵ������)
