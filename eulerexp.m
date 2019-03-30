function [T, Y] = eulerexp(f, time_span, init_cond)
    % Resout l'equation differentielle sur l'intervalle time_span
    % a l'aide de la methode d'Euler explicite.
    %
    % init_cond est un vecteur contenant les conditions initiales.
    % 
    % f represente les fonctions a resoudre.
    
    n = length(init_cond);
    h = r_consts.euler_gap; % Definit le nombre d'iterations (et donc la precision)
    iterations = (time_span(2) - time_span(1)) / h;
    T = zeros(1, iterations + 1);
    Y = zeros(n, iterations + 1);
    
    T(1) = time_span(1);
    Y(:, 1) = init_cond;
        
    for i = 1:iterations
        T(i+1) = T(i) + h;
        Y(:, i+1) = Y(:, i) + h * f(T(i), Y(:, i));
    end
end
