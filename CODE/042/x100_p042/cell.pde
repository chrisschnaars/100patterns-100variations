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

    // Ellipse display id
    float eD = random(0, 1);

    // Colors
    int c1, c2, c3;
    do {
      c1 = floor(random(0, shapeColors.length));
      c2 = floor(random(0, shapeColors.length));
      c3 = floor(random(0, shapeColors.length));
    } while (c1 == c2 || c1 == c3 || c2 == c3);

    render(d1, r1, eD, c1, c2, c3);
  }

  // DRAW CELL
  void render(float d1, int r1, float eD, int c1, int c2, int c3) {
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

    // Shape threshold
    float st1 = 0.55;
    float st2 = 0.75;

    // Rotate Shape
    rotate(radians(90 * r1));

    // Draw Shapes
    if (d1 < st1) {
      // Arc Settings
      float arcC = 2;
      float arcW = w * arcC;
      float arcH = h * arcC;
      noStroke();

      // Draw Arc1
      fill(shapeColors[c1]);
      arc(-w/2, -h/2, arcW, arcH, radians(45), radians(90), PIE);

      // Draw Arc2
      fill(shapeColors[c2]);
      arc(w/2, h/2, arcW, arcH, radians(225), radians(270), PIE);
    } else if (d1 >= st1 && d1 < st2) {
      noStroke();
      // Draw Arc1
      fill(shapeColors[c1]);
      arc(-w/2, 0, w, h, radians(270), radians(450), PIE);

      // Draw Arc2
      fill(shapeColors[c2]);
      arc(w/2, 0, w, h, radians(90), radians(270), PIE);
    } else {
      noFill();

      strokeWeight(2);
      // ellipse(0, 0, w/1.85, h/1.85);

      stroke(shapeColors[c2]);
      drawTriangle(w, h);

      stroke(shapeColors[c3]);
      drawStarFlower(12, w/1.25);
    }

    // END DRAWING
    popMatrix();
  }
}

// Draw a full ellipse using beginShape();
// Assumes translate to shape center
void drawEllipseShape(float s) {
  beginShape();
  for (int i = 0; i < 360; i+=1) {
    float xpos = (s/2 * sin(i)) + (s/2);
    float ypos = (s/2 * cos(i)) + (s/2);
    vertex(xpos, ypos);
  }
  endShape(CLOSE);
}

// Draw a star flower shape
// Assumes tranlsate to shape center
void drawStarFlower(int sides, float w) {
  float segment = w/2;
  float rotateIncrement = 180 / sides;

  for (int i = 0; i < sides; i++) {
    rotate(radians(rotateIncrement));
    line(-segment, 0, segment, 0);
  }
}

// Draw a triangle shape
void drawTriangle(float w, float h) {
  triangle(-w/2, -h/2, -w/2, h/2, w/2, h/2);
}
