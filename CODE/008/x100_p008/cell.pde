class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  int cId, rId; // column and row ids
  int sW;

  Cell(float _x, float _y, int _cId, int _rId) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
    sW = 4; // stroke weight
  }

  // CONFIGURE CELL
  void configure() {

    // BG DISPLAY ID
    int b = floor(random(0, 10));

    // BACKGROUND SHAPE ORIENTATION
    // OPTIONS: HORIZONTAL OR VERTICAL
    int o = floor(random(0, 2));
    int o2 = floor(random(0, 2));

    // BACKGROUND SHAPE STYLE ID
    // OPTIONS: STROKE OR FILL
    int s = floor(random(0, 10));

    // ARC DISPLAY ID
    int a = floor(random(0, 10));

    // COLORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(b, o, o2, s, a, c1, c2);
  }

  // DRAW CELL
  void render(int b, int o, int o2, int s, int a, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT TOP LEFT
    translate(x,y);
    strokeWeight(sW);

    // DISPLAY VARIABLES
    boolean drawBG = false; // draw containing cell (good for debugging)

    // THRESHOLDS
    int t = 8;  // BACKGROUND SHAPE THRESHOLD
    int aT = 4; // FOREGROUND SHAPE THRESHOLD
    int f = 8; // STYLE THRESHOLD


    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }


    /**** BG SHAPE ****/

    if (b < t) {
      // SET STYLE
      if (s < f) {
        stroke(shapeColors[c1]);
        fill(shapeColors[c1]);
      } else {
        noFill();
        stroke(shapeColors[c1]);
      }

      if (o == 0) {
        if (o2 == 0) {
          // HORIZONTAL ARCS
          arc(0, h/2, w, h, radians(270), radians(450), CHORD);
          arc(w, h/2, w, h, radians(90), radians(270), CHORD);
        } else {
          // VERTICAL ARCS
          arc(w/2, 0, w, h, radians(0), radians(180), CHORD);
          arc(w/2, h, w, h, radians(180), radians(360), CHORD);
        }

      } else {
        if (o2 == 0) {
          // HORIZONTAL TRIANGLES
          triangle(0, 0, w/2, h/2, 0, h);
          triangle(w, 0, w/2, h/2, w, h);
        } else {
          // VERTICAL TRIANGLES
          triangle(0, 0, w/2, h/2, w, 0);
          triangle(0, h, w/2, h/2, w, h);
        }
      }
    }


    /**** FOREGROUND SHAPE ****/

    // SET SIZE OF FOREGROUND SHAPE
    float aW = w * 0.75;

    // DRAW SHAPE
    if (a < aT) {
      // SET SHAPE STYLE
      noFill();
      stroke(shapeColors[c2]);
      strokeWeight(sW);
      arc(w/2, h/2, aW, aW, radians(0), radians(360));
    }


    popMatrix();
  }
}
