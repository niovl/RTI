function [phi_c, u_c, w_c] = estimator( phi_c, u_c, p_k, Link, r_c)
%
estimator_args = struct('alpha', 0.90, 'Tr', 1.0, 'Tv', 0.2);

lambda = 0.05;
alpha = 0.9;
L = size(Link, 1);
for l = 1: L,
    len1 = sqrt(power(Link(l, 1) - p_k(1), 2) + power(Link(l, 2) - p_k(2), 2));
    len2 = sqrt(power(Link(l, 3) - p_k(1), 2) + power(Link(l, 4) - p_k(2), 2));
    len = sqrt(power(Link(l, 1) - Link(l, 3), 2) + power(Link(l, 2) - Link(l, 4), 2));
    delta_l = len1 + len2 - len;
    if delta_l <= 2 * lambda,
        phi_c(l) = alpha * phi_c(l) + (1 - alpha) * (r_c(l) - u_c(l));
    else
        u_c(l) = alpha * u_c(l) + (1 - alpha) * r_c(l);
    end
    w_c(l) = sign(phi_c(l));
end

end

