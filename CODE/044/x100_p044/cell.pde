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

  // Configure Cell
  void configure() {
    // Display Setting
    float d1 = random(0, 1);

    // Shape Rotation
    int r1 = floor(random(0, 4));

    // Shape type IDs
    float st1 = random(0, 1); // triangle
    float st2 = random(0, 1);
    float st3 = random(0, 1);

    // Colors
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c1 == c3 || c2 == c3);

    render(d1, r1, st1, st2, st3, c1, c2, c3);
  }

  // DRAW CELL
  void render(float d1, int r1, float st1, float st2, float st3, int c1, int c2, int c3) {
    // BEGIN DRAWING
    pushMatrix();
    translate(x + w/2, y + h/2);

    // BACKGROUND CELL BORDER FOR DEBUGGING
    boolean drawBG = false;
    if (drawBG) {
      noFill();
      stroke(255);
      rect(-w/2, -h/2, w, h);
    }

    // Shape type threshold
    float t1 = 0.59;
    float t2 = 0.90;
    float t3 = 0.15;

    // Global Shape Settings
    // strokeWeight(2);
    rotate(radians(90 * r1));

    if (st1 < t1) {
      drawTriangle(c1);

    } else if (st1 < t2) {
      drawInvertedTriangle(c1);
      drawSquiggle(c2);
    } else {
      // drawShortTriangle(c1);
      drawEllipse(c2);
    }

    if (st2 > t2 || st2 < t3) {
      drawAngledLines(c2);
    }



    // END DRAWING
    popMatrix();
  }

  void drawTriangle(int c) {
    noStroke();
    fill(shapeColors[c]);

    beginShape();
    vertex(-w/2, -h/2);
    vertex(w/2, h/2);
    vertex(-w/2, h/2);
    endShape(CLOSE);
  }

  void drawShortTriangle(int c) {
    noStroke();
    fill(shapeColors[c]);

    beginShape();
    vertex(0, 0);
    vertex(w/2, h/2);
    vertex(-w/2, h/2);
    endShape(CLOSE);
  }

  void drawEllipse(int c) {
    noFill();
    stroke(shapeColors[c]);
    strokeWeight(6);

    float eSize = w * 0.6;

    ellipse(0, 0, eSize, eSize);
  }

  void drawInvertedTriangle(int c) {
    noStroke();
    fill(shapeColors[c]);

    float insetScale = 0.25;
    float iW = w * (1 - insetScale);
    float iH = h * (1 - .13);

    float inv = (w/2) * 0.75;

    beginShape();
    vertex(0, -h/2);
    vertex(w/2, h/2);
    vertex(-w/2, h/2);
    beginContour();
    vertex(0, -iW/2);
    vertex(-iW/2, iH/2);
    vertex(iW/2, iH/2);
    endContour();
    endShape(CLOSE);
  }

  void drawAngledLines(int c) {
    noFill();
    stroke(shapeColors[c]);
    strokeWeight(6);

    line(-w/4, -h/2, 0, 0);
    line(w/4, -h/2, 0, 0);
  }

  void drawSquiggle(int c) {
    noFill();
    stroke(shapeColors[c]);
    strokeWeight(6);

    // Jagged Lines
    float lineSpan = w*0.1;
    float lineHeight = w * 0.1;
    float numLines = 6;

    for (int i = 0; i < numLines; i++) {
      float x1 = (-(numLines/2) * lineSpan) + (i * lineSpan);
      float x2 = x1 + lineSpan;
      float yTop = -lineHeight/2;
      float yBottom = lineHeight/2;

      if (i % 2 == 0) {
        line(x1, yBottom, x2, yTop);
      } else {
        line(x1, yTop, x2, yBottom);
      }
    }
  }
}
