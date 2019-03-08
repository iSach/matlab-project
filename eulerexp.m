function [T, Y] = eulerexp(f, end_time, init_cond)
    % Résout l'équation différentielle sur l'intervalle [0 ; end_time]
    % à l'aide de la méthode d'Euler explicite.
    %
    % init_cond est un vecteur contenant les conditions initiales.
    % 
    % f représente les fonctions à résoudre.
    
    n = length(init_cond);
    h = 0.005;
    iterations = (end_time)/h;
    T = zeros(1, iterations + 1);
    Y = zeros(n, iterations + 1);
    
    for step = 1:n
        Y(step, step) = init_cond(step);
    end
        
    for i = 1:iterations
        T(i+1) = i * h;
        Y(:, i+1) = Y(:, i) + h * f(T(i), Y(:, i));
    end
end