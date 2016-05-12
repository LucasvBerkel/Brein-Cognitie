function [x,rt] = simdiff(N,a,v,ter)
  % a: boundary sep; v: drift rate; ter: non-decision time
  si=1; %scaling factor
  M=pi.*si.^2./a.^2 .* (exp(a.*v./(2.*si.^2))+exp(-a.*v./(2.*si.^2))) .* ...
      1./ (v.^2./(2.*si.^2)+pi.^2.*si.^2 ./ (2.*a.^2));
  lmb = v.^2./(2.*si.^2) +pi.^2.*si.^2./(2.*a.^2);
  eps=1e-15;
  ou=[];
  rej=0;
  while(length(ou)<N)
    w=rand(1,1); 
    u=rand(1,1);
    FF=pi.^2.*si.^4 .* 1./(pi.^2.*si.^4+v.^2*a.^2);
    sh1=1;
    sh2=0;
    sh3=0;
    i=0;
    while(abs(sh1-sh2)>eps || abs(sh2-sh3)>eps)
      sh1=sh2;
      sh2=sh3;
      i=i+1;
      sh3= sh2 + (2.*i+1).*(-1).^i.*(1-u).^(FF.*(2.*i+1).^2);
    end
    eval=1+(1-u).^-FF .* sh3;
    if(w<=eval) 
        ou= [ou 1./lmb.*abs(log(1-u))];
    else
        rej=rej+1;
    end
  end
  p=exp(a.*v)./(1+exp(a.*v));
  chance=rand(1,N);
  x = (p > chance).*1;
  rt = ou+ter;
end