function y = fitnessSpd(spd, height, interv, coef)
% Constants
alpha = 0.6;

% Restrictions
v0 = 0;
v1 = 16;
t0 = 3;
h0 = 30;
h1 = 100;


if( spd<v0 || spd>v1 )
    y = 0;
else if(interv < t0)
        y = 0;
    else
        if(height < h0 || height > h1)
            y = 0;
        else
            [s, overlap] = resolution(spd, height, interv);
            power_mr = polyval(coef, spd); 
            EperDist = power_mr / spd;
            DistPerEner = 1 / EperDist;
            w = f(overlap,alpha) * DistPerEner;
            I = 1/s;
            y = w * I;
        end
    end
end

velocity = [2 4 6 8 10 12 14 16];
    power = [220  215 210  208 212 230 260 300];
    %plot(velocity, power, 'o');
    coef = polyfit(velocity,power,3);
    power_mr = @(speed) polyval(coef, speed); 

end