function testf()
    [A, B] = eulerexp(@oderobotQ2, 20, zeros(7, 1));
    
    hold off
    plot(A, B(3, :))
    plot(B(6, :), B(7, :))
end