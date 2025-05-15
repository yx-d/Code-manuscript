clear all
Cinv=6500;%investment cost CNY/kW
Com=Cinv*0.02;%operating and maintenance cost
m=180;%loan period is 180 months
rl=0.1;%lending rate
rd=0.08;%discount rate
rp=0.8;%performance ratio of PV system
Hp=1364;%annual peak hours
Cfin=Cinv*(rl/12*(1+rl/12)^180)/((1+rl/12)^180-1);%monthly principal and interest
sumC=0;sumH=0;
for i=1:25%lifetime of PV system is 25 years
    if i<16
        C(i,1)=(Com+Cfin*12)/(1+rd)^i;%annual cost
    else
        C(i,1)=Com/(1+rd)^i;
    end
    H(i,1)=Hp*rp*(1-0.03)*(1-0.007)^(i-1)/(1+rd)^i;%the degradation rate is 3% in the first year and 0.7% per year thereafter
    sumC=sumC+C(i,1);
    sumH=sumH+H(i,1);
end
LCOEPV=sumC/sumH;