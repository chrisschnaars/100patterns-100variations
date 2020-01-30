// 100X100 Patterns
// Chris Schnaars

// DOCUMENT SETTINGS
String patternNumber = "007";
int version = 1;
int iteration = 1;
int totalCount = 100;

// PDF EXPORT LIBRARY
import processing.pdf.*;

// CAPTURE SETTINGS
boolean capture = true;
boolean monochromatic = true; // SET TO TRUE FOR JUST B&W

// CELLS ARRAY
ArrayList<Cell> cells = new ArrayList<Cell>();

// CELL GRID SETTINGS
int xCount = 10;
int yCount = 10;;
float cellW, cellH;
int cellSpacer = 0;
int margin = 40; // canvas margin

// COLOR SETTINGS
color bgColor;  // SKETCH BACKGROUND COLOR
color[] colors; // MAIN COLOR ARRAY

// CANVAS SETUP
void setup() {
  // SETUP CANVAS
  size(1080, 1080);

  // GLOBAL DRAWING SETTINGS
  colorMode(RGB, 255);
  smooth();

  // SET TOTAL COUNT SO YOU ONLY GET ONE MONO
  if (monochromatic) {
    totalCount = 1;
  }

  // SET ARTOWKR COLOR PALETTE
  setColors();

  // INITALIZE CELLS
  makeCells();
}

// SET ARTWORK COLOR PALETTE
void setColors() {
  // CREATE COLOR ARRAY
  colors = new color[7];

  // ASSIGN ARRAY COLORS
  if (monochromatic) {
    for (int i=0; i < 7; i++) {
      colors[i] = color(255, 255, 255);
    }
  } else {
    // set background
    bgColor = color(9, 13, 14);
    // set main colors
    colors[0] = color(0, 162, 149);
    colors[1] = color(242, 164, 162);
    colors[2] = color(232, 92, 60);
    colors[3] = color(249, 215, 31);
    colors[4]m= color(68, 190, 116);
    colors[5] = color(81, 193, 207);
    colors[6] = color(17, 22, 26);
  }
}

// INITIALIZE CELLS
void makeCells() {
  // CALCULATE CELL WIDTH AND HEIGHT
  cellW = (width - (margin*2) - (cellSpacer * (xCount-1))) / xCount;
  cellH = (height - (margin*2) - (cellSpacer * (yCount - 1))) / yCount;

  // INITIALIZE CELLS
  for (int i=0; i<xCount; i++) {
    for (int j=0; j<yCount; j++) {
      float xpos = margin + (i * cellW) + (i * cellSpacer);
      float ypos = margin + (j * cellH) + (j * cellSpacer);
      cells.add(new Cell(xpos, ypos));
    }
  }
}

// FUNCTION TO DRAW NEW BATCH OF CELLS
void renderCells() {
  for (int i=0; i<cells.size(); i++) {
    Cell c = (Cell) cells.get(i);
    c.configure();
  }
}

// GLOBAL DRAW
void draw() {
  if (iteration <= totalCount) {

    // CAPTURE SETTINGS
    if (capture == true) {
      if (monochromatic) {
        beginRecord(PDF, "../01-output/-mono/100p_" + patternNumber + "_mono.pdf");
      } else {
        beginRecord(PDF, "../01-output/pdf/100p_" + patternNumber + "_" + iteration + ".pdf");
      }
    }

    // DRAW BACKGROUND IF NOT MONOCHROMATIC MODE
    if (!monochromatic) {
      background(bgColor);
    }

    // DRAW CELLS
    renderCells();

    // CAPTURE END
    if (capture == true) {
      endRecord();
    }

    // INCREASE ITERATION COUNT
    iteration++;
  }
}

// CREATE ANOTHER ROUND WITH MOUSE PRESS
void mousePressed() {
  iteration = 1;
}
