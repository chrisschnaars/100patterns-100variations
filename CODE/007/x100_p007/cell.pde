class Cell {

  float x, y;
  float wt, ht;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    wt = cellW;
    ht = cellH;
  }

  // CONFIGURE CELL PROPERTIES
  void configure() {

    // GENERATE ARCS ORIENTATION ID
    int c1 = floor(random(0, 4));

    render(c1);
  }

  // DRAW CELL
  void render(int c1) {

    // DRAWING SETTINGS
    pushMatrix();

    // ORIENT AT TOP LEFT CORNER
    translate(x, y);

    // GLOBAL CELL SETTINGS
    noFill();
    rectMode(CENTER);
    strokeWeight(8);
    strokeCap(SQUARE);

    // NUMBER OF ARCS PER CELL
    // 8 is good, probably the max.
    // 6, 4 is good
    int n = 6;

    // CALCULATE SPACE BETWEEN EACH ARC WITHIN CELL
    float r = wt / (n + 1);

    // ORIGIN POINT FOR EACH DIRECTION
    float[] orgX = { 0, wt, wt, 0 };
    float[] orgY = { 0, 0, ht, ht };

    // START AND STOP ANGLES FOR EACH DIRECTION
    float[] aStart = { radians(0), radians(90), radians(180), radians(270) };
    float[] aStop = { radians(90), radians(180), radians(270), radians(360) };

    // DRAW EACH ARC
    if (c1 >= 0) {
      for (int i=0; i<n; i++) {
        // CALC ARC RADIUS
        float l = (r + (r * i)) * 2;

        // GENERATE RANDOM COLOR FOR ARC
        int c2 = floor(random(0, colors.length - 1));
        stroke(colors[c2]);

        // DRAW ARC
        arc(orgX[c1], orgY[c1], l, l, aStart[c1], aStop[c1]);
      }
    }

    // END DRAWING
    popMatrix();
  }

}
