BeginPackage["ADEOM`"];

core`debug`typeList={"msg","val","usr"};
DistributeDefinitions[core`debug`typeList];

(*Print[core`debug`typeList];*)

Global`$PackageDir = DirectoryName[
  $InputFileName /. HoldPattern[$InputFileName] :>
      (File /. FileInformation[System`Private`FindFile[$Input]]) ];
DistributeDefinitions[Global`$PackageDir];

(*Print[Global`$PackageDir];*)

Get["main/core/Init.m"];

(*Remove[context];*)

EndPackage[];