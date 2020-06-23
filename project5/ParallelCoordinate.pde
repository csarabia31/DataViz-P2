import java.util.Arrays;

//creating rectangle class for the y axis of the different data 
class Rectangle implements Comparable{

  //data for each rectangle
  int xpos;
  float ypos;
  int w;
  int h;
  String name;
  boolean click = false;
  
  //constructor for rectangle class
  Rectangle(int _xpos, float _ypos, int _w, int _h, String _name)
  {
 
    name = _name;
    xpos = _xpos;
    ypos = _ypos;
    w = _w;
    h = _h;
    
  }
  
  //displaying the actual rectangle
  void display(){
    
     fill(0);
     rect(xpos, ypos, w, h);
    
  }
  
  
  //comparator function used for sorting the array of objects
  int compareTo(Object o){
            Rectangle r = (Rectangle)o;
            return xpos-r.xpos;
      }
}



class ParallelCoordinate extends Frame {

  //variables to get  the information from the csv file
  String satm, satv, act, gpa;
  float minSatm, minSatv, minAct, minGpa, maxSatm, maxSatv, maxAct, maxGpa;
  float [] satmData, satvData, actData, gpaData; 
  float y1, y2, y3,y4;
  
  //setting a margin
  float xMargin = 200;
  int startPos = 200;
  float temp;
  
  //booleans to be used for mouse pressed and mouse released function
  boolean locked;
  boolean locked2;
  boolean locked3;
  boolean locked4;
  
  //Pvectors to get positions of all of the points
  PVector[] positions1 = new PVector[myTable.getRowCount()];
  PVector[] positions2 = new PVector[myTable.getRowCount()];
  PVector[] positions3 = new PVector[myTable.getRowCount()];
  PVector[] positions4 = new PVector[myTable.getRowCount()];
    
  
  //creating the rectangle objects
  Rectangle rect1 = new Rectangle(startPos,100, 0, 400, "SATV");
  Rectangle rect2 = new Rectangle((startPos*2),100, 0, 400, "SATM");
  Rectangle rect3 = new Rectangle((startPos*3),100, 0, 400, "ACT");
  Rectangle rect4 = new Rectangle((startPos*4),100, 0, 400, "GPA");
  
  //public vector <Rectangle> objVector = new vector <Rectangle>(50);
  
  //creating an array of objects (rectangles) to be sorted later according to their x position
  Rectangle[] rects = new Rectangle[4];
  { 
    rects[0] = rect1;
    rects[1] = rect2;
    rects[2] = rect3;
    rects[3] = rect4;
  }
  

  
  
  
  
  
  
