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
    float st1 = random(0, 1);
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

    // Global Shape Settings
    // strokeWeight(2);
    rotate(radians(90 * r1));
    float shapeHeight = h * 0.65;
    float offset = (h - shapeHeight) / 2;
    float linesHeight = shapeHeight + offset;

    //
    if (st1 > t1 && st2 > t1) {
      noFill();
      stroke(shapeColors[c3]);
      strokeWeight(6);

      // Ellipse
      stroke(shapeColors[c3]);
      // ellipse(0, 0, w*0.65, h*0.65);

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

    strokeWeight(2);
    // Left side
    if (st1 < t1) {
      drawSkewedRectangle(c1, -1, offset);
    } else {
      drawLines(c1, -1, linesHeight, offset);
    }

    // Right Side
    if (st2 < t1) {
      drawSkewedRectangle(c2, 1, offset);
    } else {
      drawLines(c2, 1, linesHeight, offset);
    }

    // END DRAWING
    popMatrix();
  }

  void drawSkewedRectangle(int c, int dir, float offset) {
    // Rectangle settings
    noStroke();
    fill(shapeColors[c]);

    // Calculate edge direction
    float xEdge = dir * (w/2);

    // Other poitns
    float xCenter = 0;
    float yTop = -h/2;
    float yTopOffset = (-h/2) + offset;
    float yBottom = h/2;
    float yBottomOffset = (h/2) - offset;

    // Draw shape
    beginShape();
    vertex(xCenter, yTop); // top center
    vertex(xCenter, yBottomOffset); // bottom center
    vertex(xEdge, yBottom); // bottom edbe
    vertex(xEdge, yTopOffset);
    endShape(CLOSE);
  }

  void drawLines(int c, float dir, float ht, float offset) {
    pushMatrix();

    // Line Settings
    int numLines = 13;
    float lineSpacer = ht / (numLines - 1);

    // Drawing Settings
    noFill();
    stroke(shapeColors[c]);

    for (int i = 0; i < numLines; i++) {
      // Set points
      float x1 = dir * (w/2);
      float y1 = (-h/2) + (i * lineSpacer) + offset;
      float x2 = 0;
      float y2 = (-h/2) + (i * lineSpacer);

      // Draw lines
      beginShape();
      vertex(x1, y1);
      vertex(x2, y2);
      endShape();
    }

    popMatrix();
  }
}
