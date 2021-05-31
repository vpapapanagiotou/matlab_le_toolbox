function out=simpleMetrics(x)

w=20;
w=6.9;

tp=x(:,1);
fp=x(:,2);
fn=x(:,3);
tn=x(:,4);
wtp=w*tp;
wfn=w*fn;

% Precision
out.prec=tp./(tp+fp);

% Recall
out.rec=tp./(tp+fn);

% Accuracy
out.acc=(tp+tn)./(tp+tn+fp+fn);

% Weighted accuracy
out.wacc=(wtp+tn)./(wtp+tn+fp+wfn);

% f1 measure
out.f1=fmeasure(tp,fp,fn,tn,1);

% f2 measuse
out.f2=fmeasure(tp,fp,fn,tn,2);

end

function f=fmeasure(tp,fp,fn,tn,beta)
    nom=(1+beta^2)*tp;
    den=(1+beta^2)*tp + beta^2*fn + fp;
    f=nom./den;
end
