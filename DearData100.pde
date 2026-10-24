Table table;
void setup() {
  size(600, 400);
  // load the CSV data file from the sketch folder
  table= loadTable("dear data project.csv", "header");
  
  if(table!= null) {
    println("Successfully loaded " + table.getRowCount() + "rows of data.");
  } else {
  println("Error: Could not load CSV file.");
  }
  
  int totalSteps= getTotalSteps();
  println("Total steps recorded: " + totalSteps);
}

void draw() {
  background(240);
  fill(0);
  textSize(18);
  if (table != null) {
    text("Dear Data 100 - Loaded " + table.getRowCount() + " entries", 30, 50);
    text("Total Steps Logged: " + getTotalSteps(), 30, 90);
  } else {
    text("Data file not found!", 30, 50);
  }
}

int getTotalSteps() {
  int sum =0;
  for(TableRow row : table.rows()) {
    sum += row.getInt("Step_Count");
  }
  return sum;
}
