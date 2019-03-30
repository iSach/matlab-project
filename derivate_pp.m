function d_poly = derivate_pp(pp)
    % Dérive le polynôme par morceau (pp) en le multipliant par une matrice
    % diagonale composée des exposants, puis réduit l'ordre des polynômes.

    A = diag(pp.order - 1:-1:0);
    dcoefs = pp.coefs * A;
   
    % On tronque a (n-1)eme colonne afin de réduire l'ordre des polynômes.
    [m, n] = size(dcoefs);
    dcoefs = dcoefs(1:m, 1:(n - 1));
    
    d_poly = mkpp(pp.breaks, dcoefs);
end