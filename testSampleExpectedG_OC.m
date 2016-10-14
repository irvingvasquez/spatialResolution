%TODO: Revisar que las muestras no varien en interv
clear;

% Experiment configuration

% Camera parameter: Cam = [f; h_s; s_pix, t0]
%GOPRO4 Silver parameters:
GOPRO4 = [1.6976; 4.65; 0.00155; 1];
MAPPIR = [3.97; 3.68; 0.00121; 3];
TETRACAM_MICRO = [8.43; 4.92; 0.0032; 3];

%Cam = MAPPIR;
Cam = GOPRO4;
%Cam = TETRACAM_MICRO;

% UAV parameters: UAV = [v0; v1; h0; h1]
% 3DR Solo parameters
UAV = [0; 24; 40; 120];

% Desired overlap: alpha
alpha = 0.8;

% number of samples: n
n = 250;

% Sigma = [sigma_spd; sigma_height; sigma_t]
Sigma = [1; 3; 0];

SPD = UAV(1):0.25:UAV(2);
nn=size(SPD,2);

H = UAV(3):2.5:UAV(4);
m = size(H,2);

velocity = [2 4 6 8 10 12 14 16];
power = [220  215 210  208 212 230 260 300];
Coef = polyfit(velocity,power,3);

interv = 3;

for(i=1:m)
    for(j=1:nn)
        Q = [SPD(j);H(i);interv];
        EI(i,j) = expectedG_OC(Q, Cam, UAV, alpha, n, Sigma, Coef);
        %EI(i,j) = ExpectedInfo(SPD(j),H(i),interv);
    end
end

figure
mesh(SPD,H,EI);

figure
contour(SPD,H,EI,10);
hold on
%plot3(5,35,-0.02698);
xlabel('Speed');ylabel('Height');