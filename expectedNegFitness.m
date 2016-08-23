function value = expectedNegFitness(A)
[m,n] = size(A);

interv = 3;

for i=1:m
    value(i) = -ExpectedInfo(A(i,1),A(i,2),interv);
end
end