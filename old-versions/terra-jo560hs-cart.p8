pico-8 cartridge // http://www.pico-8.com
version 33
__lua__
-- terra - a terraria demake or
-- something - by cubee 🐱

--[[

=== flags ===

0 solid
1 breakable with pickaxe
2 bg wall
3 top-solid
4 needs support
5 door
6 
7 


=== map usage ===

the map data is used for tline
 based sprite rotation

tile 1,1 is used for various 1x1
 tiles (held item, projectiles,
 etc...)


=== current music layout ===

0:  overworld
12: underground
24: jungle
36: corruption
48: boss music
60: none (night?)


=== current map size ===

252X130 tiles
15 3/4 screens wide
8 1/8 screens tall

]]

function _init()
 -- disable btnp repeat
 poke(0x5f5c,-1)

 surfacelevel=40
 cavernlevel=80

 dark=split"0,1,2,3,4,1,6,12,8,9,7,0,12,13,2"

 palettes=split([[
 130,132,4,
 9,10,5,134,
 131,3,139,7,
 1,140,12,136;

 128,130,132,
 4,137,133,5,
 1,131,3,6,
 129,1,140,2;
 
 0,128,130,
 132,4,130,133,
 129,1,131,13,
 0,129,1,130;
 
 0,0,128,
 128,132,128,130,
 0,129,1,5,
 0,0,129,128;
 
 0,0,0,
 0,128,0,128,
 0,0,129,130,
 0,0,0,0;
 ]],";")

 t=0
 worldtime=6000

 -- write map data
	--for i=1,_🐱w*_🐱h do
	 --if(_🐱s+i<1)poke(_🐱s+i-1,flr(rnd(256)))
	--end

-- definitions

--[[ recipe format:
oi:oa:rt|ii:ia,ii:ia,ii:ia|comment

oi: output id
oa: output amount (default 1)
rt: required tile (default none)

ii: ingredient id
ia: ingredient amount (default 1)

comment: does nothing, just an
 identifier for the humans
 reading them

separate them using semicolons

]]
recipes=split([[

17:3|5,59|torch;
14:2|5|platform;
5|14:2|wood from platform;
78:1:15|5:6|door;
13:1:16|3:2|grey brick;
64:1:16|19:2|red brick;

52:25:15|3:1,5:1|arrows;
51:25:18|56:1|bullets;

15|5:10|workbench;
16:1:15|5:4,3:20,17:3|furnace;
18:1:15|56:5|anvil;

69:4:15|5|wood wall;
66:4:15|2|dirt wall;
67:4:15|3|stone wall;
71:4:15|7|mud wall;
75:4:15|11|ebonwall;

5:1:15|69:4|wood;
2:1:15|66:4|dirt;
3:1:15|67:4|stone;
7:1:15|71:4|mud;
11:1:15|75:4|ebonstone;

53:1:18|24,60:5,27|nights edge;
65:1:18|48,55:2,27|dogblaster;

55:1:16|23:3|demonite bar;
24:1:18|55:3|lights bane;
26:1:18|55:4|nightmare pick;

58:1:16|22:4|gold bar;
34:1:18|58:2|sword;
28:1:18|58:3|bow;
33:1:18|58:3,5:4|pick;
35:1:18|58:2,5:3|axe;
32:1:18|58:2,5:3|hammer;

57:1:16|21:4|silver bar;
38:1:18|57:2|sword;
29:1:18|57:3|bow;
37:1:18|57:3,5:4|pick;
39:1:18|57:2,5:3|axe;
36:1:18|57:2,5:3|hammer;

56:1:16|20:3|iron bar;
42:1:18|56:2|sword;
30:1:18|56:3|bow;
41:1:18|56:3,5:3|pick;
43:1:18|56:2,5:3|axe;
40:1:18|56:2,5:3|hammer;

46:1:15|5:2|w sword;
31:1:15|5:3|w bow;
44:1:15|5:3|w hammer;

62|54:6|sus eye;
63|59:15|slime crown;
25|61:6,55:1|ocram
]],";")

--[[ item stats
 damage,type,usetime,value

 value varies based on type
 ranged: ammo id to use
 summon: entity id to spawn
]]
toolstat=split[[
0:block,
0:block,
0:block,
0,
0:block,
0:block,
0:block,
0:block,
0:hpup:1:20,
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,

0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
18:melee:20,
0:summon:16:marco,
9:pick:15,
0,
11:ranged:26:52,
9:ranged:27:52,
8:ranged:28:52,
4:ranged:30:52,

9:hammer:28,
6:pick:17,
13:melee:20,
7:axe:26,
9:hammer:29,
6:pick:19,
11:melee:21,
6:axe:26,
7:hammer:30,
5:pick:20,
10:melee:21,
5:axe:27,
2:hammer:37,
4:pick:23,
7:melee:25,
3:axe:30,

31:ranged:50:51,
17:ranged:25:52,
0:aight imma head out,
8:bullet:16:6,
3:arrow:16:4,
42:melee:21,
0,0,0,0,0,0,0,0,
0:summon:16:eoc,
0:summon:16:kingslime,

0:block,
27:ranged:27:51,
0:block,
0:block,
0,
0:block,
0,
0:block,
0:block,
0,0,
0:block,
0:block,
0,
0:block,
0,

0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,

0,0,0,0,0,0,0,0,0,0,0,0,0,
0:item,
0,0,

]]

-- tile drops
drops=split[[
2,
2,
3,
4,
5,
7,
7,
8,
9,
2,
2,
12,
13,
14,
15,
16,
17,
18,
19,
20,
21,
22,
23

]]

-- doors
drops[79]=78

-- trees
drops[111]=5
drops[127]=5

-- names of sprite tiles
tilenames=split[[
forest grass,
dirt,
stone,
barrier,
wood,
jungle grass,
mud,
sand,
life crystal,
corruption grass,
corruptiondirt,
ebonstone,
grey brick,
wooden platform,
workbench,
furnace,
torch,
anvil,
clay,
iron ore,
silver ore,
gold ore,
demonite ore,
light's bane,
sigil of blight,
nightmare pickaxe,
soul of blight,
gold bow,
silver bow,
iron bow,
wood bow,
gold hammer,
gold pickaxe,
gold broadsword,
gold axe,
silver hammer,
silver pickaxe,
silver broadsword,
silver axe,
iron hammer,
iron pickaxe,
iron broadsword,
iron axe,
wooden hammer,
copper pickaxe,
wooden broadsword,
copper axe,
musket,
shade bow,
magic mirror,
musket ball,
wood arrow,
night's edge,
lens,
demonite bar,
iron bar,
silver bar,
gold bar,
gel,
stinger,
rotten chunk,
suspicious-looking eye,
slime crown,
red brick,
cubee's dogblaster,
dirt wall,
stone wall,
b,
wood wall,
b,
mud wall,
sandstone wall,
b,
b,
corruptiondirt wall,
ebonstone wall,
shadow orb,
wooden door,
open wood door,

b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,

b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
b,
tree trunk,
gold greaves,
gold chainmail,
silver greaves,
silver chainmail,
iron greaves,
iron chainmail,
wood greaves,
wood breastplate,
b,
b,
b,
b,
b,
heart,
b,
tree stump,


]]

-- end definitions

	-- generate
	generate()

	pflip,pjump,pair,pdigt,php_max,pfall,ptype,pdiet,pswing,pangle=false,true,true,0,100,0,0,0,0,0

 spawnplayer()

	grv,acc,frc,dec,max_x,jmp=0.08,0.05,0.08,0.15,1,-2.2

	items={}
	inventory={
 	{id=46},
 	{id=45},
 	{id=47}
	}

	mobs,lights,projectiles,craftable={},{},{},{}

 hoveritem,invsel,invopen,invside,craftsel=false,1,false,1,1

 -- convert recipe string to array
 for k,i in pairs(recipes) do
  recipes[k]=split(i,"|")
  recipes[k][1]=split(recipes[k][1],":")
  recipes[k][2]=split(recipes[k][2])
  for j,o in pairs(recipes[k][2]) do
   recipes[k][2][j]=split(o,":")
  end
 end

 nextmusic,currentmusic=0,-1

 orbsmash=0

--[[

 for i=0,5 do
  bset(px/8+i,py/8-1,77)
 end]]
end



function _update60()
 lights={}

 -- clean inventory, update item stats
 for i in all(inventory) do
  i.autoswing,stats=(i.type~="melee" and i.type~="ranged"),split(toolstat[i.id],":")

