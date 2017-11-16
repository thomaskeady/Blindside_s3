function toReturn = makeInt(notInt)
    while (0 ~= notInt - floor(notInt))
        notInt = notInt * 10;
    end
    toReturn = notInt;
end