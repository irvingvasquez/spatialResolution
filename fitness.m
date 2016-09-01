function y = fitness(spd, height, interv)
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
            w = f(overlap,alpha);
            I = 1/s;
            y = w * I;
        end
    end
end

end