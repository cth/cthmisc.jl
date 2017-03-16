### Statistics

rank_inverse_transform(dist::Distribution, x) = quantile(dist,  (tiedrank(x) - 0.5) / length(x))

inverse_normal_transform(x::Array) = rank_inverse_transform(Normal(), x)

function inverse_normal_transform(x::DataArray)
	y  = copy(x)
	y[!isna(y)] = rank_inverse_transform(Normal(), dropna(x))
	return y 
end



## FIXME: These functions needs cleanup!

function mean_imputation!(data::DataFrame,key::Symbol)
	mean_value = mean(map(Float32, x[find(!isna(x[:,key])),key]))
	data[key] = map(1:nrow(data)) do i
		if isna(data[i,key])
			value = group_mean_dict[data[i,groupby]]
			isnan(value) ? NA : value
		else
			data[i,key]
		end
	end
end

function group_mean_imputation!(data::DataFrame,key::Symbol, groupby::Symbol)
	group_mean = by(data, groupby, x->mean(map(Float32, x[find(!isna(x[:,key])),key])))
	group_mean_dict = Dict(zip(group_mean[groupby], group_mean[:x1]))
	data[key] = map(1:nrow(data)) do i
		if isna(data[i,key])
			value = group_mean_dict[data[i,groupby]]
			isnan(value) ? NA : value
		else
			data[i,key]
		end
	end
end
