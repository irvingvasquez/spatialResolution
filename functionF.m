% Copyright (c) 2016, J.I. Vasquez <ivasquez@ccc.inaoep.mx>
% Consejo Nacional de Ciencia y Tecnología
% Instiuto Politecnico Nacional
% Centro de Innovación y Desarrollo Tecnológico en Cómputo
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

% Evaluation function for overlap
% tested ok
function y = functionF(x, alpha)
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
