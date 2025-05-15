clear all
enoxc=0.004;enoxg=0.00176;enoxb=0.00279;enoxo=0.00962;%emission factors of 4 boilers and 5 pollutants,kgemission/kgfuel
eso2c=0.0064;eso2g=0;eso2b=0.0007;eso2o=0.00095;
evocc=0.00018;evocg=0.00029;evocb=0.000094;evoco=0.00012;
epm25c=0.00189;epm25g=0.00017;epm25b=0.00095;epm25o=0.0005;
eco2c=2.99001285;eco2g=2.758102838;eco2b=0;eco2o=3.095909637;
Qh=1;
for k=1:31
    data=xlsread('C:\Users\Administrator\Desktop\analyses.xlsb','emission','J2:N32');%natioanl electricity mix
    E=xlsread('C:\Users\Administrator\Desktop\analyses.xlsb','emission','C2:F5');%emission factors of different electricity. From row 1 to row 4 are coal, natural gas, oil, biomass respectively, from column 1 to column 4 are NOx, SO2, PM2.5, VOC respectively.
    Eco2e=xlsread('C:\Users\Administrator\Desktop\analyses.xlsb','emission','U2:U32');%CO2 emission factors of electricity in different countries
    Rtp=(data(k,1)+data(k,2)+data(k,3)+data(k,4))/data(k,5);%proportion of thermal power
    Rcp=data(k,3)/data(k,5);%proportion of coal power
    F(k,1)=Rtp;F(k,2)=Rcp;
    ghp=2.39;gc=0.8;gg=0.92;gb=0.8;go=0.9;%energy efficiency of different boilers or heat pump
    hc=8.13;hg=9.88;hb=4.89;ho=11.85;%calorific value of different fuels,kwh/kg;
    mc=Qh/hc/gc;mg=Qh/hg/gg*0.7175;mb=Qh/hb/gb;mo=Qh/ho/go;mehp=Qh/ghp;%mc,mg,mb,mo(kg),mehp（kwh);0.7175kg/Nm3 is the density of natural gas
    for i=1:-0.01:0%national electricity emission reduction. When calculating the optimal choice at present, i=1
    enoxe=i*(data(k,1)*E(3,1)+data(k,2)*E(2,1)+data(k,3)*E(1,1)+data(k,4)*E(4,1))/data(k,5);%national electricity emission factors g/kwh
    eso2e=i*(data(k,1)*E(3,2)+data(k,2)*E(2,2)+data(k,3)*E(1,2)+data(k,4)*E(4,2))/data(k,5);
    epm25e=i*(data(k,1)*E(3,3)+data(k,2)*E(2,3)+data(k,3)*E(1,3)+data(k,4)*E(4,3))/data(k,5);
    evoce=i*(data(k,1)*E(3,4)+data(k,2)*E(2,4)+data(k,3)*E(1,4)+data(k,4)*E(4,4))/data(k,5);
    eco2e=i*Eco2e(k);
    denox=16.64932918;deso2=10.28112338;deco2=0.3455;dhnox=6.90E-05;dhso2=1.40E-05;dhvoc=3.90E-08;dhpm25=1.20E-03;dhco2=8.18E-07;%two impact category（e: ecosystem,h:human health）and five emissions,PDF m2 year/kgemission or DALY/kgemi
    ne=90000;nh=0.03;%normalization factor of two category
    Denoxc=enoxc*denox;Deso2c=eso2c*deso2;Deco2c=eco2c*deco2;Dhnoxc=enoxc*dhnox;Dhso2c=eso2c*dhso2;Dhco2c=eco2c*dhco2;Dhpm25c=epm25c*dhpm25;Dhvocc=evocc*dhvoc;%PDF m2 year or DALY/kgfuel
    Denoxg=enoxg*denox;Deso2g=eso2g*deso2;Deco2g=eco2g*deco2;Dhnoxg=enoxg*dhnox;Dhso2g=eso2g*dhso2;Dhco2g=eco2g*dhco2;Dhpm25g=epm25g*dhpm25;Dhvocg=evocg*dhvoc;
    Denoxb=enoxb*denox;Deso2b=eso2b*deso2;Deco2b=eco2b*deco2;Dhnoxb=enoxb*dhnox;Dhso2b=eso2b*dhso2;Dhco2b=eco2b*dhco2;Dhpm25b=epm25b*dhpm25;Dhvocb=evocb*dhvoc;
    Denoxo=enoxo*denox;Deso2o=eso2o*deso2;Deco2o=eco2o*deco2;Dhnoxo=enoxo*dhnox;Dhso2o=eso2o*dhso2;Dhco2o=eco2o*dhco2;Dhpm25o=epm25o*dhpm25;Dhvoco=evoco*dhvoc;
    Denoxe=enoxe*denox;Deso2e=eso2e*deso2;Deco2e=eco2e*deco2;Dhnoxe=enoxe*dhnox;Dhso2e=eso2e*dhso2;Dhco2e=eco2e*dhco2;Dhpm25e=epm25e*dhpm25;Dhvoce=evoce*dhvoc;%PDF m2 year or DALY/kwh
    Ic=(Denoxc+Deso2c+Deco2c)*mc/ne+(Dhnoxc+Dhso2c+Dhco2c+Dhpm25c+Dhvocc)*mc/nh;%total impact
    Ig=(Denoxg+Deso2g+Deco2g)*mg/ne+(Dhnoxg+Dhso2g+Dhco2g+Dhpm25g+Dhvocg)*mg/nh;
    Ib=(Denoxb+Deso2b+Deco2b)*mb/ne+(Dhnoxb+Dhso2b+Dhco2b+Dhpm25b+Dhvocb)*mb/nh;
    Io=(Denoxo+Deso2o+Deco2o)*mo/ne+(Dhnoxo+Dhso2o+Dhco2o+Dhpm25o+Dhvoco)*mo/nh;
    Ihp=(Denoxe+Deso2e+Deco2e)*mehp/1000/ne+(Dhnoxe+Dhso2e+Dhpm25e+Dhvoce+Dhco2e)*mehp/1000/nh;
    [~, idx]=sort([Ic,Ig,Ib,Io,Ihp],'descend'); % ranking from high to low,idx records the original position  
    rankings=zeros(1,5);
    rankings(idx)=1:5; % Assign values from 1 to 5 in ascending order.
    A(k,1)=rankings(1);A(k,2)=rankings(2);A(k,3)=rankings(3);A(k,4)=rankings(4);A(k,5)=rankings(5);
    B(k,1)=Ic;B(k,2)=Ig;B(k,3)=Ib;B(k,4)=Io;B(k,5)=Ihp;
    [Imin,p]=min([Ic,Ig,Ib,Io,Ihp]);
    C(k,1)=p;
    D(k,1)=i;
    if p==5% stop the decreasing of electricity emission when heat pump has become the technology with lowest total impact
        break
    end
    end
end