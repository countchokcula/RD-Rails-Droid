installdb(){
	if [ -d "db" ]; then
		echo "Do you want to reinstall current database directory?[y/n]"
		read input
		if [ "$input" == y ]; then
			echo Reinstalling database
			rm -rf "db"
			mkdir "db"
			cd "db"
			initdb .
			postgres -d .
		fi
	else
		echo Creating database...
		rm -rf "db"
	        mkdir "db"
		cd "db"
		initdb .
		postgres -d .
		echo Database has been created
	fi
}
dependencies(){
	gem_list=(ffi pkg-config uglifier)
	apt_list=(postgresql-dev postgresql ruby ruby-dev python python-dev clang make libllvm pkg-config libxslt-dev libffi-dev nodejs libffi)
	cd
	for i in "${apt_list[@]}"
	do
		apt install $i -y
	done
	for i in "${gem_list[@]}"
	do
		gem install $i
	done
	echo Done!
}
dependencies
installdb
gem install nokogiri -- --use-system-libraries
gem install rails
