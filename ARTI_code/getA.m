function [A] = getA(wsn, rti)
%
nodesCoordinates = wsn.nodesCoordinates;
pixLoc = wsn.pixLoc;
linkNum = wsn.linkNum;
pixNum = wsn.pixNum;
A = zeros(linkNum, pixNum);
nodeNum = size(nodesCoordinates, 1);
lambda = rti.lambda;           % ²ÎÊý

link_index = 1;
for i = 1: nodeNum - 1;
    for j = i + 1: nodeNum;
        t_x = nodesCoordinates(i, 1);
        t_y = nodesCoordinates(i, 2);
        
        r_x = nodesCoordinates(j, 1);
        r_y = nodesCoordinates(j, 2);
        
        for k = 1: pixNum;
            pix_x = pixLoc(k, 1);
            pix_y = pixLoc(k, 2);
            d_l = sqrt(power(t_x - r_x, 2) + power(t_y - r_y, 2));
            d_t = sqrt(power(pix_x - t_x, 2) + power(pix_y - t_y, 2)) +  ...
                sqrt(power(pix_x - r_x, 2) + power(pix_y - r_y, 2)) - d_l;
            e_p = exp(d_t / lambda);
            A(link_index, k) = 1 / (sqrt(d_l) * e_p);
        end
        
       link_index = link_index + 1; 
    end
end


end

