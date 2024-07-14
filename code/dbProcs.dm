proc
	_RowCount(string){
		#ifdef _MYSQL
		var
			DBI = "dbi:mysql:[MYSQL_DATABASE]:[MYSQL_HOSTNAME]:[MYSQL_PORT]"
			DBConnection/my_connection = new()
			connected = my_connection.Connect(DBI,MYSQL_USER,MYSQL_PASSWORD)

		if(!connected){ world.log << "MySQL Connection: [my_connection.ErrorMsg()]!"; }

		var/DBQuery/qry = my_connection.NewQuery(string)

		if(qry.Execute()) { return qry.RowCount() } else { world.log << "\[[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]\] [qry.ErrorMsg()]";return null }

		#else
		var
			database/query/q = new(string)
			rowCount = 0;

		if(q.Execute(game.DB)){
			while(q.NextRow()){
				rowCount++
			}
		}else{
			game.logger.error("([q.Error()]) - [q.ErrorMsg()] - [string]")
		}
		. = rowCount
		#endif
	}

	_rowCount(string){
		#ifdef _MYSQL
		var
			DBI = "dbi:mysql:[MYSQL_DATABASE]:[MYSQL_HOSTNAME]:[MYSQL_PORT]"
			DBConnection/my_connection = new()
			connected = my_connection.Connect(DBI,MYSQL_USER,MYSQL_PASSWORD)

		if(!connected){ world.log << "MySQL Connection: [my_connection.ErrorMsg()]!"; }

		var/DBQuery/qry = my_connection.NewQuery("SELECT * [string]")

		if(qry.Execute()) { return qry.RowCount() } else { world.log << "\[[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]\] [qry.ErrorMsg()]";return null }

		#else
		var
			database/query/q = _query("SELECT Count(*) [string]");
			list/rowData[] = list();

		q.NextRow();

		rowData = q.GetRowData();

		return rowData["Count(*)"];
		#endif
	}

	_query(string){
		#ifdef _MYSQL
		var
			DBI = "dbi:mysql:[MYSQL_DATABASE]:[MYSQL_HOSTNAME]:[MYSQL_PORT]"
			DBConnection/my_connection = new()
			connected = my_connection.Connect(DBI,MYSQL_USER,MYSQL_PASSWORD)

		if(!connected){ world.log << "MySQL Connection: [my_connection.ErrorMsg()]!"; }

		var/DBQuery/qry = my_connection.NewQuery(string)

		if(qry.Execute()) { return qry } else { world.log << "\[[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]\] [qry.ErrorMsg()]";return null }
		#else
		var/database/query/q = new(string)
		if(!q.Execute(game.DB)){
			game.logger.error("([q.Error()]) - [q.ErrorMsg()] - [string]")
			. = NULL;
		}else{
			. = q
		}
		#endif
	}