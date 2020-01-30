class Cell {

  float x, y; // x and y position of cell
  float w, h; // width and height of cell
  float cId, rId; // column and row ids

  Cell(float _x, float _y, float _cId, float _rId) {
    x = _x;
    y = _y;
    w = cellW;
    h = cellH;
    cId = _cId;
    rId = _rId;
  }

  // CONFIGURE CELL
  void configure() {

    // SHAPE DISPLAY ID
    float shapeDisplay = random(0, 1);

    // SHAPE ORDER DECIDER
    float layerOrder = random(0, 1);

    // SHAPE ORIENTATION DECIDERS
    int r1 = floor(random(0, 4));
    int r2 = floor(random(0, 4));

    // COLORS
    int c1, c2;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
    } while (c1 == c2);

    // DRAW
    render(shapeDisplay, layerOrder, r1, r2, c1, c2);
  }

  // DRAW CELL
  void render(float shapeDisplay, float layerOrder, int r1, int r2, int c1, int c2) {

    // BEGIN DRAWING
    pushMatrix();

    // ORIENT AT CENTER
    translate(x + w/2, y + h/2);
    noStroke();

    // DISPLAY VARIABLES
    boolean drawBG = false; // draw containing cell (good for debugging)
    float shapeThreshold = 0.90;
    float layerThreshold = 0.7;

    // BACKGROUND CELL BORDER FOR DEBUGGING
    if (drawBG) {
      noFill();
      stroke(255);
      rect(-w/2, -h/2, w, h);
    }


    if (shapeDisplay < shapeThreshold) {

      if (layerOrder < layerThreshold) {
        drawLines(r1, shapeColors[c1]);
        drawTriangle(r2, shapeColors[c2]);
      } else {
        fill(shapeColors[c2]);
        rect(-w/2, -h/2, w, h);
        drawLines(r1, bgColor);
        drawTriangle(r2, bgColor);
      }
    }

    // END DRAWING
    popMatrix();
  }

  // DRAW PARALLELL LINES
  void drawLines(int r, int c) {
    pushMatrix();

    // SET STYLE
    noStroke();
    fill(c);

    // SPACING
    int rectW = 2;
    int numLines = 9;
    float spacer = (w - (rectW * numLines)) / (numLines);
    rotate(radians(r * 90));

    for (int i = 0; i < numLines; i++) {
      float x1 = (-w/2) + (spacer / 2) + (i * spacer) + (i * rectW);
      float y1 = -h/2;
      float y2 = h/2;
      rect(x1, y1, rectW, h);
    }

    popMatrix();
  }

  // DRAW TRIANGLE
  void drawTriangle(int r, int c) {
    pushMatrix();

    stroke(c);
    strokeWeight(1);
    fill(c);

    float q = random(0, 1);

    float tW = w/2;
    float tH = h/2;

    // DRAW TRIANGLE
    rotate(radians(r * 90));
    triangle(-w/2, -h/2, w/2, h/2, -w/2, h/2);

    popMatrix();
  }
}
