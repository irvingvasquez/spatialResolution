function y = fitnessSpd(spd, height, interv)
% Constants
alpha = 0.6;
v_star = 12;

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
            v_star_norm = (v_star - v0)/(v1 - v0);
            spd_norm = (spd - v0)/(v1 - v0);
            w = f(overlap,alpha) .* f(spd_norm,v_star_norm);
            I = 1/s;
            y = w * I;
        end
    end
end

end