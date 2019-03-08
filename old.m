function dvect = oderobotQ2(t, vect)
    dvect = zeros(1, 1)
    dvect(1) = vect(1)
    fprintf('t : %f\n', t(1))
    fprintf('y : %f\n', vect(1))
end