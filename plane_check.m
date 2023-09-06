% Define the plane equation
plane = [0.498064693929453,0.867139873757954,2,20.515076131967696];

% Create a grid of points
[x,y] = meshgrid(-5:0.5:5, -5:0.5:5);

% Evaluate the plane equation at each point on the grid
z = (-plane(1)*x - plane(2)*y - plane(4)) / plane(3);

% Plot the plane
surf(x,y,z)