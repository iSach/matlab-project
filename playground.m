a = 0.975928955078125; % a optimal en E : t_f
a = 0.930468750000000; % a optimal en E : moyenne
[x, y] = gen_traj(a);
dxd = derivate_pp(x);
dyd = derivate_pp(y);
[psil, psir] = mov_interpolation(4, dxd, dyd);