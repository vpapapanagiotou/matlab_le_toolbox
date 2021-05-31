function s = make_table(x, p)

c = mymat2cell(x, p.prec);
bold = make_bold(x, p.bold);

if ~isempty(p.rowtitles)
    c = [p.rowtitles(:) c];
    bold = [false([size(x, 1) 1]) bold];
end

s = [];
s = sappend(s, '\begin{table}');
s = sappend(s, '  \centering');
s = sappend(s, ['  \caption{' p.caption '}']);
s = sappend(s, ['  \label{' p.label '}']);
s = sappend(s, ['  \begin{tabular}{' p.colspecs '}']);
s = sappend(s, '    \toprule');
s = sappend(s, ['    ' p.header]);
s = sappend(s, '    \midrule');

for i = 1:size(c, 1)
    r = make_row(c(i, :), bold(i, :));
    s = sappend(s, ['    ' r]);
end

s = sappend(s, '    \bottomrule');
s = sappend(s, '  \end{tabular}');
s = sappend(s, '\end{table}');
