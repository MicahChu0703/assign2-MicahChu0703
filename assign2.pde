PImage bg, groundhog, life, soil, soldier,cabbage;
PImage title, gameover,startNormal, startHovered, restartNormal, restartHovered;
int grid=80;
int soldierSpeed=1; float soldierX=-80; float soldierY;
float groundhogX=grid*4, groundhogY=grid;
float lifeAmount=2;
float cabbageX, cabbageY;
//gameState
final int GAME_START=0; final int GAME_RUN=1; final int GAME_LOSE=2;
int gameState=GAME_START;
//movement
final int STOP=0; final int LEFTWARD=1;final int DOWNWARD=2; final int RIGHTWARD=3;
int movement=STOP;

void setup() {
	size(640, 480, P2D);
  // loadImage
  bg = loadImage("img/bg.jpg");
  groundhog = loadImage("img/groundhogIdle.png");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");

  //set soldierY randomly
  soldierY =grid*2+grid*floor(random(0,4));
  //set cabbage position radomly
  cabbageX =grid*floor(random(0,8));
  cabbageY =grid*2+grid*floor(random(0,4));
}


void draw() {
	// Switch Game State
  switch(gameState){
    // Game Start
    case GAME_START:
      image(title,0,0);
      image(startNormal,248,360);
      if(248<mouseX && mouseX<248+startNormal.width && 360<mouseY && mouseY<360+startNormal.height){
      image(startHovered,248,360);
      if(mousePressed){gameState=GAME_RUN;}
      }
    break;
    
    // Game Run
    case GAME_RUN:       
      //movement
      switch(movement){
        case STOP:
          groundhog = loadImage("img/groundhogIdle.png");
          groundhogY+=0;
        break;
        case DOWNWARD:
          groundhogY+=80/15;
          groundhog = loadImage("img/groundhogDown.png");
          if(groundhogY%grid==0){movement=STOP;}
        break;
        case LEFTWARD:
          groundhogX-=80/15;
          groundhog = loadImage("img/groundhogLeft.png");
          if(groundhogX%grid==0){movement=STOP;}
        break;
        case RIGHTWARD:
          groundhogX+=80/15;
          groundhog = loadImage("img/groundhogRight.png");
          if(groundhogX%grid==0){movement=STOP;}
        break;
        
        }
        // set up scene
        image(bg,0,0);
          //grass
            rectMode(CORNERS);
            noStroke();
            fill(124,204,25);
            rect(0,grid*2-15,width,grid*2);
          image(soil,0,grid*2);
          //sun
            strokeWeight(5);
            stroke(255,255,0);
            fill(253,184,19);
            ellipse(width-50,50,120,120);
        //life
          //if (lifeAmount>=1){image(life,10,10);}
          //if (lifeAmount>=2){image(life,10+life.width+20,10);}
          //if (lifeAmount>=3){image(life,10+(life.width+20)*2,10);}
          image(life,10+(life.width+20)*(lifeAmount-1),10);
          image(life,10+(life.width+20)*(lifeAmount-2),10);
          image(life,10+(life.width+20)*(lifeAmount-3),10);
        //draw groundhog
          image(groundhog,groundhogX,groundhogY);
        //draw cabbage
          image(cabbage,cabbageX,cabbageY);
        //soldier
          soldierX += 5;
          if(soldierX>640+soldier.width){
            soldierX=-80;}//loop from left to right
          image(soldier,soldierX,soldierY);
        //collision
          //groundhog & soldier
          if(groundhogX<soldierX+soldier.width && groundhogX+groundhog.width>soldierX
          &&groundhogY<soldierY+soldier.height && groundhogY+groundhog.height>soldierY){
            movement=STOP;
            groundhogX=grid*4;
            groundhogY=grid;
            lifeAmount = lifeAmount-1;}
          //groundhog & cabbage
          if(groundhogX==cabbageX && groundhogY==cabbageY){
            cabbageX=width;
            cabbageY=height;
            lifeAmount = lifeAmount+1;}
        //lose
          if(lifeAmount<=0){gameState=GAME_LOSE;}
       break;   
       
       // Game Lose
       case GAME_LOSE:
       image(gameover,0,0);
       image(restartNormal,248,360);
       if(248<mouseX && mouseX<248+restartNormal.width && 360<mouseY && mouseY<360+restartNormal.height){
       image(restartHovered,248,360);
       if(mousePressed){
       //reset
         movement=STOP;
         //groundhog position
         groundhogX=grid*4;groundhogY=grid;
         //lifeAmount
         lifeAmount=2;       
         //set soldierY randomly
         soldierY =grid*2+grid*floor(random(0,4));
         //set cabbage position radomly
         cabbageX =grid*floor(random(0,8));
         cabbageY =grid*2+grid*floor(random(0,4));
       gameState=GAME_RUN;}
       }
       break;
  }
		
		
}

void keyPressed(){
  if(groundhogX%grid==0 && groundhogY%grid==0){
    switch(keyCode){
    case DOWN:
    if(groundhogY+grid<height){movement=DOWNWARD;}
    break;
    case RIGHT:
    if(groundhogX+grid<width){movement=RIGHTWARD;}
    break;
    case LEFT:
    if(groundhogX>0){movement=LEFTWARD;}
    break;
  }}
}

void keyReleased(){
}
