

//------------------------------------------------------------------------------------------------variables----------------
import processing.sound.*;
SoundFile song;      //audio
SoundFile sad;

Button b;
boolean toggleColor;
int stage;   // stage 1 = menu, stage 2 = game play, stage 3 = game over



// star background
float starSpeed;     
star[] stars = new star[2000];

// asteroids and game variables
PImage img;
int pX = width;
int pY = height;
int pW = width;
int pH = height;
int difficulty = 3;
int limit = 10;
float score = 0;
Asteroid[] asteroid;
boolean isCollided = false;

//------------------------------------------------------------------------------------------------main functions----------

void setup(){
  stage = 1;
  frameRate(60);
  fullScreen();
  b = new Button(width/2, height/2, 125, "start game");
  
// initializing star background
  for (int s = 0; s < stars.length; s++) {
    stars[s] = new star();
  }
  
// music and sounds
  song = new SoundFile(this, "song.mp3");
  song.loop();
  sad = new SoundFile(this, "sad.mp3");
  
// loading dinosaur character
  img = loadImage("player.png");
  launchAsteroid(-100, width + 20, -250, -80, difficulty); 
}

void draw() {
//-------------------------------------------------------------------------------------------start menu screen-----------
  if (stage == 1) {
    //song.loop();
    if(toggleColor) {   // button
      stage = 2;
    } else {
      background(#350061);  // start menu screen
      textSize(100);
      text("This Extincts!", 400,200);
      textSize(50);
      text("Elsa's Dinosaur Game", 450, 700);
    }
    if (b.visible) {
      b.show();
    }
  }
  
//-----------------------------------------------------------------------------------------------game display-------------
  if (stage == 2) {    
// star background (display)
    starSpeed = 5;
    background(#350061);
    translate(width / 2, height / 2);
    for (int s = 0; s < stars.length; s++){
      stars[s].update();
      stars[s].show();
    }
    
// dinosaur character
    translate(-width / 2, -height / 2);
    drawPlayer();
    
    if(!isCollided){
      moveAsteroid();
      if(score > limit && score < limit + 2){
        launchAsteroid(-100, width-20, -260, -80, difficulty); difficulty += 10; limit += 20;
      }
    }
    else {
      //song.stop();
      stage = 3;
    }  
  }
  
//------------------------------------------------------------------------------------------------game over display-------
  if (stage == 3) {
    //sad.play();
    background(#350061);  // game over display
    textSize(100);
    text("Exctinct :( \n Score: "+(int)score, (width/2)-250, height-500);
    textSize(30);
    text("press ESC to exit game", (width/2)-200, (height/2)+300);
  }
}

void mousePressed() {  
  if (b.isClicked()) {
    toggleColor = !toggleColor;
  } 
}


void mouseDragged(){
  if(mouseX >= 0 && mouseX <= width - pW + 1){
    pX = mouseX;
  }
  if(mouseY >= 0 && mouseY <= height - pH){
    pY = mouseY;
  }
}



//-------------------------------------------------------------------------------------------------asteroid---------------

void launchAsteroid(int xMin, int xMax, int yMin, int yMax, int num){
  asteroid = new Asteroid[num];
  
  for(int i = 0; i < asteroid.length; i++){
    int x = (int)random(xMin, xMax);
    int y = (int)random(yMin, yMax);
    asteroid[i] = new Asteroid(x, y, 30, 15);
  }
}

void moveAsteroid() {
  for(int i = 0; i < asteroid.length; i++){
    if(asteroid[i].yCor > height){
      asteroid[i].yCor = -10;
    }
    asteroid[i].display();
    asteroid[i].drop(random(1, 15));
    
    boolean conditionXLeft = asteroid[i].xCor + asteroid[i].w >= pX;
    boolean conditionXRight = asteroid[i].xCor + asteroid[i].w <= pX + pW + 4;
    boolean conditionUp = asteroid[i].yCor >= pY;
    boolean conditionDown = asteroid[i].yCor + asteroid[i].h <= pY + pH;
    
    if(conditionXLeft && conditionXRight && conditionUp && conditionDown){
      isCollided = true;
    }
  }
  score += 0.1;
  fill(#E39200);
  text("Score: "+(int)score, width-300,100);
  textSize(30);
}

// dinosaur character
void drawPlayer() {
  image(img,pX,pY);
}
