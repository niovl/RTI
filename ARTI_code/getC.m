function [C] = getC(wsn)
%
pixLoc = wsn.pixLoc;
pixNum = wsn.pixNum;
deta = 2;           % ²ÎÊý
C = zeros(pixNum, pixNum);

for i = 1: pixNum,
    for j = 1: pixNum,   
        tmp = sqrt(power(pixLoc(i, 1) - pixLoc(j, 1), 2) + power(pixLoc(i, 2) - pixLoc(j, 2), 2)) / deta;
        C(i, j) = 1 / exp(tmp);
    end
end


end

