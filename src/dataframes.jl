### Dataframes

"merge_columns! merges data from from two columns of a dataframe into the first given column and drops the latter column. It will throw an error if data is conflicting, or if preference is given it will pick the preference column."
function merge_columns!(dataframe, keep,drop ; preference = :none)
	@assert preference == :none || preference == keep || preference == drop
	dataframe[keep] = map(1:nrow(dataframe)) do i
		a=dataframe[i,keep]
		b=dataframe[i,drop]
		if (isna(a) && isna(b))
			NA
		elseif(isna(a))
			b
		elseif(isna(b))
			a
		elseif a==b
			a
		elseif preference == :none
			throw(error(string("Cannot merge conflicting values: ", a, " with ", b)))
		else
			dataframe[i,preference]
		end
	end
	delete!(dataframe, drop)
end

"indexer returns a function (closure with a dict) that returns the row-index of the element in the dataframe in constant time"
function indexer(df::DataFrames.DataFrame, column::Symbol)
	d=Dict(map(x->(df[x,column],x), 1:nrow(df)))
	column_indexer_function(i) = if i in keys(d) d[i] else NA end
end
