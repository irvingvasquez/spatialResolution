function [s overlap] = resolution(spd, height, interv)
% Camera parameters
s_pix = 0.00121; % pixel resolution in mm
f = 3.97; %focal lenght in mm
h_s = 3.68; %sensor height

s = s_pix * height * 1000 / f;

d = spd * interv;
overlap = 1 - (d *1000 *f)/(h_s*height*1000);
end