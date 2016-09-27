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

function value = fitnessFunction_OC(A)
[m,n] = size(A);

% Experiment configuration

% Camera parameter: Cam = [f; h_s; s_pix, t0]
%GOPRO4 Silver parameters:
GOPRO4 = [1.6976; 4.65; 0.00155; 1];
MAPPIR = [3.97; 3.68; 0.00121; 3];
Cam = GOPRO4;

% UAV parameters: UAV = [v0; v1; h0; h1]
% 3DR Solo parameters
UAV = [0; 20; 30; 100];

% Desired overlap: alpha
alpha = 0.8;

% number of samples: n
n = 250;

% Sigma = [sigma_spd; sigma_height; sigma_t]
Sigma = [1; 3; 0];

velocity = [2 4 6 8 10 12 14 16];
power = [220  215 210  208 212 230 260 300];
    %plot(velocity, power, 'o');
Coef = polyfit(velocity,power,3);
    %power_mr = @(speed) polyval(coef, speed); 

    for i=1:m
        %value(i) = -ExpectedInfo(A(i,1),A(i,2),A(i,3));
        
        
        spd = A(i,1);
        height = A(i,2);
        interv = A(i,3);
        Q = [spd; height; interv];

        value(i) = -expectedG_OC(Q, Cam, UAV, alpha, n, Sigma, Coef);
    end
end