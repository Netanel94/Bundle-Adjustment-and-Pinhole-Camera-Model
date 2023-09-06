function pc = check_plane(plane,vec,camera_point,c1,c2,c3,c4)
a = plane(1);
b = plane(2);
c = plane(3);
d = plane(4);
t = -(a*camera_point(1) + b*camera_point(2) + c*camera_point(3) + d) / (a*vec(1) + b*vec(2) + c*vec(3));
intersection_point = camera_point + t*vec;
if(t == 0)
    pc = 0;
    return;
end
[x_min,x_max,y_min,y_max,z_min,z_max] =  min_max_values(c1,c2,c3,c4);

if (intersection_point(1) >= x_min && intersection_point(1) <= x_max && ...
    intersection_point(2) >= y_min && intersection_point(2) <= y_max && ...
    intersection_point(3) >= z_min && intersection_point(3) <= z_max)

    pc = 1;
else
    pc = 0;
end

end
