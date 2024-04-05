# Bundle Adjustment and Pinhole Camera Model Implementation

This repository contains the code and documentation for a project that explores the implementation of the pinhole camera model and the use of the Bundle Adjustment algorithm in MATLAB. The primary goal of this project is to gain a deeper understanding of how a camera model can translate 3D points into 2D points, and to encapsulate this process in code.

## Project Overview

In this project, we follow a step-by-step approach to achieve our goals:

1. **Creating a 3D Object**: We begin by creating a 3D object in MATLAB, leveraging the built-in functions. For this project, we use a cylinder shape as our reference object.

2. **Determining Camera Positions**: Next, we determine the positions of three cameras around the 3D object. These positions are crucial for capturing different viewpoints.

3. **Calibrating Camera Intrinsic Parameters**: We define the intrinsic parameters of each camera, including image size, principal point, and focal length. Additionally, we ensure that each camera is properly oriented towards the cylinder shape using vector manipulation.

4. **Creating the Field of View (FOV)**: To simulate the camera's field of view, we create a frustum shape. We use mathematical calculations to determine the frustum's edges. Points within this frustum represent visible points for the camera. In this test, we also consider points behind the object, simulating a transparent object. Adjusting the FOV can address this if needed.

5. **Converting 3D Points to 2D Points**: Once the FOV is established, we convert 3D points within the camera's view to 2D points. This step is crucial for rendering the object from different camera angles.

6. **Bundle Adjustment**: To optimize the camera parameters and 3D point positions, we implement the Bundle Adjustment algorithm. This involves adjusting camera poses and 3D point coordinates to minimize the reprojection error.


| File Name               | Description                                                      |
|-------------------------|------------------------------------------------------------------|
| `cylinder_cameras_3.m`  | The main class that orchestrates the entire process.            |
| `camera_points.m`       | A class responsible for extracting 3D points from the camera's field of view. |
| `planeFromPoints.m`     | A class used to create a specific plane from the frustum shape.  |
| `check_plane.m`         | A class for checking if a vector between the camera position and a 3D point doesn't intersect with any objects. |
| `min_max_values.m`      | A class for checking if a point is within the bounds of a plane. |
| `plot_frustum.m`        | A class responsible for visualizing the camera's field of view.  |
| `check_plane_inter.m`   | A class for checking if a vector between the far plane of the frustum intersects with a 3D point and the far plane position. |


## Usage

To use this codebase, follow these steps:

1. Clone the repository to your local machine.
2. Open MATLAB and navigate to the project directory.
3. Execute the `cylinder_cameras_3.m` script to run the entire pipeline.

## Conclusion

This project offers valuable insights into the pinhole camera model, field of view determination, and Bundle Adjustment. It provides a foundation for further exploration in the field of 3D reconstruction and computer vision. Feel free to explore the code, experiment with different objects, or extend the functionality to suit your specific needs.
