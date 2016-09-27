function value = expectedNegFitnessDPE(A)
[m,n] = size(A);

%interv = 3;

    for i=1:m
        %value(i) = -ExpectedInfo(A(i,1),A(i,2),interv);
        value(i) = -ExpectedInfoDistPE(A(i,1),A(i,2),A(i,3));
    end
end