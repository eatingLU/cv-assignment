function score = getCorrelation(method, regionLeft, regionRight, meanLeft, meanRight)
  if strcmp(method,'SAD')
      tempCorrScore = abs(regionLeft - regionRight); % implement yourself!!!
  elseif strcmp(method,'ZSAD')
      tempCorrScore = abs(regionLeft - meanLeft - regionRight + meanRight);
  elseif strcmp(method,'LSAD')
      tempCorrScore = abs(regionLeft - meanLeft/meanRight*regionRight);
  elseif strcmp(method,'SSD')
      tempCorrScore = (regionLeft - regionRight).^2;
  elseif strcmp(method,'ZSSD')
      tempCorrScore = (regionLeft - meanLeft - regionRight + meanRight).^2;
  elseif strcmp(method,'LSSD')
      tempCorrScore = (regionLeft - meanLeft/meanRight*regionRight).^2;
  elseif strcmp(method,'NCC')
      % Calculate the term in the denominator (var: den)
      den = sqrt(sum(sum(regionLeft.^2))*sum(sum(regionRight.^2)));
      tempCorrScore = regionLeft.*regionRight/den;
  elseif strcmp(method,'ZNCC')
      % Calculate the term in the denominator (var: den)
      den = sqrt(sum(sum((regionLeft - meanLeft).^2))*sum(sum((regionRight - meanRight).^2)));
      tempCorrScore = (regionLeft - meanLeft).*(regionRight - meanRight)/den;
  end
  score = sum(sum(tempCorrScore));
