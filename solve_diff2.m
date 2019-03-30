function [T, Y] = solve_diff2(x, y, psil, psir, a)
% Résout le systeme d'equations differentielles avec les C.I. definies dans
% r_consts sur l'intervalle [0 t_f].
% Renvoie un vecteur contenant les temps (T), et les solutions en ces temps
% (Y). Egalement represente la trajectoire du robot sur x et y et la
% vitesse en fonction du temps
    
    % Conditions initiales
    init_cond = zeros(7, 1);
    dx = derivate_pp(x);
    dy = derivate_pp(y);
    
    epsilon = r_consts.mov_angle_epsilon;
    init_cond(5) = atan2(ppval(dy, 0 + epsilon), ppval(dx, 0 + epsilon));
    init_cond(6) = ppval(x, 0);
    init_cond(7) = ppval(y, 0);
    
    [T, Y] = ode45(@(t, vect)oderobotQ4(t, vect, psil, psir, ...
    r_consts.sys_gain), [0 a * r_consts.final_time], init_cond);

    % plot(Y(:, 6), Y(:, 7))
    % xq = 0:0.01:(a * r_consts.traj_time_values);
    % hold on
    % plot(T, ppval(x,xq))
end