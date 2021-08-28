function [f] = eval_metrics(actual,predicted)
real_g1=actual(predicted==1);
real_g2=actual(predicted==2);

one_g1=sum(real_g1==1);
two_g1=sum(real_g1==2);

one_g2=sum(real_g2==1);
two_g2=sum(real_g2==2);
%+nchoosek(two_g1,2)+nchoosek(one_g2,2)
tp= nchoosek(one_g1,2)+nchoosek(two_g2,2);
fp=one_g1*two_g1+one_g2*two_g2;
fn=one_g1*one_g2+two_g1*two_g2;
tn=one_g1*two_g2+two_g1*one_g2;
p=tp/(tp+fp);
r=tp/(tp+fn);
f=2*p*r/(p+r);

end

