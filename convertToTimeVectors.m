function [times] = convertToTimeVectors(timeNumbers)
% �޸ģ���ǰ���������ʾ��20160603111129096�����ڵ��������ʾ��20200926142506�������������
%convertToTimeVectors  Convert time values in the database format to the 
%   six-valued format used by matlab. The (yyyymmddhhmmsss), indicating y
%   digits for year, m for month, d for day, h for hour, m for minutes and
%   s for milliseconds.
    secs = rem(timeNumbers, 10^2); % r = rem(a,b) ���� a ���� b �������
    mins = rem(floor(timeNumbers./10^2), 10^2);
    hors = rem(floor(timeNumbers./10^4), 10^2);
    days = rem(floor(timeNumbers./10^6), 10^2);
    mths = rem(floor(timeNumbers./10^8), 10^2);
    year = floor(timeNumbers./10^10);
    times = [year, mths, days, hors, mins, secs];
end