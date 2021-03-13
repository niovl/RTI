function [xi, xt, sys_args] = ARTI(sys_args, r_, Channel_num)
% wsn, rti, estimator_args, image_kalman,  state_kalman, arti

phi_c = sys_args.arti.phi_c;
u_c = sys_args.arti.u_c;
r_c = sys_args.arti.r_c;
w_c = sys_args.arti.w_c;
  K = sys_args.arti.K;
 PI = sys_args.arti.PI;
 Pi = sys_args.arti.Pi;
 Pt = sys_args.arti.Pt;
 xi = sys_args.arti.xi;
 xt = sys_args.arti.xt;
 
 image_kalman = sys_args.image_kalman;
 state_kalman = sys_args.state_kalman;
 estimator_args = sys_args.estimator_args;
 wsn = sys_args.wsn;
 
y = zeros(K + 1, wsn.linkNum);
zi = zeros(K + 1, wsn.pixNum);
for k = 2: K + 1, % (1 ~ K)
    y(k, :) = w_c .* (r_c(k, :) - u_c);
    zi(k, :) = PI * y(k, :)';
    % image kalmanfilter
    xi_pre = reshape(xi(k - 1, :, :), 2, wsn.pixNum);
    Pi_pre = reshape(Pi(k - 1, :, :), 2, 2);
    [xi_, Pi_] = kalmanfilter(xi_pre, Pi_pre, zi(k, :), image_kalman);
    xi(k, :, :) = xi_;Pi(k, :, :) = Pi_;
    n = find(image_kalman.H * xi_ == max(image_kalman.H * xi_));
    xn = n / wsn.sidePixNum;
    yn = mod(n, wsn.sidePixNum);
    zt(:, k) = [xn; yn];
    xt_pre = reshape(xt(k - 1, :, :), 1, 4);
    Pt_pre = reshape(Pt(k - 1, :, :), 4, 4);
    [xt_, Pt_] = kalmanfilter(xt_pre', Pt_pre, zt(:, k), state_kalman);
    xt(k, :, :) = xt_;Pt(k, :, :) = Pt_;
    v = [xt_(2) xt_(4)];p_k = [xt_(1) xt_(3)];
    if ((norm(zt(:, k) - state_kalman.H * state_kalman.F * xt_) < estimator_args.Tr) && (norm(v) > estimator_args.Tv)),
        [phi_c, u_c, w_c] = estimator(phi_c, u_c, p_k, wsn.Link, r_c); % TODO
    end
    % state kalmanfilter
    
end

end

