clear all
close all
clc

lambda1=1.55e-6;
k1=2*pi/lambda1;

lambda2=1.31e-6;
k2=2*pi/lambda2;

n1=1.51;
n2=1.5;

nmax1=n1;
nmin1=n2;
nmax2=n1;
nmin2=n2;

neff1=(n1+n2)/2;
neff2=(n1+n2)/2;

precision1=nmax1-nmin1;
precision2=nmax2-nmin2;
dneff1=(n1-n2)/200;
dneff2=(n1-n2)/200;

d=[1e-6:1e-8:1e-5];

for (i=1:length(d))
    
    nmax1=n1;
    nmin1=n2;
    nmax2=n1;
    nmin2=n2;
    
    neff1=(n1+n2)/2;
    neff2=(n1+n2)/2;

    precision1=nmax1-nmin1;
    precision2=nmax2-nmin2;
    
    while(max(precision1,precision2)>1e-7)

        kappa1=k1*sqrt(n1.^2-neff1.^2);
        gamma1=k1*sqrt(neff1.^2-n2^.2);
        res1=kappa1*d(i)/2-atan(gamma1/kappa1);

        kappa2=k2*sqrt(n1.^2-neff2.^2);
        gamma2=k2*sqrt(neff2.^2-n2^.2);
        res2=kappa2*d(i)/2-atan(gamma2/kappa2);

        if res1>0
            nmin1=neff1;
        else
            nmax1=neff1;
        end

        neff1=(nmax1+nmin1)/2;

        if res2>0
            nmin2=neff2;
        else
            nmax2=neff2;
        end
        neff2=(nmax2+nmin2)/2;

        precision1=nmax1-nmin1;
        precision2=nmax2-nmin2;

    end
    nefftab1(i)=neff1;
    nefftab2(i)=neff2;
    b1(i)=(nefftab1(i)^2-n2^2)/(n1^2-n2^2);
    v1(i)=2*pi*d(i)/lambda1*sqrt(n1^2-n2^2);
    
    b2(i)=(nefftab2(i)^2-n2^2)/(n1^2-n2^2);
    v2(i)=2*pi*d(i)/lambda2*sqrt(n1^2-n2^2);
    

    
        
    
    
    
end
     






plot(d,nefftab1,d,nefftab2);
figure;
plot(d,b1,d,b2);
figure;
plot(d,v1,d,v2);
figure;
plot(v1,b1);
