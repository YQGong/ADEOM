BeginPackage["core`Init`"];

Get[FileNameJoin[{Global`$PackageDir,"main","core","Utils.m"}]];
Get[FileNameJoin[{Global`$PackageDir,"main","core","Debug.m"}]];
Get[FileNameJoin[{Global`$PackageDir,"main","core","Src.m"}]];

(*local variables to be removed*)
Remove /@ {};

`Private`isLoaded = True;
EndPackage[];