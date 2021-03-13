function [PI] = getPI(rti, A, C)
%
gamma = rti.gamma;           % ²ÎÊý
PI = inv(A' * A + gamma * inv(C)) * A';


end

