function testf()
    [T, Y] = eulerexp(@oderobotQ2, 20, zeros(7, 1));
    
    hold off
    plot(T, Y(3, :))
    plot(Y(6, :), Y(7, :))
end