module cthmisc
	using DataFrames
	export merge_columns!,indexer
	include("dataframes.jl")


	using Distributions
	export inverse_normal_transform, mean_imputation!, group_mean_imputation!
	include("statistics.jl")


	export  joincmds,mkdir_ifnot,parse_danish_float
	include("other.jl")
end # module
