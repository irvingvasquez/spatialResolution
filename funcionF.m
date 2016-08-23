function y = funcionF(x, alpha)
    if (x >=0 && x <= alpha)
        a0 = -2/(alpha.^3); 
        a1 = 3/(alpha.^2);
        y = a0 * x.^3 + a1 * x.^2;
    else if (x>alpha && x<=1)
            amuc = (alpha - 1).^3;
            a0 = -2/amuc;
            a1 = (3*(alpha+1))/amuc;
            a2 = -(6*alpha)/amuc;
            a3 = (3*alpha-1)/amuc;
            y = a0*x.^3 + a1*x.^2 + a2*x + a3;
        else
            y = 0;
        end
    end
end