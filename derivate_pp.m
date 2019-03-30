function d_poly = derivate_pp(pp)
    % D�rive le polyn�me par morceau (pp) en le multipliant par une matrice
    % diagonale compos�e des exposants, puis r�duit l'ordre des polyn�mes.

    A = diag(pp.order - 1:-1:0);
    dcoefs = pp.coefs * A;
   
    % On tronque a (n-1)eme colonne afin de r�duire l'ordre des polyn�mes.
    [m, n] = size(dcoefs);
    dcoefs = dcoefs(1:m, 1:(n - 1));
    
    d_poly = mkpp(pp.breaks, dcoefs);
end