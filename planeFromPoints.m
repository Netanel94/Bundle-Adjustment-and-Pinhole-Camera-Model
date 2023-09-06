function plane = planeFromPoints(p1, p2, p3,p4)
v1 = p2 - p1;
v2 = p3 - p1;
n = cross(v1, v2);
d = -dot(n, p1);
plane = [n d];
 
vertices = [p1; p2; p3; p4];
faces = [1, 2, 3, 4];
patch('Vertices', vertices, 'Faces', faces, 'FaceColor', 'blue', 'FaceAlpha', 0.3)

end
