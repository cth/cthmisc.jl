module cthmisc
	export  joincmds,mkdir_ifnot

	"joincmds(cmds): stitch together an array of commands"
	joincmds(cmds) = foldl((cmd1,cmd2)->`$cmd1 $cmd2`, ``, cmds)

	# Filesystem stuff
	"mkdir_ifnot(dir): Create directoy if it does not exist"
	mkdir_ifnot(dir) = if (!isdir(dir)) mkdir(dir) end


function mean_imputation!(data::DataFrame,key::Symbol)
	cohort_mean = by(data, :cohort, x->mean(map(Float32, x[find(!isna(x[:,key])),key])))
	cohort_mean_dict = Dict(zip(cohort_mean[:cohort], cohort_mean[:x1]))
	println(cohort_mean_dict)
	data[key] = map(1:nrow(data)) do i
		if isna(data[i,key])
			value = cohort_mean_dict[data[i,:cohort]]
			isnan(value) ? NA : value
		else
			data[i,key]
		end
	end
end


rank_inverse_transform(dist::Distribution, x) = quantile(dist,  (tiedrank(x) - 0.5) / length(x))

inverse_normal_transform(x::Array) = rank_inverse_transform(Normal(), x)

function inverse_normal_transform(x::DataArray)
	y  = copy(x)
	y[!isna(y)] = rank_inverse_transform(Normal(), dropna(x))
		    return y 
	    end

end # module
