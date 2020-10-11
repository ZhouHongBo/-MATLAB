function [times] = convertToTimeVectors(timeNumbers)
%{
��ʱ���ת��Ϊ������ʱ�������ʽ

Args:
    timeNumbers: ʱ���

Returns:
    times:������ʱ����
    
Test1��
    timeNumbers: 20200926142506
    times: [2020 9 26 14 25 6]
%}
    secs = rem(timeNumbers, 10^2); % r = rem(a,b) ���� a ���� b �������
    mins = rem(floor(timeNumbers./10^2), 10^2);
    hors = rem(floor(timeNumbers./10^4), 10^2);
    days = rem(floor(timeNumbers./10^6), 10^2);
    mths = rem(floor(timeNumbers./10^8), 10^2);
    year = floor(timeNumbers./10^10);
    times = [year, mths, days, hors, mins, secs];
end