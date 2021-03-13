function [intersection] = getLinkIntersection(Link, nodesCoordinates)
%
figure(2);
scatter(nodesCoordinates(:, 1), nodesCoordinates(:, 2), 'k', 'filled');
xlabel('X(feet)');
ylabel('Y(feet)');
box on;

linkNum = size(Link, 1);
p = 1;
for i = 1: linkNum - 1,
    for j = i + 1: linkNum,
        t_link = Link(i, :);
        r_link = Link(j, :);
        [A1, B1, C1] = GeneralEquation(t_link(1), t_link(2), t_link(3), t_link(4));
        [A2, B2, C2] = GeneralEquation(r_link(1), r_link(2), r_link(3), r_link(4));
        m = A1 * B2 - A2 * B1;
        if m == 0,
            continue;
        end
        p_ = [(C2 * B1 - C1 * B2) / m (C1 * A2 - C2 * A1) / m];
        if p_(1) <= 0 || p_(1) >= 21,
            continue;
        end
        if p_(2) <= 0 || p_(2) >= 21,
            continue;
        end
        
        intersection(p, 1) = p_(1);
        intersection(p, 2) = p_(2);
%         line([t_link(1), t_link(3)], [t_link(2), t_link(4)], 'Color','red');
%         line([r_link(1), r_link(3)], [r_link(2), r_link(4)], 'Color','blue');
        p = p + 1;
    end
end
intersection = unique(intersection, 'rows');
scatter(intersection(:, 1), intersection(:, 2), 2, 'filled');

end

function [A, B, C] = GeneralEquation(p1_x, p1_y, p2_x, p2_y)
A = p2_y - p1_y;
B = p1_x - p2_x;
C = p2_x * p1_y - p1_x * p2_y;
end

