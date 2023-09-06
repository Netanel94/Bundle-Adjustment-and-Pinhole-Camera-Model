clc,clear
t = 0:pi/10:2*pi;
r = 2 + cos(t);
[X,Y,Z] = cylinder(r);
surf(5*X,5*Y,155*Z)
hold on;

f = 50; % Focal length in pixel
u = 60;
v = 85;
principalPoint = [u,v];
imageSize = [170,120];
intrinsics = cameraIntrinsics(f,principalPoint,imageSize);

camera1 = [11,20,77.5];
camera2 = [-11,-20,77.5];
camera3 = [-4,20,77.5];

up = [0, 0, 1];

centroid = [mean(5*X(:)), mean(5*Y(:)), mean(155*Z(:))];
% Compute the camera's f2 direction
f1 = centroid - camera1;
f2 = centroid - camera2;
f3 = centroid - camera3;
f1 = f1 / norm(f1);
f2 = f2 / norm(f2);
f3 = f3 / norm(f3);

% Compute the camera's r2 direction
r1 = cross(up, f1);
r2 = cross(up, f2);
r3 = cross(up, f3);
r1 = r1 / norm(r1);
r2 = r2 / norm(r2);
r3 = r3 / norm(r3);
% Compute the camera's true up direction
up1 = cross(f1, r1);
up2 = cross(f2, r2);
up3 = cross(f3, r3);
up1 = up1 / norm(up1);
up2 = up2 / norm(up2);
up3 = up3 / norm(up3);


