BeginPackage["core`Init`"];
If[ToExpression["core`Init`Private`isLoaded"] === True,Goto[`Private`end]];

Get[FileNameJoin[{Global`$PackageDir,"main","core","Utils.m"}]];
Get[FileNameJoin[{Global`$PackageDir,"main","core","Debug.m"}]];
Get[FileNameJoin[{Global`$PackageDir,"main","core","Src.m"}]];

(*local variables to be removed*)
Remove /@ {};

`Private`isLoaded = True;
Label[`Private`end];
EndPackage[];