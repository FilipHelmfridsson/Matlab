
% För framåt Euler gäller att metoden är stabil om absolutbeloppet av (1 + h·λ) är mindre än 1.
% Sätter man in λ = −3/4 från differentialekvationen får man att steglängden h (steglängden) måste vara mindre än ungefär 2,67 
% för att metoden ska vara stabil.

% Eftersom slutvärdet är T = 24 och steglängden definieras som h = 24 / n blir det stabilt om n är större än 9 dvs i vårt 
% tidigare fall med en dubblerande antal steg skulle det bli 16.

% Den teoretiska stabilitetsgränsen för framåt Euler är h < 8/3 ≈ 2.67, medan bakåt Euler är stabil för alla h.
% För att testa detta kör man båda programmen med steglängder nära gränsen, t.ex. 
% h = 2.4, 2.7, 3.0 dvs  n = 10, 8.89, 8
% Man observerar då att framåt Euler blir instabil (lösningen växer okontrollerat) när h > 2.67, 
% medan bakåt Euler förblir stabil även vid stora steg.