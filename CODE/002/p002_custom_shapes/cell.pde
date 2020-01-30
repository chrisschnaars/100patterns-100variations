class Cell {

  float x, y;
  float wt, ht;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
    wt = cellW;
    ht = cellH;
  }

  // CREATE CUSTOM SETTINGS FOR EACH CELL
  void configure() {

    // GENERATE RANDOM POINTS ALONG CELL BORDER
    float xN = random(0, cellW);  // north
    float yE = random(0, cellH);  // east
    float xS = random(0, cellW);  // south
    float yW = random(0, cellH);  // west

    // GENERATE COLOR ID
    int c = floor(random(0, colors.length));

    // GENERATE STYLE DECIDER
    int s = floor(random(0, 2));

    // RENDER
    render(xN, yE, xS, yW, c, s);

  }

  // DRAW CELL
  void render(float xN, float yE, float xS, float yW, int c, int s) {

    // START DRAWING
    pushMatrix();

    // GLOBAL CELL SETTINGS
    noStroke();

    // DRAW BORDER
    // noFill();
    // stroke(colors[c]);
    // rect(x, y, wt, ht);

    // SET COLOR STYLE

    if (c < 0) {
      noFill();
    } else {
      if (s < 1) {
        // DRAW BACKGROUND
        fill(colors[c]);
        rect(x, y, wt, ht);
        // SET SHAPE COLOR
        fill(bgColor);
      } else {
        // SET SHAPE COLOR
        fill(colors[c]);
      }
    }

    // CHANGE ORIENT
    translate(x, y);

    // CREATE SHAPE
    beginShape();
    vertex(xN, 0);
    vertex(cellW, yE);
    vertex(xS, cellH);
    vertex(0, yW);
    endShape(CLOSE);

    // END DRAWING
    popMatrix();
  }
}