--do not combine these, future me
  stats=stats or split"0,item"
  i.damage,i.type,i.var,i.usetime,i.amount=stats[1],i.type or stats[2] or "item",stats[4],stats[3] or 16,i.amount or 1

  if i.type=="melee" or i.type=="pick" or i.type=="axe" or i.type=="hammer" then
   i.melee=true
  end

  if i.amount<=0 then
   del(inventory,i)
  end
 end
 if(invsel>#inventory)invsel=#inventory

 -- inventory
 if invopen then

  -- inventory side
  if invside==1 then
   if(btnp(0))invside=0
   if(btnp(2))invsel-=1
   if(btnp(3))invsel+=1
   if(invsel<1)invsel=#inventory
   if(invsel>#inventory)invsel=1

	  -- moving items (place back if leaving inventory)
	  if btnp(4) or ((btnp(6) or btnp(0) or btnp(1)) and hoveritem) then
	   if hoveritem==false then
	    hoveritem=inventory[invsel]
	    deli(inventory,invsel)
	   else
	    if #inventory>0 then
	     add(inventory,hoveritem,invsel)
	    else
	     inventory[0]=hoveritem
	    end
	    hoveritem=false
	   end

	  end

	  -- trash selected item
	  if btnp(5) then
	   trashslot=inventory[invsel]
	   deli(inventory,invsel)
	  end

   -- recover trashed item
   if btnp(1) and trashslot then
    add(inventory,trashslot)
    trashslot=false
   end

   -- stay at bottom of inventory
   if(invsel>#inventory)invsel=#inventory
 
  -- craft side
  else
   if(btnp(1))invside=1
   if(btnp(2))craftsel-=1
   if(btnp(3))craftsel+=1
   if(craftsel<1)craftsel=#craftable
   if(craftsel>#craftable)craftsel=1

   it=craftable[craftsel]
   if it then
	   out,ing=it[1],it[2]

	   -- craft
	   if btnp(4) then
	
	    -- use ingredients
	    for i in all(ing) do
	     --i=split(i,":")
	     amount=i[2] or 1

	     -- each in amount
	     for a=1,amount do
	      got=false
	
	      -- search inventory
	      for b=1,#inventory do
	
	       -- remove if found
	       if not got and inventory[b].id==i[1] and inventory[b].amount>0 then
	        inventory[b].amount-=1
	        got=true
	       end
	      end
	     end
	    end

	    -- search inventory for this item
	    ininv,slot=false,1
	    for a in all(inventory) do
	     if a.id==out[1] then
	      ininv=true
	     end
	     if(not ininv)slot+=1
	    end
	    if ininv then
	     inventory[slot].amount+=out[2] or 1
	    else
	     add(inventory,{id=out[1],amount=out[2] or 1})
	    end

	    -- refresh recipe list
     updaterecipes()
	   end

   else
    invside=1
   end--if it

  end

  -- close inventory
  --if(btnp(5))invopen=false
  pjump=true

 -- gameplay
 else

  -- return to hotbar
  invside=1

	 -- time, slightly faster than 1 min = 1 hour
	 worldtime+=0.4
	 worldtime%=24000

	 -- player dead
	 if pdead then
	  pdiet=max(pdiet-1)

	  if pdiet==0 and btnp(4) then
	   spawnplayer(php_max)
	  end

	 -- player alive
	 else

		 -- healing
		 if(t%100==0)php+=1

	  frc=pair and 0.03 or 0.08

		 -- move left
		 if btn(0) then

		  -- compact movement
		  if(pxv>-max_x)pxv-=pxv>0 and dec or acc
		  if(canturn)pflip=true

		 -- move right
		 elseif btn(1) then

    -- compact movement
		  if(pxv<max_x)pxv+=pxv<0 and dec or acc
		  if(canturn)pflip=false

		 else

		  -- friction
		  pxv-=sgn(pxv)*frc
		  -- stop if moving really slow
		  if abs(pxv)<frc*1.1 then
		   pxv=0
		  end
		 end

		 -- apply gravity
		 pyv+=grv

		 -- collisions

		 -- down
		 d,e,pair=0,false,true
		 repeat
		  l,r=bget((px-3)/8,(py+4+d)/8),bget((px+2)/8,(py+4+d)/8)
		  if pyv>0 and (fget(l,0) or fget(r,0) or ((fget(l,3) or fget(r,3)) and not btn(3))) then
		   if(not btn(4))pjump=false
		   pair,e,pyv=false,true,0
		   py+=d

		   -- fall damage
		   pfall=max(pfall/8-13)
		   if pfall>0 then
		    php-=flr(pfall*10)
		    piframes=30
		    sfx(ptype)
		   end
		   pfall=0

				 if btn(4) and not pjump then
				  pjump=true
				  pyv=jmp
				 end
		
		  end
		  d+=1
		 until d>pyv or e

		 -- up
		 d,e=0,false
		 repeat
		  lef,rgt=fget(bget((px-3)/8,(py-5+d)/8),0),fget(bget((px+2)/8,(py-5+d)/8),0)
		  if pyv<0 and (lef or rgt) then
		   e=true
		   if lef and rgt then
		    pyv=0
		    py+=d
		   end
		   if(not rgt)px+=1
		   if(not lef)px-=1
		  end
		  d-=1
		 until d<pyv or e
	
		 -- right
		 d,e=0,false
		 repeat
		  bx,by=(px+3+d)/8,(py+3)/8
		  b,top=bget(bx,by),fget(bget((px+3+d)/8,(py-4)/8),0)

		  -- doors
		  if fget(b,5) then
		   if pxv>0 and fget(b,0) then
		    bset(bx,by,b+1)
		   elseif pxv<0 and not fget(b,0) then
		    bset(bx,by,b-1)
		   end

    -- normal collision
		  elseif pxv>0 and (top or fget(b,0)) then
		   e,pxv=true,0
		   px+=d
		   if(not top)py-=1 pyv=min(pyv)
		  end
		  d+=1
		 until d>pxv or e
	
		 -- left
		 d,e=0,false
		 repeat
		  bx,by=(px-4+d)/8,(py+3)/8
		  b,top=bget(bx,by),fget(bget((px-4+d)/8,(py-4)/8),0)

		  -- doors
		  if fget(b,5) then
		   if pxv<0 and fget(b,0) then
		    bset(bx,by,b+1)
		   elseif pxv>0 and not fget(b,0) then
		    bset(bx,by,b-1)
		   end

    -- normal collision
		  elseif pxv<0 and (top or fget(b,0)) then
		   e,pxv=true,0
		   px+=d
		   if(not top)py-=1 pyv=min(pyv)
		  end
		  d-=1
		 until d<pxv or e
		
		 if pjump and not btn(4) then
		  pyv=max(pyv,-0.2)
		 end

		 -- move
		 px+=pxv
		 py+=pyv
		 pfall+=pyv

   -- use position
		 digx,digy=pflip and -7 or 7,(btn(3) and 7) or (btn(2) and -7) or 0
	  if not (btn(0) or btn(1)) then
	   if(btn(3) or btn(2))digx=0
	  end
   actx,acty=(px+digx)/8,(py+digy)/8
		 tile,helditem,canturn,digging=bget(actx,acty),inventory[invsel] or {id=0,type="item",usetime=10},true,false

   -- use item
   hitype,hiuse=helditem.type,helditem.usetime
		 if btn(5) then

		  if(pswing==0 and (btnp(5) or helditem.autoswing))pswing=hiuse

    -- breakable tiles
		  if hitype=="axe" or hitype=="pick" then

		   if til~=0 and(
		   (hitype=="axe" and tile==127) or
		   (hitype=="pick" and fget(tile,1) and bget(actx,acty-1)~=127)
		   )then
		    digging=true
		    pdigt+=1
			  	if(pdigt%hiuse==1)sfx(4)
			  	--sfx(2)

			  	-- break tile
			  	if pdigt>=hiuse*3 then
			  	 pdigt=0
			  	 sfx(3)

			  	 -- tiles that need support
			   	ty=-1
			  	 if fget(tile,4) then
		 	   	ty=0

			    -- everything else
			  	 else
	 		  	 additem(drops[tile] or tile,px+digx,py+digy,1,tile==9 and 20 or "block")
			   	 bset(actx,acty,0)
			    end

			  	 -- break supported tiles
		   	 while fget(bget(actx,acty+ty),4)
		   	 do
		   	  b=bget(actx,acty+ty)
		  	   additem(drops[b] or b,px+digx,py+digy+ty*8,1,bget(actx,acty+ty)==9 and 20 or "block")
		   	  bset(actx,acty+ty,0)
		  	   ty-=1
		  	  end
	
			  	end

     end

    -- place block
	   elseif hitype=="block" then

	    canplace=false

	    -- platform offset
	    if fget(helditem.id,3) and pxv~=0 then
	     acty+=1
	    end

	    -- check nearby tiles
	    for ix=-1,1 do
	     for iy=-1,1 do
	      bl=bget(actx+ix,acty+iy)
	      if abs(ix)+abs(iy)==1 and bget(actx,acty)==0 and (fget(bl,0) or fget(bl,2) or fget(bl,3)) then
	       canplace=true
	      end
	     end
	    end

     -- needs support?
     lt=bget(actx,acty+1)
     if fget(helditem.id,4) and not (fget(lt,0) or fget(lt,3)) then
      canplace=false
     end

     -- place block
	    if canplace then
		    if pdigt==0 and tile==0 then
				   sfx(4)
				   bset(actx,acty,helditem.id)
				   helditem.amount-=1
				  end
				  pdigt+=1
				  pdigt%=7
				 else
				  pdigt=0
				 end

			 -- hammer
			 elseif tile~=0 and hitype=="hammer" and fget(tile,2) then

			  -- break walls
			  if pdigt==0 then
			   sfx(4)
			   dropitem=drops[tile] or tile

			   -- smash orbs
			   if(tile==77)dropitem=48+orbsmash orbsmash+=1
			   if(dropitem==48)additem(51,px+digx,py+digy,100)

      -- drop item
			   additem(dropitem,px+digx,py+digy)
			   bset(actx,acty,0)
			  end
			  pdigt+=1
			  pdigt%=hiuse

			 -- ranged weapon
			 elseif hitype=="ranged" then

			  if pswing==hiuse then
	     -- find ammo
	     ammodamage=false

      for a in all(inventory) do
       if a.id==helditem.var then
        a.amount-=1
        ammovel=a.var
        ammodamage=a.damage
       end
      end

	     --helditem.var

	     -- bullet
	     if ammodamage then
	      addprojectile(helditem.var,px,py,pangle,helditem.damage+ammodamage,ammovel)
      else
       pswing=0
       sfx(9)
      end
     end

    -- life crystal
    elseif hitype=="hpup" then
     if pdigt==0 then
      if php_max<400 then
       php_max+=helditem.var
       php+=helditem.var
       helditem.amount-=1
      end
      sfx(5)
     end
     pdigt=20

			 -- boss summons
			 elseif hitype=="summon" then
     if pdigt==0 then
      sfx(10)
      addmob(helditem.var,px-32,py-64,true)
      helditem.amount-=1
     end
     pdigt=20

    elseif hitype=="aight imma head out" then
     spawnplayer(php)
     sfx(11)
    end

		 else
		  pdigt=0
		 end
		 pswing,canturn=max(pswing-1),not (pswing>0 and (helditem.type=="melee" or helditem.type=="ranged"))

   -- change music
   floortile=bget(px/8,py/8+1)
   if fget(floortile,0) then
    if floortile>=1 and floortile<=3 then
	    if py/8>surfacelevel+10 then
		    nextmusic=12
		   else
	     nextmusic=(worldtime<17500 and worldtime>4300) and 0 or 60
	    end
    elseif floortile==6 or floortile==7 then
     nextmusic=24
    elseif floortile>=10 and floortile<=12 then
     nextmusic=36
    end

   end

	  -- update tool position
	  --[[
	  wyo=-7
	  wxo=-7
	  wflip=false
	  if pspr==131 then
	   wflip=true
	  elseif pspr==132 then
	   wxo=6
	   wyo=-6
	  elseif pspr==133 then
	   wxo=7
	   wyo=6
	  end
	  if(pflip)wflip=not wflip wxo=-wxo
	 ]]

   a=(hiuse-pswing)/(hiuse*2)+0.1
	  wxo=cos(a)*8*(pflip and 1 or -1)
	  wyo=sin(a)*8

		end--player alive

	 -- update items
	 for i in all(items) do
	  i.yv=min(i.yv+grv/2,1.2)
	  i.xv*=0.95
	  i.timer=max(i.timer-1)

	  -- go to player
	  if not pdead and i.timer<=0 and abs(px-i.x)<24 and abs(py-i.y)<24 then
	   i.xv+=(px-i.x)/50
	   i.yv+=(py-i.y)/50
	   if abs(px-i.x)<4 and abs(py-i.y)<4 then

	    -- search inventory for this item
	    ininv=false
	    slot=1
	    for a in all(inventory) do
	     if a.id==i.id then
	      ininv=true
	     end
	     if(not ininv)slot+=1
	    end
	    if ininv then
	     inventory[slot].amount+=i.amount
	     del(items,i)
	    else

	     -- life hearts
	     if i.id==125 then
       php+=20
	     -- normal
	     else
	      add(inventory,{id=i.id,amount=i.amount})
      end

	     del(items,i)
	    end
	   end

	  -- fall
	  else

		  if fget(bget((i.x)/8,(i.y+2)/8),0) then
		   i.yv=min(i.yv)
		  end
		  if fget(bget((i.x)/8,(i.y-2)/8),0) then
		   i.yv=max(i.yv)
		  end
		  if fget(bget((i.x+2)/8,(i.y)/8),0) then
		   i.xv=min(i.xv)
		  end
		  if fget(bget((i.x-2)/8,(i.y)/8),0) then
		   i.xv=max(i.xv)
		  end
		 end

	  i.x+=i.xv
	  i.y+=i.yv

	  -- delete oldest items
	  if(#items>70)del(items,i)

	 end

  -- update projectiles
  for i in all(projectiles) do
   if i.grav then
    i.yv+=grv/8
   end
   i.x+=i.xv
   i.y+=i.yv

   -- delete on collision
   --(world edges are solid btw)
   if fget(bget(i.x/8,i.y/8),0) then
    del(projectiles,i)
   end

  end

  -- mob spawning
  if t%(((pxv==0 and pyv==0 and py/8<surfacelevel+10) and 10 or 6)+#mobs)==1 and not pdead then
	  ata,adi=rnd(),rnd(24)
	  atx,aty=(px+cos(ata)*(80+adi))\8,(py+sin(ata)*(80+adi))\8
	  if not fget(bget(atx,aty),0) then
	   sptile=bget(atx,aty+1)

	   -- spawn tile lists
	   forest=(worldtime<4300 or worldtime>17500) and
	   "zombie,zombie,eye" or
	   "gslime,gslime,gslime,bslime"
	   jungle="jslime,jbat,jbat"
	   underground="bat,bat,yslime,yslime,rslime"
	   cavern="bat,bat,skeleton,rslime"

	   -- lists
	   spawns={}
	   spawns[10]="eater"
	   spawns[11]="eater"
	   spawns[12]="eater"
    spawns[6]="jslime,jbat,hornet,hornet"
    spawns[7]="jslime,jbat,hornet,hornet"
	   if py\8>cavernlevel then
	    spawns[1]=cavern
	    spawns[2]=cavern
	    spawns[3]=cavern
	    spawns[5]=cavern
	    spawns[19]=cavern
	    spawns[20]=cavern
	    spawns[21]=cavern
	    spawns[22]=cavern
	   elseif py\8>surfacelevel+10 then
	    spawns[1]=underground
	    spawns[2]=underground
	    spawns[3]=underground
	    spawns[5]=underground
	    spawns[19]=underground
	    spawns[20]=underground
	    spawns[21]=underground
	    spawns[22]=underground
	   else
	    spawns[1]=forest
	    spawns[2]=forest
	    spawns[3]=forest
	    spawns[5]=forest
	    spawns[6]=jungle
	    spawns[7]=jungle
	   end

	   -- attempt to spawn
	   if spawns[sptile] then
	    addmob(rnd(split(spawns[sptile])),atx*8+4,aty*8+4)
	   end
	  end

  end -- spawn mobs

	 -- update mobs
  distance=120
	 pangle=pflip and 0.5 or 0
	 for i in all(mobs) do
	  -- TOKEN SAVING GO brrrrrrr
	  ai,grav,collide,stoponwalls,enemy,bouncy,vmod,knockback,friction,boss="none",true,true,true,true,false,1,1,true,false

	  if i.id=="gslime" then
	   ai,i.spr,knockback="slime",176,0.8

	  elseif i.id=="bslime" then
	   ai,i.spr="slime",160

	  elseif i.id=="rslime" then
	   ai,i.spr,i.angry="slime",144,true

	  elseif i.id=="yslime" then
	   ai,i.spr,i.angry="slime",180,true

	  elseif i.id=="jslime" then
	   ai,i.spr,i.angry="slime",164,true

	  elseif i.id=="eye" then
	   ai,i.rspr,i.sprx,i.spry="eye",true,1+t%20\10*2,10,0.8

	  elseif i.id=="zombie" then
	   ai,i.spr,i.vmod,knockback="fighter",146,0.5,0.5

	  elseif i.id=="eater" then
	   ai,i.rspr,i.sprx,i.spry,knockback="flying",true,1+t%20\10*2,12,0.5
	
	  elseif i.id=="bat" then
	   ai,i.spr,knockback="bat",162,0.8
	
	  elseif i.id=="jbat" then
	   ai,i.spr,knockback="bat",150,0.8

	  elseif i.id=="hornet" then
	   ai,i.spr,i.flip,vmod,knockback="flying",166,i.xv<0,1.5,0.5

	  elseif i.id=="skeleton" then
	   ai,i.spr,vmod,knockback="fighter",182,1.1,0.5

	  elseif i.id=="eocservant" then
	   ai,i.rspr,i.sprx,i.spry,vmod,collide,friction="flying",true,1+t%20\10*2,14,0.6,false,false

	  elseif i.id=="marcoservant" then
	   ai,i.spr,vmod,collide,friction="flying",168,0.9,false,false

	  elseif i.id=="eoc" then
	   nextmusic,ai,i.w,i.h,i.rspr,i.spry,knockback=48,"eoc",3,3,true,10+t%20\10*4,0
	   if(not i.sprx)i.sprx=5

	  elseif i.id=="kingslime" then
	   nextmusic,ai,i.angry,i.w,i.h,i.spr,i.vmod,i.scale,knockback,boss=48,"slime",true,3,2,230,2-i.hp/2000,0.6+i.hp/2000,0,true
	   
	   i.php=i.php or i.hp

	   if i.hp~=i.php then
	    addmob("bslime",i.x,i.y)
	   end

    i.php=i.hp

	  elseif i.id=="marco" then
	   nextmusic,ai,i.w,i.h,i.rspr,i.spry,knockback=48,"eoc",4,4,true,18+t%20\10*5,0
	   if(not i.sprx)i.sprx=5

	  end

   -- keep angles 0-1
	  i.ang%=1

	  -- base ai
	  if ai=="fighter" then
	   i.xv+=sgn(px-i.x)*(i.air and 0.01 or 0.08)*vmod
	   i.xv=mid(-0.5*vmod,i.xv,0.5*vmod)
	   i.flip=i.xv<0
	   i.spr+=i.x/8%2
	
	  elseif ai=="slime" then
	   i.jumpt=i.jumpt or 60
	   i.d=i.d or sgn(rnd(2)-1)
	   stoponwalls=false
	  
	   v=i.angry and sgn(px-i.x) or i.d

	   i.jumpt-=0.5*vmod

	   if i.jumpt<=0 and not i.air then
	    i.jumpt=80+rnd(40)
	    i.yv=-1.2-rnd()
	    i.xv=v*vmod
	   end
	
	   if i.jumpt<30 then
	    i.spr+=t%20\10*i.w
	   else
	    i.spr+=t%40\20*i.w
	   end

	  elseif ai=="flying" then
	   grav,bouncy=false,true
	   i.spr+=t%20\10
	   v,angv,tang=0.02,0,(atan2(py-i.y,px-i.x)+0.5)%1
    -- if it works, it works
    if i.ang>tang then
     angv=-v
     if(i.ang>0.75 and tang<0.25)angv=v
    elseif i.ang<tang then
     angv=v
     if(tang>0.75 and i.ang<0.25)angv=-v
    end

	   i.ang+=angv

    i.xv,i.yv=mid(-vmod,i.xv+cos(i.ang-0.25)*0.01*vmod,vmod),mid(-0.5*vmod,i.yv-sin(i.ang-0.25)*0.01*vmod,0.5*vmod)

   elseif ai=="eye" then
	   grav,bouncy=false,true
	   i.spr+=t%20\10

    i.xv,i.yv=mid(-0.8,i.xv+(px-i.x)*0.001,0.8),mid(-0.5,i.yv+(py-i.y)*0.001,0.5)

	   i.ang=(atan2(i.yv,i.xv)+0.5)%1

	  elseif ai=="bat" then
	   grav,bouncy=false,true
	   i.spr+=t%16\8
	   i.xv,i.yv=mid(-1.2*vmod,i.xv+sgn(px-i.x)/80*vmod,1.2*vmod),mid(-vmod,i.yv+sgn(py-i.y)/80*vmod,vmod)
	   i.flip=i.xv<0

   elseif ai=="eoc" then
	   grav,collide,friction,i.ang,boss=false,false,false,(atan2(py-i.y,px-i.x)+0.5)%1,true

    if i.hp<1200 then
     i.damage,i.defence=23,0
     if(not i.secondphase)i.dashstate=1 i.secondphase=true
    end

    -- leave
    if timelight<=1 then
     i.yv-=0.02

    -- spiiin
    elseif i.dashstate==1 then
     i.av=i.av or 0
     i.a=i.a or i.ang
     i.av+=0.002
     i.a+=i.av

     i.ang=i.a

     if(i.av>0.2) sfx(10) i.dashstate=false i.sprx=10

    -- dash
    elseif i.dashstate then

     i.v=i.v or 0
     i.va=i.va or 0
     if i.t%120==0 then
      i.v=(i.secondphase and 2.4 or 1.6)*vmod
      i.va=0.25-i.ang
      if(i.secondphase)sfx(10)
     end
     i.xv=cos(i.va)*i.v
     i.yv=sin(i.va)*i.v
     i.v*=0.98

    -- float above
    else

     if i.t%120==0 and not i.secondphase then
      addmob(i.id.."servant",i.x,i.y)
     end

     if i.x<px then
      if i.xv<0 then
       i.xv+=0.1
      else
       i.xv+=0.05
      end
     end
     if i.x>px then
      if i.xv>0 then
       i.xv-=0.1
      else
       i.xv-=0.05
      end
     end

     if i.y<py-40 then
      if i.yv<0 then
       i.yv+=0.1
      else
       i.yv+=0.05
      end
     end
     if i.y>py-40 then
      if i.yv>0 then
       i.yv-=0.1
      else
       i.yv-=0.05
      end
     end

	    i.xv,i.yv=mid(-vmod,i.xv,vmod),mid(-vmod,i.yv,vmod)

    end

    i.t=max(i.t+1)

    -- loop states
    if i.t%360==0 and i.dashstate~=1 then
     i.dashstate=not i.dashstate
    end

	  end
	
	  -- fall
	  if grav then
	   i.yv+=grv
	  end

   -- pixel scale
   pxw,pxh=i.w*4*i.scale,i.h*4*i.scale

	  -- collide with player
	  if enemy and not pdead then
	   if piframes<=0 and abs(px-i.x)<pxw and abs(py-i.y)<pxh then
	    php-=i.damage
	    piframes,pxv,pyv=30,sgn(px-i.x)*1.2,-1.2
		   sfx(ptype)
	   end
	  end

   -- collide with projectiles
   hit=false
   for a in all(projectiles) do
    if i.iframes==0 and abs(a.x-i.x)<pxw and abs(a.y-i.y)<pxh then
     i.hp-=max(a.damage-i.defence/2,1)
     i.xv=sgn(i.x-a.x)*knockback
	    hit=true
	    del(projectiles,a)
    end
   end

	  -- collide with blocks
	  if collide then
	   left,right,up,down=false,false,false,false
	
			 -- collisions
			 xr,yr=pxw,pxh

			 -- down
			 d,e,i.air=0,false,true
			 repeat
			  l,r=bget((i.x-pxw+1)/8,(i.y+pxh+d)/8),bget((i.x+pxw-2)/8,(i.y+pxh+d)/8)
			  if i.yv>0 and (fget(l,0) or fget(l,3) or fget(r,0) or fget(r,3)) then
			   i.yv=bouncy and -i.yv or 0
			   i.y+=d
			   e,down,i.air=true,true,false
			  end
			  d+=1
			 until d>i.yv or e

			 -- up
			 d,e=0,false
			 repeat
			  lef,rgt=fget(bget((i.x-pxw+1)/8,(i.y-pxh-1+d)/8),0),fget(bget((i.x+pxw-2)/8,(i.y-pxh-1+d)/8),0)
			  if i.yv<0 and (lef or rgt) then
			   if lef and rgt then
			    i.yv=bouncy and -i.yv or 0
			    i.y+=d
			   end
			   if(not rgt)i.x+=1
			   if(not lef)i.x-=1
			   e,up=true,true
			  end
			  d-=1
			 until d<i.yv or e

			 -- right
			 d,e=0,false
			 repeat
			  top=fget(bget((i.x+pxw-1+d)/8,(i.y-pxh)/8),0)
			  if i.xv>0 and (top or fget(bget((i.x+pxw-1+d)/8,(i.y+pxh-1)/8),0)) then
			   i.xv=bouncy and -i.xv or 0
			   i.x+=d
			   if(not top)i.y-=1 i.yv=min(i.yv)
		    e,right=true,true
			  end
			  d+=1
			 until d>i.xv or e

			 -- left
			 d,e=0,false
			 repeat
			  top=fget(bget((i.x-pxw+d)/8,(i.y-pxh)/8),0)
			  if i.xv<0 and (top or fget(bget((i.x-pxw+d)/8,(i.y+pxh-1)/8),0)) then
			   i.xv=bouncy and -i.xv or 0
			   i.x+=d
			   if(not top)i.y-=1 i.yv=min(i.yv)
			   e,left=true,true
			  end
			  d-=1
			 until d<i.xv or e

	  end

	  -- ground/air friction
	  if(friction)i.xv*=down and 0.8 or 0.99

   -- move
	  i.x+=i.xv
	  i.y+=i.yv
	
	  -- after collisions ai
	  if ai=="fighter" then

	   -- zombie jump at walls and near but below player
	   if down and (left or right or (i.y>py+2 and abs(px-i.x)<16)) then
	    i.yv=jmp
	   end

	  -- slime step over tiles
	  elseif ai=="slime" then
	   if((left or right) and not down)i.xv+=(v-i.xv)/10

	  end

   -- player hit enemies
   if helditem.melee and pswing>0 then
    if i.iframes==0 and abs(px+wxo-i.x)<pxw+3 and abs(py+wyo-i.y)<pxh+3 then
	    i.hp-=max(helditem.damage-i.defence/2,1)
     if(knockback>0)i.xv=(pflip and -1 or 1)*knockback
	    hit=true
	   end
   end
   i.iframes=max(i.iframes-1)

   -- hit effects
   if hit then
    i.iframes,i.angry=pswing,true
	   sfx(6)
    if(knockback>0)i.yv=-1*knockback
	  end

   -- get line of sight
   cansee,sight,d=true,1,dist(px-i.x,py-i.y)

   -- check if closest or boss
   if d<distance or boss then

    ba=0.25-atan2(py-i.y,px-i.x)
    repeat
     if(fget(bget((i.x-cos(ba)*sight)/8,(i.y-sin(ba)*sight)/8),0))cansee=false
     sight+=1
    until sight>d

    if cansee then
     distance,pangle=d,ba
     if(boss)distance=0
    end
   end

	  -- despawn
	  if d>200 then
	   i.despt-=1
   end
   -- die
   if i.hp<=0 then
    if i.drop then
	    it=split(i.drop,":")
	    for a=1,it[2] do
	     additem(it[1],i.x,i.y)
		   end

     -- randomly drop health pickups
		   if(rnd(12)<1)additem(125,i.x,i.y)
	   end
	   del(mobs,i)
	  elseif i.despt<=0 or d>360 or pdead then
	   del(mobs,i)
   end
	  -- light
   --add(lights,{i.x,i.y})
	 end

	 piframes=max(piframes-1)

	 -- player die
	 if php<=0 and not pdead then
	  php,pdiet,pdead,pswing=0,60,true,0
	  sfx(2)
	 end

	 -- player sprites
	 if pswing~=0 then
	  pspr=131+((hiuse-pswing)/hiuse*3)%3
	 elseif pair then
	  pspr=130
	 elseif pxv==0 then
	  pspr=128
	 else
	  pspr=128+px/8%2
	 end

	 -- camera
	 cam_x,cam_y=mid(0,px-64,_🐱w*8-128),mid(0,py-64,_🐱h*8-128)

 end--invopen

 if helditem.id==17 then
  add(lights,{px,py})
 end

 -- add lights
 --lights[1]={px,py}
--[[
 for iy=flr(cam_y/8)-1,flr(cam_y/8)+18 do
  for ix=flr(cam_x/8)-1,flr(cam_x/8)+17 do
--
   if iy<surfacelevel and not fget(bget(ix,iy),0) then
    canlight=false
    for lx=-1,1 do
     for ly=-1,1 do
      if not canlight and abs(lx)+abs(ly)==1 and fget(bget(ix+lx,iy+ly),0) then
       canlight=true
      end
     end
    end
    if(canlight)add(lights,{ix*8+4,iy*8+4})
   end
   if bget(ix,iy)==17 then
    add(lights,{ix*8+4,iy*8+4})
   end
  end
 end
]]

 -- toggle inventory
 if btnp(6) and not pdead then
  poke(0x5f30,1)
  sfx(invopen and 8 or 7)
  invopen=not invopen
  updaterecipes()
 end

 t,php=max(t+1),min(php,php_max)

 -- frame
 --worldtime+=0.2778

 -- night
 if worldtime<2000 or worldtime>18000 then
  timelight=5

 -- early dawn
 elseif worldtime<3000 then
  timelight=4

 -- dawn
 elseif worldtime<4000 then
  timelight=3

 -- late dawn
 elseif worldtime<5000 then
  timelight=2

 -- late dusk
 elseif worldtime>17000 then
  timelight=4

 -- dusk
 elseif worldtime>16000 then
  timelight=3

 -- early dusk
 elseif worldtime>15000 then
  timelight=2

 -- day
 else
  timelight=1

 end

 -- fade music
 if nextmusic~=currentmusic or stat(24)==-1 then
  music(-1,100)
  currentmusic=nextmusic
 end
 -- start new music
 if stat(24)==-1 then
  music(nextmusic,1000)
 end

end



function _draw()

 pal()
 palt(0,false)
 palt(14,true)

 cls(14)

 camera()

 -- bg
 e=flr(cam_y)
 rectfill(0,surfacelevel*8-e,127,80*8,1)
 rectfill(0,cavernlevel*8-e,127,130*8,12)

 -- woah
 bigmap(0,0,-flr(cam_x),-e)

 camera(cam_x,cam_y)
 --map(0,0,-x,-y,128,64)
 --rect(px-4,py-4,px+3,py+3,7)

 -- treetops and light tiles
 for iy=flr(cam_y/8)-1,flr(cam_y/8)+18 do
  for ix=flr(cam_x/8)-1,flr(cam_x/8)+17 do

   if bget(ix,iy)==111 and bget(ix,iy-1)~=111 then
    y=iy
    repeat
     y+=1
    until bget(ix,y)==127
    s,w,o,b=142,2,4,bget(ix,y+1)
    if(b==6)s=137w=3o=8
    if(b==10)s=140
    spr(s,ix*8-o,iy*8-16,w,2)

   elseif bget(ix,iy)==17 then
    add(lights,{ix*8+4,iy*8+4})
   end

  end
 end

 for i in all(items) do
  sspr(i.id%16*8,i.id\16*8,8,8,i.x-2,i.y-2,4,4)
 end

 pal(11,14)

 -- mobs
 for i in all(mobs) do
  --spr(i.spr,i.x-i.w*4,i.y-i.h*4,i.w,i.h,i.flip)

  -- rotatey
  if i.rspr then
   rspr(i.x,i.y,i.ang,i.sprx,i.spry,i.w)

  -- non-rotatey
  else
   sspr(flr(i.spr)%16*8,i.spr\16*8,i.w*8,i.h*8,i.x-i.w*4*i.scale,i.y-i.h*4*i.scale,i.w*8*i.scale,i.h*8*i.scale,i.flip)
  end
 
  -- extra details
  if i.id=="kingslime" then
   vo=(i.spr==233 and 2*i.scale or 0)
   -- crown
   spr(206,i.x-8,i.y-i.h*4*i.scale-5.5+vo,2,1)
   -- ninja
   spr(236,i.x-4,i.y-4+vo/2)
  end
 end

 -- projectiles
 for i in all(projectiles) do
  mset(1,1,i.id)
  rspr(i.x,i.y,atan2(i.yv,i.xv)+0.5,1,1,1)
 end

 pal(11,11)

 -- player
 if not pdead and (piframes==0 or t%4<2) then
  spr(pspr,px-4,py-4,1,1,pflip)
 end

 -- player tool
 mset(1,1,helditem.id)
 if pswing>0 then
		vflip=false
		if helditem.type=="ranged" or helditem.type=="magic" then
		 pangle%=1
		 wxo,wyo=cos(pangle)*8,sin(pangle)*8
		 rspr(px+wxo,py+wyo,-pangle,1,1,1,false,pangle<=0.75 and pangle>0.25)
		else
   rspr(px+wxo,py+wyo,atan2(wyo,wxo)-(pflip and 0.625 or 0.375),1,1,1,not pflip)
		end

  --spr(helditem.id,px+wxo-4,py+wyo-4,1,1,wflip,pspr==133)

  -- break progress
  --pdigt>=helditem.usetime*3
  if digging then
   spr(192+(pdigt/hiuse)*2,(px+digx)\8*8,(py+digy)\8*8)
  end
 end

 camera()

 --pset(64,64,7)

 -- inventory
 for id,i in pairs(inventory) do
  invy=id*13-invsel*13+64
  if invside==1 and id==invsel and not hoveritem then
   sspr(90,84,12,12,115,invy-14)
  else
   sspr(102,86,10,10,116,invy-13)
  end
  spr(i.id,117,invy-12)
  if(i.amount and i.amount>1)print(i.amount,116,invy-8,11)

 end

 -- hovering item
 if hoveritem then
  sspr(90,84,12,12,103,50)
  spr(hoveritem.id,105,52)
  --print(hoveritem.type,64,64)
 end

 -- trashed item slot
 if invopen then
  sspr(80,86,10,10,116,116)
  if trashslot then
   spr(trashslot.id,117,117)
  end
 end

 if(#inventory==0)bprint("you've trashed all your items!\nthat may be an issue",2,115)

 -- craft
 selectedcraft=0
 if invopen then
	 for id,i in pairs(craftable) do
	  out,ing=craftable[id][1],craftable[id][2]

	  invy=id*13-craftsel*13+64
	  if invside==0 and id==craftsel then
	   sspr(90,84,12,12,1,invy-14)
	   selectedcraft=out[1]
	  else
	   sspr(102,86,10,10,2,invy-13)
	  end
	  spr(out[1],3,invy-12)
	  if(out[2] and out[2]>1)print(out[2],2,invy-8,11)

	 end
 end

 -- health bar
 for i=0,(php_max-1)\20 do
  sspr(112,87,9,9,(i*8%80)+1,(i*8\80)*8+1)
 end
 for i=0,(php-1)\20 do
  sspr(121,89,7,7,(i*8%80)+2,(i*8\80)*8+2)
 end
 bprint(flr(php).."/"..php_max,2,12+(php_max-20)\200*8)

 -- menu label / item name
 if invopen and #inventory>0 then
  cprint(invside==1 and "inventory" or "crafting",121)

  cprint(tilenames[
   (hoveritem and hoveritem.id) or
   (invside==1 and inventory[invsel] and inventory[invsel].id) or
   (invside==0 and selectedcraft)
   ] or "\nmissing name",40)
 end

 if pdead then
  --cprint(pdiet\60+1,60,11,15)
  --cprint("you were slain",68,11,15)

  cprint("you were slain",60,11,15)
  if(pdiet==0)cprint("jump to respawn",68,11,15)
 end

 -- get light level
 d=120
 for i in all(lights) do
  d=min(dist(i[1]-px,i[2]-py),d)
 end
 if d<48 then
  distlight=1
 elseif d<64 then
  distlight=2
 elseif d<80 then
  distlight=3
 elseif d<88 then
  distlight=4
 else
  distlight=5
 end
 if py/8<surfacelevel+2 then
  surfacelight=1
 elseif py/8<surfacelevel+5 then
  surfacelight=2
 elseif py/8<surfacelevel+8 then
  surfacelight=3
 elseif py/8<surfacelevel+11 then
  surfacelight=4
 else
  surfacelight=5
 end

 -- apply light level palette
 pal(split(palettes[min(distlight,max(surfacelight,timelight))]),1)

 -- sky
 pal(14,split"12,140,1,129,0"[timelight],1)

 -- keep palette
 --poke(0x5f2e,1)

end

---function music()return 0 end

-->8
-- bigmap
-- by cubee 🐱

--[[

obsolete in 0.2.3b

for terra, swap between normal
and extended ram for drawing
tline and map respectively


  === extended memory map ===

utilises the extended memory to
store a larger map that can be
about the same size as tic-80's

       === map sizes ===

 tic-80 map | pico-8 map |  fc  
------------+------------+------
  240X136   |   128X64   | tiles
 1920X1088  |  1024X512  | pixel

  bigger map, plus all sprite
space and original map available

]]

-- init
poke(24374,16)
_🐱s=0x8000 -- ram start
_🐱w=252 -- map width
_🐱h=130 -- map height

-- check if map will fit
assert(_🐱w*_🐱h>-1,"map too big!")

-- clear map
for i=0,_🐱w*_🐱h-1 do
poke(_🐱s+i,0)
end

-- bigmap mget
function bget(x,y)
 -- 4 in this game is unbreakable solid
 if(x<0 or y<0 or x>=_🐱w or y>=_🐱h)return 4
	return @(_🐱s+flr(x)+flr(y)*_🐱w)
end

-- bigmap mset
function bset(x,y,t)
 if(x<0 or y<0 or x>=_🐱w or y>=_🐱h)return
	poke(_🐱s+flr(x)+flr(y)*_🐱w,t)
end

-- bigmap map
function bigmap(x,y,tx,ty,w,h)
 x=x or 0
 y=y or 0
 tx=tx or 0
 ty=ty or 0
 w=w or _🐱w
 h=h or _🐱h
	for ix=max(flr(-tx/8),0),min(flr(-tx/8)+16,w-1) do
	 for iy=max(flr(-ty/8),0),min(flr(-ty/8)+16,h-1) do
   _t=@(_🐱s+ix+iy*_🐱w)
	  if(_t>0)spr(_t,ix*8+tx,iy*8+ty)
	 end
	end
end

-->8
-- worldgen

function generate()
 function genprint(t)
  camera()
  cls()
  cprint(t,62,7,5)
  flip()
 end
 function maketunnel()
  -- cave tunnel
  for ix=-s,s do
   for iy=-s,s do
	   -- place walls above height
    if cy<60 then
	    reptil=bget(cx+ix,cy+iy)
	    if(reptil<64 and reptil>0)reptil+=64
	    bset(cx+ix,cy+iy,reptil)
    else
     bset(cx+ix,cy+iy,0)
    end
   end
  end
	end

 genprint("generating world...")

 worlddir=sgn(rnd(2)-1)

	ry=30
	ra=0
	tunnel=0
	dirttile=2
 genprint("sculpting the land")
	for ix=0,_🐱w-1 do

	 -- ground height
	 ra+=(rnd(2)-1)/10
	 ra=mid(-0.22,ra,0.22)
	 ry+=sin(ra)/4

	 -- limit ground variation
	 if ry<20 or ry>surfacelevel then
	  ra,ry=0,mid(20,ry,surfacelevel)
	 end

	 -- tunnels
	 if rnd(50)<1 and tunnel<=0 then
	  tunnel=flr(rnd(8)+6)
	 end

	 -- add tiles
	 for iy=0,_🐱h-1 do

	  -- stone
	  if iy>ry+10 then
	   bset(ix,iy,dirttile==7 and 7 or 3)

   -- dirt
	  elseif iy>=flr(ry) then

	   -- put jungle
	   if ix>_🐱w/2+_🐱w/4*worlddir-(26+rnd(4)) and ix<_🐱w/2+_🐱w/4*worlddir+(26+rnd(4)) then
	    dirttile=7

    -- put corruption
	   elseif ix>_🐱w/2-_🐱w/4*worlddir-(26+rnd(4)) and ix<_🐱w/2-_🐱w/4*worlddir+(26+rnd(4)) then
	    dirttile=11
     --tunnel=0

	   else
	    dirttile=2
	   end
	   bset(ix,iy,dirttile)

	  end

	 end

  -- generate tunnels
	 if tunnel>0 then
	  for i=1,5 do
    bset(ix,ry-i,i>3 and dirttile or (dirttile+64))
	  end
   --bset(ix,ry-5,2)
	  tunnel-=1
	 end
	end

 genprint("making spaghetti caves")
 for i=0,50 do
  a,cx,cy,s=rnd(),rnd(_🐱w),rnd(_🐱h-50-i/2)+50+i/2,rnd(2)+1
  for l=0,10+rnd(80) do
   av=(rnd(2)-1)/12
   a+=av

   cx+=cos(a)
   cy+=sin(a)
   
   cx,cy=mid(0,cx,_🐱w),mid(surfacelevel,cy,_🐱h)
	  -- cave
	  maketunnel()
  
  end
  
 end

 genprint("digging corrupt chasms")
 chasms=0
 repeat

  -- go to ground
  x,y=rnd(_🐱w),0
  repeat
   y+=1
  until bget(x,y)==11 or y>40

  -- has found corrupt?
  if y<=surfacelevel then

   for l=2,30+rnd(20) do

		  -- make tunnel
		  s=3
    x+=rnd(2)-1
		  for ix=-s,s do
		   for iy=-s,s do
		    if (abs(ix)>=s-1 or iy>=s-1) and bget(x+ix,y+iy+l)~=76 then
		     bset(x+ix,y+iy+l,12)
		    else
		     bset(x+ix,y+iy+l,76)
		    end
		    bset(x,y+l,77)
		   end
		  end
		  
   end
  end

	 -- count chasms
	 chasms=0
	 for ix=0,_🐱w do
	  for iy=0,_🐱h do
	   if bget(ix,iy)==77 then
	    chasms+=1
	   end
		 end
		end

	until chasms>=3

 genprint("adding mounds of dirt")
	-- forest/jungle cave entrances
 surfacecaves=0
	repeat
	 ix,iy=rnd(_🐱w-40)+20,0

	 -- go to ground
	 repeat
	  iy+=1
	  dirttile=bget(ix,iy)
	 until dirtitle==2 or dirttile==7 or iy>_🐱h/2

  -- don't spawn them underground
  if iy<=_🐱h/2 then
	  
		 -- circle
	  r=7+rnd(4)
		 for y2=-r,r do
		  x2=flr(sqrt(abs(y2*y2-r*r)))
		  --tline(ix-x2,iy+y2,ix+x2,iy+y2,(ix+mx*8-x2)/8,(iy+my*8+y2)/8)
		  for ox=ix-x2,ix+x2 do
		   bset(ox,iy+y2+3,dirttile)
		  end
		 end
		 
		 -- cave
		 xo,s=sgn(rnd(2)-1),1
		 ca,cx,cy=0.5-0.25*xo,ix+xo*r,iy
		 for l=0,80+rnd(40) do
		  ca=mid(0.25,ca+(rnd(2)-1)/8,0.75)

		  cx+=cos(ca+0.25)
		  cy+=sin(ca+0.25)
	
		  -- cave tunnel
		  maketunnel()
		  
		  surfacecaves+=1
		  
		 end
		 
		end
		 
	until surfacecaves>=3

--[[
 genprint("placing oceans")
 -- find ground level
 ly=0
 ry=0
 repeat
  ly+=1
 until fget(bget(20,ly),0) or ly>surfacelevel
 repeat
  ry+=1
 until fget(bget(_🐱w-20,ry),0) or ry>surfacelevel
 ly-=6
 ry-=6

 -- place ocean
	for ix=0,_🐱w do

	 -- put left ocean
	 if ix<20 then
	  for oy=0,20-ix/2 do
	   bset(ix,ly+oy,8)
	  end
	  for oy=0,10-ix/4 do
	   bset(ix,ly+oy,0)
	  end

	 -- put right ocean
	 elseif ix>=_🐱w-20 then
	  for oy=20-(_🐱w-ix)/2,0,-1 do
	   bset(ix,ry+oy,8)
	  end
	  for oy=10-(_🐱w-ix)/4,0,-1 do
	   bset(ix,ry+oy,0)
	  end

	 end
 end
]]

 genprint("adding various details")
	-- post processing
	for ix=0,_🐱w-1 do
	 for iy=0,_🐱h-1 do
	 
	  -- add grass on dirt and mud
	  if (bget(ix,iy)==2 or bget(ix,iy)==7 or bget(ix,iy)==11) and not (fget(bget(ix,iy-1),0) or fget(bget(ix,iy-1),2)) then
	   bset(ix,iy,bget(ix,iy)-1)

    -- trees
    if rnd(2)<1 then
     cantree=true
     th=4+rnd(5)
     
     for y=1,th+4 do
      if bget(ix,iy-y)~=0 then
       cantree=false
      end
     end

     if cantree then
	     for y=2,th do
       bset(ix,iy-y,111)
	     end
      bset(ix,iy-1,127)
     end

    end
    -- end trees

   --[[ open corrupt chasms
   elseif bget(ix,iy)==12 and bget(ix,iy-1)==0 and bget(ix,iy+1)==76 then
    bset(ix,iy,0)]]

	  end


--[[
	 -- generate trees
	 if rnd(10)<5 then
	  ty=ry-(tunnel>0 and 6 or 1)
	  bset(ix,ty,63)
   for i=1,4+rnd(4) do
    bset(ix,ty-i,47)
   end
   
	 end]]
	 
	 end
	end

 genprint("hiding life crystals")

 crystals=0
 repeat
  ix,iy=rnd(_🐱w),rnd(_🐱h-70)+60
  -- life crystals
  if bget(ix,iy)==0 and fget(bget(ix,iy+1),0) then
   bset(ix,iy,9)
   crystals+=1
  end
 until crystals>=20

 genprint("metal. take it or leave it")
 ores=0
 repeat
  ix,iy=rnd(_🐱w),rnd(_🐱h-90)+ores/2

  -- vein
  set=false
  for i=0,3+rnd(4)+iy/30 do
   ix+=rnd(2)-1
   iy+=rnd(2)-1
   tile=bget(ix,iy)
   if tile==2 or tile==3 or tile==7 or tile==11 then
    bset(ix,iy,19+ores/46)
    set=true
   end
  end
  if(set)ores+=1
 until ores>=180

end

-->8
-- functions

function addmob(id,x,y,override)
 -- name = hp, damage, defence, drop
 -- drop: id:amount:type
 stats={
  gslime="14,6,0,59:1",
  bslime="25,7,2,59:1",
  rslime="45,15,4,59:2",--blackslime
  yslime="45,15,7,59:2",
  jslime="60,18,6,59:2",
  eye="60,18,2,54:1",
  zombie="45,14,6",
  eater="40,22,8,61:1",
  bat="16,13,2",
  jbat="34,20,4",
  hornet="48,26,12,60:1",
  eocservant="8,12,0,125:1",
  marcoservant="20,12,0,125:1",
  skeleton="60,20,8",
  eoc="2400,10,12,23:18",
  kingslime="1800,25,10,22:12",
  marco="3000,20,12,27:1"
  --thanks for the fun, 3ds version

 }

 -- mob cap
 s=split(stats[id])
 if((#mobs<8 or override) and s)add(mobs,{id=id,x=x,y=y,xv=0,yv=0,spr=176,scale=1,hp=s[1],damage=s[2],defence=s[3],w=1,h=1,despt=300,ang=0,iframes=0,drop=s[4],t=0})

end

function additem(id,x,y,amount)
 add(items,{id=id,amount=amount or 1,x=x,y=y,xv=(rnd(2)-1)/3,yv=-1,timer=60})
end

function addprojectile(id,x,y,a,damage,s)
 s=s or 3
 s/=2
 add(projectiles,{
  id=id,x=x,y=y,xv=cos(a)*s,yv=sin(a)*s,damage=damage,
  grav=id==52 or id==53
 })
end

function bprint(t,x,y,c1,c2)
 for ix=-1,1 do
  for iy=-1,1 do
   ?t,x+ix,y+iy,c2 or 6
  end
 end
 ?t,x,y,c1 or 11
end

function cprint(t,y,c1,c2)
 bprint(t,66-#tostr(t)*2,y,c1,c2)
end

-- check crafting recipes
function updaterecipes()

 --craftable=recipes
 craftable={}
 for i in all(recipes) do

  -- station
  s,cancraft=i[1][3],false

  -- check station nearby
  for ix=-3,3 do
   for iy=-3,3 do
    if not s or bget(px/8+ix,py/8+iy)==s then
     cancraft=true
    end
   end
  end

  -- check ingredients
  for r in all(i[2]) do
   a=r[2] or 1--amount
   for slot in all(inventory) do
    if slot.id==r[1] then
     a-=slot.amount
    end
   end

   -- can't craft if not enough
   if(a>0)cancraft=false

  end

  -- add recipe
  if(cancraft)add(craftable,i)
 end

end

function spawnplayer(hp)
 pdead,php,px,py,pxv,pyv,piframes=false,hp or php_max,_🐱w*4,0,0,0,60
 repeat
  py+=8
 until fget(bget(px/8,py/8),0)
 py-=4
end
-->8
-- borrowed functions


-- tHErOBOz (mODIFIED BY CUBEE)

--[[ 🐱

 reduced size to clip corners
 fixed horizontal flipping
 added vertical flipping
 
]]

function rspr(x,y,sw_rot,mx,my,r,flip,vflip)

 if(flip or vflip)sw_rot=-sw_rot

 local cs,ss,ssx,ssy,cx,cy,yf=cos(sw_rot),-sin(sw_rot),mx-0.3,my-0.3,mx+r/2,my+r/2,vflip and -1 or 1

 ssy-=cy-0.1
 ssx-=cx-0.1

 local sx,sy,delta_px=cs*ssx+cx,-ss*ssx+cy,-ssx*8
 if(flip)delta_px=-delta_px x-=1

 --this just draw a bounding box to show the exact draw area
 --rect(x-delta_px,y-delta_px,x+delta_px,y+delta_px,5)

 for py=y-abs(delta_px)*yf,y+abs(delta_px)*yf,yf do
  tline(x-delta_px,py,x+delta_px,py,sx+ss*ssy,sy+cs*ssy,cs/8,-ss/8)
  ssy+=1/8
 end
end


--freds72

function dist(dx,dy)
local maskx,masky=dx>>31,dy>>31
local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
if a0>b0 then
return a0*0.9609+b0*0.3984
end
return b0*0.9609+a0*0.3984
end
__gfx__
09aaa990aa9aa99a1222333266677761effffffe34444442aa9aa99a1112221145554443eeeeeeee1101100112223332ccc666c16177617734444442eeeeeeee
a323332999a218992233232367767676ffeeefff4344434399a108991221212154545544effeef2e0012110022332323c66c6c6c6176617643444343eeeeeeee
a3223269189322982223332216777661feeeffff44433433089211981122211144555433f44ff4f210032201222333221c666cc16166616644433433eeeeeeee
89a32998222332222233323267776766feefffef32222332111221111222121145455544f4fffff22223322222333232c666c6cc1111111132222332eeeeeeee
08967980223333322323233276767766fefffeef444423441122222121212211455454542fffff2222333332232323326c6c66cc77617761eeeeeeee32333322
00976900232333222332332377677676ffffeeef44343434121222112212212154554554e2fff22e232333222332332366c66c6c76617661eeeeeeee22222222
00966a00223232322233323266666761fffeeeff34432443112121211222121145444443ee2f22ee2232323222333232ccccc6c166616661eeeeeeeee111111e
008a9800222222212322222161116611effffffe33222322111111102111111134433343eee22eee2222222123222221c111cc1111111111eeeeeeeee2eeee2e
eeeeeeeeeeeeeeeeeeeeeeee2333444376667667677bbb774455554411666611eeeeee61eee77eeee1666eeeeeeeeeeeee5b5eeeeebbbeeeee777eeeee333eee
eeeeeeeeeeefeeeeeeeeeeee33443434677bb7766bb7b7b745bb5b5416776761eeeee61cee7997eeeee116ceee5b5eeeee6e45eeee6e7beeee6e67eeee6e23ee
6666661eeeeffeeeeeeeeeee333444337bb7bb667b77bb7655b5555566766666eeee61cee790097eeeee116ee54eeeeeee7ee54eee7eeb7eee7ee76eee7ee32e
6100011eeef44feeeeeeeeee33444343bb7bb7767bbbbb774555545516666166e6e61cee67900976eee6c116ebeb545eee7eef2eee7ee21eee7ee32eee7ee76e
10000077ee4454ee67b77611343434437bbb7b77b7bbb7b75455445461661161e661ceee16799761ee6c1e1ee545bebeee7eef2eee7ee21eee7ee32eee7ee76e
77777776eee34eee1666661e3443443477b7b7767bbb77b74554455416611661ec16eeeee167761ee6c1eeeeeeeee45eee7ee43eee7ee76eee7ee61eee7ee21e
1111111eeee33eeee11111ee3344434367677767677bbb7734555544c166661161cc1eeeee1661ee6c1eeeeeeee5b5eeee6e54eeee6eb7eeee6e76eeee6e32ee
6161611eeee32eeeee7661ee343333326776667676777776434444431c11111c1ceeeeeeeee11eeec1eeeeeeeeeeeeeeee544eeeeeb77eeeee766eeeee322eee
eeeb5eeeeeb55eeeeeeeeeb5eeeb5eeeeeebbeeeeebbbeeeeeeeeebbeeebbeeeeee77eeeee777eeeeeeeee77eee77eeeeee33eeeee333eeeeeeeee33eee33eee
eeb5451eeee442feeeeeeb54eeb5442eeebb7b7eeee772feeeeeebb7eebb772eee77676eeee6676eeeeee776ee77662eee33232eeee2232eeeeee332ee33232e
ee542f5eeeee342eeeeeb54eee54f21eeeb72fbeeeee672eeeeebb7eeeb7f21eee76767eeeeec67eeeee776eee76621eee32323eeeee123eeeee332eee32321e
eee34243eee32345eeeb54eeeee421eeeee67276eee3267beeebb7eeeee721eeeeec6c6ceee32c67eee776eeeee621eeeee12121eee32123eee332eeeee321ee
ee323433ee321e45e5254eeeee321eeeee326766ee321e7bebfb7eeeee321eeeee32c6ccee321e67e7676eeeee321eeeee321211ee321e23e3232eeeee321eee
e321e33ee321eee4e1f2eeeee321eeeee321e66ee321eee7e12feeeee321eeeee321eccee321eee6e166eeeee321eeeee321e11ee321eee2e122eeeee321eeee
321eeeee321eeeee3214eeee321eeeee321eeeee321eeeee3217eeee321eeeee321eeeee321eeeee3216eeee321eeeee321eeeee321eeeee3212eeee321eeeee
21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee
eeeeeeeeee6c6eeeeeeeeeeeeeeeeeeeeee7eeeeeeeeee61eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeee6e16eeee77776eeeeeeeeeee766eeeeeeee61ceeeebeeeeeee766eeeeeb77eeeeebbbeeeeebb5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5e54e5e
ee77ee7eee7ee61ee76dbd7eeee7eeeeee626eeeeeee61ceeeebe7eeee76661ceeb77761eebbbb76eebb5543eeeddeeeeeee3eeeee671eeeeeff7deee54f244e
e7766666ee7ee98ee7dbdd7eee776eeeeee3eeeeee661ceeee7eebeee66661cce7777611ebbbb766eb555433eedbdceeeee2322eeee67c7eef267d0eed77ddce
3321eeeeee7ee98ee7bddc7eeee6eeeeeee2eeee116eceeeeebeebee66611ccc77766111bbb7766155544332eecdcceeeee321eeeeec876ef2f67c0edddddddc
22eeeeeeee7ee1cee7ddc76eeeeeeeeeeee7eeeeec16ceeeeee7b7ee1611ccce6766111e7b77666e4544333eeeecceeeee32eeeeee76761eee226ceecddddccc
eeeeeeeeee6e61eee67776eeeeeeeeeeee766eee61c1eeeeeeee7eee111cccee666111ee777661ee444332eeeeeeeeeeeeeeeeeeeee161eeeeeeeeeeecccccde
eeeeeeeeee61ceeeeeeeeeeeeeeeeeeeee6e6eee1ceceeeeeeeeeeeee1cceeeee611eeeee766eeeee433eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
21ff21ffe222222e00001110000ccc00e222222e01111110e222222e0111000012221111e222222ee222222e00001110000ccc00c000000ceee22eeee211111e
21f221f222eee222001101010cc0c0c022eee2221011101022eee222101011002121221122eee22222eee222001101010cc0c0c000666100eee32eeee222111e
212221222eee22220001110000ccc0002eee2222111001002eee222200111000112221112eee22222eee22220001110000ccc00006776610eee32eeee222111e
111111112ee222e2001110100ccc0c002ee222e2000000002ee222e201011100121222112ee222e22ee222e2001110100ccc0c0006776610eee32eeee222111e
ff21ff212e222ee201010110c0c0cc002e222ee2111100112e222ee201101010122121212e222ee22e222ee201010110c0c0cc0006666610ee6326eee222166e
f221f2212222eee201101101cc0cc0c02222eee2110101012222eee210110110212212212222eee22222eee201101101cc0cc0c001666110eee32eeee222111e
22212221222eee220011101000000c00222eee2201100110222eee220101110012111111222eee22222eee220011101000000c0000111100eee32eeee222111e
11111111e222222e0100000000000000e222222e00000000e222222e0000001011111111e222222ee222222e0100000000000000c000000ceee22eeee211111e
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee3331ee
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee2332ee
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee2322ee
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee2321ee
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee3321ee
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee2332ee
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee2322ee
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee3331ee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeee00000000ee3322ee
eb54b54eb54eeb54ebb7bb7ebb7eebb7e776776e776ee776e332332e332ee3320000000000000000000000000000000000000000effeeffe04400430ee2321ee
eb53b53e55bb5554ebb6bb6ebbbbbbb7e77c77ce77777776e331331e333333320000000000000000000000000000000000000000f44ff4ff45544543ee2321ee
e543543e45555543eb76b76e7bbbbb76e76c76ce6777776ce321321e233333210000000000000000000000000000000000000000f4ffffff45444443ee2332ee
e543543ee455443eeb76b76ee7bb776ee76c76cee67766cee321321ee233221e0000000000000000000000000000000000000000fffffff234444433ee3331ee
b554b543e555543ebbb7bb76ebbbb76e7776776ce77776ce33323321e333321e0000000000000000000000000000000000000000efffff2e03444330ee3321ee
44434433e455443e77767766e7bb776e666c66cce67766ce22212211e233221e0000000000000000000000000000000000000000ee2ff2ee00343300e332321e
eeeeeeeeee4433eeeeeeeeeeee7766eeeeeeeeeeee66cceeeeeeeeeeee2211ee0000000000000000000000000000000000000000eee22eee0003300032123321
ee22222eeeeeeeeeee22222e772222eeeeeeeeeeeeeeeeee0000000000000000eeeeeeeeeeeee89a8ca989989a8eceeeeeeeee1e16eeeeeeeeeeee8e89eeeeee
e226c6eeee22222e7726c666776c6eeeeee22772eeeeeeee0000000000000000eeeeeeeeeec9caaa9aaaa99aaa9a8cceee16116166161eeeee89889899898eee
ee6777eee226c6ee77677766ff677eeeee22f77eeee222220000000000000000eeaee7deee999aa9aaaaaaaaaa99898ce1766677677671eee8a999aa9aa9a8ee
eeffffeeee6777eeeffffffeeffff6eeeefff66eee2266ce0000000000000000ea98ddccc8999aaaaa9aaaa9aa999988e1667677767716eee899a9aaa9aa89ee
e77fff6e77ffff66eeffffeeeffff6eeeefff6eeeefff76e000000000000000033329aa988a9a9aa9a9aaaaa9aa99989ee6677767766771eee99aa9a9a99aa8e
e771116e77ffff66ee1111eee1111eeee11ff1eeee1fff77000000000000000032323299c9989aa9aa9aa9a9a98a999ce166666767776670e89999a9aaaa99ac
ee1111ee3311112233111122111111ee1111111ee11111770000000000000000332333238899a89aa9a9aaa98899988e1617767676677716898aa99aa99aaa89
e333222ee331122ee33ee22e333e222e333e222e333e222e000000000000000022222222c8898999999aa999989988cc0676776776766161c9a9aaa9a9aa989c
eeeeeeeeeeeeeeeeee66600eeeeeeeeeee4ee4eee4eeee4eeeeeeeeeeeeeeeeeeeeeeeeecc8898a999a99a98999898890166777777766110c899aaaaaaa99888
eeeeeeeeee1111eee60171eeee66600ee14ee41e14eeee41eeeeeeeeeeeeeeeeeeeeeeeeeec8c98989898889a88989cc1161767677666661889899a99a999998
ee1111eee166110eee1888eee60171ee1611116116111161122ee111eee122eeeeeee76eeccc8888889888998c9c9cee117671667661161188a9989999988988
e161110ee161110eee699988ee1888ee1670076116700761e111221eee2242eeeeeee76eeeec8c8c9888c888c9c8c8ce0116661776661101c889899a989988cc
16661110e111110eee66968eee69998891677619e167761eee1242eee221111eeeeee707eeeccecc8cccec8c8ccceeeee111161661616110ec889898889898ce
11111110e111110eee2221eeee66968ee116611e91166119eee111ee211ee111eee77666eeeeceeecc1eeec1ce1eeeeee10111101110101eeee8898c918c8cee
01111000e011000eee2211eeee22211ee916619eee1661eeeeeeeeeeeeeeeeeee676676eeeeeeeeee321e111ee28eeeee0e1011210e01e0eeeece882c1eeceee
e000001ee000001eee33222ee3331222eee66eeeee9669eeeeeeeeeeeeeeeeeeee77e76eeeeeeeeeee32121ee93eeeeeeee0ee2311ee0eeeeeeeee2321eeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee777eeeffeeeeeeffe2e23e3ee32e23ee000000000000000000000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaaaaee6677206eee77206e32177122ee1771e3000000000000000000000000000000000000000000000000
eeeeeeeeeeddddeecddeeccceeecddeeeeaaaaeeea55aa9eee54200177642001e17f271e317f2712000000000000000000000000000000000000000000000000
eeddddeeed77ddceecccddceeedd5deeea5aaa9eea5aaa9ee45541116655411137200f7227200f7e000000000000000000000000000000000000000000000000
ed77ddceedddddceeecd5deeeddccccea555aaa9eaaaaa9e55421eee55421eee27f00273e7f002720000000000e5555555554e00000000000000000000000000
dddddddcedddddceeeeccceedcceecccaaaaaaa9eaaaaa9e4554eeee4554eeeee172f71e2172f713000000000054444444445400000000000000000000000000
cddddcccecddccceeeeeeeeeeeeeeeee9aaaa999e9aa999ee3454eeee3454eee221771233e1771eeefffffff2e540000000054edddddddce0000000000000000
ecccccdeecccccdeeeeeeeeeeeeeeeeee99999aee99999aeeee433eeeee433eee3e32e2eee32e23ef2222222f2540000000054dcccccccdce4554554e0000000
eeeeeeeeeeeeeeeeee000eeeee000eeeeeeeeeeeeeeeeeeeeee77eeeeeeeeeeeeeeeeeeeeeeeeeeef2000000f2540000000054dc000000dc4522522540000000
eeeeeeeeeeeeeeeee7ddd6eee7ddd6eeeeeeeeeeee4444eeee7707eeeee77eeeeee00eeeeee00eeef2000000f2540000000054dc000000dc522222225effef2e
eeeeeeeeeeeeeeeee67776eee67776eeee4444eee455443eee6776eeee7707eeeeddddeeeeddddeef2000000f2540000000054dc000000dc522222225f4ff4f2
eeeeeeeeeeeaaeeeef2662eee2662feee454443ee454443eeecc66eeee6776eeee6776eeee6776eef2000000f2540000000054dc000000dc522222225ffffff2
eeeaaeeeeea5a9eeeffff2eeeffff2ee45554443e444443eee76c1eeeecc66eeeef662eeeef662eef2000000f2540000000054dc000000dc4522222542ffff22
ea55aa9eeeaaa9eeeff2feeeeef2f2ee44444443e444443eee66c1eee76cc16eee2ff2eeee2ff2eef2000000f2540000000054dc000000dce4522254ee2ff22e
e9aaa99eee9a99eeeefe2eeeee2efeee34444333e344333eee111eeee66cc11eeee2feeeeeef2eee2fffffff22455555555554cdddddddccee45254eeee222ee
ee999aeeee999aeeee2eeeeeeeee2eeee333334ee333334eee3322eee331122eeeee2eeeeee2eeeee22222222ee4444444444eecccccccceeee454eeeeee2eee
eeeeeeeeeeeeeeeeeeeeeeeeeeee0eeee0ee00eee0ee00e00000000000000000ef2eff2f2222222f22fe22feeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeee00eeeeee00eeeeee00eeeeee00ee0e0000000000000000e2eef22ff22ff2fffffeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee54eeeeeee
eeeeeeeeeeee0eeeeeee0eeeeeee0eee0eee0ee00e0e0ee00000000000000000eeeeef22ff22f2f2ffeeeeeeeeeee62344eeee44326eeeeeeee5e3e55e3e5eee
eeee0eeeeeee0eeeeeee0e0ee0ee0e0ee0ee0e0ee0ee0e0e0000000000000000eeeee22ef2ff2f2ef2eeeeeeeeee66344eeeeee44366eeeeeee5435554355eee
eee0eeeeee00e0eeee00e0eeee00e0eeee00e0eeee00e0ee0000000000000000eeeee2e2f22f2f2ef2eeeeeeeeeef62eeeeeeeeee262eeeeee554355443554ee
eeeeeeeeeeeeeeeee0e0ee0ee0e0ee00e0e0ee00e0e00e000000000000000000eeeeeeef2eeeeffef2eeeeeeeee6f7eeeeeeeeeeee622eeeee5a555f2555a4ee
eeeeeeeeeeeeeeeeeee0eeeee0e0eeee00e0eeee00e0ee0e0000000000000000eeeeeeef2eeeeefee2eeeeeeeee6672e344ee443ef766eeeee495552254493ee
eeeeeeeeeeeeeeeeeeeeeeeeeeee00eeeeee00eeee0e00e00000000000000000eeeeeee2eeeeee2eeeeeeeeeee6677f344eeee44377766eeee344444444333ee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000eeeeeeeeee333300eeeeeeeeeeeeeeeeecccccceeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000eeeeeeeeeee3022eeeeeeeeeeeeeeeedccccccccdeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000eeeeeeeeeee32eeeeeeeeeeeeeeee69ddccccccdd96eeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000eeeeeeee3e333222eeeeeeeeeeee667fd999999df266eeee
ee2ee32eeeeeeeee23ee2eeeeeee32eeeeeeeeeee23eeeee00000000000000000000000000000000eeeeeeee233333eeeeeeeeeeeeeef7777fff777f7762eeee
e22e33e111111161e33e22eee2e33ee111111161ee33e2ee00000000000000000000000000000000eeeeeeee3322323eeeeeeeeeeee6f7777777777777622eee
e32e22ee1161666ee22e23eee2222eee1161666eee2222ee00000000000000000000000000000000eeeeeeee321e3323eeeeeeeeeee667777777777777766eee
e331121116661661121133eee321121116661661121123ee00000000000000000000000000000000eeeeeeee3e1e23e2eeeeeeeeee66777f77777777777766ee
2e3161160760670611613e2ee331611607606706116133eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee6677727777777f277766ee
22e16600677077600661e22e2e3166006770776006613e2eeeeeeeeecddddddceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecceeeee2277f7f7777ff7772762ee
32161061117171116016123e22161061117171116016122eeeeeeedddddddddddceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecceeeeef267f77777777f7f7662ee
32161166601910666116123e32161166601a10666116123eeeeeeddd7777777dddceeeeeeeeeeeecddddddddceeeeeeeeecccceeeef26f7777777777f77662ee
e3161170769a9670711613ee3216117076a9a6707116123eeeeedd7777777ddddddceeeeeeeeedddddddddddddceeeeeecccccceeef22667f7777f77f26222ee
ee111676661a166676111eeee311167666191666761113eeeeedd7777ddddddddddcceeeeeeedddd7777777ddddceeeeececceceee22f2266277f776662222ee
eee16161616961616161eeeeeee16161616a61616161eeeeeeedd77dddddddddddddceeeeeedd77777777dddddddceeeeecccceeeee2ff2662662666662f2eee
ee81166a1611161a66118eeeee81166a1611161a66118eeeeecdd7ddddddddddddddcceeeedd77777dddddddddddcceeecceecceee2f2ff22666226222fff2ee
e88e66a986696689a66e88eeee8e66a9866a6689a66e8eeeeedddddddddddddddddccceeeedd77dddddddddddddddceeeeeeeeeeeefeff2f2222222f22fe2fee
e8eee69aa81618aa96eee8eeee8ee69aa81618aa96ee8eeeeedddddddddddddddddccceeecdd7ddddddddddddddddcceeeeeeeeeee2ef22ff22ff2fff2feefee
e8eee88a9a6a6a9a88eee8eeee8ee88a9a696a9a88e88eeeeedddddddddddddddddccceeedddddddddddddddddddccce344ee443eeeef2e2ff22f2f2ffeeeeee
e88eee8eea969aee8eee88eeee88e8eeea969aeee8e8eeeeeeddddddddddddddddcccdeeedddddddddddddddddddccce73eeee37eeee22eef2ff2f2e2f2eeeee
ee8eee88eeeeeee88eee8eeeeee8e8eeeeeeeeeee8e8eeeeeedddddddddddddddccccdeeedddddddddddddddddccccdef72eef77eeee2eeef22f2f2eef2eeeee
eeeeeee8eeeeeee8eeeeeeeeeeeee8eeeeeeeeeee8eeeeeeeecdddddddddddccccccddeeecddddddddddddcccccccdde6272f776eeeeeeeef2eeff2eef2eeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeecccdddcccccccccdddeeeeecccdddcccccccccccdddee62662666eeeeeeee22eeefeeee2eeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeccccccccccddddeeeeeeeeeccccccccccccddddeeee26662262eeeeeeee2eeee2eeeeeeeeee
__label__
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc33rr3r3r33rrj4kiccccccccccccc
cc9aa9aa9c9aa9aa9c9aa9aa9c9aa9aa9c9aa9aa9cccccccccccccccccccccccccccccccccccccccccccccccccccccccccj3333r3rrrr33r14kccccccccccccc
c9aooaoka9aooaoka9aooaoka9aooaoka9aooaoka9cccccccccccccccccccccccccccccccccccccccccccccccccccccccj3jrr33rr33rrrj3kkccccccccccccc
cao9oo9okao9oo9okao9oo9okao9oo9okao9oo9okaccccccccccccccccccccccccccccccccccccccccccccccccccccccc13r3rrr3r3rr3j314iccccccccccccc
caooooookaooooookaooooookaooooookaooooookacccccccccccccccccccccccccccccjcj3ccccccccccccjcj3cccccc1j33rrrrrrr33jjj4iccccjcj3ccccc
cakooookkakooookkakooookkakooookkakooookkacccccccccccccccccccccccccj3jj3j33j3jcccccj3jj3j33j3jcccjj3j33r33r33333j4kj3jj3j33j3jcc
c9akookka9akookka9akookka9akookka9akookka9ccccccccccccccccccccccccjr333rr3rr3rjcccjr333rr3rr3rjccjjr33j33333jj3jjkjr333rr3rr3rjc
cc9akkka9c9akkka9c9akkka9c9akkka9c9akkka9cccccccccccccccccccccccccj33r3rrr3rrj3cccj33r3rrr3rrj3cc1jj3j33r3j33jj11kj33r3rrr3rrj3c
ccc9aka9ccc9aka9ccc9aka9ccc9aka9ccc9aka9ccccccccccccccccccccccccccc33rr3r3r33rrjccc33rr3r3r33rrjcc1jj3j3jjj3j3j14ki33rr3r3r33rrj
cccc9a9ccccc9a9ccccc9a9ccccc9a9ccccc9a9cccccccccccccccccccccccccccj3333r3rrrr33r1cj3333r3rrrr33r1cccjj3j13ij1j1k44j3333r3rrrr33r
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccj3jrr33rr33rrrj3j3jrr33rr33rrrj3ccc1cjjk1icc1ck4j3jrr33rr33rrrj
c5555555555555c555555555555555ccccccccccccccccccccccccccccccccccc13r3rrr3r3rr3j3113r3rrr3r3rr3j31cccccck4kicccc4413r3rrr3r3rr3j3
c57755777577755575775577757775cjcj3cccccccccccccccccccccccccccccc1j33rrrrrrr33jjj1j33rrrrrrr33jjjcccccc444icccc441j33rrrrrrr33jj
c55755757575755755575575757575j3j33j3jcccccccccccccccccccccccccccjj3j33r33r33333jjj3j33r33r33333jcccccck44kcccck4jj3j33r33r33333
cc575575757575575c5755757575753rr3rr3rjccccccccccccccccccccccccccjjr33j33333jj3jjjjr33j33333jj3jjcccccck4kkcccck4jjr33j33333jj3j
c557557575757557555755757575753rrr3rrj3cccccccccccccccccccccccccc1jj3j33r3j33jj111jj3j33r3j33jj11cccccck4kicccck41jj3j33r3j33jj1
c57775777577757555777577757775r3r3r33rrjcccccccccccccccccccccccccc1jj3j3jjj3j3j1cc1jj3j3jjj3j3j1ccccccc44kicccc44k1jj3j3jjj3j3j1
c555555555555555155555555555553r3rrrr33r1cccccccccccccccccccccccccccjj3j13ij1j1cccccjj3j13ij1j1cccccccck44kcccck44kcjj3j13ij1j1c
cj3jrr33rr33rrrj3ccccccccj3jrr33rr33rrrj3ccccccccccccccccccccccccccc1cjjk1icc1cccccc1cjjk1icc1ccccccccck4kkcccck4kkc1cjjk1icc1cc
c13r3rrr3r3rr3j31cccccccc13r3rrr3r3rr3j31cccccccccccccccccccccccccccccck4kicccccccccccck4kicccccccccccc444icccc444icccck4kiccccc
c1j33rrrrrrr33jjjcccccccc1j33rrrrrrr33jjjj3cccccccccccccccccccccccccccc444icccccccccccc444icccccccccccc444icccc444icccc444iccccc
cjj3j33r33r33333jccccccccjj3j33r33rj3jj3j33j3jccccccccccccccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kcccck44kccccc
cjjr33j33333jj3jjccccccccjjr33j333jr333rr3rr3rjcccccccccccccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkcccck4kkccccc
c1jj3j33r3j33jj11cccccccc1jj3j33r3j33r3rrr3rrj3cccccccccccccccccccccccck4kicccccccccccck4kicccccccccccck4kicccck4kicccck4kiccccc
cc1jj3j3jjj3j3j1cccccccccc1jj3j3jjj33rr3r3r33rrjccccccccccccccccccccccc44kicccccccccccc44kicccccccccccc44kicccc44kicccc44kiccccc
ccccjj3j13ij1j1cccccccccccccjj3j13j3333r3rrrr33r1cccccccccccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kccsssssss1ccc
cccc1cjjk1icc1cccccccccccccc1cjjkj3jrr33rr33rrrj3cccccccccccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkcs111111441cc
ccccccck4kicccccccccccccccccccck413r3rrr3r3rr3j31cccccccccccccccccccccc444icccccccccccc444icccccccccccc444icccc444ics1000044k1cc
ccccccc444icccccccccccccccccccc441j33rrrrrrr33jjjj3cccccccccccccccccccc444icccccccccccc444icccccccccccc444icccc444ics100044ks1cc
ccccccck44kcccccccccccccccccccck4jj3j33r33rj3jj3j33j3jccccccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kcs10044k0s1cc
ccccccck4kkcccccccccccccccccccck4jjr33j333jr333rr3rr3rjcccccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkcs14k4k00s1cc
ccccccck4kicccccccccccccccccccck41jj3j33r3j33r3rrr3rrj3cccccccccccccccck4kicccccccccccck4kicccccccccccck4kicccck4kics1ikk000s1cc
ccccccc44kicccccccccccccccccccc44k1jj3j3jjj33rr3r3r33rrjccccccccccccccc44kicccccccccccc44kicccccccccccc44kicccc44kics4kik000s1cc
1cccccck44kcccccccccccccccccccck44kcjj3j13j3333r3rrrr33r1cccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kc1kisssss11cc
3cccccck4kkcccccccccccccccccccck4kkc1cjjkj3jrr33rr33rrrj3cccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkcc11111111ccc
1cccccc444icccccccccccccccccccc444icccck413r3rrr3r3rr3j31cccccccccccccc444icccccccccccc444icccccccccccc444icccc444icccc444iccccc
jj3cccc444icccccccccccccccccccc444icccc441j33rrrrrrr33jjjcccccccccccccc444icccccccccccc444icccccccccccc444icccc444icccc444iccccc
j33j3jck44kcccccccccccccccccccck44kcccck4jj3j33r33r33333jcccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kcccck44kccccc
r3rr3rjk4kkcccccccccccccccccccck4kkcccck4jjr33j33333jj3jjcccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkccsssssss1ccc
rr3rrj3k4kicccccccccccccccccccck4kicccck41jj3j33r3j33jj11cccccccccccccck4kicccccccccccck4kicccccccccccck4kicccck4kics1144411s1cc
r3r33rrj4kicccccccccccccccccccc44kicccc44k1jj3j3jjj3j3j1ccccccccccccccc44kicccccccccccc44kicccccccccccc44kicccc44kics100kk4ks1cc
3rrrr33r14kcccccccccccccccccccck44kcccck44kcjj3j13ij1j1cccccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kcs1000ik4s1cc
rr33rrrj3kkcccccccccccccccccccck4kkcccck4kkc1cjjk1icc1ccccccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkcs1004kik41cc
3r3rr3j314icccccccccccccccccccc444icccc444icccck4kicccccccccccccccccccc444icccccccccccc444icccccccccccc444icccc444ics104ki0k41cc
rrrr33jjj4icccccccccccccccccccc444icccc444icccc444icccccccccccccccccccc444icccccccccccc444icccccccccccc444icccc444ics14ki000k1cc
33r33333j4kcccccccccccccccccccck44kcccck44kcccck44kcccccccccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kcs4ki0000s1cc
3333jj3jjkkcccccccccccccccccccck4kkcccck4kkcccck4kkcccccccccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkc1kisssss11cc
r3j33jj11kicccccccccccccccccccck4kicccck4kicccck4kicccccccccccccccccccck4kicccccccccccck4kicccccccccccck4kicccck4kicc11111111ccc
jjj3j3j14kicccccccccccccccccccc44kicccc44kicccc44kicccccccccccccccccccc44kicccccccccccc44kicccccccccccc44kicccc44kicccc44kiccccc
13ij1j1k44kcccccccccccccccccccck44kcccck44kcccck44kcccccccccccccccccccck44kcccccccccccck44kcccccccccccck44kcccck44kcccck44kccccc
k1icc1ck4kkcccccccccccccccccccck4kkcccck4kkcccck4kkcccccccccccccccccccck4kkcccccccccccck4kkcccccccccccck4kkcccck4kkcaaaaaaaaa9cc
4kicccc444icccccccccccccccccccc444icccc444icccc444icccccccccccccccccccc444icccccccccccc444icccccccccccc444icccc444ia999999999a9c
44icccc444icccccccccccccccccccc444icccc444icccc444icccccccccccccccccccc444icccccccccccc444icccccccccccc44kkcccc44kka900044000a9c
44kcccck44kcccccccccccccccccccck44kcccck44kcccck44kccccccc44ccccccccccck44kcccccccccccck44kcccccccccccck4kicccck4kia90044k4k0a9c
4kkcccck4kkcccccccccccccccccccck4kkcccck4kkcccck4kkccccck4k44cccccccccck4kkcccccccccccck4kkcccccccccccck4kicccck4kia9004k4ki0a9c
4kicccck4kicccccccccccccccccccck4kicccck4kicccck4kicccccik4k4cccccccccck4kicccccccccccck4kicccccccccccck44kcccck44ka90004ki00a9c
4kicccc44kicccccccccccccccccccc44kicccc44kicccc44kiccccccik4ccccccccccc44kicccccccccccc44kicccccccccccc444icccc444ia9004ki000a9c
44kcccck44kcccccccccccccccccccck44kcccck44kcccck44kcccccccik4cccccccccck44kcccccccccccck44kcccccccccccc44kicccc44kia904ki0000a9c
4kkcccck4kkcccccccccccccccccccck4kkcccck4kkcccck4kkccccccccikcccccccccck4kkcccccccccccck4kkccccccccccc44k4kicc44k4ka94ki00000a9c
44icccc444icccccccccccccccccccc444icccc444icccc444iccccccccci4ccccccccc444icccccccccccc444icccccccccc4kik44ki4kik44a9ki000000a9c
44icccc444icccccccccccccccccccc444icccc444icccc444iccccccccci4kkkkccccc44kkcccccccccccc44kkccccccccccrr3rr33rrr3rr39aaaaaaaaaa93
44kcccck44kcccccccccccccccccccck44kcccck44kcccck44kcccccccccmk515cccccck4kicccccccccccck4kicccccccccc33rkij3333rkij399999999993r
4kkcccck4kkcccccccccccccccccccck4kkcccck4kkcccck4kkcccccccccoo5mmcccccck4kicccccccccccck4kiccccccccccij34kk3jij34kk3jij34kk3jij3
4kicccck4kicccccccccccccccccccck4kicccck4kicccck4kiccccccccccoooo5ccccck40kcccccccccccck44kcccccccccckkk44kkkkkk44kkkkkk44kkkkkk
4kicccc44kicccccccccccccccccccc44kicccc44kicccc44kiccccccccccoooo5ccccc404icccccccccccc444icccccccccckk44444kkk44444kkk44444kkk4
44kcccck44kcccccccccccccccccccck44kcccck44kcccck44kcccccccccciiiicccccc44kicccccccccccc44kicccccccccck4k444kkk4k444kkk4k444kkk4k
4kkcccck4kkcccccccccccccccccccck4kkcccck4kkcccck4kkccccccccciiiiiicccc44k4kicccccccccc44k4kiccccccccckk4k4k4kkk4k4k4kkk4k4k4kkk4
44icccc444icccccccccccccccccccc444icccc444icccc444iccccccccc444ckkkcc4kik44kicccccccc4kik44kicccccccckkkkkkkikkkkkkkikkkkkkkikkk
44icccc444icccccccccccccccccccc44kkcccc44kkcccc44kkccccccccccrr3rr33rrr3rr33rrr3rr33rrr3rr33rrr3rr33rikkk444kikkk444kikkk444kikk
44kcccck44kcccccccccccccccccccck4kicccck4kicccck4kicccccccccc33rkij3333rkij3333rkij3333rkij3333rkij33kk44k4k4kk44k4k4kk44k4k4kk4
4kkcccck4kkcccccccccccccccccccck4kicccck4kicccck4kiccccccccccij34kk3jij34kk3jij34kk3jij34kk3jij34kk3jkkk444kkkkk444kkkkk444kkkkk
4kicccck4kicccccccccccccccccccck44kcccck44kcccck44kcccccccccckkk44kkkkkk44kkkkkk44kkkkkk44kkkkkk44kkkkk444k4kkk444k4kkk444k4kkk4
4kicccc44kicccccccccccccccccccc444icccc444icccc444icccccccccckk44444kkk44444kkk44444kkk44444kkk44444kk4k4k44kk4k4k44kk4k4k44kk4k
44kcccck44kcccccccccccccccccccc44kicccc44kicccc44kicccccccccck4k444kkk4k444kkk4k444kkk4k444kkk4k444kkk44k44k4k44k44k4k44k44k4k44
4kkcccck4kkccccccccccccccccccc44k4kicc44k4kicc44k4kiccccccccckk4k4k4kkk4k4k4kkk4k4k4kkk4k4k4kkk4k4k4kkk444k4kkk444k4kkk444k4kkk4
44icccc444icccccccccccccccccc4kik44ki4kik44ki4kik44kicccccccckkkkkkkikkkkkkkikkkkkkkikkkkkkkikkkkkkkik4kkkkkik4kkkkkik4kkkkkik4k
4kkcccc44kkccccccccccccccccccrr3rr33rrr3rr33rrr3rr33rrr3rr33rikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kk44
4kicccck4kicccccccccccccccccc33rkij3333rkij3333rkij3333rkij33kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4449
4kicccck4kiccccccccccccccccccij34kk3jij34kk3jij34kk3jij34kk3jkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kk444
44kcccck44kcccccccccccccccccckkk44kkkkkk44kkkkkk44kkkkkk44kkkkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k449
44icccc444icccccccccccccccccckk44444kkk44444kkk44444kkk44444kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44k494
4kicccc44kicccccccccccccccccck4k444kkk4k444kkk4k444kkk4k444kkk44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4499
k4kicc44k4kiccccccccccccccccckk4k4k4kkk4k4k4kkk4k4k4kkk4k4k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k449
k44ki4kik44kicccccccccccccccckkkkkkkikkkkkkkikkkkkkkikkkkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkki494
rr33rrr3rr33rrr3rr33rrr3rr33rikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kk44
kij3333rkij3333rkij3333rkij33kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4449
4kk3jij34kk3jij34kk3jij34kk3jkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kk444
44kkkkkk44kkkkkk44kkkkkk44kkkkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k449
4444kkk44444kkk44444kkk44444kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44k494
444kkk4k444kkk4k444kkk4k444kkk44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4499
k4k4kkk4k4k4kkk4k4k4kkk4k4k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k449
kkkkikkkkkkkikkkkkkkikkkkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkki494
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4k
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kk4449994ikkk444kikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k444994949kk44k4k4kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kk44499944kkk444kkkkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k44999494kk444k4kkk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44k49494994k4k4k44kk4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k449949949k44k44k4k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k44999494kk444k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkki4944444kk4kkkkkik4k
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444km555m55mk4449994k4449994ikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k45mm77mm54499494944994949kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkm77m77554449994444499944kkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k77m77mm54499949444999494kk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44km777m7mm4949499449494994k4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4mm7m7mm54994994949949949k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k5m5mmm5m4499949444999494kk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkki5mm555m54944444k4944444kk4k
49994ikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444km555m55mikkk444km555m55mk44
94949kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k45mm77mm5kk44k4k45mm77mm5449
99944kkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkm77m7755kkk444kkm77m7755444
99494kk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k77m77mm5kk444k4k77m77mm5449
94994k4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44km777m7mmk4k4k44km777m7mm494
49949k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4mm7m7mm5k44k44k4mm7m7mm5499
99494kk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k5m5mmm5mkk444k4k5m5mmm5m449
4444kk4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkki5mm555m5k4kkkkki5mm555m5494
49994ikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444km555m55mm555m55mikkk444kk4449994k44
94949kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k45mm77mm55mm77mm5kk44k4k444994949449
99944kkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkm77m7755m77m7755kkk444kk44499944444
99494kk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k77m77mm577m77mm5kk444k4k44999494449

__gff__
00030303010303031312030303030a1212121003030303030400040000000000040404040404040404040404040404040000000000040000000000000000000003000404000400040404040404042322000000000000000000000000000000000000000000000000100000000000001000000000000000000000000000000014
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
dcdcdc00dadadadadadadadada6fdada00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dc2edc00dadadadadadadadada6fdada00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdc00dadadadadadadadada6fdada00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dc00dc00dadab7dadadada11da6fdada00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdcdada0e0e0e0e0e0e05da7fdada00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dc00dc09dadadae6e7e8dc050101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdadc800f1012f6f7f801010202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dc00dc0101010101010102020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdadc0202020202020202020202020200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdcdcdcdcdcdcdcdcdcdcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcb2dcb3dcdddedfdccbcccddc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdcdcdcedeeefdcedfcefdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dc94dc95dcfdfeffdcfdfeffdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdcdcdcdcdcdcdcdcdcdcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcb8dcb9dcdddedfdccbcccddc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdcdcdcedeeefdcedfcefdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dca8dc00dcc8c9cadcc8c9cadc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdc00dcdcdcdcdcdcdcdcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcd0d1d2dcd0d1d2dc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dce0e1e2dce0e1e2dc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcf0f1f2dcf0f1f2dc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcdcdcdcdcdcdcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcd3d4d5dcd3d4d5dc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dce3e4e5dce3e4e5dc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcf3f4f5dcf3f4f5dc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcdcdcdcdcdcdcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
040100000e0601107012070120701207011060100500f0400c0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000017560195701a5701a57019560175501554013520005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
a00200001e1722017222172231721b1721e1721a17219172191721617212172151720010200102001020010200102001020010200102001020010200102001020010200102001020010200102001020010200102
000400000a07500045000050e00506005090050500500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
000400000707300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003
300400001c7221c7421c7521c7621c7621c7621c7521c7521c7421c7421c7321c7321c7221c7221c7121c7121c7021c7021c7021c702000020000200002000020000200002000020000200002000020000200002
000100001567015660146501363012620116100060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
4803000010070170501a0301d02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
480300001c07019050150301202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
101000001b07526005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
640400000c1600d1700e1700f1700e1700d1700c1700d1700c1700d1700e1700e1600d1500c1400b1300a12009110121001310013100131001310000100001000010000100001000010000100001000010000100
890400001055610556115561155613556135561554615546175361753618526185261a5161a516000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006
310c00002b3751f30500005000052a3750000523375000052330500005233751f1252437500005283750000526375000051f3751f12500005000051f3750000500005000051f3750000526375000052b37500005
310c00002d3751f30500005000052a305000052f3750000523305000051a1041a1021a1541a1521f1541f1521f1541f1521f1521f15521102211052115421152211522115523102231052b37526375233751f375
090c00001f0141f0101f0101f0101f0211f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0201f0311f0301f0301f0301f0301f0301f0301f030
010c000000000000001f1251f1251a2241a2251f1251f1252b7242b7202b7222b7222b7251f2251a1251a125231542315223152231551c1251c12524154241522415224155211252112500000000001f1251f125
090c1f201f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f0301f030
000c000000000000001f1251f12500000000001f1251f1252672426720267222672226725000001f1251f12537525000001f1252b525000002b5151f1251f12500000131252b1251f1251a0241a0251f1251f125
310c00002b3751f30500005000052a3750000523375000052330500005233751f1252437500005283750000526375000051f3051f12500005000051f3050000500005000051f3050000526305000052b30500005
310c000026470264751f4701f4752b0352b0352b0252b0252b0152b0152117421175231742317524174241751f1742117023172231752b0142b0102b0102b0151a3751f375213752130523375000001f37518625
310c00001f4501f4551a4501a45500000000001a1251a1251f2241f22524174241752617426175281742817523174241702617226175375253750526125261252b525000001a1251a1251f525000001f1251f125
041e00001f7141f7211f7311f7411f7511f7501f7501f7501f7521f7521f750207512175121750217522175221750217502475126751287512875028750287502875028741287312872128711287150000000000
081e00000000004611056200562006630066300563004620036111a0141a0211a0111a0151f6141f621206312063220621206111e6151f125181251a125356143561237621386203862236620356113461030615
090c0000240730c073000001f325000001a325000001800018650186601866018671186711867518625186150000000000000001a325240730c0731f325000001865018660186601867118671186751862518615
19200000263751f1251f055233751f125230551f125230351a1741a17217174171721917419172191721917219172191751317415174181741717417172171721717513172131721317213172131752b3751f375
291a18002375423750237502375023750237312371123715227542275022750227502275022731227112271523754237502375023750237502373123711237150000000000000000000000000000000000000000
a91a00001f7241f1211f2311f2311f2411f1311f7311f7251f7241f1211f2311f2311f2411f1311f7311f7251f7241f1211f2311f2311f2411f1311f7311f7251f0001f0011f0011f0011f7011f7011f7011f701
291a16002375423750237502375023750237312371123715227542275022750227502275022731227112271523754237502375023750237502373123711237150000000000000000000000000000000000000000
05070f102b4502b430205722053229350293301e5721e5321f4530735007350073500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002b4502b430205722053229350293301e5721e532
291a0a001f7301f725000000000000000000000e305000000e35000000000000000000000000000e3050e30000000000000000000000000000000000000000000000000000000000000000000000000000000000
090d00100c0733f600136150c0731862018623136153f60013615136053f60013615136053f600136153f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f600
050d000007350073500e3500e35024451244502445224452234551f4551d4050e350000000000007350000000735000000073500000024454244522445024455234551f455000000735000000000000e35000000
050d100007350073500e3500e35024451244502445224452234551f4551d4050e350000000000007350000000730000000073000000024404244022440024405234051f405000000730000000000000e30000000
050d00000735000000073500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010900283033126300243003031118300303312630024300303110000000000183003033126300243003031100000000001830030331263002430030311000000000000000000001830030331263002430030311
01400020076210762108621096210b6210c6210e6210f62110621106210f6210d6210b62108621076210762107621096210a6210b6210d6210d6210b6210b621096210862108621086210a6210b6210b6210a621
012400001301413020130301304013040130501305013050130501305013050130501305013050130501305013050130501305013050130701307013070130701305013050130501304013040130301302013015
03240000140141401414014140143f000240110c0113c000240110c01139000240110c0113c6153a61539615006200062000620006253a4163b4163a4163b416304243042033421334203a4163b4163a4163b416
1a1200002e3751805337375071452b375260353237526025263751b1252e3751d1251f375161252b3751a1251f375326242137522375071452134522345021452131522315071452737500005243750000525305
001200001a0501a0521a7421a7451f2241f2243761500000180533721407211180533761518053376150000018053000001a0501a0521a7421a74518053376151866018650186401864537615000003761500000
0012000013050130521374213745376150703507035070350000002135071350e1353e0142b0111a0110001007040070431305013052137421374526624296241805329624000003761507145021450704502745
1a1200002537518053081252d375081250f1253e37526025263051b125260351d1250f02516125160251b1251402532624140250f025081450f0251402503145140250f025061451a14419144191451814418145
011200001905019052197421974514224142243761500000180533821408211180533761518053376150000018053000001905019052197421974518053376151866018650186401864532634286241e62412614
0012000014050140521474214745376150803508035080350000003135081350f1353e0142b0111a0110001008040080431405014052147421474526624296241805329624000003761508145031450804503745
1a1200002e3751805337375071452b375260353237526025263751b1252e3751d1251f375161252b3751a1251f375326242137522375071452134522345021453337522305303752e37500005273750000525305
01120000023700e14502470276452c64502175077450e05500000021452c645023752c6450e1450e145276450a370163750a470113752c645276452c62527625021450a37505145276452c645021452c6452c645
01120c140e1301740013130174000e1300c4000e13033400370242a0211a02106021304243042033421334203a4263b4263a4263b426304043040033401334000000000000000000000000000000000000000000
00120000043701014504470276452c645041750b7451005500000041452c645043752c645101451014527645043700e37504470103752c645276452c62527625021450a37505145276452c644021352c6242c614
030d000021451214501807321441214401807321421214201115505050131550505018073141553a6551615518073111553f0253e0253d0253c0253b0253a0253a655180733a655180733a655135503a65516550
020d0000050703a6553a655050703a6553a655110703a655180733a6553a6553a6551124411242112421124505055050553c6551807335655180732b6553a6550505005050111601127005050050501116011270
000d0000164540315016454160202245122450164540a1501645416320214512145016454051501645416020204512045020450204501645416150164540a1501645403150164541653023451234502345023450
020d00000c0530c0530c0533e6550c0530a0503e655160500c0530c0530c0533e6550c0530a1503e655161500c0530c0530c0533e6550c0530a2503e655162500c0530c0530c0533e6550c0533e6553e6553e655
030d0000160503a655160503a655163203a655160503a6551805018320180503a6553a65518053180503a655190503a65519050193203a6553a655190503a6551b0503a6551f0501b3203a6551e3201e0503a655
010d0000180530a1500a1500a150180530a1500a1500a150180530815008150081500815008150081500815018053071500715007150180530715007150071501805306150061500615006150061500615006150
050d000011156051561115605156161560a156161560a1561b1560f1561b1560f15620156141562015614156251561915625156191562a1561e1562a1561e1562a1561e1562a0201e020191501e1502015023150
030e00183d6500c0533d6203d6501e0253d6203d6503d65500000010550d010010550c0530c0033d6203d6501e0253d6203d6503d655000001942400000010550000000000000000000000000000000000000000
011500001975019750197501c7501c7501c7502175021750217502075020750207502074020730207202071519400000000000000000000000000000000000001940000000000000000000000000000000000000
091500001705017050170501805018050180501e0501e0501e0501e0501e0501e0501f0501f0501c0501c0501c0501c0501c0501c0501c0401c0301c0201c0150000000000000000000000000000000000000000
192a0000100541005010050100500b0510b05519154191521715417152171521715519104191020b0500b0500d0500d0500d0500d05008050080501e155201551915508000191351c10507424074220742207425
1915000004050000001c3551435500000193550405017355040500000020355000000405000000000000000004050000001c35514355000001935504050173550405000000203050405004050000000000000000
011500001031000000190551431019025190551731019025190550d31019025190551031019025190550d31019025103101431010310173101431019310173101c31019310203101c31023310203102531023310
001500001031000000150551531015025150551731015025150550931015025150551031015025150550d3101502510310153101031019310153101c31017310213101c310253102131028310253102d31028310
__music__
00 15164354
01 0c11430e
00 0d0f4310
00 12114310
00 13144310
00 18544310
00 0c11170e
00 0d0f1710
00 12111710
00 13141710
02 18544310
03 23244344
01 191a4a44
00 1d4c4344
00 1b1a1f44
00 1c1e4e44
00 20424344
00 214c4344
00 1d224344
00 201f4344
00 211f4344
02 1d224344
01 25264344
00 27284329
00 2a2b432c
00 2d285129
00 2a2b432c
00 2f2e4344
00 2f304344
00 2f2e4344
02 2f304344
01 383a4344
00 38394344
00 383a4344
00 383d4344
00 383e4344
00 383c4344
00 383c4344
00 383b4344
00 383b4344
02 383a4344
00 01020304
00 01020304
00 01020304
00 31324344
00 31324344
01 33344344
00 33344344
00 33344344
00 33344344
00 35364344
00 35364344
02 37364344
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384

