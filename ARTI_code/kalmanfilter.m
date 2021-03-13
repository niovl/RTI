function [x, P] = kalmanfilter(x_pre, P_pre, z, kalman_args)
%
F = kalman_args.F;
Q = kalman_args.Q;
H = kalman_args.H;
V = kalman_args.V;

x_ = F * x_pre;
P_ = F * P_pre * F' + Q;
S = H * P_ * H' + V;
K = P_ * H' * inv(S);
x = x_ + K * (z - H * x_);
P = P_ - K * S * K';


end

