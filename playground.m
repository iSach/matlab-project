a = 0.975928955078125; % a optimal en E : t_f
a = 0.930468750000000; % a optimal en E : moyenne
[x, y] = gen_traj(a);
dxd = derivate_pp(x);
dyd = derivate_pp(y);
[psil, psir] = mov_interpolation(4, dxd, dyd);

A = zeros(40, 1);
G = 0.8:0.005:1;
for i = 1:41
   A(i) = mean_error(G(i));
   fprintf('a=%f -> E''=%f\n', G(i), A(i));
end