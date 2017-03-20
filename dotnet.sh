_dotnet()
{
	local cur prev prev2 cmd opts
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	prev2="${COMP_WORDS[COMP_CWORD-2]}"
	cmd=$"${COMP_WORDS[1]}"

	case "${cmd}" in
		new)
			_dotnet_new
		;;

		restore)
			_dotnet_restore
		;;

		build)
			_dotnet_build
		;;

		publish)
			_dotnet_publish
		;;

		run)
			_dotnet_run
		;;

		test)
			_dotnet_test
		;;	

		pack)
			_dotnet_pack
		;;

		migrate)
			_dotnet_migrate
		;;
		
		clean)
			_dotnet_clean
		;;

		sln)
			_dotnet_sln
		;;

		add)
			_dotnet_add
		;;

		remove)
			_dotnet_remove
		;;

		list)
			_dotnet_list
		;;

		*)
		;;
	esac

	if [[ ${prev} == dotnet ]] ; then
		opts="new restore build publish run test pack migrate clean sln add remove list nuget msbuild vstest"
		COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
		return 0
	fi

}

_dotnet_new()
{
	case "${prev}" in 
		new)
			opts="console classlib mstest xunit web mvc webapi sln"
			COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
			return 0
		;;

		--language)
			opts="$(_get_languages ${prev2})"
			COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
			return 0
		;;

		*)
			opts="--list --language --name --output --help"
			COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
			return 0
		;;
	esac
}

_get_languages()
{
	local template
	template=$1

	if [[ "web webapi" == *${template}* ]] ; then
		echo "C#"
		return 0
	fi

	echo "C# F#"
	return 0
}

_dotnet_restore()
{
	#TODO
	return 0;
}

_dotnet_build()
{
	#TODO
	return 0;
}

_dotnet_publish()
{
	#TODO
	return 0;
}

_dotnet_run()
{
	#TODO
	return 0;
}

_dotnet_test()
{
	#TODO
	return 0;
}

_dotnet_pack()
{
	#TODO
	return 0;
}

_dotnet_migrate()
{
	#TODO
	return 0;
}

_dotnet_clean()
{
	#TODO
	return 0;
}

_dotnet_sln()
{
	#TODO
	return 0;
}


_dotnet_add()
{
	case "${prev}" in
		add)
			opts="package reference"
			COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
			return 0
		;;

		package)
			opts="$(curl -s https://api-v2v3search-0.nuget.org/autocomplete?q=${cur} | grep -Po '\[.*?\]' | grep -Po '(?<=").*?(?=")' | grep -Po '^[^,]+$' | sort)"
			COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
			return 0
		;;

		--version)
			opts="$(curl -s https://api-v2v3search-0.nuget.org/autocomplete?id=${prev2} | grep -Po '\[.*?\]' | grep -Po '(?<=").*?(?=")' | grep -Po '^[^,]+$' | sort)"
			COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
			return 0
		;;

		*)
			opts="--version"
			COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
			return 0
		;;
	esac
}

_dotnet_remove()
{
	#TODO
	return 0;
}

_dotnet_list()
{
	if [[ ${prev} == list ]] ; then
		opts="$(find . -name \*.csproj -print)"
		COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
		return 0
	else
		opts="reference"
		COMPREPLY=( $(compgen -W "${opts}" ${cur}) )
		return 0
	fi
}

complete -F _dotnet dotnet