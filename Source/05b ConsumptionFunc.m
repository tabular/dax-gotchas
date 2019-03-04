let
    GetData = (PartitionBucket as text) =>
	let
	    DaxQueryPart1 = "EVALUATE CALCULATETABLE ( 'Consumption', 'Consumption'[Partition Bucket] = ",
	    DaxQueryPart3 = " )#(lf)",
	    DaxQuery = DaxQueryPart1 & PartitionBucket & DaxQueryPart3,
	    Consumption = AnalysisServices.Database(RandomServer, RandomDatabase, [Query=DaxQuery, Implementation="2.0"])
	in Consumption
in GetData