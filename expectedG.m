% Copyright (c) 2016, J.I. Vasquez <ivasquez@ccc.inaoep.mx>
% All rights reserved.
%   
% BSD License
%  
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%      * Redistributions of source code must retain the above copyright
%      notice, this list of conditions and the following disclaimer.
%      * Redistributions in binary form must reproduce the above copyright
%      notice, this list of conditions and the following disclaimer in the
%      documentation and/or other materials provided with the distribution.
%      * Neither the name of the <organization> nor the
%      names of its contributors may be used to endorse or promote products
%      derived from this software without specific prior written permission.
%  
%  THIS SOFTWARE IS PROVIDED BY <copyright holder> <email> ''AS IS'' AND ANY
%  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%  DISCLAIMED. IN NO EVENT SHALL <copyright holder> <email> BE LIABLE FOR ANY
%  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
%  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


% Config parameter: Q = [spd; height, interv]
% Camera parameter: Cam = [f; h_s; s_pix, t0]
% UAV parameters: UAV = [v0; v1; h0; h1]
% Desired overlap: alpha
% number of samples: n
% Sigma = [sigma_spd; sigma_height; sigma_t]

function E = expectedG(Q, Cam, UAV, alpha, n, Sigma)
    %TODO: cambiar u por Q
    %u = [spd; height; interv];
    %Sigma = [1; 3; 0];
    
    for i=1:n
         [u_circunfleja, pdu]= sample(Q, Sigma);
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
        Q = Samples(:,i);
        %spd = Samples(1,i);
        %height = Samples(2,i);
        %interv = Samples(3,i);
        fit(i,1) = g_utility(Q, Cam, UAV, alpha);
    end
    
    E = sum(Pdu_cir_norm .* fit);
end
