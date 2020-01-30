class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  int cId, rId; // column and row ids

  Cell(float _x, float _y, int _cId, int _rId) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
  }

  // CONFIGURE CELL
  void configure() {

    // DISPLAY ID
    // DECIDES WHAT TYPE OF SHAPE WILL DISPLAY
    float shapeDisplay = random(0, 1);

    // SHAPE SIZE
    // OPTIONS: BIG AND SMALL (0.5 WIDTH);
    int shapeSize = floor(random(0, 2));

    // SHAPE DECIDER
    // OPTIONS: RECTANGLES OR LINES
    int shapeDecider = floor(random(0, 2));

    // SHAPE ORIENTATION
    // OPTIONS: VERTICAL, HORIZONTAL
    int shapeOrientation = floor(random(0, 2));

    // DRAW
    render(shapeDisplay, shapeSize, shapeDecider, shapeOrientation);
  }

  // DRAW CELL
  void render(float shapeDisplay, int shapeSize, int shapeDecider, int shapeOrientation) {
    pushMatrix();

    // ORIENT AT TOP LEFT CORNER
    translate(x, y);

    // DISPLAY THRESHOLDS
    float displayThreshold = 0.07;
    float shapeThreshold = 0.78;
    float ellipseThreshold = 0.53;

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false;
    if (drawBG) {
      noFill();
      stroke(255);
      rect(0, 0, w, h);
    }

    if (shapeDisplay > displayThreshold) {
      if (shapeDecider == 1 || shapeDisplay > ellipseThreshold) {
        // DRAW ELLIPSE
        drawEllipse(shapeSize, shapeDecider);
      }

      if (shapeDisplay < shapeThreshold && shapeDisplay > ellipseThreshold) {
        if (shapeDecider == 1) {
          drawDiagonal();
        }
      }

      if (shapeDisplay < shapeThreshold) {
        if (shapeDecider > 0) {
          drawRectangles(shapeOrientation);
        } else {
          drawLines(shapeOrientation);
        }
      }
    }
    
    // END DRAWING
    popMatrix();
  }

  // DRAW RECTANGLE
  void drawRectangles(int d) {
    pushMatrix();

    // SET QUANTITY
    int numRects = 5;

    // SET CELL SIZE
    float cW = w * 0.46;
    float spacer = (w - cW) / 2;

    // RECTANGLE DIMENSIONS
    float aW = cW / numRects;
    float aH = cW;

    // RECT POSITION & COLORVARIABLES
    float xP, yP, rW, rH;
    int c1 = 0;
    int c2 = 0;

    for (int i = 0; i < numRects; i++) {

      // SET LINE POSITIONS BASED ON ORIENTATION
      if (d == 0) {
        xP = spacer + (aW * i);
        yP = spacer;
        rW = aW;
        rH = aH;
      } else {
        xP = spacer;
        yP = spacer + (aW * i);
        rW = aH;
        rH = aW;
      }

      // SET RANDOM COLOR
      if (i == 0) {
        c1 = floor(random(0, shapeColors.length - 1));
      } else {
        c2 = c1;
        do {
          c1 = floor(random(0, shapeColors.length - 1));
        } while (c1 == c2);
      }

      // DRAW RECTANGLE
      noStroke();
      fill(shapeColors[c1]);
      rect(xP, yP, rW, rH);
    }

    popMatrix();
  }


  // DRAW HORIZONTAL AND VERTICAL LINES
  void drawLines(int d) {
    pushMatrix();

    // SET QUANTITY
    int numLines = 5;
    float lineW = w / (numLines * 4);

    // SET SPACING
    float lineSpacer = (w - lineW) / (numLines - 1);

    // LINE POINT VARIABLES
    float px1, py1, pW, pH;

    // SETUP LINE
    for (int i = 0; i < numLines; i++) {
      if (d == 0) {
        px1 = i * lineSpacer;
        py1 = 0;
        pW = lineW;
        pH = w;
      } else {
        px1 = 0;
        py1 = i * lineSpacer;
        pW = w;
        pH = lineW;
      }

      // SET RANDOM COLOR
      int c = floor(random(0, shapeColors.length - 1));

      // DRAW LINE
      noStroke();
      fill(shapeColors[c]);
      rect(px1, py1, pW, pH);
      // line(px1, py1, px2, py2);
    }

    popMatrix();
  }

  // DRAW ELLIPSE
  void drawEllipse(int size, int shapeDecider) {
    pushMatrix();

    translate(w/2, h/2);

    float cW1 = w * 1;
    float cW2 = w * 0.75;

    // SET RANDOM COLORS
    int c1 = floor(random(0, shapeColors.length));

    // DRAW BG RECTANGLE
    noStroke();
    fill(shapeColors[c1]);
    ellipse(0, 0, cW1, cW1);

    // DRAW FG RECTANGLE
    fill(bgColor);
    ellipse(0, 0, cW2, cW2);

    popMatrix();
  }

  void drawDiagonal() {
    pushMatrix();

    translate(w/2, h/2);

    float cW2 = w * 0.80;

    // SET RANDOM COLORS
    int c1 = floor(random(0, shapeColors.length));

    int r = floor(random(0, 2));
    rotate(radians(r * 90));
    strokeWeight(4);
    stroke(shapeColors[c1]);
    line(-cW2/2, -cW2/2, cW2/2, cW2/2);


    popMatrix();
  }



}
