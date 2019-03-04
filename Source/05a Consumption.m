let
    Source = List.Generate(()=>0, each _ < 1000, each _ + 1),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Changed Type" = Table.TransformColumnTypes(#"Converted to Table",{{"Column1", type text}}),
    #"Invoked Custom Function" = Table.AddColumn(#"Changed Type", "ConsumptionFunc", each ConsumptionFunc([Column1])),
    #"Removed Other Columns" = Table.SelectColumns(#"Invoked Custom Function",{"ConsumptionFunc"}),
    #"Expanded ConsumptionFunc" = Table.ExpandTableColumn(#"Removed Other Columns", "ConsumptionFunc", {"Consumption[Partition Bucket]", "Consumption[SSN]", "Consumption[Date]", "Consumption[Cups Count]"}, {"Consumption[Partition Bucket]", "Consumption[SSN]", "Consumption[Date]", "Consumption[Cups Count]"}),
    #"Removed Columns" = Table.RemoveColumns(#"Expanded ConsumptionFunc",{"Consumption[Partition Bucket]"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"Consumption[SSN]", "SSN"}, {"Consumption[Date]", "Date"}, {"Consumption[Cups Count]", "Cups Count"}}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Renamed Columns",{{"Cups Count", Int64.Type}, {"Date", type date}, {"SSN", Int64.Type}})
in  
    #"Changed Type1"