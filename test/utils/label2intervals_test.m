t = (1:10) * 10;
l = [1 1 2 3 3 2 1 2 2 5];


[idx, t_ss, t_l] = label2intervals(t, l);

[idx t_ss t_l]
