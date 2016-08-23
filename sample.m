function [u, pdu] = sample(u, SIGMA)
  epsilon = zeros(3,1);
  pdu = zeros(3,1);
  n = size(SIGMA,1);
  dens = 0;
  
  for i =1:n
    if SIGMA(i,1)==0
        epsilon(i,1) = 0;
        dens = 1;
    else
        epsilon(i,1) = normrnd(0, SIGMA(i,1));
        dens = normpdf(epsilon(i,1),0,SIGMA(i,1));
    end
    
    pdu(i,1) = dens;
  end
  
  u = u + epsilon;
end