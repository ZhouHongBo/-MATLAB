% ����ʵ�ʵ㵽Ԥ���ļ�ͷͼ

close all; % ɾ������δ���ص�����ͼ��
addpath('db','files','ids','ips'); % ������·��������ļ���

% For reproducibilty in the random method
rng('default'); % ��������ͬ�������

% Common to all methods
mounthAmount = 1; % ��һ����
notDetected = 100;
monthRange = (1:mounthAmount);

% Storage for 2D error
metricRand = zeros(1, mounthAmount);
metricProb = zeros(1, mounthAmount);
metricKnn = zeros(1, mounthAmount);
metricNn = zeros(1, mounthAmount);
metricStg = zeros(1, mounthAmount);
metricGk = zeros(1, mounthAmount);

% Storage for floor detection rate
rateRand = zeros(1, mounthAmount);
rateProb = zeros(1, mounthAmount);
rateKnn = zeros(1, mounthAmount);
rateNn = zeros(1, mounthAmount);
rateStg = zeros(1, mounthAmount);
rateGk = zeros(1, mounthAmount);

for month = monthRange
    % load current month data
    dataTrain = loadContentSpecific('db', 1, [2, 4], 1); % �����ϵ�����
    dataTest = loadContentSpecific('db', 2, [2, 4, 6, 8], 1); % �����ϵ�����
    
    % deal with not seen AP
    dataTrain.rss(dataTrain.rss==100) = -105;
    dataTest.rss(dataTest.rss==100) = -105;
    
    % random location estimation tst��ƽ��
    kAmount = 1;    % Single Point
    [M, ~, pos] = getMeanAndStd(dataTest.rss, dataTest.coords);
    [predictionRandom] = randomEstimation(dataTrain.rss, M, dataTrain.coords, kAmount);
    [errorRandom,fsrR] = customError(predictionRandom, pos, 0);
    metricRand(1, month) = getMetric(errorRandom);
    rateRand(1, month) = fsrR;
    
    drawPoints();
    title('Random');
    arrow(pos(:, 1:2), predictionRandom(:, 1:2), 'Length', 5, 'BaseAngle', 20);
    
    % Probabilistic method estimation tst��ƽ��
    kValue = 1;    % Single Point
    [M, ~, pos] = getMeanAndStd(dataTest.rss, dataTest.coords);
    [predictionProb] = probEstimation(dataTrain.rss, M, dataTrain.coords, kValue, floor(dataTrain.ids./100));
    [errorProb,fsrP] = customError(predictionProb, pos, 0);
    metricProb(1, month) = getMetric(errorProb);
    rateProb(1, month) = fsrP;
    
    drawPoints();
    title('Prob');
    arrow(pos(:, 1:2), predictionProb(:, 1:2), 'Length', 5, 'BaseAngle', 20);
    
    % kNN method estimation tst��ƽ��
    knnValue = 9;    % Number of neighbors
    [M, ~, pos] = getMeanAndStd(dataTest.rss, dataTest.coords);
    predictionKnn = kNNEstimation(dataTrain.rss, M, dataTrain.coords, knnValue);
    [errorKnn,fsrK] = customError(predictionKnn, pos, 0);
    metricKnn(1, month) = getMetric(errorKnn);
    rateKnn(1, month) = fsrK;
    
    drawPoints();
    title('KNN');
    arrow(pos(:, 1:2), predictionKnn(:, 1:2), 'Length', 5, 'BaseAngle', 20);
    
    % Nn method estimation
    knnValue = 1;    % Number of neighbors
    [M, ~, pos] = getMeanAndStd(dataTest.rss, dataTest.coords);
    predictionNn = kNNEstimation(dataTrain.rss, M, dataTrain.coords, knnValue);
    [errorNn,fsrK] = customError(predictionNn, pos, 0);
    metricNn(1, month) = getMetric(errorNn);
    rateNn(1, month) = fsrK;
    
    drawPoints();
    title('NN');
    arrow(pos(:, 1:2), predictionNn(:, 1:2), 'Length', 5, 'BaseAngle', 20);
    
    % Stg method estimation tst��ƽ��
    stgValue = 3;    % AP filtering value
    kValue = 5;    % Number of neighbors
    [M, ~, pos] = getMeanAndStd(dataTest.rss, dataTest.coords);
    predictionStg = stgKNNEstimation(dataTrain.rss, M, dataTrain.coords, stgValue, kValue);
    [errorStg,fsrS] = customError(predictionStg, pos, 0);
    metricStg(month) = getMetric(errorStg);
    rateStg(1, month) = fsrS;
    
    drawPoints();
    title('Stg');
    arrow(pos(:, 1:2), predictionStg(:, 1:2), 'Length', 5, 'BaseAngle', 20);
     
    % Gk method estimation tst��ƽ��
    std_dB = 4; % (has almost no effect in this scenario)
    kValue = 12;
    [M, ~, pos] = getMeanAndStd(dataTest.rss, dataTest.coords);
    predictionGk = gaussiankernelEstimation(dataTrain.rss, M, dataTrain.coords, std_dB, kValue);
    [errorGk,fsrGk] = customError(predictionGk, pos, 0);
    metricGk(1, month) = getMetric(errorGk);
    rateGk(1, month) = fsrGk;
    
    drawPoints();
    title('Gk');
    arrow(pos(:, 1:2), predictionGk(:, 1:2), 'Length', 5, 'BaseAngle', 20);

    disp(month);
end

% ����75%��λ���
function [metric] = getMetric(errors)
    metric = prctile(errors, 75);
end

