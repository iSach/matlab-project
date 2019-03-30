function [T, Y] = solve_diff_sys()
% Résout le systeme d'equations differentielles avec les C.I. definies dans
% r_consts sur l'intervalle [0 t_f].
% Renvoie un vecteur contenant les temps (T), et les solutions en ces temps
% (Y). Egalement represente la trajectoire du robot sur x et y et la
% vitesse en fonction du temps.

    [T, Y] = eulerexp(@oderobotQ2, [0 r_consts.sys_final_time], ...
        r_consts.sys_init_cond);
    
    hold off
    plot(T, Y(3, :))
    figure
    plot(Y(6, :), Y(7, :))
end