function [poly_x, poly_y] = gen_traj(a)
% Interpole les trajectoires sur x et y avec des splines.

    poly_x = spline(a * r_consts.traj_time_values, [0 r_consts.traj_x_values 0]);
    poly_y = spline(a * r_consts.traj_time_values, [0 r_consts.traj_y_values 0]);
end