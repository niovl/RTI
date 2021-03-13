function [nodesCoordinates] = NodePlace(oneSideNodeNum, nodesDistance)
% 函数功能： 网络中各个节点的坐标映射
    %输入：
        % oneSideNodeNum：需要安置的系统，每条边节点个数
        % nodesDistance：相邻节点之间的距离
    %输出：
        % nodeCoordinates：各个节点对应的坐标

totalNum = (oneSideNodeNum - 1)*4;                      % 网络中总节点个数
% 提示
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

nodesCoordinates = zeros(totalNum, 2);         % 各个节点对应的坐标

% 节点的坐标映射
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

% 节点坐标的可视化（可选择性操作）
% figure(1);
% scatter(nodesCoordinates(:, 1), nodesCoordinates(:, 2), 'filled');
% axis([0 (oneSideNodeNum-1)*nodesDistance 0 (oneSideNodeNum-1)*nodesDistance]);
% xlabel('X(feet)');
% ylabel('Y(feet)');
% title({'节点部署平面示意图'; ['节点总数：',num2str(totalNum)]});
% box on;



% 所有链路的可视化（可选择性操作）
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
% title({'网络工作示意图'; ['无向链路总条数：',num2str(i*j/2)]});


end

