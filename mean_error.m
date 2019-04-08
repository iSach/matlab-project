function mean = mean_error(a)
    sum = 0;
    count = 0;
    for i=1:5
        err = get_error(a, r_consts.traj_time_values(i));
        sum = sum + err;
        count = count + 1;
    end
    mean = sum / count;
end