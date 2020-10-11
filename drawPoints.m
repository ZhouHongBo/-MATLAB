% �����еĵ���ʾ����
function [] = plotPoint()

addpath('db','files','ids','ips');

% ��������
tst1 = loadContentSpecific('db', 2, 2, 1);
tst2 = loadContentSpecific('db', 2, 4, 1);
tst3 = loadContentSpecific('db', 2, 6, 1);
tst4 = loadContentSpecific('db', 2, 8, 1);
trn1 = loadContentSpecific('db', 1, 2, 1);
trn2 = loadContentSpecific('db', 1, 4, 1);

figure('PaperUnits','centimeters','PaperSize',[20,20],'PaperPosition',[0 0 20 20]);
scatter(trn1.coords(:,1),trn1.coords(:,2), [], 'black');
hold on;
scatter(trn2.coords(:,1),trn2.coords(:,2), [], 'black');
hold on;
scatter(tst1.coords(:,1),tst1.coords(:,2), [], 'red', 'filled');
hold on;
scatter(tst2.coords(:,1),tst2.coords(:,2), [], 'yellow', 'filled');
hold on;
scatter(tst3.coords(:,1),tst3.coords(:,2), [], 'black', 'filled');
hold on;
scatter(tst4.coords(:,1),tst4.coords(:,2), [], [0.63 0.13 0.94], 'filled'); % ��ɫ
hold on;

xlim([-2 31]);
ylim([-1 30]);
axis square;
set(gca,'XDir','reverse'); %��x�᷽������Ϊ����(���ҵ������)

end