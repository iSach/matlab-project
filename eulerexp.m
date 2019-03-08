function [T, Y] = eulerexp(f, end_time, init_cond)
    % Resout l'equation differentielle sur l'intervalle [0 ; end_time]
    % a l'aide de la methode d'Euler explicite.
    %
    % init_cond est un vecteur contenant les conditions initiales.
    % 
    % f represente les fonctions a resoudre.
    
    n = length(init_cond);
    h = 4;
    iterations = (end_time)/h;
    T = zeros(1, iterations + 1);
    Y = zeros(n, iterations + 1);
    
    Y(:, 1) = init_cond;
        
    for i = 1:iterations
        T(i+1) = i * h;
        Y(:, i+1) = Y(:, i) + h * f(T(i), Y(:, i));
    end
end
