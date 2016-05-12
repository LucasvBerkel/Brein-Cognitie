function sh3 = ddiff(t,x,a,v,Ter)
  % t: reaction time
  % x: accuracies
  % a: boundary sep; v: drift rate; ter: non-decision time
  sh1=1;
  sh2=1;
  sh3=0;
  eps=1e-15;
  k=1;
  
  while(abs(sh1-sh2) > eps || abs(sh1-sh3) > eps)
    K=k.*sin(.5.*pi.*k).*exp(-(pi.^2*k.^2)/(2.*a.^2)*(t-Ter));
    sh1=sh2;
    sh2=sh3;
    sh3=sh3+pi./a.^2.*exp(a.*v.*(x-.5)-v.^2./2.*(t-Ter)).*K;
    k=k+1;
  end
end