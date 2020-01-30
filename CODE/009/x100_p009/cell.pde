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

    // GENERATE BACKGROUND COLOR ID
    int c1 = floor(random(0, colors.length));

    // GENERATE UNDERLYING RECTANGLE COLOR ID
    int c2;
    do {
     c2 = floor(random(0, colors.length));
    } while (c2==c1);

    //// GENERATE OVERLAPPING PIE COLOR ID
    //int c3;
    //do {
    //  c3 = floor(random(0, shapeColors.length));
    //} while (c3==c1 || c3==c2);

    // CREATE SHAPE
    render(c1, c2);
  }

  // DRAW CELL
  void render(int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT CENTER
    translate(x+wt/2, y+ht/2);

    // GLOBAL CELL SETTINGS
    rectMode(CENTER);
    noStroke();

    // DRAW CELL BACKGROUND
    fill(colors[c2]);
    rect(0, 0, wt, ht);

    // CALCULATE RANDOM SIDE
    float w = wt * random(1, 1);

    // DRAW UNDERLYING ELLIPSE
    //fill(shapeColors[0]);
    //ellipse(0, 0, w, w);

    // DRAW OVERLAID PIE
    float n = 4;  // NUMBER OF STARTING POINTS FOR ARC
    float r = 360 / n;  // SPACE BETWEEN EACH STARTING POINT

    // GENERATE A RANDOM STARTING POINT
    float s = floor(random(0, n));  // pick from total start locations
    //s = 3;
    float startAngle = r * s; // calculate angle

    // CALCULATE END ANGLE
    float e = floor(random(0, 3));  // units of 90
    //e = 2;
    float endAngle = startAngle + (90 + (e * 90));
    //if (endAngle >= 360) {
    //  endAngle-=360;
    //}

    fill(colors[c1]);
    arc(0, 0, w, w, radians(startAngle), radians(endAngle));
    //arc(0, 0, wt, ht, radians(270), radians(360 + 180));

    // END DRAWING
    popMatrix();
  }
}
