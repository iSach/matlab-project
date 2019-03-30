function [psid_l, psid_r] = wheel_movement(final_time, dxd, dyd)
% Cr�e et renvoie 2 vecteurs contenant une certaine quantit� (d�finie par
% la constante r_consts.wheel_mov_grid) de points (t, psi_r) et t(psi_l)
% sur l'intervalle [0 ; final_time]. L'ordonn�e en chacun des points
% repr�sente le mouvement � appliquer sur la roue droite ou gauche � ce
% moment-l�.

    psir = zeros(1, r_consts.wheel_mov_grid);
    psil = zeros(1, r_consts.wheel_mov_grid);
    psir(1) = r_consts.init_psir;
    psil(1) = r_consts.init_psil;
    
    time_grid = linspace(0, final_time, r_consts.wheel_mov_grid);
    
    % "Limite" de theta pour t -> 0 (on prend t = 10^-6)
    % pour avoir l'angle en t_1 car theta(t=0) n'a pas de sens,
    % par d�finition de la fonction atan2.
    lim_epsilon = r_consts.mov_angle_epsilon;
    
    dxdt = ppval(dxd, lim_epsilon);
    dydt = ppval(dyd, lim_epsilon);
    prev_angle = atan2(dydt, dxdt);
    
    for i = 2:r_consts.wheel_mov_grid
        % Calcul de l'int�grale sur t_{i-1} -> t_{i}
        int = integral(@(t)fun_vd(t, dxd, dyd), time_grid(i-1), time_grid(i));
        
        if i < r_consts.wheel_mov_grid
            dxdt = ppval(dxd, time_grid(i));
            dydt = ppval(dyd, time_grid(i));
        else
            % Pareil que pour t = 0, si on a t = t_f on a dxd et dyd = 0
            % et alors theta n'a pas de sens. On �value donc en tf -
            % epsilon.
            dxdt = ppval(dxd, time_grid(i) - lim_epsilon);
            dydt = ppval(dyd, time_grid(i) - lim_epsilon);
        end
        angle = atan2(dydt, dxdt);
        
        psir(i) = psir(i - 1) + 1 / r_consts.wheel_radius * int + ...
        r_consts.wheel_offset / r_consts.wheel_radius * (angle - prev_angle);
        
        psil(i) = psil(i - 1) + 1 / r_consts.wheel_radius * int - ...
        r_consts.wheel_offset / r_consts.wheel_radius * (angle - prev_angle);
    
        prev_angle = angle;
    end
    
    psid_r = psir;
    psid_l = psil;
end