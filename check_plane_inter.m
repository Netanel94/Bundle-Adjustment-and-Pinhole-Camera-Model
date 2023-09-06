function pc = check_plane_inter(plane,p)
a = plane(1);
b = plane(2);
c = plane(3);
d = plane(4);
distance = (a*p(1) + b*p(2) + c*p(3) + d) / sqrt(a^2 + b^2 + c^2);
if(distance > 0)
    pc = 1;
else
    pc = 0;
end
