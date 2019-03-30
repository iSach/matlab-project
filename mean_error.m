function mean = mean_error(x, y, psil, psir, a)
    sum = 0;
    count = 0;
    for i=1:5
        err = get_error(x, y, psil, psir, a, r_consts.traj_time_values(i));
        sum = sum + err;
        count = count + 1;
    end
    mean = sum / count;
end