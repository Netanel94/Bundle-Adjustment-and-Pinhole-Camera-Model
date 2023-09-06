function [x_min,x_max,y_min,y_max,z_min,z_max] =  min_max_values(c1,c2,c3,c4)

corners = [c1;c2;c3;c4];

x_min = min(corners(:, 1));
x_max = max(corners(:, 1));
y_min = min(corners(:, 2));
y_max = max(corners(:, 2));
z_min = min(corners(:, 3));
z_max = max(corners(:, 3));

end