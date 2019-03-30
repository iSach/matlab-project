function [psiL_d, psiR_d] = mov_interpolation(final_time, dxd, dyd)
% Calcule la trajectoire en n=wheel_mov_grid valeurs de temps
% entre 0 et final_time via wheel_movement puis renvoie 2 polynomes par
% morceaux (pp) pour chacune des roues.

    [L, R] = wheel_movement(final_time, dxd, dyd);

    % Abscisses
    time_grid = linspace(0, final_time, r_consts.wheel_mov_grid);
    
    % Calcul des polynomes par morceaux
    psiL_d = spline(time_grid, L);
    psiR_d = spline(time_grid, R);
end