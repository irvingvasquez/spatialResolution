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

function g = g_utility_OC(Q, Cam, UAV, alpha, Coef)
    spd = Q(1);
    height = Q(2);
    interv = Q(3);

    % Restrictions
    v0 = UAV(1);
    v1 = UAV(2);
    t0 = Cam(4);
    h0 = UAV(3);
    h1 = UAV(4);

    if( spd<v0 || spd>v1 )
        g = 0;
    else if(interv < t0)
            g = 0;
        else
            if(height < h0 || height > h1)
                g = 0;
            else
                [s, overlap] = resolution(Q, Cam);
                power_mr = polyval(Coef, spd);
                EperDist = power_mr / spd;
                DistPerEner = 1 / EperDist;
                w = functionF(overlap,alpha) * DistPerEner;
                I = 1/s;
                g = w * I;
            end
        end
    end
end