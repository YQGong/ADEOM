BeginPackage["test`utils`NamesCheck`"];

(*dependencies of this module*)
`Private`dependence = {"core`Utils`", "core`Debug`"};

core`Src`loadDependencies[`Private`dependence];

debug["begin of ", $Context, {"msg",4}];

`Private`moduleVariableQ[name_String] :=
    Module[{dolarPosition, tail},
      If[StringPosition[name, "$"]=!={} && StringPosition[name, "$"][[1, 1]] =!= 1,
        dolarPosition = StringPosition[name, "$"][[-1, 1]];
        tail = StringTake[name, {dolarPosition + 1, -1}];
        StringMatchQ[tail, RegularExpression["[0-9]*"]], False]
    ];

`Private`ExistUsageQ[name_String] :=Head@ToExpression[name <> "::usage"]=!=MessageName;

`Private`filterFunctions = If[
  StringTake[#, -1] === "$" || `Private`moduleVariableQ[#] || `Private`ExistUsageQ[#], Nothing, #] &;

contextNamesCheck::usage = "contextNamesCheck[]";
contextNamesCheck[package_String] := Module[{names},
  names = Names[StringReplace[package, "/" -> "`"] <> "`*"];
  `Private`filterFunctions /@ names];

(*local variables to be removed*)
Remove /@ {name,names,package,dolarPosition,tail};

`Private`isLoaded = True;

debug["end of ", $Context, {"msg",4}];
EndPackage[];
$ContextPath = Delete[$ContextPath, Position[$ContextPath, "test`utils`NamesCheck`"]];