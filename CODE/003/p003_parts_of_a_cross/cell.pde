class Cell {

  float x, y;
  float wt, ht;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    wt = cellW;
    ht = cellH;
  }

  void configure() {
    // GENERATE DECIDER FOR SHAPE CONFIGURATION
    float t = floor(random(0, 2));

    // GENERATE DECIDER TO DRAW EACH LINE
    float n = random(-1, 1); // NORTH LINE
    float e = random(-1, 1); // EAST LINE
    float s = random(-1, 1); // SOUTH LINE
    float w = random(-1, 1); // WEST LINE

    // GENERATE COLOR ID
    int c = floor(random(0, colors.length));

    render(t, n, e, s, w, c);
  }

  void render(float t, float n, float e, float s, float w, int c) {

    // START DRAWING
    pushMatrix();

    // GLOBAL CELL SETTINGS
    noFill();
    strokeWeight(12);
    strokeCap(ROUND);

    // SET COLOR
    stroke(colors[c]);

    // CREATE LENGTH OF LINE VARIABLE
    float l = wt/2;

    // SET ORIENT TO CELL CENTER
    translate(x + wt/2, y + ht/2);

    // RECTANGE ORIENTED AROUND CELL BORDER
    if (t == 0) {
      // NORTH LINE
      if (n > 0) {
        line(0, 0, 0, -l);
      }

      // EAST
      if (e > 0) {
        line(0, 0, l, 0);
      }

      // SOUTH
      if (s > 0) {
        line(0, 0, 0, l);
      }

      if (w > 0) {
        line(0, 0, -l, 0);
      }
    }

    // RECTANGLE ROTATED 45 DEGREES
    if (t==1) {
      // NE LINE
      if (n > 0) {
        line(0, -l, l, 0);
      }

      // SE
      if (e > 0) {
        line(l, 0, 0, l);
      }

      // SW
      if (s > 0) {
        line(0, l, -l, 0);
      }

      // NW
      if (w > 0) {
        line(-l, 0, 0, -l);
      }
    }

    // END DRAWING
    popMatrix();


  }
}
