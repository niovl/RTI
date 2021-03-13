function [nodesCoordinates] = NodePlace(oneSideNodeNum, nodesDistance)
% �������ܣ� �����и����ڵ������ӳ��
    %���룺
        % oneSideNodeNum����Ҫ���õ�ϵͳ��ÿ���߽ڵ����
        % nodesDistance�����ڽڵ�֮��ľ���
    %�����
        % nodeCoordinates�������ڵ��Ӧ������

totalNum = (oneSideNodeNum - 1)*4;                      % �������ܽڵ����
% ��ʾ
if(oneSideNodeNum < 2)
    fprintf('\nError: The total number of nodes in the system is too little;\n');
    return; 
else
    fprintf('\nPrompt: The total number of nodes in the system is %d;\n', totalNum);
end

if(nodesDistance <= 0)
    fprintf('\nError: The distance between nodes should be a nonzero number;\n');
    return; 
else
    fprintf('\nPrompt: The distance between nodes in the system is %d;\n', nodesDistance);
end

nodesCoordinates = zeros(totalNum, 2);         % �����ڵ��Ӧ������

% �ڵ������ӳ��
for i = 1: totalNum,
    if(i < oneSideNodeNum + 1)
     nodesCoordinates(i,:) = [0, nodesDistance*(i - 1)];
    else if(i < 2*oneSideNodeNum && i > oneSideNodeNum)
            nodesCoordinates(i,:) = [nodesDistance*(i - oneSideNodeNum), nodesDistance*(oneSideNodeNum-1)];%
        else if(i < 3*oneSideNodeNum-1 && i > 2*oneSideNodeNum-1)
                nodesCoordinates(i,:) = [nodesDistance*(oneSideNodeNum-1), nodesDistance*(3*oneSideNodeNum - i - 2)]; 
            else if(i <= totalNum && i > 3*oneSideNodeNum-2)
                nodesCoordinates(i,:) = [nodesDistance*(totalNum - i + 1), 0]; 
            end
            end
        end
    end
end

% �ڵ�����Ŀ��ӻ�����ѡ���Բ�����
% figure(1);
% scatter(nodesCoordinates(:, 1), nodesCoordinates(:, 2), 'filled');
% axis([0 (oneSideNodeNum-1)*nodesDistance 0 (oneSideNodeNum-1)*nodesDistance]);
% xlabel('X(feet)');
% ylabel('Y(feet)');
% title({'�ڵ㲿��ƽ��ʾ��ͼ'; ['�ڵ�������',num2str(totalNum)]});
% box on;



% ������·�Ŀ��ӻ�����ѡ���Բ�����
% figure(2);
% scatter(nodesCoordinates(:, 1), nodesCoordinates(:, 2), 'k', 'filled');
% axis([0 (oneSideNodeNum-1)*nodesDistance 0 (oneSideNodeNum-1)*nodesDistance]);
% xlabel('X(feet)');
% ylabel('Y(feet)');
% box on;
% for i=1: totalNum-1,
%     for j= i+1: totalNum,
%         line([nodesCoordinates(i, 1), nodesCoordinates(j, 1)], [nodesCoordinates(i, 2), nodesCoordinates(j, 2)]);
%     end
% end
% title({'���繤��ʾ��ͼ'; ['������·��������',num2str(i*j/2)]});


end

