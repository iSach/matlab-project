function v_d = fun_vd(t, dxd, dyd)
    % Evaluation (approximative) du polyn�me en t
     
    dxdt = ppval(dxd, t);
    dydt = ppval(dyd, t);
    
    angle = atan2(dydt, dxdt);
    v_d = dxdt .* cos(angle) + dydt .* sin(angle);
end