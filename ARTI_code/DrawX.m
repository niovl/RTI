function [] = DrawX(x, N)
% 函数功能：画出x的像素图
%   输入：
    % x: 信号
    % N：信号像素图的维度（N * N）

lx = [0 22];
ly = [22 0];

xAbs = abs(x);                          % 求取绝对值
xMax = max(xAbs);                       % 获取x中最大值
xNormal = xAbs/xMax;                    % 归一化处理
xReshape = reshape(xNormal, N, N);      % 矩阵变形
image(lx, ly, xReshape*256);            % 画灰度图
colormap(gray(256));                   
colorbar();                             % 画灰度条

end

