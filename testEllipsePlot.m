% thanks to AJ Johnson for this function

covar = [
    [1, 0],
    [0, 1]
    ];

covar = [
    [eps, eps],
    [eps, eps]
    ];


%handle = ERROR_ELLIPSE(covar);
handle = error_ellipse(covar);

get(handle);

plot(handle);

