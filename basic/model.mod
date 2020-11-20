param nRows  >=0, integer;
param cashierCount >=0, integer;
param cashierLength >=0;

set Rows := 1..nRows;

set ProductGroups;
param space{ProductGroups} >=0;

var assign{ProductGroups,Rows} >=0, binary;
var rowlength{Rows};
var longest;

s.t. AllProdusctsPlaced{p in ProductGroups}:
	sum{r in Rows} assign[p,r] = 1;

s.t. CashierRow {r in Rows: r<=cashierCount}:
	rowlength[r] = cashierLength + (sum{p in ProductGroups} assign[p,r]*space[p]);

s.t. SimpleRow {r in Rows: r>cashierCount}:
	rowlength[r] = sum{p in ProductGroups} assign[p,r]*space[p];

s.t. LongestRow{r in Rows}:
	 longest >= rowlength[r];

minimize BuildingLength:
	longest;

solve;

printf "%f\n",BuildingLength;
