DatePicker = function() {
	this.datePicker = null;
	this.daysArray = null;
	this.monthsArray = null;
	this.selectedIndex = null;
	this.selectedDate = null;
	this.centralDate = null;
	this.displayDate = null;
}

DatePicker.prototype.initialize = function(datePickerDiv, displayDateDiv, userDate) {
	this.datePicker = datePickerDiv;
	this.displayDate = displayDateDiv;
	this.centralDate = userDate || new Date();
	this.setDaysAndMonthsArray();
	this.setDatePickerHtml();
	this.setWithCentralDate(this);
	this.selectDateColumn(3);
}

DatePicker.prototype.newDateFromDateAndDiffDays = function(oldDate, diffDays) {
	var newDate = new Date(oldDate);
	newDate.setDate(newDate.getDate() + diffDays );
	return newDate;
}

DatePicker.prototype.setDatePickerHtml = function() {
	this.setPrevWeekArrow(this);
	this.setNextWeekArrow(this);
	this.setDateTableHtml();
}

DatePicker.prototype.setDaysAndMonthsArray = function() {
	this.daysArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]	
	this.monthsArray = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
		"Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
}

DatePicker.prototype.compareDates = function(dateOne, dateTwo) {
	return dateOne.getFullYear() === dateTwo.getFullYear() 
		&& dateOne.getMonth() === dateTwo.getMonth()
		&& dateOne.getDate() === dateTwo.getDate()
}

DatePicker.prototype.setPrevWeekArrow = function(datePicker) {
	var prevArrowDiv = $("<div id=prev_week>")
	prevArrowDiv.html("<<");
	this.datePicker.append(prevArrowDiv);	
	prevArrowDiv.bind("click", function(event) {
		datePicker.moveDatePickerByAWeek("prev");
	});	
}

DatePicker.prototype.setNextWeekArrow = function(datePicker) {
	var nextArrowDiv = $("<div id=next_week>")
	nextArrowDiv.html(">>");
	this.datePicker.append(nextArrowDiv);	
	nextArrowDiv.bind("click", function(event) {
		datePicker.moveDatePickerByAWeek("next");
	});	
}

DatePicker.prototype.setDateTableHtml = function() {
	var dateTable = $("<table id=date_table>");
	var dayDiv, dateDiv, yearDiv;
	var tableColumn;
	
	for (var j = 1; j < 8; j++) {
		dayDiv = $("<div>").addClass("date_day_div");
		dateDiv = $("<div>").addClass("date_date_div");
	 	yearDiv = $("<div>").addClass("date_year_div");

		tableColumn = $("<td>").append(dayDiv, dateDiv, yearDiv);
		dateTable = dateTable.append(tableColumn);	  
	}
	this.datePicker.append(dateTable);		
}

DatePicker.prototype.setWithCentralDate = function(datePicker) {
	var daysDate;
	var tableColumns = this.datePicker.find("td");
	var dayString, dateString;
	
	
	for (var i=0; i < 7; i++) {
		daysDate = this.newDateFromDateAndDiffDays(this.centralDate, i-3)
				
		dayString = this.daysArray[daysDate.getDay()];
		dateString = this.monthsArray[daysDate.getMonth()] + " " + daysDate.getDate(); 

		tableColumn = tableColumns.first();
		tableColumn.find("div.date_day_div").html(dayString);		
		tableColumn.find("div.date_date_div").html(dateString);
		tableColumn.find("div.date_year_div").html(daysDate.getFullYear());

		tableColumn.bind("click", function(event) {
			datePicker.selectDateColumn($(event.target).closest("td").index());
		});
											
		tableColumns = tableColumns.next();
	};
}

DatePicker.prototype.selectDateColumn = function(index) {
	$("td.selected").removeClass();
	var tableColumn = this.datePicker.find("td:eq(" + index + ")");
	tableColumn.addClass("selected");
	this.selectedIndex = index;
	
	var oldSelectedDate = this.selectedDate;
	this.displayDate.val(this.getDateFromSelectedIndex());
	if (oldSelectedDate && !this.compareDates(oldSelectedDate, this.selectedDate))
		this.displayDate.trigger('date_change');
}

DatePicker.prototype.moveDatePickerByAWeek = function(direction) {
	var diffDays, newCentralDate;
	if (direction == "prev")
		diffDays = -7;
	if (direction == "next")
		diffDays = 7;
	
	this.centralDate = this.newDateFromDateAndDiffDays(this.centralDate, diffDays)		
	this.setWithCentralDate(this);
	this.selectDateColumn(this.selectedIndex);
}

DatePicker.prototype.getDateFromSelectedIndex = function() {
	this.selectedDate = this.newDateFromDateAndDiffDays(this.centralDate, 
		this.selectedIndex-3);
		
	var selectedDateString = this.daysArray[this.selectedDate.getDay()] + ", "
		+ this.selectedDate.getDate() + " " + this.monthsArray[this.selectedDate.getMonth()] 
		+ " " + this.selectedDate.getFullYear(); 
		
	return selectedDateString;
}

