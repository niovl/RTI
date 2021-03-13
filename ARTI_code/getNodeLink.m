function [Link] = getNodeLink(nodesCoordinates, linkNum)

Link = zeros(linkNum, 4);
nodeNum = size(nodesCoordinates, 1);
link_index = 1;

for i = 1: nodeNum - 1;
    for j = i + 1: nodeNum;
        t_x = nodesCoordinates(i, 1);
        t_y = nodesCoordinates(i, 2);
        
        r_x = nodesCoordinates(j, 1);
        r_y = nodesCoordinates(j, 2);
        Link(link_index, :) = [t_x, t_y, r_x, r_y];    
       link_index = link_index + 1; 
    end
end


end

