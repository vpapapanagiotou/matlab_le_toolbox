x = randi(10, [5 3]) - 1;
p = new_table_properties();
p.caption = 'The caption';
p.label = 'The label';
p.colspecs = 'l c c c c';
p.prec = 0;
p.bold = 'colmax';
p.header = '\textbf{he}\\';
p.rowtitles = {'1st', '2nd', '3ed', '4th', 'last'};
s = make_table(x, p);
disp(s)