% Construct the rotation matrix
R1 = -1*[r1', up1', -f1'];
R2 = -1*[r2', up2', -f2'];
R3 = -1*[r3', up3', -f3'];



T1 = -R1 * camera1';
T2 = -R2 * camera2';
T3 = -R3 * camera3';



% Create a cell array to hold camera poses

K1 = [R1,camera1'];
K2 = [R2,camera2'];
K3 = [R3,camera3'];
proj_mat1 = intrinsics.IntrinsicMatrix * K1;
proj_mat2 = intrinsics.IntrinsicMatrix * K2;
proj_mat3 = intrinsics.IntrinsicMatrix * K3;
% num_points = size(5*X, 1) * size(5*X, 2);
% object_points = [reshape(5*X, [1, num_points]); reshape(5*Y, [1, num_points]); reshape(155*Z, [1, num_points]); ones(1, num_points)];
xyz_points = [5*X(:), 5*Y(:), 155*Z(:)];


rigid1 = rigid3d(R1,T1');
rigid2 = rigid3d(R2,T2');
rigid3 = rigid3d(R3,T3');

p6 = uint32(1);
p7 = uint32(2);
p8 = uint32(3);


row1 = {p6,rigid1};
row2 = {p7,rigid2};
row3 = {p8,rigid3};

cameraPoses = cell2table([row1; row2; row3], 'VariableNames', {'ViewId', 'AbsolutePose'});

% sensor_size = 35;
sensor_w = imageSize(2);
sensor_h = imageSize(1);

near_distance = 5;
near_center1 = camera1 + near_distance * f1;
near_center2 = camera2 + near_distance * f2;
near_center3 = camera3 + near_distance * f3;
% 
% fov = 2 * atan(sensor_size / (2 * f));
fov_horizontal = 2 * atan((sensor_w / 2) / f);
fov_vertical = 2 * atan((sensor_h / 2) / f);
near_height = 2 * near_distance * tan(fov_vertical / 2);
near_width = 2 * near_distance * tan(fov_horizontal / 2);

% Camera 1 Near plane

near_top_left_1 = near_center1 + (near_height / 2) * up1 - (near_width / 2) * r1;
near_top_r1 = near_center1 + (near_height / 2) * up1 + (near_width / 2) * r1;
near_bottom_left_1 = near_center1 - (near_height / 2) * up1 - (near_width / 2) * r1;
near_bottom_r1 = near_center1 - (near_height / 2) * up1 + (near_width / 2) * r1;


% Camera 2 Near plane

near_top_left_2 = near_center2 + (near_height / 2) * up2 - (near_width / 2) * r2;
near_top_r2 = near_center2 + (near_height / 2) * up2 + (near_width / 2) * r2;
near_bottom_left_2 = near_center2 - (near_height / 2) * up2 - (near_width / 2) * r2;
near_bottom_r2 = near_center2 - (near_height / 2) * up2 + (near_width / 2) * r2;

% Camera 3 Near plane

near_top_left_3 = near_center3 + (near_height / 2) * up3 - (near_width / 2) * r3;
near_top_r3 = near_center3 + (near_height / 2) * up3 + (near_width / 2) * r3;
near_bottom_left_3 = near_center3 - (near_height / 2) * up3 - (near_width / 2) * r3;
near_bottom_r3 = near_center3 - (near_height / 2) * up3 + (near_width / 2) * r3;


far_distance = 50;
far_center1 = camera1 + far_distance * f1;
far_center2 = camera2 + far_distance * f2;
far_center3 = camera3 + far_distance * f3;

far_height = 2 * far_distance * tan(fov_vertical / 2);
far_width = 2 * far_distance * tan(fov_horizontal / 2);

% Camera 1 Far plane
far_top_left_1 = far_center1 + (far_height / 2) * up1 - (far_width / 2) * r1;
far_top_r1 = far_center1 + (far_height / 2) * up1 + (far_width / 2) * r1;
far_bottom_left_1 = far_center1 - (far_height / 2) * up1 - (far_width / 2) * r1;
far_bottom_r1 = far_center1 - (far_height / 2) * up1 + (far_width / 2) * r1;


% Camera 2 Far plane
far_top_left_2 = far_center2 + (far_height / 2) * up2 - (far_width / 2) * r2;
far_top_r2 = far_center2 + (far_height / 2) * up2 + (far_width / 2) * r2;
far_bottom_left_2 = far_center2 - (far_height / 2) * up2 - (far_width / 2) * r2;
far_bottom_r2 = far_center2 - (far_height / 2) * up2 + (far_width / 2) * r2;

% Camera 3 Far plane
far_top_left_3 = far_center3 + (far_height / 2) * up3 - (far_width / 2) * r3;
far_top_r3 = far_center3 + (far_height / 2) * up3 + (far_width / 2) * r3;
far_bottom_left_3 = far_center3 - (far_height / 2) * up3 - (far_width / 2) * r3;
far_bottom_r3 = far_center3 - (far_height / 2) * up3 + (far_width / 2) * r3;



% Cam visible points


cam1_points = camera_points(camera1,xyz_points,near_top_r1,near_top_left_1,near_bottom_left_1,near_bottom_r1,far_top_r1,far_top_left_1,far_bottom_left_1,far_bottom_r1);
cam2_points = camera_points(camera2,xyz_points,near_top_r2,near_top_left_2,near_bottom_left_2,near_bottom_r2,far_top_r2,far_top_left_2,far_bottom_left_2,far_bottom_r2);
cam3_points = camera_points(camera3,xyz_points,near_top_r3,near_top_left_3,near_bottom_left_3,near_bottom_r3,far_top_r3,far_top_left_3,far_bottom_left_3,far_bottom_r3);

%Getting rid of duplicates
% cam1_points = unique(cam1_points, 'rows');
% cam2_points = unique(cam2_points, 'rows');
% cam3_points = unique(cam3_points, 'rows');



% for i=1:size(cam1_points,1)
%     point_1 = cam1_points(i,:);
%     plot3(point_1(1), point_1(2), point_1(3), 'bx', 'MarkerSize', 10, 'LineWidth', 2);
% end

%Plot for the visble points

% for i=1:size(cam2_points,1)
%     point_2 = cam2_points(i,:);
%     plot3(point_2(1), point_2(2), point_2(3), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
% end

% for i=1:size(cam3_points,1)
%     point_3 = cam3_points(i,:);
%     plot3(point_3(1), point_3(2), point_3(3), 'gx', 'MarkerSize', 10, 'LineWidth', 2);
% end

%Plot for the frusturm

plot_frustrum(near_top_r1,near_top_left_1,near_bottom_left_1,near_bottom_r1,far_top_r1,far_top_left_1,far_bottom_left_1,far_bottom_r1)
plot_frustrum(near_top_r2,near_top_left_2,near_bottom_left_2,near_bottom_r2,far_top_r2,far_top_left_2,far_bottom_left_2,far_bottom_r2)
plot_frustrum(near_top_r3,near_top_left_3,near_bottom_left_3,near_bottom_r3,far_top_r3,far_top_left_3,far_bottom_left_3,far_bottom_r3)



point_track_array = cell(0);




xyz_all_points = zeros(3,182)';
xyz_cams = zeros(3,182)';
jx = 1;

for i = 1:size(cam1_points, 1)
    xyz_all_points(jx,:) = cam1_points(i,:);
    xyz_cams(jx,1) = 1;
    jx = jx +1;
end


% Iterate through each point in camera_points_2
for i = 1:size(cam2_points, 1)
    % Check if the point is already in pointTrack
    idx = find(ismember(xyz_all_points, cam2_points(i,:), 'rows'));
    if ~isempty(idx)
        % If the point already exists, update the ViewIds for this camera
        xyz_cams(idx,2) = 2;
    else
        % If the point is new, add it to the pointTrack with ViewId 2    
        xyz_all_points(jx,:) = cam2_points(i,:);
        xyz_cams(jx,2) = 2;
        jx = jx +1;
    end
end

% Iterate through each point in camera_points_3
for i = 1:size(cam3_points, 1)
    % Check if the point is already in pointTrack
    idx = find(ismember(xyz_all_points, cam3_points(i,:), 'rows'));
    if ~isempty(idx)
        % If the point already exists, update the ViewIds for this camera
        xyz_cams(idx,3) = 3;
    else
        % If the point is new, add it to the pointTrack with ViewId 3
        xyz_all_points(jx,:) = cam3_points(i,:);
        xyz_cams(jx,3) = 3;
        jx = jx +1;
    end
end




point_track_array = pointTrack.empty(0,182);
jx = 1;

%Creating the pointTrack object array

for i = 1:size(xyz_all_points,1)
    point_3D = xyz_all_points(i,:);
    point_3D_cam = [point_3D,1]';
    cam_vec = xyz_cams(i,:);
    flag_1 = 0;
    flag_2 = 0;
    flag_3 = 0;
    id = [];
    if (cam_vec(1) ~= 0)
        id(end+1) = 1;
        object_point_1 = proj_mat1 * point_3D_cam;
        cam1_point_2D = object_point_1(1:2) ./ object_point_1(3);
        cam1_point_2D = cam1_point_2D';
        flag_1 = flag_1 + 1;
    end
    if (cam_vec(2) ~= 0)
        id(end+1) = 2;
        object_point_2 = proj_mat2 * point_3D_cam;
        cam2_point_2D = object_point_2(1:2) ./ object_point_2(3);
        cam2_point_2D = cam2_point_2D';
        flag_2 = flag_2 + 1;
    end
    if(cam_vec(3) ~= 0)
        id(end+1) = 3;
        object_point_3 = proj_mat3 * point_3D_cam;
        cam3_point_2D = object_point_3(1:2) ./ object_point_3(3);
        cam3_point_2D = cam3_point_2D';
        flag_3 = flag_3 + 1;
    end
    
    size_cams = numel(id);
    
    if(size_cams == 1 && flag_1 == 1 && flag_2 == 0 && flag_3 == 0)
        point_track_array(end+1) = pointTrack(id,cam1_point_2D);
    end
    
    if(size_cams == 1 && flag_1 == 0 && flag_2 == 1 && flag_3 == 0)
        point_track_array(end+1) = pointTrack(id,cam2_point_2D);
    end
    
    if(size_cams == 1 && flag_1 == 0 && flag_2 == 0 && flag_3 == 1)
        point_track_array(end+1) = pointTrack(id,cam3_point_2D);
    end
    
    if(size_cams == 2 && flag_1 == 1 && flag_2 == 1 && flag_3 == 0)
        mat_2 = [cam1_point_2D;cam2_point_2D];
        point_track_array(end+1) = pointTrack(id,mat_2);
    end
    
    if(size_cams == 2 && flag_1 == 1 && flag_2 == 0 && flag_3 == 1)
        mat_2 = [cam1_point_2D;cam3_point_2D];
        point_track_array(end+1) = pointTrack(id,mat_2);
    end
    
     if(size_cams == 2 && flag_1 == 0 && flag_2 == 1 && flag_3 == 1)
        mat_2 = [cam2_point_2D;cam3_point_2D];
        point_track_array(end+1) = pointTrack(id,mat_2);
     end
     
    if(size_cams == 3)
        mat_3=[cam1_point_2D;cam2_point_2D;cam3_point_2D];
        point_track_array(end+1) = pointTrack(id,mat_3);
    end
     
end


figure;
[xyzRefinedPoints,refinedPoses] = ...
    bundleAdjustment(xyz_all_points,point_track_array,cameraPoses,intrinsics);
pcshow(xyzRefinedPoints,'VerticalAxis','y','VerticalAxisDir',...
    'down','MarkerSize',45);
hold on
plotCamera(refinedPoses,'Size',10);
hold off
grid on



