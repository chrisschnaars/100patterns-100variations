class Cell {

  float x, y;
  float w, h;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
  }

  // CONFIGURE CELL
  void configure() {

    // BACKGROUND DECIDER
    // OPTIONS: SLASH OR FULL RECTANGLE
    int bgDecider = floor(random(0, 10)); // give slash 2:1 odds

    // GENERATE SLASH ORIENTATION
    // OPTIONS: NORTH TO SOUTH, SOUTH TO NORTH
    int slashOrientation = floor(random(0, 2));

    // GENERATE BACKGROUND SHAPE
    // OPTIONS: RECTANGE, ELLIPSE, TRIANGE
    int shapeDecider = floor(random(0, 3));

    // GENERATE SHAPE STYLE DECIDER
    int shapeStyleDecider = floor(random(0, 10));

    // GENERATE BG AND SHAPE COLORS
    // NEED TO BE DIFFERENT
    int c1 = floor(random(0, shapeColors.length));
    int c2;
    do {
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW SHAPE
    render(bgDecider, slashOrientation, shapeDecider, shapeStyleDecider, c1, c2);

  }

  // DRAW CELL
  void render(int bgDecider, int slashOrientation, int shapeDecider, int shapeStyleDecider, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);

    // THRESHOLDS
    int t1 = 6; // THRESHOLD FOR DETERMINING SLASH OR RECT BG
    int t2 = 8; // TRESHOLD FOR DETERMINING FILL OR STROKE FOREGROUND SHAPE

    // SCALE VARIABLES
    float offset = w * 0.2; // OFFSET FROM CORNER. DETERMINES WIDTH OF SLASH
    float shapeScale = w * 0.5; // SCALE OF BACKGROUND SHAPE
    int strokeThin = 2;
    int strokeFat = 6;
    boolean drawBG = false;

    // GLOBAL CELL SETTINGS
    strokeWeight(strokeThin);

    // BACKGROUND CELL BORDER
    // FOR DEBUGGING PURPOSES
    if (drawBG) {
      fill(255);
      rect(0, 0, w, h);
    }


    /*
      DRAW BACKGROUND LAYER
    */

    // SET BACKGROUND COLOR
    noStroke();
    fill(shapeColors[c1]);

    // DRAW BACKGROUND
    if (bgDecider >= t1) {
      rect(0, 0, w, h);
    } else {

      // DRAW NORTH TO SOUTH SLASH
      if (slashOrientation == 0) {
        beginShape();
        vertex(0, 0);
        vertex(w, h - offset);
        vertex(w, h);
        vertex(0, offset);
        endShape(CLOSE);
      }

      // DRAW SOUTH TO NORTH SLASH
      if (slashOrientation == 1) {
        beginShape();
        vertex(0, h);
        vertex(w, offset);
        vertex(w, 0);
        vertex(0, h - offset);
        endShape(CLOSE);
      }
    }


    /*
      DRAW FOREGROUND SHAPE
    */

    // SET SHAPE COLORS
    // SHAPE ON BG FILL GETS STROKE. OTHERWISE FILL.
    if (bgDecider >= t1 || shapeStyleDecider >= t2) {
      noFill();
      stroke(shapeColors[c2]);
      strokeWeight(strokeFat);
    } else {
      noStroke();
      fill(shapeColors[c2]);
    }

    // SET SHAPE OFFSET FOR CENTERING IN CELL
    float p = (w - shapeScale) / 2;

    // SQUARE
    if (shapeDecider == 0) {
      rect(p, p, shapeScale, shapeScale);
    }

    // ELLIPSE
    if (shapeDecider == 1) {
      ellipse(w/2, h/2, shapeScale, shapeScale);
    }

    // TRIANGLE
    if (shapeDecider == 2) {
      // GENERATE TRIANGLE ORIENTATION
      // OPTIONS: NORTH, SOUTH
      int tOrientation = floor(random(0, 2));

      if (tOrientation == 0) {
        triangle(w/2, p, w-p, h-p, p, h-p);
      } else {
        triangle(w/2, h-p, p, p, w-p, p);
      }

    }



    // END DRAWING
    popMatrix();
  }

}
