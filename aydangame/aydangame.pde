int attacktype = 0;
float penalty = 0;
int timeleft = 0;
boolean victory = false;
int attackphase = 0;
int direction = 1;
boolean intro = true;
boolean gameover = false;
PImage img;
PImage startscreen;
PImage endscreen;
float timer = 60;
float scaling = 0;
PVector[] obstacles = new PVector[8]; //array of obstacle locations
//initializing global variables

//function to draw a hexagonal obstacle given a location and radius)
void obstacle(PVector location, int radius)
{
  float angle = TWO_PI/6;
  beginShape();
  for (float x = 0; x < TWO_PI; x+= angle)
  {
    float sx = location.x + radius*cos(x);
    float sy = location.y + radius*sin(x); 
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

//function to draw the user sprite at a given location
void drawuser(PVector coordinates)
{

  image(img, coordinates.x-25, coordinates.y-25);
}

//checks if the user has crashed into any obstacles by comparing the distance between their locations
boolean crashed(PVector a, PVector[] b)
{
  for (int i = 0; i < 8; i++)
    if (PVector.dist(a, b[i]) < 40)
    {
      return true;
    } 
  return false;
}

//functions that set the pvector of obstacles into a pattern based on an x value i.e diamond centered at that x val
void attack1(int x, PVector[] yeets)
{
  yeets[1].x = x;
  yeets[1].y = 150; 
  // yeets[2] = new PVector(x, 250);
  yeets[3] = new PVector(x, 350);
  yeets[4] = new PVector(x, 450);
  yeets[5] = new PVector(x-200, 150);
  yeets[6] = new PVector(x-200, 250);
  // yeets[7] = new PVector(x-200, 350);
  yeets[0] = new PVector(x-200, 450);
}
void attack2(int x, PVector[] yeets)
{
  yeets[1] = new PVector(x+50, 300);
  yeets[2] = new PVector(x-50, 300);
  yeets[3] = new PVector(x+25, 350);
  yeets[4] = new PVector(x-25, 350);
  yeets[5] = new PVector(x+25, 250);
  yeets[6] = new PVector(x-25, 250);
  yeets[7] = new PVector(x, 200);
  yeets[0] = new PVector(x, 400);
}
void attack3(int x, PVector[] yeets)
{
  yeets[1] = new PVector(x, 150);
  yeets[2] = new PVector(x-125, 150);
  yeets[3] = new PVector(x-250, 150);
  yeets[4] = new PVector(x-375, 150);
  yeets[5] = new PVector(x+25, 450);
  yeets[6] = new PVector(x-100, 450);
  yeets[7] = new PVector(x-225, 450);
  yeets[0] = new PVector(x-350, 450);
}
void attack4(int x, PVector[] yeets)
{
  yeets[1] = new PVector(x-350, 150);
  yeets[2] = new PVector(x-50, 150);
  yeets[3] = new PVector(x, 150);
  yeets[4] = new PVector(x-350, 450);
  yeets[5] = new PVector(x-300, 450);
  yeets[6] = new PVector(x-50, 450);
  yeets[7] = new PVector(x-50, 400);
  yeets[0] = new PVector(x, 450);
}

void attack5(int x, PVector[] yeets)
{
  yeets[1] = new PVector(x, 150);
  yeets[2] = new PVector(x, 250);
  yeets[3] = new PVector(x, 350);
  yeets[4] = new PVector(x, 450);
  yeets[5] = new PVector(x-200, 150);
  yeets[6] = new PVector(x-200, 250);
  yeets[7] = new PVector(x-200, 350);
  yeets[0] = new PVector(x-200, 450);
}
void attack6(int x, PVector[] yeets)
{
  yeets[1] = new PVector(x, 150);
  yeets[2] = new PVector(x, 250);
  yeets[3] = new PVector(x, 350);
  yeets[4] = new PVector(x, 450);
  yeets[5] = new PVector(x-200, 150);
  yeets[6] = new PVector(x-200, 250);
  yeets[7] = new PVector(x-200, 350);
  yeets[0] = new PVector(x-200, 450);
}

//function to click on mouse button
void mousePressed() {
  if (intro == true && mouseX > 70 && mouseX < 330 && mouseY > 480 && mouseY < 560) {
  timer = millis();
  intro = false;
  }
}
void keyPressed()

{
  //changes character direction w/space
  if (key == ' ')
  {
   
    direction *= -1;
    penalty += 0.01;
    
  }
  if (key == CODED)
  {
    //moves left
    if (keyCode == LEFT)
    {
      userpos.x-=10;
      if (userpos.x <= 0)
      {
        userpos.x = 400;
      }
     
    }
    //moves right
    if (keyCode == RIGHT)
    {
      userpos.x+=10;
      if (userpos.x >= 400)
      {
        userpos.x = 0;
      }
      
    }
  }
}
PVector userpos;

void settings()

{
  //sets screen size
  size(400, 600);
}

void setup()

{
  //loads images, startscreen user and endscreen
  userpos = new PVector(200, 100);
  img = loadImage("usersprite.png");
  startscreen = loadImage("startscreen.png");
  endscreen = loadImage("endscreen.png");
  for (int i = 0; i < 8; i++)
  {
    obstacles[i] = new PVector(800, 800);
  }
  obstacles[0].x = 100;
  //initialized obstacles array
}

void draw()

{ 
  if (gameover == false) //if the game isn't over
  {
    if (intro == true) //if still on intro screen
    {
      image(startscreen, 0, 0); //display intro screen
    } else {
      //starts timer and prepares speed scaling
      timeleft = int((timer + 60000 - millis())/1000);
      scaling = penalty+2-(float(timeleft)/60);
      attackphase+= (4*scaling);
      

//starts a new attack when the old one moves off the screen
      if (attackphase >= 800)
      {

        attackphase = 0;
        attacktype = int(random(0, 4));
      }

      switch (attacktype) {
      case 0:
        attack1(attackphase, obstacles);
        //   attack 1
        break;
      case 1:
        attack2(attackphase, obstacles);
        //  attack 2
        break;
      case 2:
        attack3(attackphase, obstacles);
        // attack 3
        break;
      case 3:
        attack4(attackphase, obstacles);
        // attack 4
        break;

      case 4:
        attack5(attackphase, obstacles);
        // attack 5 (unused)
        break;
      case 5:
        attack6(attackphase, obstacles);
        //attack 6 (unused)
        break;
      }


      background(0);
      textSize(16);
      fill(255);
      stroke(255);
      line(0, 75, width, 75);
      line(0, 525, width, 525); //draws background and lines
      text("Time:" + str(timeleft), 3*width/4, 25); //displays timer
      textSize(32);
      text("BIDEOGAME", width/3, 50); //title
      noFill();
      userpos.y = (userpos.y+(5*direction));
      if (userpos.y >= 500)
      {
        userpos.y = 100;
      }
      if (userpos.y < 100)
      {
        userpos.y = 500;
      }
      //makes user constantly fall and cycle
      drawuser(userpos);
      //draws user sprite at position
      for (int i = 0; i < 8; i++)
      {
        obstacle(obstacles[i], 25);
      }
      //draws the obstacles set during attacks
      if ((crashed(userpos, obstacles) == true) || timeleft <= 0)
      {

       //ends game if timer ends or user hits obstacle
        gameover = true;
        if (timeleft <= 0)
        {
          victory = true;
          //if the timer ran out, user won
        }
      }
    }
  } else
  { 
    //game over screen
    image(endscreen, 0, 0);
    textSize(32);
    fill(0);
    text(60-timeleft, 200, 150);
    if (victory)
    { text("YOU WON", 150, 250); //only shows if user won
    } else
    {
      text("BETTER LUCC NEXT TIM", 0, 275);
    }
  }
}