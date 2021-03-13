function [pixLoc] = getPixLoc(nodesCoordinates, sidePixNum)
%
Srt = min(nodesCoordinates(:, 1));
End = max(nodesCoordinates(:, 1));
pixLength = (End - Srt) / sidePixNum;

pixLoc = zeros(sidePixNum*sidePixNum, 2);

for i = 1: sidePixNum,
    for j = 1: sidePixNum,
        pixLoc((i - 1) * sidePixNum + j, 1) = (i - 0.5) * pixLength;   % 像素（i， j）的 x 轴坐标
        pixLoc((i - 1) * sidePixNum + j, 2) = (j - 0.5) * pixLength;   % 像素（i， j）的 y 轴坐标
    end
end


end

