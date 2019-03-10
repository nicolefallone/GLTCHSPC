import processing.video.*;

/*
  GLTCHSPC | NICOLE FALLONE
  
  GLTCHSPC (pronounced Glitch Space) is a webcam filter that disperses and 
  misshapens pixels into horizontal rectangles and vertical lines.
*/

int spacing = 7;    // grid spacing 
int spacing2 = 8;

Capture camera;          // webcam input
boolean debug = false;   // show debug info
PFont font;              // for debug display


void setup() {
  

  //size(displayWidth, displayHeight);
  
  // final version:
  // set your sketch to run fullscreen (similar to Present Mode)
   fullScreen();


  camera = new Capture(this, width,height);
  
  // start the camera input
  camera.start();
  
  // create debug font
  font = createFont("Arial", 60);
  textFont(font, 60);
}


void draw() {
  

  if (camera.available()) {
    
    camera.read();
    
    set(0,0, camera);
    
    // flip the image to mirror correctly
    pushMatrix();
    scale(-1,1);
    image(camera, -width,0);
    popMatrix();
    
    //vertical
    loadPixels();    
    for (int y=0; y<height; y+=spacing) {
      for (int x=0; x<width; x+=spacing) {

        int index = y*width+x;
        float r = red(pixels[index]); 
        float g = green(pixels[index]);
        float b = blue(pixels[index]);
        
        float c = ((r+g+b)/3.0);
        
        pushMatrix();
        translate(x,y);
        //set fill color to current pixel
        fill(r,g,b);
        noStroke();
        //replace pixel with displaced rect
          if (r > 0 && r < 255) {
          rect(0,0,2,(c-210)/3);
          //change these values to alter the length. 
          //The closer to 0 the longer the lines. 
          }
      popMatrix(); 
     }

    }
    
    //horizontal
    for (int y=0; y<height; y+=spacing2) {
      for (int x=0; x<width; x+=spacing2) {

        int index = y*width+x;
        float r = red(pixels[index]); 
        float g = green(pixels[index]);
        float b = blue(pixels[index]);
        
        float c = ((r+g+b)/3.0);
        
        pushMatrix();
        translate(x,y);
        fill(r,g,b);
        noStroke();
        
          if (r > 100 && r < 255) {
          rect(0,0,(c-210)/3,7);
        }
      popMatrix(); 
     }

    }
    
    
    // display debug info, if turned on
    if (debug) {
      fill(255);
      noStroke();
      text(nf(frameRate,0,1), 40,height-40);
    }
  }
}


// use the 'd' key to toggle debug mode
void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
}
