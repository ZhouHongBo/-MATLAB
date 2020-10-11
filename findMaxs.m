function [minIndexes] = findMaxs(fingerprint, k)
%{
�ҵ�������������ǿk��AP���±�

Args:
    fingerprint: һ����������
    k: ��ǿAP������
Returns:
    minIndexes: ������������ǿk��AP���±�
%}

    [B,~] = sort(fingerprint,'descend');
    minIndexes = false(1,length(fingerprint));
    for v = (1:k)
        minIndexes = minIndexes | (fingerprint==B(v));
    end
end