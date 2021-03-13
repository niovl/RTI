function [sys_args] = argsInitial(channel_index)
%% WSN ����
Ch_num = 5;            % wireless channel' number
if ((channel_index <= 0) || (channel_index > Ch_num)),
    fprintf('Error: channel_index: (0 < channel_index < %s)\n', num2str(channel_index));
    sys_args = null;
    return;
end
oneSideNodeNum = 8;    % ��Ҫ���õ�ϵͳ��ÿ���߽ڵ����
nodesDistance = 3;     % ���ڽڵ�֮��ľ���
sidePixNum = 42;       % һ�л�����һ�������صĸ���
linkNum = 378;         % �Զ���
pixNum = sidePixNum * sidePixNum;
[nodesCoordinates] = NodePlace(oneSideNodeNum, nodesDistance);              % ��ȡ�������߽ڵ������
[Link] = getNodeLink(nodesCoordinates, linkNum);                            % ��·����
[pixLoc] = getPixLoc(nodesCoordinates, sidePixNum);                         % ��ȡ�������ص�����
% [intersection] = getLinkIntersection(Link, nodesCoordinates);
wsn = struct('Ch_num', Ch_num, 'oneSideNodeNum', oneSideNodeNum, 'nodesDistance', ...
    nodesDistance, 'sidePixNum', sidePixNum, 'pixNum', pixNum, 'nodesCoordinates', ...
    nodesCoordinates, 'linkNum', linkNum, 'Link', Link, 'pixLoc', pixLoc);
%% RTI ����
rti = struct('p', 0.1524, 'gamma', 500, 'delta', 2, 'lambda', 0.05);
%% ������
estimator_args = struct('alpha', 0.90, 'Tr', 1.0, 'Tv', 0.2);
%% kalman
dt = 0.1;
F = [1 dt; 0 1];
Q = [power(dt, 3) / 3 power(dt, 2) / 2; power(dt, 2) / 2 dt];
H = [1 0];

%% picture - kalman
qi = 1.0;
vi = 0.03;
Fi = F;
Qi = qi * Q;
Hi = H;
Vi = vi;
image_kalman = struct('F', Fi, 'Q', Qi, 'H', Hi, 'V', Vi);
%% state - kalman
qt = 2.0;
vt = 0.5;
Ft = blkdiag(F, F);
Qt = qt * blkdiag(Q, Q);
Ht = blkdiag(H, H);
Vt = blkdiag(vt, vt);
state_kalman = struct('F', Ft, 'Q', Qt, 'H', Ht, 'V', Vt);

%% ARTI
K = 100;
A = getA(wsn, rti);
C = getC(wsn);
PI = getPI(rti, A, C);
% Y = csvread('.\s-3-3.csv');                                                 % ��ȡ�������ݣ�����
% y = Y(5, :);                                                                % ��ȡ�������ݣ�������
phi = -exp(-3) * ones(Ch_num, linkNum);
u = sign(phi);  
r = rand(Ch_num, K + 1, linkNum);  % setup in the begining!(read file or from the serial port)
w = rand(Ch_num, linkNum);  % setup in the begining!(TODO!)
phi_c = phi(channel_index, :);
u_c = u(channel_index, :);
r_c = reshape(r(channel_index, :, :), K + 1, linkNum);
w_c = w(channel_index, :);

Pii = eye(2);
Ptt = eye(4);
xii = [ones(1, pixNum); zeros(1, pixNum)];   % TODO
xtt = [1 0 1 0]; % TODO
xi = zeros(K + 1, 2, pixNum);  % (1 -> 0)
Pi = zeros(K + 1, 2, 2);       % (k -> k -1)
xt = zeros(K + 1, 1, 4);       % (k + 1 -> k)
Pt = zeros(K + 1, 4, 4);
for i = 1: K + 1,
    xi(i, :, :) = xii;
    xt(i, :, :) = xtt;
    Pi(i, :, :) = Pii;
    Pt(i, :, :) = Ptt;
end

arti = struct('PI', PI, 'K', K, 'phi_c', phi_c, 'u_c', u_c, 'r_c', r_c, ...
    'w_c', w_c, 'Pi', Pi, 'xi', xi, 'Pt', Pt, 'xt', xt);

%% sys_args
sys_args = struct('wsn', wsn, 'rti', rti, 'estimator_args', estimator_args, ...
    'image_kalman', image_kalman,  'state_kalman', state_kalman, 'arti', arti);

end

