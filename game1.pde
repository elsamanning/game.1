PImage img;
float starSpeed;
star[] stars = new star[2000];

int pX = width; //600; 
int pY = height; //590;
int pW = width; //55;
int pH = height; //55;
int difficulty = 3;
int limit = 10;
float score = 0;
Asteroid[] asteroid;
boolean isCollided = false;

void launchAsteroid(int xMin, int xMax, int yMin, int yMax, int num){
  asteroid = new Asteroid[num];
  
  for(int i = 0; i < asteroid.length; i++){
    int x = (int)random(xMin, xMax);
    int y = (int)random(yMin, yMax);
    asteroid[i] = new Asteroid(x, y, 30, 15);
  }
}

void setup(){
  fullScreen();
  frameRate(60);
  for (int s = 0; s < stars.length; s++) {
    stars[s] = new star();
  }
  
  img = loadImage("player.png");
  launchAsteroid(-100, width + 20, -250, -80, difficulty);
  
}
   


void draw(){
  starSpeed = 5;
  background(#350061);
  translate(width / 2, height / 2);
  for (int s = 0; s < stars.length; s++){
    stars[s].update();
    stars[s].show();
  }
  translate(-width / 2, -height / 2);
  drawPlayer();
  if(!isCollided){
    moveAsteroid();
    if(score > limit && score < limit + 2){
      launchAsteroid(-100, width-20, -260, -80, difficulty); difficulty += 10; limit += 20;
    }
  }
  else{
    background(#350061);
    text("Exctinct :( \n Score: "+(int)score, (width/2) -250, (height/2)-100);
    textSize(100);
  } 
}

void moveAsteroid(){
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
  text("Score: "+(int)score, width-150,50);
  textSize(30);
}
  
void drawPlayer(){
  image(img,pX,pY);
  //stroke(204, 132, 0);
  //strokeWeight(4);
  //fill(204, 102, 0);
  //rect(pX, pY, pW, pH, 7);
}


void mouseDragged(){
  if(mouseX >= 0 && mouseX <= width - pW + 1){
    pX = mouseX;
  }
  if(mouseY >= 0 && mouseY <= height - pH){
    pY = mouseY;
  }
}

  
  
  
  
