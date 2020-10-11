function [e,fsr] = customError(estimationPos, actualPos, floorPenalty)
%{
����Ԥ��λ����ʵ��λ��֮������

Args:
    estimationPos: Ԥ��λ��
    actualPos: ʵ��λ��

Returns:
    e: ���
    fsr: ¥���ж����
%}
    e = sqrt(sum((estimationPos(:,[1,2])-actualPos(:,[1,2])).^2, 2));
    if (~exist('floorPenalty', 'var'))
        floorPenalty = 5;
    end
    fDiff = abs(estimationPos(:,3) - actualPos(:,3));
    fsr = sum(fDiff==0)/size(actualPos,1);
    penalty = fDiff*floorPenalty;
    e = e + penalty;
end