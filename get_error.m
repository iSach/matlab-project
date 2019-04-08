function error = get_error(a, time)
    [x, y] = gen_traj(a);
    dxd = derivate_pp(x);
    dyd = derivate_pp(y);
    [psil, psir] = mov_interpolation(a * 4, dxd, dyd);
     
    [T, Y] = solve_diff2(x, y, psil, psir, a);

    % calcul de l'erreur finale
    % Trajectoire souhaitée :
    xdf = ppval(x, time);
    ydf = ppval(y, time);
    
    % Trajectoire réelle
    [~, index] = min(abs(T - time));
    xf = Y(index, 6);
    yf = Y(index, 7);
  
    error = sqrt(power(xf - xdf, 2) + power(yf - ydf, 2));
end