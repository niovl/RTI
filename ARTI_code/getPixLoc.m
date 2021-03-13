function [pixLoc] = getPixLoc(nodesCoordinates, sidePixNum)
%
Srt = min(nodesCoordinates(:, 1));
End = max(nodesCoordinates(:, 1));
pixLength = (End - Srt) / sidePixNum;

pixLoc = zeros(sidePixNum*sidePixNum, 2);

for i = 1: sidePixNum,
    for j = 1: sidePixNum,
        pixLoc((i - 1) * sidePixNum + j, 1) = (i - 0.5) * pixLength;   % ���أ�i�� j���� x ������
        pixLoc((i - 1) * sidePixNum + j, 2) = (j - 0.5) * pixLength;   % ���أ�i�� j���� y ������
    end
end


end