 ParallelCoordinate( String _satm, String _satv, String _act, String _gpa ) {
   //constructor
    satm = _satm;
    satv = _satv;
    act = _act;
    gpa = _gpa;
    
  
    //getting the data from the file
    satmData = myTable.getFloatColumn(satm);
    satvData = myTable.getFloatColumn(satv);
    actData = myTable.getFloatColumn(act);
    gpaData = myTable.getFloatColumn(gpa);
    
    //getting max and min values of each of the four types of data to be used for y axis labeling
    minSatm = min(satmData);
    maxSatm = max(satmData);
    
    minSatv = min(satvData);
    maxSatv = max(satvData);
    
    minAct = min(actData);
    maxAct = max(actData);
    
    minGpa = min(gpaData);
    maxGpa = max(gpaData);
    
  }
  
  
  

void draw() { 
    
  background(175);
  stroke(0);
  
  
  //legend
  fill(150,0,0);
  text("*Drag any line and drop it inbetween the two lines you want to locate it at", 5, 20);
  text("*Hover over any point to get the respective data", 5, 40);
  
  //displaying the rectangles
  rect1.display();
  rect2.display();
  rect3.display();
  rect4.display();
  
  //displaying each of the names of the data 
  text(rect1.name, rect1.xpos-5, 550);
  text(rect2.name, rect2.xpos-5, 550);
  text(rect3.name, rect3.xpos-5, 550);
  text(rect4.name, rect4.xpos-5, 550);
  
  
  for(int i = 0; i<myTable.getRowCount(); i++)
  {
    //mapping values to their respective rectangles (y axis)
    y1=map(satvData[i], minSatv, maxSatv, height-100, 100);
    y2=map(satmData[i], minSatm, maxSatm, height-100, 100);
    y3=map(actData[i], minAct, maxAct, height-100, 100);
    y4=map(gpaData[i], minGpa, maxGpa, height-100, 100);
    stroke(0);
    fill(255);
    
    fill(255,0,0);
    //displaying min and max values for each of the different types of data
    text(maxSatv, rect1.xpos, 90);
    text(minSatv, rect1.xpos, 510);
    
    text(maxSatm, rect2.xpos, 90);
    text(minSatm, rect2.xpos, 510);
    
    text(maxAct, rect3.xpos, 90);
    text(minAct, rect3.xpos, 510);
    
    text(maxGpa, rect4.xpos, 90);
    text(minGpa, rect4.xpos, 510);
   
   //settong color for the lines depending on values 
       if(y1 < (400/3)+25)
         stroke(0);
       else if(y1<(400/3)*2)
         stroke(0,0,255);
       else if (y1 > (400/3)*2 && y1 < (400/3) *3)
         stroke(0,255,0);
       else stroke(255,0,0);
   
     //if-else function to pick where the data lines are going to be mapped to
     //satv
    
    
    if(rect1.xpos>=xMargin && rect1.xpos<=width-xMargin)
    {
       
       if(rect1.xpos+xMargin == rect2.xpos)
           line(rect1.xpos, y1, rect2.xpos, y2);
           
       else if(rect1.xpos+xMargin == rect3.xpos)
           line(rect1.xpos, y1, rect3.xpos, y3);
           
       else if(rect1.xpos+xMargin == rect4.xpos)   
           line(rect1.xpos, y1, rect4.xpos, y3);
         
   }
   //satm
   if(rect2.xpos>=xMargin && rect2.xpos<=width-xMargin)
    {
       if(rect2.xpos+xMargin == rect1.xpos)
           line(rect2.xpos, y2, rect1.xpos, y1);
           
       else if(rect2.xpos+xMargin == rect3.xpos)
           line(rect2.xpos, y2, rect3.xpos, y3);
           
       else if(rect2.xpos+xMargin == rect4.xpos)   
           line(rect2.xpos, y2, rect4.xpos, y4);
         
   }
   //act
   if(rect3.xpos>=xMargin && rect3.xpos<=width-xMargin)
    {
       if(rect3.xpos+xMargin == rect1.xpos)
           line(rect3.xpos, y3, rect1.xpos, y1);
           
       else if(rect3.xpos+xMargin == rect2.xpos)
           line(rect3.xpos, y3, rect2.xpos, y2);
           
       else if(rect3.xpos+xMargin == rect4.xpos)   
           line(rect3.xpos, y3, rect4.xpos, y4);
         
   }
   //gpa
   if(rect4.xpos>=xMargin && rect4.xpos<=width-xMargin)
    {
       if(rect4.xpos+xMargin == rect1.xpos)
           line(rect4.xpos, y4, rect1.xpos, y1);
           
       else if(rect4.xpos+xMargin == rect2.xpos)
           line(rect4.xpos, y4, rect2.xpos, y2);
           
       else if(rect4.xpos+xMargin == rect3.xpos)   
           line(rect4.xpos, y4, rect3.xpos, y3);
         
   }
     
      fill(255);
      stroke(0);
      //drawing the elipses(data points) in each of the y axis rectangles
      //and getting their respective positions which are stored in Pvector
      positions1[i]= new PVector(rect1.xpos,y1);
      ellipse(rect1.xpos,y1, 5,5);
      
      positions2[i]= new PVector(rect2.xpos,y2);
      ellipse(rect2.xpos,y2, 5,5);
      
      positions3[i]= new PVector(rect3.xpos,y3);
      ellipse(rect3.xpos,y3, 5,5);
      
      positions4[i]= new PVector(rect4.xpos,y4);
      ellipse(rect4.xpos,y4, 5,5);
      
      //using position of ellipses so that when the mouse is over a certain point it'll show information
      //for that respective point
       float d = dist(mouseX, mouseY, positions1[i].x, positions1[i].y);
       if (d < 2.5) 
       {
         
               fill(0,125,0);
               ellipse(positions1[i].x, positions1[i].y , 5, 5);
               text("SATV:", width-80, height-65); 
               text(myTable.getInt(i,1), width-40, height-65);
               
       }
       
       float d2 = dist(mouseX, mouseY, positions2[i].x, positions2[i].y);
       if (d2 < 2.5) 
       {
         
               fill(0,125,0);
               ellipse(positions2[i].x, positions2[i].y , 5, 5);
               text("SATM:", width-80, height-65); 
               text(myTable.getInt(i,0), width-40, height-65);
               
       }
       
       float d3 = dist(mouseX, mouseY, positions3[i].x, positions3[i].y);
       if (d3 < 2.5) 
       {
         
               fill(0,125,0);
               ellipse(positions3[i].x, positions3[i].y , 5, 5);
               text("ACT:", width-80, height-65); 
               text(myTable.getInt(i,2), width-40, height-65);
               
       }
       
       float d4 = dist(mouseX, mouseY, positions4[i].x, positions4[i].y);
       if (d4 < 2.5) 
       {
         
               fill(0,125,0);
               ellipse(positions4[i].x, positions4[i].y , 5, 5);
               text("GPA:", width-80, height-65); 
               text(myTable.getFloat(i,3), width-40, height-65);
               
       }
     
     
   }
  
   //calling mouse dragged function defined below
   mouseDragged();
   // mousePressed();
   
    //noLoop();
}


  void mousePressed() { 
 
    
    //if mouse is in the position of any of the rectangles, their respective locked value  = true
    if(mouseX>=rect1.xpos-10 && mouseX<=rect1.xpos+10 && mouseY>=100 && mouseY<=500)
          locked = true;
    
    
    if(mouseX>=rect2.xpos-10 && mouseX<=rect2.xpos+10 && mouseY>=100 && mouseY<=500)
          locked2 = true;
          
    if(mouseX>=rect3.xpos-10 && mouseX<=rect3.xpos+10 && mouseY>=100 && mouseY<=500)
          locked3 = true;
          
          
    if(mouseX>=rect4.xpos-10 && mouseX<=rect4.xpos+10 && mouseY>=100 && mouseY<=500)
          locked4 = true;
    
    
    
  }

  void mouseReleased() {  
    
    //when the mouse is released, sort the array and set that position to a fixed position
     Arrays.sort(rects);
    rects[0].xpos = 200;
    rects[1].xpos = 400;
    rects[2].xpos = 600;
    rects[3].xpos = 800;
    
    //when mouse is released all locked values become false
     locked = false;
     locked2 = false;
     locked3 = false;
     locked4 = false;
  }
  
  void mouseDragged(){
    
    //when mouse is dragged in between the screen, move the x position according to the locked value that is true
    if(mouseX >= 0 && mouseX<=width)
    {
      if(locked==true)
         rect1.xpos += mouseX-pmouseX;
        
          
      if(locked2==true)
          rect2.xpos += mouseX-pmouseX;
      if(locked3==true)
          rect3.xpos += mouseX-pmouseX;
      if(locked4==true)
          rect4.xpos += mouseX-pmouseX;
    }
    
        
  }
  
}
