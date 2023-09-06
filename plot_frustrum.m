function plot_frustrum(near_top_right,near_top_left,near_bottom_left,near_bottom_right,far_top_right,far_top_left,far_bottom_left,far_bottom_right)

% Plot the near plane corners
plot3([near_bottom_left(1), near_bottom_right(1)], [near_bottom_left(2), near_bottom_right(2)], [near_bottom_left(3), near_bottom_right(3)], 'r', 'LineWidth', 2);
plot3([near_bottom_right(1), near_top_right(1)], [near_bottom_right(2), near_top_right(2)], [near_bottom_right(3), near_top_right(3)], 'r', 'LineWidth', 2);
plot3([near_top_right(1), near_top_left(1)], [near_top_right(2), near_top_left(2)], [near_top_right(3), near_top_left(3)], 'r', 'LineWidth', 2);
plot3([near_top_left(1), near_bottom_left(1)], [near_top_left(2), near_bottom_left(2)], [near_top_left(3), near_bottom_left(3)], 'r', 'LineWidth', 2);

% Plot the far plane corners
plot3([far_bottom_left(1), far_bottom_right(1)], [far_bottom_left(2), far_bottom_right(2)], [far_bottom_left(3), far_bottom_right(3)], 'b', 'LineWidth', 2);
plot3([far_bottom_right(1), far_top_right(1)], [far_bottom_right(2), far_top_right(2)], [far_bottom_right(3), far_top_right(3)], 'b', 'LineWidth', 2);
plot3([far_top_right(1), far_top_left(1)], [far_top_right(2), far_top_left(2)], [far_top_right(3), far_top_left(3)], 'b', 'LineWidth', 2);
plot3([far_top_left(1), far_bottom_left(1)], [far_top_left(2), far_bottom_left(2)], [far_top_left(3), far_bottom_left(3)], 'b', 'LineWidth', 2);

% Plot the lines between near and far plane corners
plot3([near_bottom_left(1), far_bottom_left(1)], [near_bottom_left(2), far_bottom_left(2)], [near_bottom_left(3), far_bottom_left(3)], 'g', 'LineWidth', 2);
plot3([near_bottom_right(1), far_bottom_right(1)], [near_bottom_right(2), far_bottom_right(2)], [near_bottom_right(3), far_bottom_right(3)], 'g', 'LineWidth', 2);
plot3([near_top_left(1), far_top_left(1)], [near_top_left(2), far_top_left(2)], [near_top_left(3), far_top_left(3)], 'g', 'LineWidth', 2);
plot3([near_top_right(1), far_top_right(1)], [near_top_right(2), far_top_right(2)], [near_top_right(3), far_top_right(3)], 'g', 'LineWidth', 2);

end