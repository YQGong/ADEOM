Global`$PackageDir = DirectoryName[
  $InputFileName /. HoldPattern[$InputFileName] :>
      (File /. FileInformation[System`Private`FindFile[$Input]]) ];
DistributeDefinitions[Global`$PackageDir];

SetAttributes[`Private`doNothing,HoldAll];
`Private`doNothing[___]=Null;

If[ToString[Definition[Global`debugf]] === "Null",
  Global`debugf=Print;
  ParallelEvaluate[Global`debugf=`Private`doNothing]];
SetAttributes[Global`debugf,HoldAll];

Get["main/core/Init.m"];
ParallelEvaluate[Get["main/core/Init.m"];];