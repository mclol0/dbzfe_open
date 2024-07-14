proc/getNameFromDB(name) {
	var/rowCount = _rowCount("FROM `characters` WHERE `name`='[sanit(name)]' COLLATE NOCASE;")
	if (rowCount == 0) {
		return NULL
	}

	var/database/query/q = _query("SELECT * FROM `characters` WHERE `name`='[sanit(name)]' COLLATE NOCASE;")
	q.NextRow()
	var/list/rowData = q.GetRowData()

	return rowData["name"]

}