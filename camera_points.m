function cam_p = camera_points(camera2,xyz_points,near_top_r2,near_top_left_2,near_bottom_left_2,near_bottom_r2,far_top_r2,far_top_left_2,far_bottom_left_2,far_bottom_r2)


near_plane2 = planeFromPoints(near_top_r2,near_top_left_2,near_bottom_left_2,near_bottom_r2);
upper_plane2 = planeFromPoints(near_top_left_2,far_top_left_2,near_top_r2,far_top_r2);
bottom_plane2 = planeFromPoints(near_bottom_left_2,far_bottom_left_2,near_bottom_r2,far_bottom_r2);
right_plane2 = planeFromPoints(near_bottom_r2,far_bottom_r2,near_top_r2,far_top_r2);
left_plane2 = planeFromPoints(near_bottom_left_2,far_bottom_left_2,near_top_left_2,far_top_left_2);
far_plane2 = planeFromPoints(far_bottom_left_2,far_bottom_r2,far_top_left_2,far_top_r2);


num_points = 441;
check_arr2 = zeros(1,num_points);

counter2 = 0;



for i=1:size(xyz_points,1)
    point_2 = xyz_points(i,:); 
    vec2 = point_2 - camera2;
    up_p_2 = check_plane(upper_plane2,vec2,camera2,near_top_left_2,far_top_left_2,near_top_r2,far_top_r2);
    down_p_2 = check_plane(bottom_plane2,vec2,camera2,near_bottom_left_2,far_bottom_left_2,near_bottom_r2,far_bottom_r2);
    right_p_2 = check_plane(right_plane2,vec2,camera2,near_bottom_r2,far_bottom_r2,near_top_r2,far_top_r2);
    left_p_2 = check_plane(left_plane2,vec2,camera2,near_bottom_left_2,far_bottom_left_2,near_top_left_2,far_top_left_2);
    near_p_2 = check_plane(near_plane2,vec2,camera2,near_top_r2,near_top_left_2,near_bottom_left_2,near_bottom_left_2);
    far_p_2 = check_plane_inter(far_plane2,point_2);
    
    if(up_p_2 == 0 && down_p_2 == 0 && right_p_2 == 0 && left_p_2 == 0 && far_p_2 == 0)
        if(near_p_2 == 1)
            check_arr2(i) = 1;
            counter2 = counter2 + 1;
        end
    end
    
end
j2 = 1;
cam2_points = zeros(3,counter2)';

for i=1:size(xyz_points,1)
    if(check_arr2(i) == 1)
        cam2_points(j2,:) = xyz_points(i,:);
        j2 = j2+1;
    end
    
end

cam_p = cam2_points;