function [M, S, pos] = getMeanAndStd(samples, locations, ids)
%{
��ȡѵ���������ľ�ֵ�;�����

Args:
    samples: ѵ��������
    positions: ѵ����������λ��
    ids: ѵ����������ID

Returns:
    M: ��ֵ
    S: ������
    pos: λ��
%}
    if (exist('ids','var'))
        [uids, ~, ic] = unique(ids, 'rows');
    else
        [uids, ~, ic] = unique(locations, 'rows');
    end
    nCols = size(samples,2);
    nRows = size(uids,1);
    M = zeros(nRows,nCols);
    S = zeros(nRows,nCols);
    
    pos = zeros(nRows,3);
    
    for i = (1:nRows)
        indexes = ic == i;
        values = samples(indexes, :);
        M(i,:) = mean(values, 'omitnan');
        S(i,:) = std(values, 'omitnan');
        pos(i,:) = mean(locations(indexes,:));
    end
end