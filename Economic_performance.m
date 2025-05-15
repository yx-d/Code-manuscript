clear all
P=xlsread('C:\Users\Administrator\Desktop\analyses.xlsb','economic performance in different countries','I2:M31');%energy price USD/kWh
g(1)=0.8;g(2)=0.92;g(3)=0.8;g(4)=0.9;g(5)=2.39;%energy efficincy of different boilers (1-4) or heat pump(5)
for i=[1:4,6:12,15:20,23,29:30]
    for j=1:5
        C(i,j)=P(i,j)/g(j);
    end
    [~, idx]=sort([C(i,1),C(i,2),C(i,3),C(i,4),C(i,5)],'ascend');% ranking from low to high,idx records the original position
    D(i,1)=idx(1);D(i,2)=idx(2);D(i,3)=idx(3);D(i,4)=idx(4);D(i,5)=idx(5);%ranking different heating technologies from low to high cost in different countries
end

RHPCB=g(5)/g(1);RHPGB=g(5)/g(2);RHPBB=g(5)/g(3);RHPOB=g(5)/g(4);%break-even price ratio between heat pump and a certain kind of boiler

for i=[6,15,17,23,29]
    for j=1:4
        deltaCinv(i,j)=(C(i,j)-C(i,5))*40000;%the maximum permitted exceeding value of the investment and maintenance cost of heat pump than boilers
    end
end

ee=xlsread('C:\Users\Administrator\Desktop\analyses.xlsb','economic performance in different countries','AD2:AD31');%carbon emission factor of electricity,kg/kwh
gc=0.8;gg=0.92;gb=0.8;go=0.9;ghp=2.39;
ec=2.99;eg=2.758102838*0.7175;eb=0;eo=3.095909637;%kg/kg (0.7175kg/Nm3 is the density of natural gas)
hc=8.13;hg=9.88;ho=11.85;%calorific value of different fuels,kwh/kg;
ec=ec/hc;eg=eg/hg;eb=0;eo=eo/ho;%carbon emission factor of other fuel,kg/kwh;
B=[];
for k=[1:4,6:12,15:20,23,29:30]
    Qh=1;
    a=0;
    for i=0:0.001:3%carbon cost USD/kg
        a=a+1;
        Pc=P(k,1);Pg=P(k,2);Pb=P(k,3);Po=P(k,4);Pe=P(k,5);
        Cc=Qh/gc*Pc+i*Qh/gc*ec;Cg=Qh/gg*Pg+i*Qh/gg*eg;Cb=Qh/gb*Pb+i*Qh/gb*eb;Co=Qh/go*Po+i*Qh/go*eo;Chp=Qh/ghp*Pe+i*Qh/ghp*ee(k,1);
        [Imin,p]=min([Cc,Cg,Cb,Co,Chp]);
        A(1,a)=i;A(k+1,a)=p;
        if a>1&&A(k+1,a)~=A(k+1,a-1)
            B(k,end+1)=A(k+1,a-1);B(k,end+1)=i;B(k,end+1)=A(k+1,a);%record the changes of heating technologies with the lowest cost and the carbon cost when shifts
        end
    end
end