function [] = DrawX(x, N)
% �������ܣ�����x������ͼ
%   ���룺
    % x: �ź�
    % N���ź�����ͼ��ά�ȣ�N * N��

lx = [0 22];
ly = [22 0];

xAbs = abs(x);                          % ��ȡ����ֵ
xMax = max(xAbs);                       % ��ȡx�����ֵ
xNormal = xAbs/xMax;                    % ��һ������
xReshape = reshape(xNormal, N, N);      % �������
image(lx, ly, xReshape*256);            % ���Ҷ�ͼ
colormap(gray(256));                   
colorbar();                             % ���Ҷ���

end

