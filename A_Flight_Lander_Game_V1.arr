import image as I
import world as W


#Implementing A Flight Lander Game
#https://www.pyret.org/docs/latest/Tutorial__A_Flight_Lander_Game.html

#Downloading image from the internet 

AIRPLANE-URL = "https://www.pyret.org/docs/latest/airplane-small.png"
AIRPLANE = I.image-url(AIRPLANE-URL)

AIRPLANE-X-MOVE = 10

#<--------------1.2.4.1 Updating the World State----------------->

fun move-airplane-x-on-tick(w):
  #Moves the plane 10 steps to the right
  w + AIRPLANE-X-MOVE 
where:
  move-airplane-x-on-tick(50) is 50 + AIRPLANE-X-MOVE
  move-airplane-x-on-tick(0) is 0 + AIRPLANE-X-MOVE
  move-airplane-x-on-tick(100) is 100 + AIRPLANE-X-MOVE
end


#<--------------1.2.4.2 Displaying the World State--------------->

WIDTH  = 800
HEIGHT = 500

BASE-HEIGHT = 50
WATER-WIDTH = 500


BLANK-SCENE = I.empty-scene(WIDTH, HEIGHT) # A transparent canvas used 


WATER = I.rectangle(WATER-WIDTH,BASE-HEIGHT, "solid" , "blue")
LAND  = I.rectangle(WIDTH - WATER-WIDTH, BASE-HEIGHT,"solid", "brown")

#Places the land right to the water (Water---->Land)

BASE = I.beside(WATER, LAND)



#Image.place-image(img,x,y,background)
#Places the image img on the scene background so that its center is located at the coordinates (x,y), cropping the resulting image as necessary to maintain the size of background. The coordinates are relative to the top-left of background (i.e. standard screen coordinates).


BACKGROUND =  I.place-image(BASE,WIDTH / 2,  
  HEIGHT - (BASE-HEIGHT / 2),
  BLANK-SCENE)  


#The reason we divide by two when placing BASE is because Pyret puts the middle of the image at the given location. Remove the division and see what happens to the resulting image.



fun place-airplane-x(w):
  I.place-image(AIRPLANE,w,50, BACKGROUND)
end

#world.big-bang :: (init :: a,handlers :: List<WorldConfig<a>>) -> a 

#W.on-tick() calls a function after every tick

W.big-bang(0,[list: W.on-tick(move-airplane-x-on-tick),
    W.to-draw(place-airplane-x)])
