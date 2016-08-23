function E = ExpectedInfo(spd, height, interv)
    % number of samples
    n = 200;
    
    u = [spd; height; interv];
    Sigma = [1; 1; 0];
    
    for i=1:n
         [u_circunfleja, pdu]= sample(u, Sigma);
         Samples(:,i) = u_circunfleja;
         Probabilidades(:,i) = pdu; 
    end
    
    Suma = sum(Probabilidades,2);
    Escalar = 1./ Suma;
    Pspd = Escalar(1,1) * Probabilidades(1,:);
    Pheight = Escalar(2,1) * Probabilidades(2,:);
    Pinterv = Escalar(3,1) * Probabilidades(3,:);

    Pdu_circunfleja = Pspd' .* Pheight' .* Pinterv';
    eta = 1/sum(Pdu_circunfleja);
    Pdu_cir_norm = eta * Pdu_circunfleja;
    
    for i=1:n
        spd = Samples(1,i);
        height = Samples(2,i);
        interv = Samples(3,i);
        fit(i,1) = fitness(spd, height, interv);
    end
    
    E = sum(Pdu_cir_norm .* fit);
end