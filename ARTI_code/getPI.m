function [PI] = getPI(rti, A, C)
%
gamma = rti.gamma;           % ����
PI = inv(A' * A + gamma * inv(C)) * A';


end

