BeginPackage["test`utils`NamesCheck`"];
If[ToExpression["test`utils`NamesCheck`Private`isLoaded"] === True, Goto[`Private`end]];

(*dependencies of this module*)
`Private`dependence = {"core`Utils`", "core`Debug`"};

core`Src`loadDependencies[`Private`dependence];

debug["begin of ", $Context, {"msg",4}];

(*enter code here*)
`Private`ExistUsageQ[name_String] :=
    If[StringTake[name, -1] != "$",
      StringQ[ToExpression[name <> "::usage"]], True];
`Private`filterFunctions = If[`Private`ExistUsageQ[#], Nothing, #] &;

contextNamesCheck::usage = "contextNamesCheck[]";
contextNamesCheck[package_String] := (
(*Get["main/" <> package <> ".m"];*)
  names = Names[StringReplace[package, "/" -> "`"] <> "`*"];
  `Private`filterFunctions /@ names)



(*local variables to be removed*)
Remove /@ {name,names,package};

`Private`isLoaded = True;

debug["end of ", $Context, {"msg",4}];
Label[`Private`end];
EndPackage[];
$ContextPath = Delete[$ContextPath, Position[$ContextPath, "test`utils`NamesCheck`"]];