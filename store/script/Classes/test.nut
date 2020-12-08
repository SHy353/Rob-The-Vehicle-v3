local styleTable = {
	background = Colour(51,57, 61,200),
	headerTextColor = Colour(51,150,255),
	cellTextColor = Colour(255,255,255),
	headerTextSize =  20,
	cellTextSize =  12,
	selectedRowColor = Colour(52,129,216,80)
}
// creating a datable and applying the style table
UI.DataTable({
	id="tbl",
	align =  "center",
	rows =  10,
	style = styleTable
	columns = [
		{ header =  "Name", field =  "col0"},
		{ header =  "Kills", field =  "col1"},
		{ header =  "Deaths", field =  "col2" },
		{ header =  "Score", field =  "col3" },
	]
	data = [
		{ col0 = "[#ff3322]Test", col1 =  "val1", col2 =  "val22" , col3 =  "val3"},
		{ col0 = "Test", col1 =  "val1", col2 =  "val22" , col3 =  "val3"},
		{ col0 = "Test", col1 =  "val2", col2 =  "abc", col3 =  "val3"},
		{ col0 = "Test", col1 =  "val3", col2 =  "val2", col3 =  "val3"}
	]
});