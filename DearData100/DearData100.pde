ArrayList<Movement> moves = new ArrayList<Movement>();

void setup() {
  pixelDensity(1);
  size(1000, 700);

  Table table = loadTable("movement.csv", "header");

  for (TableRow row : table.rows()) {
    // skip any blank rows (Excel often adds one at the end)
    String idText = row.getString("ID");
    if (idText == null || idText.trim().length() == 0) continue;

    moves.add(new Movement(
      row.getInt("ID"),
      row.getString("Date").trim(),
      row.getString("Time").trim(),
      row.getInt("Step_Count"),
      row.getString("Context").trim(),
      row.getString("Pace").trim(),
      row.getString("Weather").trim()
    ));
  }

  // place items in a simple grid
  int cols = 15;
  for (int i = 0; i < moves.size(); i++) {
    float x = 55 + (i % cols) * 63;
    float y = 90 + (i / cols) * 85;
    moves.get(i).setPosition(x, y);
  }
}

void draw() {
  background(20);
  for (Movement m : moves) {
    m.display();
  }
  fill(255);
  textSize(16);
  text("n = " + moves.size(), 20, 30);
}

class Movement {
  int id, steps;
  String date, time, context, pace, weather;
  float x, y, size;
  color col;

  Movement(int id, String date, String time, int steps,
           String context, String pace, String weather) {
    this.id = id;
    this.date = date;
    this.time = time;
    this.steps = steps;
    this.context = context;
    this.pace = pace;
    this.weather = weather;

    size = map(steps, 400, 6500, 8, 55);   // size = steps

    if (weather.equals("Clear")) col = color(255, 200, 50);
    else if (weather.equals("Cloudy")) col = color(160, 170, 190);
    else col = color(70, 130, 220);        // Rainy
  }

  void setPosition(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    noStroke();
    fill(col);
    ellipse(x, y, size, size);
  }
}
