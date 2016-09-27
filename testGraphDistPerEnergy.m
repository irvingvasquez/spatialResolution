
% Energy
velocity = [2 4 6 8 10 12 14 16];
power = [220  215 210  208 212 230 260 300];
%plot(velocity, power, 'o');
coef = polyfit(velocity,power,3);
power_mr = @(speed) polyval(coef, speed); 


Spd = 0:0.1:16;
for i=1:size(Spd,2)
    EperDist = power_mr(Spd(1,i)) / Spd(1,i);
    DistPerEner(i) = 1 / EperDist;
end

plot(Spd,DistPerEner);