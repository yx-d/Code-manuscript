clear all
th=[100,123,95,90,100.5];%heating demands in five industrial processes, Celsius degree
tc=[2,-1,0,-3,-4.5];%cooling demands in five industrial processes, Celsius degree
Qh=[1208,4197,718.7,21580,1385];%heating demands, kW
Qc=[526.2,1285,290,7326,836.3];%cooling demands, kW
tenv=15;%environmental temperature
gcarnot=0.5;%carnot efficiency
for i=1:5
    COPh(i)=(th(i)+273.15)/(th(i)-tenv)*gcarnot;%energy efficiency in single heating mode
    COPhd(i)=(th(i)+273.15)/(th(i)-tc(i))*gcarnot;
    COPcd(i)=(tc(i)+273.15)/(th(i)-tc(i))*gcarnot;
    Qc_h(i)=Qh(i)/COPhd(i)*COPcd(i);%cooling generated based on the meeting the heating demand
    if Qc(i)>Qc_h(i)
        W=Qc(i)/COPcd(i);
    else
        W=Qh(i)/COPhd(i);
    end
    gch(i,1)=(Qc(i)+Qh(i))/W;%energy efficiency in combined cooling and heating mode
end