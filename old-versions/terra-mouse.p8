pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
-- terra - a terraria demake or
-- something - by cubee 🐱

-- keep palette
poke(0x5f2e,1)

--[[

=== flags ===

0 solid
1 breakable with pickaxe
2 bg wall
3 
4 needs support
5 door
6 can have auto bg walls
7 produces light

=== music layout ===

by jO560HS

0:  overworld
12: underground
22: corruption
31: jungle
41: boss music

by CUBEE

53: night music

]]


function _init()

-- clear user memory
-- (and some more but shhh)
for i=-32768,0x55ff do
 poke(i,0)
end
reload()

-- title logo
-- :o wot it actually fits? haha
-- # = 2048
tospr("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9eeeeee8aeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeeeeeeae9eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88eae88eee9a8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88aa988a9a9a9aa9aeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8a9aaaaaaaaa9aaaaaaaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9a229aa929929929a98eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8aa233294444443339aaeeeeeeee89eeeeeeeeeeeae9eeeeeeeeeeeaaeeeeeeeea944343444433342aa988eeeeeeeaee9e9eeeeee9aeeeeeeeeeeee9e9eeeeee8a9333343333333339aaaeea8eeee9e8e9eeeeeee898ee8eeeeaeee8eaeeeeee8a233333343332232aaa889e8ee8a99a8a898e88a89aea988ee89e88899eeeeeea92929243329aa99aaaa9a9988ea9a9aaaa999a9a9aaaaa8e8eae89a9a9aeeee8aaa9a934439aaaaaaaaaaa9aa9a9aa999aaaaaaaaa999aaa9888a999aa88eeee9aaaa243639aaaa996119aaaaa92222439aaaa929226b9aaaa9a934229a9eeeeeaaaa23762aaaa91777b79aaa9343344432aa9343344771aaaa93444429a8eeee8aa9336139aa96b7617769aa93443233439a93443333679aaa23223432a9eeeeaaaa267139aa97769a9661aa23432992342a24332923161aa933aa9342a98eee8aa936732aa96b19aaa1329a93349aa9333993439aa93169aa22aaa243999eeee9aa371339aa1771111743aa93439aa9239a94339aa9239aaaaaaa9233998eee8a9a2673399ab16b671622aa93349aaaaaaa93439aaaaaaaa999992333998eeee9a936b32aa9776199a99aaaa2332aaaaaaa93332aaaaaaaa233334332a9eeeee8aa21732aa93449aaaaaaaa93432aaaaaaa933329aaaaaa93333333339a9eeee9a933139aaa93329a99329aa2339aaaaaaaa2339aaa9aa92339aa9332a98eeee892333329aaa2433223329a933329aa9aaa933329a9aaaa2333223333a9eeeee8a933339aaaa93333332aaa93339aaaaaaa93339aaa9aaa992233333399eeeee99233339a9a9a923232aaaa93229a9999a993229a9a99a99aaa922333999eeee8a29929a98889aa9a9aa99aa99a998e8e98a99aa9898998e989aa9992a98eeeee899aa998eeee99aaaa88e899899eeeeeee99898eeeeeeeeee889a9aaa98eeeeee8998eeeeeeeee8e8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee899a98eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",64,64,0)

-- disable btnp repeat
poke(0x5f5c,-1)

dark=split"0,1,2,3,4,1,6,12,8,9,7,0,12,13,2"

-- light level palettes
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

t,worldtime=0,6000

recipes=split([[

17:3|5,59|torch;
68:1|17,5:4|campfire;
14:2|5|platform;
5|14:2|wood from platform;
78:1:15|5:6|door;
13:1:16|3:2|grey brick;
64:1:16|19:2|red brick;

87:1:15|86:2,59:2|potion;

74:1:4|55:1,61:2,52:99|endless quiver;
80:15|17:1,52:15|fire arrows;
52:25:15|3:1,5:1|arrows;

73:1:4|55:1,61:2,51:99|endless pouch;
81:60:18|57:1,57:60|silver bullets;
51:25:18|56:1|bullets;

15|5:10|workbench;
16:1:15|5:4,3:10,17:3|furnace;
18:1:15|56:5|anvil;
4:1:18|58:4,27:1|cursed forge;

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

53:1:4|24,84|nights edge;
8:1:4|72,55:2|flamethrower;

84:1:18|60:10,89:10|blade of grass;
85:1:18|50,55:2|minishark;

55:1:16|23:3|demonite bar;
24:1:18|55:3|lights bane;
26:1:18|55:4|nightmare pick;
72:1:15|17:4,5:6|wand of sparking;

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
39:1:18|57:2,5:3|axe;36:1:18|57:2,5:3|hammer;

56:1:16|20:3|iron bar;
42:1:18|56:2|sword;
30:1:18|56:3|bow;
41:1:18|56:3,5:3|pick;
43:1:18|56:2,5:3|axe;
40:1:18|56:2,5:3|hammer;

46:1:15|5:2|sword;
31:1:15|5:3|bow;
45:1:15|5:3|pick;
47:1:15|5:3|axe;
44:1:15|5:3|hammer;

62:1:15|54:6|sus eye;
63:1:18|59:15|slime crown;
25:1:18|61:6,55:1|secret boss shhh;
88:1:4|89:6|the plant's treasured strawberry
]],";")

toolstat=split[[
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
20:ranged:12:gel:1,
20:hpup:1:1,
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
0:summon:16:marco:22,
9:pick:15,
0,
11:ranged:26:arrow,
9:ranged:27:arrow,
8:ranged:28:arrow,
4:ranged:30:arrow,

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

8:ranged:20:arrow,
0:aight imma head out,
24:ranged:48:bullet,
7:bullet:0:8,
4:arrow:0:3,
42:melee:21:0:1,
0,0,0,0,0,
0:gel:0:3,
0,0,
0:summon:16:eoc:53,
0:summon:16:kingslime,

0:block,
30:ranged:10:bullet:1,
0:block,
0:block,
0:block,
0:block,
0:item,
0:block,
14:ranged:26:gel,
8:bullet:1:8,
6:arrow:1:3,
0:block,
0:block,
0,
0:block,
0,

7:arrow:0:3.5,
9:bullet:0:9,
0,0,
28:melee:30,
6:ranged:9:bullet:1,
10:hpup:60,
40:hpup:120,
0:summon:16:plantera:31,
0,

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
2
]]

-- others
drops[79],drops[82],drops[83]=78,5,5


-- names of sprite tiles
tilenames=split[[
forest grass,
dirt,
stone,
cursed forge,
wood,
jungle grass,
mud,
flamethrower,
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
wooden pickaxe,
wooden broadsword,
wooden axe,
shade bow,
magic mirror,
musket,
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
campfire,
wood wall,
heart,
mud wall,
wand of sparking,
endless musket pouch,
endless quiver,
corruptiondirt wall,
ebonstone wall,
shadow orb,
wooden door,
open wood door,
flaming arrow,
silver bullet,
tree trunk,
tree stump,
blade of grass,
minishark,
mushroom,
healing potion,
plantera bulb,
leafy seed
]]

-- end definitions

-- generate
generate()

-- what is this mess haha
pflip,pjump,pair,pdigt,pfall,pdiet,pswing,pangle,
mobs,lights,projectiles,craftable,items,
hoveritem,invsel,invopen,invside,craftsel,
grv,acc,frc,dec,max_x,
mode,orbsmash,nextmusic,currentmusic,worldmusic
=
false,true,true,0,0,0,0,0,
{},{},{},{},{},
false,1,false,1,1,
0.08,0.05,0.08,0.15,1,
1,0,0,-1,0
--all in the name of token saving

loadplayer"100,100|46:1,45:1,47:1"
spawnplayer()

-- convert recipe string to array
for k,i in pairs(recipes) do
 recipes[k]=split(i,"|")
 recipes[k][1]=split(recipes[k][1],":")
 recipes[k][2]=split(recipes[k][2])
 for j,o in pairs(recipes[k][2]) do
  recipes[k][2][j]=split(o,":")
 end
end

music(0)

mouse=false
menuitem(5,"toggle mouse",function()mouse=not mouse end)

end

function _update60()

jb=btn(4) or btn(2,1)

poke(0x5f2d,0x3)
msx,msy=stat(32),stat(33)

smolmap()

-- title and load player/world
if mode<3 then

if stat(120) then

 -- load world
 if mode==2 then
  for i=0,serial(0x800,0x8000,32767)-1 do
   poke(0x8000+i,@(0x8000+i)-32)
  end
  spawnplayer(php)

 -- load player
 elseif mode==1 then
  serial(0x800,0x4300,4864)
  s=""
  for i=0,4864 do
   s..=chr(@(0x4300+i))
  end
  loadplayer(s)
 end
 loadedfile=true
end

if btnp(4) or loadedfile then
 mode+=1
 loadedfile=false
 sfx(7)
end

-- put the normal gfx back
if(mode>2)reload()

-- game
else

-- save button
menuitem(1,"save",function()
sp,sw=php..","..php_max.."|",""

genprint"processing player..."
for i in all(inventory) do
sp..=i.id..":"..i.amount..","
end

genprint"processing world..."
for i=0,32767 do
sw..=chr(@(i+0x8000)+32)
end

printh(sp,"@clip",true)

repeat
genprint("player copied to clipboard","press pause to continue")
until btn(6)

printh(sw,"@clip",true)

repeat
genprint("world copied to clipboard","press pause to continue")
until btn(6)
end)

bigmap()

lights={}

-- clean inventory, update item stats
for i in all(inventory) do
--do not combine these, future me
stats=split(toolstat[i.id],":") or split"0,item"

local itype=i.type
i.type=itype or stats[2] or "item"

itool=itype=="pick" or itype=="axe" or itype=="hammer"

i.damage,i.var,i.usetime,
i.amount,i.autoswing=
stats[1],stats[4],stats[3] or 16,
i.amount or 1,stats[5] or itool

i.melee=itype=="melee" or itool

if i.amount<=0 then
 del(inventory,i)
end
end
if(invsel>#inventory)invsel=#inventory

invsel-=stat(36)

-- inventory
if invopen then

-- inventory side
if invside==1 then
 if(btnp(0) and #craftable>0)invside=0
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
    inventory[1]=hoveritem
   end
   hoveritem=false
  end

 end

 -- trash selected item
 if btnp(5) then
  trashslot=inventory[invsel]
  deli(inventory,invsel)
  updaterecipes()
 end

 -- recover trashed item
 if btnp(1) and trashslot then
  add(inventory,trashslot)
  trashslot=false
  updaterecipes()
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

 local it=craftable[craftsel]
 if it then
  local out,ing=it[1],it[2]

  -- craft
  if btnp(4) then

   -- use ingredients
   for i in all(ing) do
    --i=split(i,":")
    local amount=i[2] or 1

    -- each in amount
    for a=1,amount do
     local got=false

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
   local ininv,slot=false,1
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

-- hack to prevent player from
-- jumping after closing inventory
pjump=true

-- gameplay
else

bossmusic,invside,craftsel=false,1,1

-- time, slightly faster than 1 min = 1 hour
worldtime+=0.4
worldtime%=24000

-- player dead
if pdead then
 pdiet=max(pdiet-1)

 if pdiet==0 and jb then
  spawnplayer(php_max)
 end

-- player alive
else

 -- healing
 if(t%100==0)php+=1

 frc=pair and 0.03 or 0.08

 -- move left
 if btn(0) or btn(0,1) then

  -- compact movement
  if(pxv>-max_x)pxv-=pxv>0 and dec or acc
  if(canturn)pflip=true

 -- move right
 elseif btn(1) or btn(1,1) then

  -- compact movement
  if(pxv<max_x)pxv+=pxv<0 and dec or acc
  if(canturn)pflip=false

 else

  -- friction
  pxv-=sgn(pxv)*frc
  -- stop if moving really slow
  if abs(pxv)<=frc then
   pxv=0
  end
 end

 -- apply gravity
 pyv+=grv

 -- collisions

 -- down
 d,e,pair=0,false,true
 repeat
  local y=(py+4+d)/8
  l,r=mget(px/8-0.375,y),mget(px/8+0.25,y)
  if pyv>0 and (py>1020 or fget(l,0) or fget(r,0) or (l==14 or r==14) and not (btn(3) or btn(3,1))) then
   if(not jb)pjump=false
   pair,e,pyv=false,true,0
   py+=d

   -- fall damage
   pfall=max(pfall/8-13)
   if pfall>0 then
    php-=flr(pfall*10)
    piframes=30
    sfx(0)
   end
   pfall=0

		 if jb and not pjump then
		  pjump,pyv=true,-2.2
		 end

  end
  d+=1
 until d>pyv or e

 -- up
 d,e=0,false
 repeat
  local y=(py-5+d)/8
  lef,rgt=fget(mget(px/8-0.375,y),0),fget(mget(px/8+0.25,y),0)
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
  local bx,by=(px+3+d)/8,py/8+0.375
  local b,top=mget(bx,by),fget(mget(bx,py/8-0.375),0)

  -- doors
  if fget(b,5) then
   if pxv>0 and fget(b,0) then
    mset(bx,by,b+1)
   elseif pxv<0 and not fget(b,0) then
    mset(bx,by,b-1)
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
  local bx,by=(px-4+d)/8,py/8+0.375
  local b,top=mget(bx,by),fget(mget(bx,py/8-0.375),0)

  -- doors
  if fget(b,5) then
   if pxv<0 and fget(b,0) then
    mset(bx,by,b+1)
   elseif pxv>0 and not fget(b,0) then
    mset(bx,by,b-1)
   end

  -- normal collision
  elseif pxv<0 and (top or fget(b,0)) then
   e,pxv=true,0
   px+=d
   if(not top)py-=1 pyv=min(pyv)
  end
  d-=1
 until d<pxv or e

 if pjump and not jb then
  pyv=max(pyv,-0.2)
 end

 -- move
 px+=pxv
 py+=pyv
 pfall+=pyv

 -- stay in world horizontally
 px=mid(4,px,2044)

 -- use position
 digx,digy=pflip and -7 or 7,(btn(3) and 7) or (btn(2) and -7) or 0
 if not (btn(0) or btn(1)) then
  if(btn(3) or btn(2))digx=0
 end
 actx,acty=(px+digx)/8,(py+digy)/8
 if(mouse)actx,acty=(cam_x+msx)/8,(cam_y+msy)/8
 tile,helditem,canturn,digging=mget(actx,acty),inventory[invsel] or {id=0,type="item",usetime=10},true,false

 -- use item
 hitype,hiuse=helditem.type,helditem.usetime
 if btn(5) then

  if(pswing==0 and (btnp(5) or helditem.autoswing))pswing=hiuse

  -- breakable tiles
  if hitype=="axe" or hitype=="pick" then

   if til~=0 and((hitype=="axe" and tile==83) or (hitype=="pick" and fget(tile,1) and mget(actx,acty-1)~=83))then
    digging=true
    pdigt+=1
	  	if(pdigt%hiuse==1)sfx(4)
	  	--sfx(2)

	  	-- break tile
	  	if pdigt>=hiuse*3 then
	  	 pdigt=0
	  	 sfx(4)

	  	 -- tiles that need support
	   	ty=-1
	  	 if fget(tile,4) then
 	   	ty=0

	    -- everything else
	  	 else
		  	 additem(drops[tile] or tile,actx*8,acty*8,1,tile==9 and 20 or "block")
	   	 mset(actx,acty,0)
	    end

	  	 -- break supported tiles
   	 while fget(mget(actx,acty+ty),4)
   	 do
   	  b=mget(actx,acty+ty)
  	   additem(drops[b] or b,actx*8,acty*8+ty*8,1,mget(actx,acty+ty)==9 and 20 or "block")
   	  mset(actx,acty+ty,0)
  	   ty-=1
  	  end

	  	end

   end

  -- place block
  elseif hitype=="block" then

   canplace=false

   -- platform offset
   if helditem.id==14 and pxv~=0 then
    acty+=1
   end

   -- check nearby tiles
   for ix=-1,1 do
    for iy=-1,1 do
     bl=mget(actx+ix,acty+iy)
     if abs(ix)+abs(iy)==1 and mget(actx,acty)==0 and (fget(bl,0) or fget(bl,2) or bl==14) then
      canplace=true
     end
    end
   end

   -- needs support?
   lt=mget(actx,acty+1)
   if fget(helditem.id,4) and not (fget(lt,0) or lt==14) then
    canplace=false
   end

   -- place block
   if canplace then
    if pdigt==0 and tile==0 then
		   sfx(4)
		   mset(actx,acty,helditem.id)
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
	   if(dropitem==50)additem(51,actx*8,acty*8,100)

    -- drop item
	   additem(dropitem,actx*8,acty*8)
	   mset(actx,acty,0)
	  end
	  pdigt+=1
	  pdigt%=hiuse

	 -- ranged weapon
	 elseif hitype=="ranged" then

	  if pswing==hiuse then
    -- find ammo
    ammodamage,ammoid=false,-1

    for a in all(inventory) do
     if a.type==helditem.var and not ammodamage then
      if(a.usetime==0)a.amount-=1
      ammovel,ammodamage,ammoid=a.var/2,a.damage,a.id
     end
    end

    -- bullet
    if ammodamage then
				 add(projectiles,{id=ammoid,x=px,y=py,xv=cos(pangle)*ammovel,yv=sin(pangle)*ammovel,damage=helditem.damage+ammodamage,bulletsprite=helditem.var})
     sfx(6)

    else
     pswing=0
     sfx(9)
    end
   end

  -- life crystals and heals
  elseif hitype=="hpup" then
   if btnp(5) and pswing==hiuse then
    if php_max<400 then
     if(helditem.var)php_max+=helditem.damage
     php+=helditem.damage
     helditem.amount-=1
    end
    sfx(5)
   end

	 -- boss summons
	 elseif hitype=="summon" then
   if btnp(5) and (not helditem.autoswing or currentmusic==helditem.autoswing) then
    sfx(10)
    addmob(helditem.var,px-72,py-40,true)
    helditem.amount-=1

    reload()
    -- load plantera's sprite
    if(helditem.var=="plantera")tospr("eeee92f212ffff212f29eeeeeaae8222122ff2212228eaae54991221222222221221994544e812212222222212218e44eef811212222222212118feeee1f1111122222211111f1eeeee2f12f11222211f21f2eeeeee11a81f111111f18911eeeeee9aa9a1211112199aaaeeeeeaa98aa99a99aa9aa89aaeeeee98aa99a9cc9a89aa89eeeeeee999889e8ce9ce9aaeeeeeeeee898ceec8ec8e98eeeeeeeeeeeee88e8eee8ceeeeeeeeeeeeee8cee8ceeceeeeeeeeeeeeeeee8eee8eeeeeeeeeee",24,72,112)

   end

  -- magic mirror
  elseif hitype=="aight imma head out" then
   if(btnp(5))spawnplayer(php)
   sfx(11)
  end

 else
  pdigt=0
 end
 pswing,canturn=max(pswing-1),not (pswing>1 and (helditem.type=="melee" or helditem.type=="ranged"))

 -- change music
 local floortile=mget(px/8,py/8+1)
 if fget(floortile,0) then
  if floortile>=1 and floortile<=3 then
   worldmusic=py/8>47 and 12 or ((worldtime<17500 and worldtime>4300) and 0 or 53)
  -- jungle
  elseif floortile==6 or floortile==7 then
   worldmusic=31
  -- corruption
  elseif floortile>=10 and floortile<=12 then
   worldmusic=22
  end

 end

 local a=(hiuse-pswing)/(hiuse*2)+0.1
 wxo,wyo=
 cos(a)*8*(pflip and 1 or -1),
 sin(a)*8

end--player alive

-- update items
for i in all(items) do
 i.yv,i.timer=min(i.yv+grv/2,1.2),max(i.timer-1)
 i.xv*=0.95

 -- go to player
 if not pdead and i.timer<=0 and abs(px-i.x)<24 and abs(py-i.y)<24 then
  i.xv+=(px-i.x)/50
  i.yv+=(py-i.y)/50
  if abs(px-i.x)<4 and abs(py-i.y)<4 then

   -- search inventory for this item
   local ininv,slot=false,1
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
    if i.id==70 then
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

  -- collisions
  local gnd=mget(i.x/8,i.y/8+0.25)
  if fget(gnd,0) or gnd==14 then
   i.yv=min(i.yv)
  end
  if fget(mget(i.x/8,i.y/8-0.25),0) then
   i.yv=max(i.yv)
  end
  if fget(mget(i.x/8+0.25,i.y/8),0) then
   i.xv=min(i.xv)
  end
  if fget(mget(i.x/8-0.25,i.y/8),0) then
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
 if not i.bullet then
  i.yv+=grv/8
 end
 i.x+=i.xv
 i.y+=i.yv

 -- delete on collision
 if fget(mget(i.x/8,i.y/8),0) then
  del(projectiles,i)
 end

end

-- mob spawning
if t%(((pxv==0 and pyv==0 and py/8<47) and 10 or 6)+#mobs)==1 and not pdead then
 local ata,adi=rnd(),rnd(24)
 local atx,aty=(px+cos(ata)*(80+adi))\8,(py+sin(ata)*(80+adi))\8
 if not fget(mget(atx,aty),0) then
  local sptile=mget(atx,aty+1)

  -- spawn tile lists
  local forest=(worldtime<4300 or worldtime>17500) and
  "zombie,zombie,eye" or
  "gslime,gslime,gslime,bslime"

  -- lists
  local spawns={}
  spawns[10],spawns[11],spawns[12],spawns[6],spawns[7]=
  "eater","eater","eater","jslime,jbat,hornet,hornet","jslime,jbat,hornet,hornet"
  if py\8>76 then
   spawns[1],spawns[2],
   spawns[3],spawns[5],
   spawns[19],spawns[20],
   spawns[21],spawns[22]=
   "bat,bat,bat,skeleton,rslime,rslime",
   "bat,bat,bat,skeleton,rslime,rslime",
   "bat,bat,bat,skeleton,rslime,rslime",
   "bat,bat,bat,skeleton,rslime,rslime",
   "bat,bat,bat,skeleton,rslime,rslime",
   "bat,bat,bat,skeleton,rslime,rslime",
   "bat,bat,bat,skeleton,rslime,rslime",
   "bat,bat,bat,skeleton,rslime,rslime"
  elseif py\8>47 then
   spawns[1],spawns[2],spawns[3],spawns[5],spawns[19],spawns[20],spawns[21],spawns[22]=
   "bat,bat,yslime,yslime,rslime",
   "bat,bat,yslime,yslime,rslime",
   "bat,bat,yslime,yslime,rslime",
   "bat,bat,yslime,yslime,rslime",
   "bat,bat,yslime,yslime,rslime",
   "bat,bat,yslime,yslime,rslime",
   "bat,bat,yslime,yslime,rslime"
  else
   spawns[1],spawns[2],spawns[3],spawns[5]=
   forest,forest,forest,forest
   spawns[6],spawns[7]=
   "jslime,jbat,jbat","jslime,jbat,jbat"
  end

  -- attempt to spawn
  if spawns[sptile] then
   addmob(rnd(split(spawns[sptile])),atx*8+4,aty*8+4)
  end
 end

end -- spawn mobs

-- update mobs
distance,pangle=120,pflip and 0.5 or 0
for i in all(mobs) do

 -- TOKEN SAVING GO brrrrrrr
 local id,ai,grav,collide,stoponwalls,enemy,bouncy,vmod,friction,boss=
 i.id,i.ai,true,true,true,true,false,1,true,false
 i.spr=i.sprx

 if ai=="flying" then
  if i.rspr then
   i.sprx=1+t%20\10*2
  end
  i.flip=i.xv<0
 end

 if id=="eocservant" or id=="marcoservant" then
  collide,friction=false,false

 elseif id=="eoc" then
  i.spry,bossmusic=10+t%20\10*4,41

 elseif id=="kingslime" then

  i.scale,vmod,bossmusic,boss=
  0.6+i.hp/2000,1.5-i.hp/2500,41,true

  if i.hp~=i.php then
   addmob("bslime",i.x,i.y)
  end

  i.php=i.hp

 elseif id=="marco" then
  i.spry,bossmusic=19+t%20\10*6,41

 elseif id=="plantera" then
  i.spry,bossmusic,grav,collide,friction,i.ang,boss=
  11+t%20\10*4,41,false,false,false,atan2(py-i.y,px-i.x)+0.5,true

  if i.hp<1500 then

   s=(1.1+sin(t/80))/80
   i.sprx=19

  else

   if i.t%80==0 then
    addmob("seed",i.x,i.y,true)
   end

   s=(0.4+sin(t/100))/100
  end
  
  if i.x<px then
   i.xv+=s
  end
  if i.x>px then
   i.xv-=s
  end

  if i.y<py then
   i.yv+=s
  end
  if i.y>py then
   i.yv-=s
  end
  i.xv,i.yv=mid(-0.5,i.xv,0.5),mid(-0.5,i.yv,0.5)

  i.t=max(i.t+1)

 end

 -- keep angles 0-1
 i.ang%=1

 -- base ai
 if ai=="fighter" then
  i.xv+=sgn(px-i.x)*(i.air and 0.005 or 0.08)*vmod
  i.xv=mid(-0.5*vmod,i.xv,0.5*vmod)
  i.flip=i.xv<0
  i.spr+=i.x/8%2

 elseif ai=="slime" then
  i.jumpt,i.d,stoponwalls,
  v=
  i.jumpt or 60,i.d or sgn(rnd(2)-1),false,
  i.angry and sgn(px-i.x) or i.d

  i.jumpt-=0.5*vmod

  if i.jumpt<=0 and not i.air then
   i.jumpt,i.yv,i.xv=
   80+rnd(40),-1.2-rnd(),v*vmod
  end

  if i.jumpt<30 then
   i.spr+=t%20\10*i.w
  else
   i.spr+=t%40\20*i.w
  end

 elseif ai=="flying" then
  grav,bouncy,v,angv,tang=
  false,true,0.02,0,(atan2(py-i.y,px-i.x)+0.5)%1

  i.spr+=t%20\10
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
  grav,bouncy,i.xv,i.yv=
  false,true,mid(-0.8,i.xv+(px-i.x)*0.001,0.8),mid(-0.5,i.yv+(py-i.y)*0.001,0.5)

  i.spr+=t%20\10
  i.ang=(atan2(i.yv,i.xv)+0.5)%1

 elseif ai=="projectile" then
  grav,collide,friction,i.ang=false,false,false,(atan2(i.yv,i.xv)+0.5)%1

  if i.angry then
   local ang=(atan2(py-i.y,px-i.x)+0.25)%1
   i.xv,i.yv,i.angry=cos(ang),-sin(ang),false
  end

  i.x+=i.xv
  i.y+=i.yv

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
   i.av,i.a=i.av or 0,i.a or i.ang
   i.av+=0.002
   i.a+=i.av

   i.ang=i.a

   if(i.av>0.2) sfx(10) i.dashstate=false i.sprx=i.id=="marco" and 12 or 10

  -- dash
  elseif i.dashstate then

   i.v=i.v or 0
   i.va=i.va or 0
   if i.t%120==0 then
    i.v,i.va=(i.secondphase and 2.4 or 1.6)*vmod,0.25-i.ang
    if(i.secondphase)sfx(10)
   end
   i.xv,i.yv=cos(i.va)*i.v,sin(i.va)*i.v
   i.v*=0.98

  -- float above
  else

   if i.t%120==0 and (i.id=="marco" or not i.secondphase) then
    addmob(id.."servant",i.x,i.y,#mobs<12)
   end

   if i.t%25==0 and i.id=="marco" and i.secondphase then
    addmob("laser",i.x,i.y,true)
    sfx(3)
   end

   if i.x<px then
    i.xv+=i.xv<0 and 0.1 or 0.05
   end
   if i.x>px then
    i.xv-=i.xv>0 and 0.1 or 0.05
   end

   if i.y<py-40 then
    i.yv+=i.yv<0 and 0.1 or 0.05
   end
   if i.y>py-40 then
    i.yv-=i.yv>0 and 0.1 or 0.05
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
 if enemy and not pdead and piframes<=0 and abs(px-i.x)<pxw and abs(py-i.y)<pxh then
  php-=i.damage
  piframes,pxv,pyv=30,sgn(px-i.x)*1.2,-1.2
  sfx(0)
 end

 -- collide with blocks
 if collide then
  left,right,up,down=false,false,false,false

	 -- collisions
	 xr,yr=pxw,pxh

	 -- down
	 d,e,i.air=0,false,true
	 repeat
	  local l,r=mget((i.x-pxw+1)/8,(i.y+pxh+d)/8),mget((i.x+pxw-2)/8,(i.y+pxh+d)/8)
	  if i.yv>0 and (fget(l,0) or l==14 or fget(r,0) or r==14) then
	   i.yv=bouncy and -i.yv or 0
	   i.y+=d
	   e,down,i.air=true,true,false
	  end
	  d+=1
	 until d>i.yv or e

	 -- up
	 d,e=0,false
	 repeat
	  local lef,rgt=fget(mget((i.x-pxw+1)/8,(i.y-pxh-1+d)/8),0),fget(mget((i.x+pxw-2)/8,(i.y-pxh-1+d)/8),0)
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
	  local top=fget(mget((i.x+pxw-1+d)/8,(i.y-pxh)/8),0)
	  if i.xv>0 and (top or fget(mget((i.x+pxw-1+d)/8,(i.y+pxh-1)/8),0)) then
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
	  local top=fget(mget((i.x-pxw+d)/8,(i.y-pxh)/8),0)
	  if i.xv<0 and (top or fget(mget((i.x-pxw+d)/8,(i.y+pxh-1)/8),0)) then
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

 -- zombie jump at walls and near but below player
 if ai=="fighter" and down and (left or right or (i.y>py+2 and abs(px-i.x)<16)) then
  i.yv=-2.2

 -- slime step over tiles
 elseif ai=="slime" and (left or right) and not down then
  i.xv+=(v-i.xv)/10

 end

 -- prevent plr hit projectiles
	local hit=false
 if i.ai~="projectile" then

	 --collide with plr projectiles
	 for a in all(projectiles) do
	  if i.iframes==0 and abs(a.x-i.x)<pxw and abs(a.y-i.y)<pxh then
	   i.hp-=max(a.damage-i.defence/2,1)
	   if(i.knockback>0)i.xv,i.yv=sgn(i.x-a.x)*i.knockback,-i.knockback
	   hit=true
	   del(projectiles,a)
	  end
	 end

	 -- player hit enemies
	 if helditem.melee and pswing>0 and i.iframes==0 and abs(px+wxo-i.x)<pxw+3 and abs(py+wyo-i.y)<pxh+3 then
   i.hp-=max(helditem.damage-i.defence/2,1)
   if(i.knockback>0)i.xv,i.yv=(pflip and -1 or 1)*i.knockback,-i.knockback
   hit=true
	 end

 end
	i.iframes=max(i.iframes-1)

 -- hit effects
 if hit then
  i.iframes,i.angry=pswing,true
  sfx(6)
 end

 -- get line of sight
 cansee,sight,d=true,1,dist(px-i.x,py-i.y)

 -- check if closest or boss
 if d<distance or boss then

  ba=0.25-atan2(py-i.y,px-i.x)
  repeat
   if(fget(mget((i.x-cos(ba)*sight)/8,(i.y-sin(ba)*sight)/8),0))cansee=false
   sight+=1
  until sight>d

  if cansee then
   distance,pangle=d,ba
   if(boss)distance=0
  end
 end

 -- die
 if i.hp<=0 then
  if i.drop then
   it=split(i.drop,":")
   for a=1,it[2]+(boss and 0 or rnd(3)\1-1) do
    additem(it[1],i.x,i.y)
   end

   -- randomly drop health pickups
   if(rnd(12)<1)additem(70,i.x,i.y)
  end
  del(mobs,i)

 -- despawn
 elseif d>360 or pdead then
  del(mobs,i)
 end
 -- light
 --add(lights,{i.x,i.y})
end

piframes=max(piframes-1)

-- player die
if php<=0 and not pdead then
 php,pdiet,pdead,pswing=0,60,true,0
 sfx(27)
end

-- player sprites
pspr=pswing~=0 and
132+((hiuse-pswing)/hiuse*3)%3 or
(pair and 130 or 128)+(pxv==0 and 0 or px/8%2)
-- yup, that's code all right :)

-- camera
cam_x,cam_y=mid(0,px-64,256*8-128),mid(0,py-64,128*8-128)

if(mouse)pangle=0.25-atan2(py-(cam_y+msy),px-(cam_x+msx))

end--invopen

-- toggle inventory
if btnp(6) and not pdead then
poke(0x5f30,1)--suppress pause
sfx(invopen and 8 or 7)
invopen=not invopen
updaterecipes()
end

php=min(php,php_max)

-- frame
--worldtime+=0.2778

timelight=1

-- night
if worldtime<2000 or worldtime>18000 then
timelight=5

-- early dawn / late dusk
elseif worldtime<3000 or worldtime>17000 then
timelight=4

-- dawn / dusk
elseif worldtime<4000 or worldtime>16000 then
timelight=3

-- late dawn / early dusk
elseif worldtime<5000 or worldtime>15000 then
timelight=2

end

-- pick music
nextmusic=bossmusic or worldmusic

-- fade music
if nextmusic~=currentmusic or stat(24)==-1 then
music(-1,1000)
currentmusic=nextmusic
end
-- start new music
if stat(24)==-1 then
music(nextmusic,1000)
end

end

t=max(t+1)

end

function _draw()

smolmap()

if mode==pmode then

pal()
palt(0,false)
palt(14,true)

cls(14)

pal(split"130,132,4,9,10,5,134,131,3,139,7,1,140,12,136",1)

-- load player/world (1/2)
if mode<3 then

 -- bg
 map(28,0,-(t/10%512),0,80,16)

 -- title logo
 rspr(64,20,sin(t/500)/40,18,1,8)

 cprint("a terraria demake",40)

 cprint(mode==1 and "drop a player file here" or "drop a world file here",76)
 cprint("(or press 🅾️ to start over)",84,7,1,63)

-- game
else

-- bg
map(28,0,-(cam_x/4%512),28-cam_y/4,80,20)

-- underground bg
e=flr(cam_y)
rectfill(0,296-e,127,640,1)
rectfill(0,608-e,127,1040,12)

camera(cam_x,e)

-- bigmap mk.2
bigmap()

-- treetops, walls and light tiles
for iy=cam_y\8-1,cam_y\8+18 do
 for ix=cam_x\8-1,cam_x\8+17 do

  -- treetops
  tile=mget(ix,iy)
  if tile==82 and mget(ix,iy-1)~=82 then
   -- check ground tile
   y=iy
   repeat
    y+=1
   until mget(ix,y)==83
   s,w,o,b=142,2,4,mget(ix,y+1)
   if(b==6)s=137w=3o=8
   if(b==10)s=140

   -- draw treetop
   spr(s,ix*8-o,iy*8-16,w,2)

  -- light sources
  elseif fget(tile,7) then
   add(lights,{ix*8+4,iy*8+4})
  end

  -- walls
  if fget(tile,6) then
   -- check for walls
   wall=false
   for ox=-1,1 do
    for oy=-1,1 do

     wtile=mget(ix+ox,iy+oy)
     if fget(wtile,2) then
      wall=wtile
     end

    end
   end

   if wall then
    spr(wall,ix*8,iy*8)
   end

  end

 end
end

map()

smolmap()

for i in all(items) do
 sspr(i.id%16*8,i.id\16*8,8,8,i.x-2,i.y-2,4,4)
end

--pal(11,14)

-- draw mobs
for i in all(mobs) do

 local sc=i.scale*4

 -- plantera's phase 2 palette
 if i.id=="plantera" and i.sprx==19 then
  -- eoc's colours
  pal(7,10)
  pal(6,9)

  -- plantera's colours
  pal(1,8)
  pal(2,9)
  pal(15,10)
 end

 -- rotatey
 if i.rspr then
  rspr(i.x,i.y,i.ang,i.sprx,i.spry,i.w)

 -- non-rotatey
 else
  sspr(flr(i.spr)%16*8,i.spr\16*8,i.w*8,i.h*8,i.x-i.w*sc,i.y-i.h*sc,i.w*2*sc,i.h*2*sc,i.flip)
 end

 -- extra details
 if i.id=="kingslime" then
  -- crown
  spr(206,i.x-8,i.y-i.h*sc-5.5+(i.spr==233 and sc/2 or 0),2,1)
 end
end

-- restore palette
pal()
palt(0,false)
palt(14,true)

-- projectiles
for i in all(projectiles) do
 mset(1,1,i.bulletsprite=="gel" and 123 or (i.bulletsprite=="bullet" and 109 or 52))
 rspr(i.x,i.y,atan2(i.yv,i.xv)+0.5,1,1,1)
end

-- player
if not pdead and (piframes==0 or t%4<2) then
 spr(pspr,px-4,py-4,1,1,pflip)
end

-- player tool
mset(1,1,helditem.id)
if pswing>0 then
	--vflip=false
	if helditem.type=="ranged" then
	 pangle%=1
	 wxo,wyo=cos(pangle)*8,sin(pangle)*8
	 rspr(px+wxo,py+wyo,-pangle,1,1,1,false,pangle<=0.75 and pangle>0.25)
	else
  rspr(px+wxo,py+wyo,atan2(wyo,wxo)-(pflip and 0.625 or 0.375),1,1,1,not pflip)
	end

 -- break progress
 if digging then
  spr(192+pdigt/hiuse*2,actx\1*8,acty\1*8)
 end
end

camera()

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

-- craft
selectedcraft=0
if invopen then

 -- trashed item slot
 sspr(80,86,10,10,116,116)
 if trashslot then
  spr(trashslot.id,117,117)
 end
 
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
 a,b=i*8%80,i\10*8
 sspr(112,87,9,9,a+1,b+1)
 if(i<=(php-1)\20)sspr(121,89,7,7,a+2,b+2)
end
bprint(flr(php).."/"..php_max,2,12+(php_max-20)\200*8)

-- menu label / item name
if invopen and #inventory>0 then
 cprint(invside==1 and "inventory" or "crafting",121)

 cprint(tilenames[
  (hoveritem and hoveritem.id) or
  (invside==1 and inventory[invsel]
   and inventory[invsel].id) or
  selectedcraft] or "\nmissing name",40)

end

if pdead then
 cprint("you were slain",60,11,15)
 if(pdiet==0)cprint("jump to respawn",68,11,15)
end

-- get light level
d=120
for i in all(lights) do
 d=min(dist(i[1]-px,i[2]-py),d or 120)
end
distlight,
surfacelight
=
flr(mid(1,d/8-6,5)),
flr(mid(1,py/24-12,5))

if(helditem.id==17)distlight=1

-- apply light level palette
pal(split(palettes[min(distlight,max(surfacelight,timelight))]),1)

-- sky colour
pal(14,split"12,140,1,129,0"[timelight],1)

end

end

pmode=mode

if(mouse)spr(199,msx,msy)

end

---function music()return 0 end

-->8
-- worldgen

function genprint(t,t2)
 poke(0x5f30,1)--suppress pause
 pal(split"130,132,4,9,10,5,134,131,3,139,7,1,140,12,136",1)
 camera()
 cls()
 cprint(t,62)
 if(t2)cprint(t2,110)
 flip()
end

function generate()

 -- go to bigmap
 bigmap()

 function maketunnel()
  -- cave tunnel
  for ix=-s,s do
   for iy=-s,s do
	   reptil=mget(cx+ix,cy+iy)
	   if(reptil<64 and reptil>0)reptil+=64
	   -- place walls above height
    mset(cx+ix,cy+iy,cy<60 and reptil or 0)
   end
  end
	end

	worlddir,ry,ra,tunnel,dirttile=sgn(rnd(2)-1),30,0,0,2
 genprint"sculpting the land"
	for ix=0,255 do

	 -- ground height
	 ra=mid(-0.22,ra+(rnd(2)-1)/10,0.22)
	 ry+=sin(ra)/4

	 -- limit ground variation
	 if ry<20 or ry>37 then
	  ra,ry=0,mid(20,ry,37)
	 end

	 -- tunnels
	 if rnd(50)<1 and tunnel<=0 then
	  tunnel=flr(rnd(8)+6)
	 end

	 -- add tiles
	 for iy=0,127 do

	  -- stone
	  if iy>ry+10 then
	   mset(ix,iy,dirttile==7 and 7 or 3)

   -- dirt
	  elseif iy>=flr(ry) then

    -- corrupt side, jungle side
    cs,js=128-64*worlddir,128+64*worlddir

	   -- put jungle
	   if ix>js-26 and ix<js+26 then
	    dirttile=7

    -- put corruption
	   elseif ix>cs-26 and ix<cs+26 then
	    dirttile=11
     --tunnel=0

	   else
	    dirttile=2
	   end
	   mset(ix,iy,dirttile)

	  end

	 end

  -- generate tunnels
	 if tunnel>0 then
	  for i=1,5 do
    mset(ix,ry-i,i>3 and dirttile or (dirttile+64))
	  end
	  tunnel-=1
	 end
	end

 genprint"making spaghetti caves"
 for i=0,50 do
  a,cx,cy,s=rnd(),rnd(256),rnd(178-i/2)+50+i/2,rnd(2)+1
  for l=0,10+rnd(80) do
   av=(rnd(2)-1)/12
   a+=av

   cx+=cos(a)
   cy+=sin(a)
   
   cx,cy=mid(0,cx,256),mid(37,cy,128)
	  -- cave
	  maketunnel()
  
  end
  
 end

 genprint"digging corrupt chasms"
 repeat

  -- go to ground
  x,y=rnd(256),0
  repeat
   y+=1
  until mget(x,y)==11 or y>40

  -- has found corrupt?
  if y<=37 then

   for l=2,30+rnd(20) do

		  -- make tunnel
		  s=3
    x+=rnd(2)-1
		  for ix=-s,s do
		   for iy=-s,s do
		    if (abs(ix)>=s-1 or iy>=s-1) and mget(x+ix,y+iy+l)~=76 then
		     mset(x+ix,y+iy+l,12)
		    else
		     mset(x+ix,y+iy+l,76)
		    end
		    mset(x,y+l,77)
		   end
		  end
		  
   end
  end

	 -- count chasms
	 chasms=0
	 for ix=0,256 do
	  for iy=0,128 do
	   if mget(ix,iy)==77 then
	    chasms+=1
	   end
		 end
		end

	until chasms>=3

 genprint"adding surface tunnels"
	-- forest/jungle cave entrances
 surfacecaves=0
	repeat
	 ix,iy=rnd(216)+20,0

	 -- go to ground
	 repeat
	  iy+=1
	  dirttile=mget(ix,iy)
	 until dirtitle==2 or dirttile==7 or iy>64

  -- don't spawn them underground
  if iy<=64 then

		 -- circle
	  r=7+rnd(4)
		 for y2=-r,r do
		  x2=flr(sqrt(abs(y2*y2-r*r)))
		  for ox=ix-x2,ix+x2 do
		   mset(ox,iy+y2+3,dirttile)
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

 genprint"adding various details"
	-- post processing
	for ix=0,255 do
	 for iy=0,127 do

	  -- add grass on dirt and mud
	  if (mget(ix,iy)==2 or mget(ix,iy)==7 or mget(ix,iy)==11) and not fget(mget(ix,iy-1),0) then
	   mset(ix,iy,mget(ix,iy)-1)

    -- trees
    if rnd(2)<1 then
     cantree,th=true,4+rnd(5)

     for y=1,th+4 do
      if mget(ix,iy-y)~=0 then
       cantree=false
      end
     end

     if cantree then
	     for y=2,th do
       mset(ix,iy-y,82)
	     end
      mset(ix,iy-1,83)
     end

    end
    -- end trees

	  end

	 end
	end

 genprint"hiding life crystals"

 crystals=0
 repeat
  ix,iy=rnd(256),rnd(58)+60
  -- life crystals
  if mget(ix,iy)==0 and fget(mget(ix,iy+1),0) then
   mset(ix,iy,9)
   crystals+=1
  end
 until crystals>=20

 genprint"placing metals and clay"
 ores=0
 repeat
  ix,iy=rnd(256),rnd(38)+ores/2

  -- vein
  set=false
  for i=0,3+rnd(4)+iy/30 do
   ix+=rnd(2)-1
   iy+=rnd(2)-1
   if fget(mget(ix,iy),0) and mget(ix,iy-1)<82 then
    mset(ix,iy,19+ores/46)
    set=true
   end
  end
  if(set)ores+=1
 until ores>=180

 --genprint("saving world to clipboard...")
 --saveworld()

end

-->8
-- functions

function addmob(id,x,y,override)

 stats={
  gslime="14,6,0,59:1,slime,0.8,1,0,0, 176",
  bslime="25,8,2,59:2,slime,1,1,1,0, 160",
  rslime="42,15,4,59:2,slime,1,1,1,0, 144",--bslime
  yslime="42,16,7,59:3,slime,1,1,1,0, 180",
  jslime="50,18,6,59:4,slime,1,1,1,0, 164",
  eye="55,18,2,54:1,eye,1,1,0,1, 1,10,1,1",
  zombie="40,14,6,59:3,fighter,0.5,0.5,0,0, 146",
  eater="38,22,8,61:1,flying,0.5,1,0,1, 1,12,1,1",
  bat="15,13,2,86:1,flying,0.8,1,0,0, 162",
  jbat="30,20,4,89:1,flying,0.8,1,0,0, 150",
  hornet="46,26,12,60:1,flying,0.5,1.5,0,0, 166",
  eocservant="8,12,0,70:1,flying,1,0.6,0,1, 1,14,1,1",
  marcoservant="20,12,0,70:1,flying,1,0.9,0,1, 1,16,1,1",
  skeleton="45,20,8,52:10,fighter,0.5,1.1,0,0, 182",
  eoc="2400,10,12,23:18,eoc,0,1,0,1, 5,10,3,3",
  kingslime="1800,22,10,22:12,slime,0,1,1,0, 230,0,3,2",
  marco="3000,22,13,27:1,eoc,0,1,0,1, 6,19,4,4",
  plantera="3200,26,14,65:1,none,0,1,0,1, 23,11,3,3",
  seed="1,19,0,0:0,projectile,0,1,1,1, 1,18,1,1",
  laser="1,13,0,0:0,projectile,0,1,1,1, 1,20,1,1"

 }

 -- from 8188 to 7865... wow
 -- thanks sup3raw3som3gam3r

 -- mob cap
 s=split(stats[id])
 if (#mobs<8 or override) and s then
  add(mobs,{id=id,x=x,y=y,xv=0,
  yv=0,spr=s[10],scale=1,hp=s[1],
  damage=s[2],defence=s[3],
  w=s[12] or 1,h=s[13] or 1,ang=0,iframes=0,
  drop=s[4],t=0,ai=s[5],
  knockback=s[6],vmod=s[7]==1,
  angry=s[8]==1,rspr=s[9]==1,sprx=s[10],spry=s[11]})
 end

end

function additem(id,x,y,amount)
 add(items,{id=id,amount=amount or 1,x=x,y=y,xv=(rnd(2)-1)/3,yv=-1,timer=60})
end

function bprint(t,x,y,c1,c2)
 for ix=-1,1 do
  for iy=-1,1 do
   ?t,x+ix,y+iy,c2 or 6
  end
 end
 ?t,x,y,c1 or 11
end

function cprint(t,y,c1,c2,x)
 bprint(t,(x or 65)-#tostr(t)*2,y,c1,c2)
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
    if not s or mget(px/8+ix,py/8+iy)==s then
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
 bigmap()
 pdead,php,px,py,pxv,pyv,piframes=false,hp or php_max,256*4,0,0,0,60
 repeat
  py+=8
 until fget(mget(px/8,py/8),0)
 py-=4
end

function bigmap()
 poke(0x5f56,0x80)
 poke(0x5f57,0)
end

function smolmap()
 poke(0x5f56,0x20)
 poke(0x5f57,128)
end

function tospr(str,w,x,y)
for i=0,#str-1 do
sset(x+i%w,y+i\w,tonum("0x"..sub(str,i+1,_)))
end
end

function loadplayer(pstr)

plr=split(pstr,"|")
hp=split(plr[1])
php,php_max,inventory=hp[1],hp[2],{}

for i in all(split(plr[2])) do
 if #i<10 then
  it=split(i,":")
  add(inventory,{id=it[1],amount=tonum(it[2])})
 end
end

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
for py=y-abs(delta_px)*yf,y+abs(delta_px)*yf,yf do
tline(x-delta_px,py,x+delta_px,py,sx+ss*ssy,sy+cs*ssy,cs/8,-ss/8)
ssy+=1/8
end
end

--freds72
--🐱 saved a token
function dist(dx,dy)
local maskx,masky=dx>>31,dy>>31
local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
return a0>b0 and a0*0.9609+b0*0.3984 or b0*0.9609+a0*0.3984
end

__gfx__
e9aaa99eaa9aa99a1222333266677761eeeeeeee34444442aa9aa99a11122211eeeeeeeeeeeeeeee1101100112223332ccc666c16177617734444442eeeeeeee
a323332999a218992233232367767676ee7777ee4344434399a1089912212121eeeeeeeeeffeef2e0012110022332323c66c6c6c6176617643444343eeeeeeee
a3223269189322982223332216777661e7b66b7e444334330892119811222111eee7eeeef44ff4f210032201222333221c666cc16166616644433433eeeeeeee
89a32998222332222233323267776766e550855e322223321112211112221211e47437eff4fffff22223322222333232c666c6cc1111111132222332eeeeeeee
e896798e22333332232323327676776674088047444423441122222121212211433376e42fffff2222333332232323326c6c66cc77617761eeeeeeee32333322
ee9769ee232333222332332377677676608998064434343412122211221221213eee6ee6e2fff22e232333222332332366c66c6c76617661eeeeeeee22222222
ee966aee2232323222333232666667615b9aa9b5344324431121212112221211eeeee66eee2f22ee2232323222333232ccccc6c166616661eeeeeeeee111111e
ee8a98ee22222221232222216111661145577554332223221111111021111111eeeeeeeeeee22eee2222222123222221c111cc1111111111eeeeeeeee2eeee2e
eeeeeeeeeeeeeeeeeeeeeeee2333444376667667677bbb774455554411666611eeeeee61eee77eeee1666eeeeeeeeeeeee5b5eeeeebbbeeeee777eeeee333eee
eeeeeeeeeeefeeeeeeeeeeee33443434677bb7766bb7b7b745bb5b5416776761eeeee61cee7997eeeee116ceee5b5eeeee6e45eeee6e7beeee6e67eeee6e23ee
6666661eeeeffeeeeeeeeeee333444337bb7bb667b77bb7655b5555566766666eeee61cee790097eeeee116ee54eeeeeee7ee54eee7eeb7eee7ee76eee7ee32e
6100011eeef44feeeeeeeeee33444343bb7bb7767bbbbb774555545516666166e6e61cee67900976eee6c116ebeb545eee7eef2eee7ee21eee7ee32eee7ee76e
10000077ee4454ee67b77611343434437bbb7b77b7bbb7b75455445461661161e661ceee16799761ee6c1ecee545bebeee7eef2eee7ee21eee7ee32eee7ee76e
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
ee6c6eeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeeeeeee61eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
ee6e16eeee77776eeeeeeeeeeeeeeeeeee766eeeeeeee61ceeeebeeeeeee766eeeeeb77eeeeebbbeeeeebb5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5e54e5e
ee7ee61ee76dbd7eee77ee7eeee7eeeeee626eeeeeee61ceeeebe7eeee76661ceeb77761eebbbb76eebb5543eeedceeeeeee3eeeee671eeeeeff7deee54f244e
ee7ee98ee7dbdd7ee7766666ee776eeeeee3eeeeee661ceeee7eebeee66661cce7777611ebbbb766eb555433eedddceeeee2322eeee67c7eef267d0eed77ddce
ee7ee98ee7bddc7e3321eeeeeee6eeeeeee2eeee116eceeeeebeebee66611ccc77766111bbb7766155544332eecdcceeeee321eeeeec876ef2f67c0edddddddc
ee7ee1cee7ddc76e22eeeeeeeeeeeeeeeee7eeeeec16ceeeeee7b7ee1611ccce6766111e7b77666e4544333eeeecceeeee32eeeeee76761eee226ceecddddccc
ee6e61eee67776eeeeeeeeeeeeeeeeeeee766eee61c1eeeeeeee7eee111cccee666111ee777661ee444332eeeeeeeeeeeeeeeeeeeee161eeeeeeeeeeecccccde
ee61ceeeeeeeeeeeeeeeeeeeeeeeeeeeee6e6eee1ceceeeeeeeeeeeee1cceeeee611eeeee766eeeee433eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
21ff21ffee33330000001110000ccc00eeeeeeee01111110eeeeeeee01110000eeeeeeeee320032eeeeee5ee00001110000ccc00c000000ceee22eeee211111e
21f221f2eee3022e001101010cc0c0c0eefeeeee10111010effeeffe10101100eeeee3eee300321eeeee554e001101010cc0c0c000666100eee32eeee222111e
21222122eee32eee0001110000ccc000eeffefee11100100f44ff4ff00111000eeee321eee32216eeee724540001110000ccc00006776610eee32eeee222111e
111111113e333222001110100ccc0c00eef4fffe00000000f4ffffff01011100eee321eee766621eee77d24e001110100ccc0c0006776610eee32eeee222111e
ff21ff21233333ee01010110c0c0cc00ef4544fe11110011fffffff201101010ee321eeee6322221edddcc3e01010110c0c0cc0006666610ee6326eee222166e
f221f2213322323e01101101cc0cc0c0e455554e11010101efffff2e10110110e3212aee23333221d7dcce2301101101cc0cc0c001666110eee32eeee222111e
22212221321e33230011101000000c00e32bb32e01100110ee2ff2ee01011100321ee98e22332211cdcc1ee20011101000000c0000111100eee32eeee222111e
111111113e1e23e201000000000000002123321100000000eee22eee0000001021eeeeeee122211eeccee23e0100000000000000c000000ceee22eeee211111e
eee4eeeeeeeeeeeeee3331eeee3322eeeeeeeeaaeeeeeeeeeeeeeeeeeee32eeeeeef2eeeeeeeeeee22eeeeee66666666eeeeeee6eeeeeeee7666666666666677
eefbfeeeeeeeeeeeee2332eeee2321eeeeee9aa9ee33eeeeeee4feeeeebbb7eeee2ff1eeeeeaeeeeffeeeeee66666666eeeeee667eeeeeee7766666666666777
ee454eeeeeebeeeeee2322eeee2321eeeee9aa9eeee23eeeee4443eeeeeb7eeeeef2f2eeeea5aeee122eeeee66666666eeee6666777eeeee7766666666667777
eef4feeeeebb7eeeee2321eeee2332eeeeeaa98e33267677eeff3feeeeb667eee2ff221eee555eee2eeeeeee66666666eeee66667777eeee7777766666677777
eeefeeeeeee7eeeeee3321eeee3331eea9a998eee2226666ee2f32eeee1f21eeaff22119ea555aeefeeeeeee66666666eee66666777777ee7777776666677777
eee7eeeeeeeeeeeeee2332eeee3321eee19aeeee21e128eeeee22eeee1fff21e9a211198e9aaa9eeffeeeeee66666666ee666666777777ee7777777666777777
ee766eeeeeeeeeeeee2322eee332321e3219eeeeeeeeeeeeeee32eeee1f2221eeaaa998eee9a9eeeffe45eee66666666ee6666667777777e7777777666777777
ee6e6eeeeeeeeeeeee3331ee3212332121e8eeeeeeeeeeeeeeeeeeeeee1111eeee9988eeeeeeeeeeff1aeeee66666666e6666666777777777777777767777777
6666666c866666666666666896666666ccccc9986689898988898989899cccccc8cc88c999898888998899898c8c8c8c77777777eeeeeeee7777777777777777
66666668886666666666666999666666ccccc8896899898989888989989ccccccc8ccc8898988888888989899cc88c8c77777777eeefeeee7777777667777777
6666668c8c6666666666669898666666cccc898986988988888898988988cccccc88c889899898888889889898c8c88c77777777eee4eeee7777776666677777
6666668cc86666666666669889666666cccc998968889888889898998998ccccccc8c899888888888989989989c8c8cc77777777eee4eeee7777776666677777
666666cc88c666666666668899866666cccc989889899898888888889898cccccccc8c898989888888888898988c8ccc77777777eee4eeee7777666666667777
6666688c8c8666666666699898966666cccc989969899888888898898989cccccc8c88988988888888899888998c88cc77777777eee4eeee7776666666667777
666668cccc8866666666698888996666ccc88998989989888888889989899ccccccc88989988888889989989898c88cc77777777eeefeeee7666666666666677
666688ccc8c866666666998889896666ccc99898899898888888899899889cccccc8c998988988888888999898988ccc77777777eeeeeeee6666666666666667
66c8c8c8c88c86c689989686eeeeeeee0677111211116660a9aee88e66611112e3332112eeeeeeeea1666777eeebeeeeeeeeeeeeeeeeeeee11116666eeeeeeee
6c88c8c8c8cc886689889966eeeeeeee0777007116606760eeeee8ee676066112e321161eeeeeeee16161161ee454eeeeeeeeeeeeeeeeeee16606760eeeeeeee
c68cc8cccc88c8c688998986eeeeeeee0770700000707760eeeee88e677000613ee21661eeeeeeee66161661e5ebe5eeeeeeeeeeeeeeeeee60007760eeeeeeee
6ccc8cccc8c88c6c89899868eeeeeeee6076617071667770eeeeee887776600632ee1666eeeeeeee1161aa66ee5e5eeeeeeeeeeeeeeeeeee00667770eeeeeeee
c8c88c8cc88c8c8689989896ee2ee2ee6601116661111771eeeeeeee77111160322166102eeeeeee66689aa6efe4efeeeeeeee23eeeeeeee61111771e2ee2eee
68c88ccccc8ccc8c88988898e22e23ee1606666166660719eeeeeeee1706666133216111ee111111118aa9a6eeeeeeee11111ee311111eee6666071ae32e22ee
8c88c8cc8ccc8c8898889899e23e333e91000001000001aaeeeeeeeea1066611e3216111e11111111689a991eeefeeee111111ee111111ee16660199333e32ee
c88c8ccccc8c88c888989989e232e2119a600000000069aaeeeeeeeea9670071ee316111eee1166169a9aa88eeeeeeee6611eee16611eee170076a9912e232ee
ee22222eeeeeeeeeee22222eee22222e772222eeeeeeeeeeeeeeeeeeeeeeeeeee3332112eeeee89a8ca989989a8eceeeeeeeee1e16eeeeeeeeeeee8e89eeeeee
e226c6eeee22222e7726c6667726c666776c6eeeeee22772eeeeeeeeeeeeeeeeee321161eec9caaa9aaaa99aaa9a8cceee16116166161eeeee89889899898eee
ee6777eee226c6ee7767776677677766ff677eeeee22f77eeee22222eeeeeeee2ee21661ee999aa9aaaaaaaaaa99898ce1766677677671eee8a999aa9aa9a8ee
eeffffeeee6777eeefffff1eefffff1eeffff6eeeefff66eee2266ceeeeeeeee2eee1666c8999aaaaa9aaaa9aa999988e1667677767716eee899a9aaa9aa89ee
e77fff6e77ffff66eeffffeeeeffffeeeffff6eeeefff6eeeefff76eeeeeeeee3221661088a9a9aa9a9aaaaa9aa99989ee6677767766771eee99aa9a9a99aa8e
e771116e77ffff66ee1111eeee1111eee1111eeee11ff1eeee1fff77ee11111132216111c9989aa9aa9aa9a9a98a999ce166666767776670e89999a9aaaa99ac
ee1111ee331111223311112233111122111111ee1111111ee1111177e1111111332161118899a89aa9a9aaa98899988e1617767676677716898aa99aa99aaa89
e333222ee331122ee33ee22ee33ee22e333e222e333e222e333e222eeee11661e3316111c8898999999aa999989988cc0676776776766161c9a9aaa9a9aa989c
eeeeeeeeeeeeeeeeee66600eeeeeeeeeee4ee4eee4eeee4eeeeeeeeeeeeeeeee112333eecc8898a999a99a98999898890166777777766110c899aaaaaaa99888
eeeeeeeeee1111eee60171eeee66600ee14ee41e14eeee41eeeeeeeeeeeeeeee61123eeeeec8c98989898889a88989cc1161767677666661889899a99a999998
ee1111eee166110eee1888eee60171ee1661166116111161122ee111eee122ee6612ee2eeccc8888889888998c9c9cee117671667661161188a9989999988988
e161110ee161110eee699988ee1888ee1670076116700761e111221eee2242ee661eee2eeeec8c8c9888c888c9c8c8ce0116661776661101c889899a989988cc
16661110e111110eee66968eee69998891677619e167761eee1242eee221111e1661223eeeeccecc8cccec8c8ccceeeee111161661616110ec889898889898ce
11111110e111110eee2221eeee66968ee116611e91166119eee111ee211ee1111161223eeeeeceeecc1eeec1ce1eeeeee10111101110101eeee8898c918c8cee
01111000e011000eee2211eeee22211ee916619eee1661eeeeeeeeeeeeeeeeee1161233eeeeeeeeee321e111ee28eeeee0e1011210e01e0eeeece882c1eeceee
e000001ee000001eee33222ee3331222eee66eeeee9669eeeeeeeeeeeeeeeeee116133eeeeeeeeeeee32121ee93eeeeeeee0ee2311ee0eeeeeeeee2321eeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee777eeeffeeeeeeffeeecceeee32e23ee00000000000000000000000000000000000000009aaeee8e
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaaaaee6677206eee77206eeeeddeeeee1771e30000000000000000000000000000000000000000eeeeee8e
eeeeeeeeeeddddeecddeeccceeecddeeeeaaaaeeea55aa9eee54200177642001eeeddeee317f27120000000000000000000000000000000000000000eeeee88e
eeddddeeed77ddceecccddceeedd5deeea5aaa9eea5aaa9ee455411166554111eeeddeee27200f7e0000000000000000000000000000000000000000eeee88ee
ed77ddceedddddceeecd5deeeddccccea555aaa9eaaaaa9e55421eee55421eeeeeeddeeee7f002720000000000e5555555554e000000000000000000eeeeeeee
dddddddcedddddceeeeccceedcceecccaaaaaaa9eaaaaa9e4554eeee4554eeeeeeeddeee2172f7130000000000544444444454000000000000000000eeeeeeee
cddddcccecddccceeeeeeeeeeeeeeeee9aaaa999e9aa999ee3454eeee3454eeeeeeddeee3e1771eeefffffff2e540000000054edddddddce00000000eeeeeeee
ecccccdeecccccdeeeeeeeeeeeeeeeeee99999aee99999aeeee433eeeee433eeeeecceeeee32e23ef2222222f2540000000054dcccccccdce4554554eeeeeeee
eeeeeeeeeeeeeeeeee000eeeee000eeeeeeeeeeeeeeeeeeeeee77eeeeeeeeeeeeeeeeeeeeeeeee22f2000000f2540000000054dc000000dc4522522540000000
eeeeeeeeeeeeeeeee7ddd6eee7ddd6eeeeeeeeeeee4444eeee7707eeeee77eeeeee00eeeeeeeeefff2000000f2540000000054dc000000dc522222225effef2e
eeeeeeeeeeeeeeeee67776eee67776eeee4444eee455443eee6776eeee7707eeeeddddeeeeeee221f2000000f2540000000054dc000000dc522222225f4ff4f2
eeeeeeeeeeeaaeeeef2662eee2662feee454443ee454443eeecc66eeee6776eeee6776eeeeeeeee2f2000000f2540000000054dc000000dc522222225ffffff2
eeeaaeeeeea5a9eeeffff2eeeffff2ee45554443e444443eee76c1eeeecc66eeeef662eeeeeeeeeff2000000f2540000000054dc000000dc4522222542ffff22
ea55aa9eeeaaa9eee2f2feeeeef2f2ee44444443e444443eee66c1eee76cc16eee2ff2eeeeeeeefff2000000f2540000000054dc000000dce4522254ee2ff22e
e9aaa99eee9a99eeeefe2eeeee2efeee34444333e344333eee111eeee66cc11eeee2feeeeee54eff2fffffff22455555555554cdddddddccee45254eeee222ee
ee999aeeee999aeeee2eeeeeeeee2eeee333334ee333334eee3322eee331122eeeee2eeeeeeea1ffe22222222ee4444444444eecccccccceeee454eeeeee2eee
eeeeeeeeeeeeeeeeeeeeeeeeeeee0eeee0ee00eee0ee00e0ee8eeeeeeceeeeeeef2eff2f2222222f22fe22feeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeee00eeeeee00eeeeee00eeeeee00ee0eee88eeeecbceeeeee2eef22ff22ff2fffffeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee54eeeeeee
eeeeeeeeeeee0eeeeeee0eeeeeee0eee0eee0ee00e0e0ee0eee8eeeecbbceeeeeeeeef22ff22f2f2ffeeeeeeeeeee62344eeee44326eeeeeeee5e3e55e3e5eee
eeee0eeeeeee0eeeeeee0e0ee0ee0e0ee0ee0e0ee0ee0e0eeeeeeeeecbbbceeeeeeee22ef2ff2f2ef2eeeeeeeeee66344eeeeee44366eeeeeee5435554355eee
eee0eeeeee00e0eeee00e0eeee00e0eeee00e0eeee00e0eeeeeeeeeecbbbbceeeeeee2e2f22f2f2ef2eeeeeeeeeef62eeeeeeeeee262eeeeee554355443554ee
eeeeeeeeeeeeeeeee0e0ee0ee0e0ee00e0e0ee00e0e00e00eeeeeeeecbbcceeeeeeeeeef2eeeeffef2eeeeeeeee6f7eeeeeeeeeeee622eeeee5a555f2555a4ee
eeeeeeeeeeeeeeeeeee0eeeee0e0eeee00e0eeee00e0ee0eeeeeeeeeeccbceeeeeeeeeef2eeeeefee2eeeeeeeee6672e344ee443ef766eeeee495552254493ee
eeeeeeeeeeeeeeeeeeeeeeeeeeee00eeeeee00eeee0e00e0eeeeeeeeeeeceeeeeeeeeee2eeeeee2eeeeeeeeeee6677f344eeee44377766eeee344444444333ee
eee111177766619a916667771111eeeeeeeeeeee111166660066619aeeeeeeeee3332112eeeeeee2ffe11eff2eeeeeeeeeeeeeeeeeeeeeeeecccccceeeeeeeee
eeee11616116161916161161611eeeeeeeeeeeee1660676061161619eeeeeeee2e321161eeeeeeef22000022feeeeeeeeeeeeeeeeeeeeeedccccccccdeeeeeee
eeee16616616166966161661661eeeeeeeeeeeee6000776066198711eeeeeeee3ee21661eeeeee221212212122eeeeeeeeeeeeeeeeeee69ddccccccdd96eeeee
eee861166aa161111161aa661168eeeeeeeeeeee006677706aaa7110eeeeeeee32ee1660eeeeeeee2f1ff1f2eeeeeeeeeeeeeeeeeeee667fd999999df266eeee
ee88e666a9986669666899a666e88eeeeee2ee2361111771a99871002ee2eeee32216616eeeeeeefff1ff1fffeeeeeeeeeeeeeeeeeeef7777fff777f7762eeee
e88eee1699aa811a118aa9961eee88eeee23e2336666071999aa711032e32eee33216111eeeeee2ff12ff21ff2eeeeeeeeeeeeeeeee6f7777777777777622eee
e8eeeee19aaa8616168aaa91eeeee8eee233e33e166601aa9aa9671133e332eee3216111eee5eefff1ffff1fffee5eeeeeeeeeeeeee667777777777777766eee
e88eeee88aa9a96a69a9aa88eeee88eee23ee211700769aa8aa9a67712ee32eeee316110eee4a1ff21ffff12ff1a4eeeeeeeeeeeee66777f77777777777766ee
eeeeeeee776661a9a1666000eeee8eee6761111266611112eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11110ee6677727777777f277766ee
eeeeeeee6116161a16161161eee88eee6770661167606611eeeeeeeecddddddceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1161ee2277f7f7777ff7772762ee
eeeeeeee6616166a17891661eee8eeee7770700167700061eeeeeedddddddddddceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee1661eef267f77777777f7f7662ee
eeeeeeee6aa16111117aa966eeeeeeee7766617077766006eeeeeddd7777777dddceeeeeeeeeeeecddddddddceeeeeeeeee86116eef26f7777777777f77662ee
2eeeeeeeaa98666a01789a96eeeeeeee0711116677111160eeeedd7777777ddddddceeeeeeeeedddddddddddddceeeeeee88e666eef22667f7777f77f26222ee
ee111111a9aa8119117aa9a6eeeeeeee1606666117066661eeedd7777ddccddddddcceeeeeeedddd7777777ddddceeeee88eee16ee22f2266277f776662222ee
e111111199a986161769a991eeeeeeeea100000191066611eeedd77ddddccdddddddceeeeeedd777777ccdddddddceeee8eeeee1eee2ff2662662666662f2eee
eee116668aa9a96976a9aa88eeeeeeeea96000009a670071eecdd7ddddccccddddddcceeeedd77777ddccdddddddcceee88eeee8ee2f2ff22666226222fff2ee
1116766088eea9a691666000112333ee006661a9eeeeeeeeeedddddddccccccddddccceeeedd77ddddccccdddddddceeeeeeeeeeeefeff2f2222222f22fe2fee
17077600e8eeeeee1616116161123e2e6116161aeeeeeeeeeedddddddcdccdcddddccceeecdd7ddddccccccddddddcceeeeeeeeeee2ef22ff22ff2fff2feefee
0077770088eeeeee178916616612ee3e66198711eeeeeeeeeeddddddddccccdddddccceeeddddddddcdccdcdddddccce344ee443eeeef2e2ff22f2f2ffeeeeee
716677608eeeeeee117aaa66661ee23e69aa7110eeeeeeeeeedddddddccddccdddcccdeeedddddddddccccddddddccce73eeee37eeee22eef2ff2f2e2f2eeeee
61117661eeeeeeee017899a61661223e9a987100eeeeeeeeeedddddddddddddddccccdeeeddddddddccddccdddccccdef72eef77eeee2eeef22f2f2eef2eeeee
6666061aeeeeeeee117aa9961161233ea9aa7110ee111111eecdddddddddddccccccddeeecddddddddddddcccccccdde6272f776eeeeeeeef2eeff2eef2eeeee
00000199eeeeeeee1769aa91116123ee99a96711e1116611eeecccdddcccccccccdddeeeeecccdddcccccccccccdddee62662666eeeeeeee22eeefeeee2eeeee
00006a99eeeeeeee76a9aa8811613eee8aa9a677eee66661eeeeeccccccccccddddeeeeeeeeeccccccccccccddddeeee26662262eeeeeeee2eeee2eeeeeeeeee
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccrccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccc3ccccccjrcccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccrccccccrc3cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccjjcrcjjccc3rjccccccccccccccccccccc5555555mmmmmmmmmmcccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccjjrr3jjr3r3r3rr3rccccccccccccccccc5555555mmmmmmmmmmmmccccccccccccccccccccccccccccccccccccccccc
mcccccccccccccccccccccccccccccccjr3rrrrrrrrr3rrrrrrrcccccccccccccc55555555mmmmmmmmmmmmmmmccccccccccccccccccccccccccccccccccccccc
mmccccccccccccccccccccccccccccccc3rkk3rr3k33k33k3r3jcccccccccccccc5555555mmmmmmmmmmmmmmmmmcccccccccccccccccccccccccccccccccccccc
mmmmccccccccccccccccccccccccccccjrrk44k39999994443rrccccccccj3ccc55555555rm3mmmmmmmmmmmrrmmmcccccccccccccccccccccccccccccccccccc
mmmmcccccccccccccccccccccccccccccr39949499994449krr3jjcccccccrcc35355555m3rmmmmmmmmmmmm3m3mmcccccccccccccccccccccccccccccccccccc
mmmmmcccccccccccccccccccccccccccjr3444494444444443rrrccrjcccc3cj53555555mj3jmmjmmmmrmmmjmrmmmccccccccccccccccccccccccccccccccccc
mmmmmmccccccccccccccccccccccccccjrk4444449444kk4krrrjj3cjccjr33rjrj3j5jjrj3rmr3jjmmj3mjjj33mmmcccccccccccccccccccccccccccccccccc
mmmmmmmmmmmmmmcccccccccccccccccccr3k3k3k944k3rr33rrrr3r33jj5r3r3rrrr333r3r3rrrrrjmjmrmj3r3r3rmcccccccccccccccccccccccccccccccccc
mmmmmmmmmmmmmmmccccccccccccccccccjrrr3r349943rrrrrrrrrrr3rr3r3rr333rrrrrrrrr333rrr3jjjr333rrjjmccccccccccccccccccccccccccccccccc
mmmmmmmmmmmmmmmmmccccccccccccccccc3rrrrk94543rrrr335ii3rrrrr3kkkk943rrrr3k3kk573rrrr3r349kk3r3mmmccccccccccccccccccccccccccccccc
mmmmmmmmmmmmmmmmmmcccccccccccccccccrrrrk4m5krrrr3immm7m3rrr349449994krr3494499mmirrrr349999k3rjmmmcccccccccccccccccccccccccccccc
mmmmmmmmmmmmmmmmmmmmcccccccccccccccjrr3445i43rr357m5imm53rr34994k44943r349944445m3rrrk4kk494kr3mmmmmcccccccccccccccccccccccccccc
mmmmmmmmmmmmmmmmmmmmcccccccccccccccrrrrk5mi43rr3mm53r355irrk494k33k49krk944k3k4i5irr344rr349kr3jmmmmcccccccccccccccccccccccccccc
mmmmmmmmmmmmmmmmmmmmmccccccccccccccjrr345m4krr357i3rrri4k3r34493rr3444334943rr34i53rrkkrrrk94333mmmmmccccccccccccccccccccccccccc
mmmmmmmmmmmmmmmmmmmmmmcccccccccccccc3rr4mi443rrimmiiiim94rr34943rr3k43r39443rr3k43rrrrrrr3k4433jmmmmmmcccccccccccccccccccccccccc
555555mmmmmmmmmmmmmmmmmmmmmmmmcccccjr3rk5m4433r7i575mi5kkrr34493rrrrrrr34943rrrrrrrr33333k44433jmmmmmmmmmmmmmmcccccccccccccccccc
5555555mmmmmmmmmmmmmmmmmmmmmmmmccccc3r34574krr3mm5i33r33rrrrk44krrrrrrr3444krrrrrrrrk4444944kr3mmmmmmmmmmmmmmmmccccccccccccccccc
555555555mmmmmmmmmmmmmmmmmmmmmmmmcccjrrkim4krr34993rrrrrrrr3494krrrrrrr3444k3rrrrrr34444444443r3mmmmmmmmmmmmmmmmmccccccccccccccc
555555555mmmmmmmmmmmmmmmmmmmmmmmmmcc3r344i43rrr344k3r334k3rrk443rrrrrrrrk443rrr3rr3k443rr344kr3jmmmmmmmmmmmmmmmmmmcccccccccccccc
5555555555mmmmmmmmmmmmmmmmmmmmmmmmmmj3k4444k3rrrk944kk44k3r3444k3rr3rrr3444k3r3rrrrk444kk4444r3mmmmmmmmmmmmmmmmmmmmmcccccccccccc
5555555555mmmmmmmmmmmmmmmmmmmmmmmmmmjr344443rrrr3444444krrr34443rrrrrrr34443rrr3rrr33kk44444433mmmmmmmmmmmmmmmmmmmmmcccccccccccc
555555555555mmmmmmmmmmmmmmmmmmmmmmmm33k44443r3r3r3k4k4krrrr34kk3r3333r334kk3r3r33r33rrr3kk444333mmmmmmmmmmmmmmmmmmmmmccccccccccc
5555555555555mmmmmmmmmmmmmmmmmmmmmmmjrk33k3r3jjj3rr3r3rr33rr33r33j5j53jr33rr3j3j33jm3j3rr333kr3jmmmmmmmmmmmmmmmmmmmmmmcccccccccc
55555555555555mmmmmmmmmmmmmmmmmmmmmmmj33rr33j555533rrrrjj5j33j33555555m33j3jmmmmmmmmmmjj3r3rrr3jmmmmmmmmmmmmmmmmmmmmmmcccccccccc
555555555555555mmmmmmmmmmmmmmmmmmmmmm5j33j555555555j5j55555555555555555mmmmmmmmmmmmmmmmmmj33r3jmmmmmmmmmmmmmmmmmmmmmmmmccccccccc
55555555555555555mmmmmmmmmmmmmmmmmmm5555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmjmmmmmmmmmmmmmmmmmmmmmmmmmmmmccccccc
55555555555555555mmmmmmmmmmmmmmmmmmm5555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmcccccc
555555555555555555mmmmmmmmmmmmmmmm5555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmcccc
555555555555555555mmmmmmmmmmmmmmm55555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmcccc
55555555555555555555mmmmmmmmmmm555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmccc
555555555555555555555mmmmmmmmm55555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmcc
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmcc
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmc
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmm
5555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmm
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmm
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmm
5555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmm
5555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmm
555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmmmm5
5555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555mmmmmmmmmmmmmmmmm55
55555555555555555555555555555555555555555555555555555j3555555555555555555555555555555j355555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555333555555555555555555555555555553335555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555553j3j55555555555555555555555555553j3j5555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555553jj355555555555555555555555555553jj35555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555555jj33j555555555555555555555555555jj33j555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555533j3j35555555555555555555555555533j3j3555555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555553jjjj3355555555555555555555555553jjjj3355555555555555555555555555555555555555
5555555555555555555555555555555555555555555555555533jjj3j355555555555555555555555533jjj3j355555555555555555555555555555555555555
555551j55555555555555j3555555555555551j555555555j3j3j3j33j35j555555551j555555555j3j3j3j33j35j555555551j55555555555555j3555555555
55555jjj55555555555553335555555555555jjj5555555j33j3j3j3jj33555555555jjj5555555j33j3j3j3jj33555555555jjj555555555555533355555551
5555j1j15555555555553j3j555555555555j1j1555555j53jj3jjjj33j3j5555555j1j1555555j53jj3jjjj33j3j5555555j1j15555555555553j3j55555515
5555j11j5555555555553jj3555555555555j11j5555555jjj3jjjj3j33j5j555555j11j5555555jjj3jjjj3j33j5j555555j11j5555555555553jj355555551
555511jj155555555555jj33j5555555555511jj155555j3j33j3jj33j3j3555555511jj155555j3j33j3jj33j3j3555555511jj155555555555jj33j555551j
555jj1j1j555555555533j3j35555555555jj1j1j5555553j33jjjjj3jjj3j55555jj1j1j5555553j33jjjjj3jjj3j55555jj1j1j555555555533j3j3555555j
555j1111jj5555555553jjjj33555555555j1111jj55553j33j3jj3jjj3j3355555j1111jj55553j33j3jj3jjj3j3355555j1111jj5555555553jjjj335555j1
55jj111j1j5555555555555555555555555j11555555555555555j55555555555555555j1j55555555555j555553j35555555555555555555533jjj3j355551j
1j1j1j1jj1j51555j357755777557757775j1j577755155777575357775757577757775jj1577757775753577755j5575757775777577755j3j3j3j33j35j555
jj1j1j1j11jj555j3357575757575757575j1j57575j555757575357575757575557575j115755557557535755535557575755575757555j33j3j3j3jj335551
j11j1111jj1j15j53j57575775575757775j1157775j155777575j577757775775577551jj5775j575575j5775j3j55777577557755775j53jj3jjjj33j3j515
11j1111j1jj1515jjj57575757575757555111575751515755575557575557575557575j1j57555575575557555j5j57575755575757555jjj3jjjj3j33j5j51
1jj1j11jj1j1j5j3j3577757575775575jj1j1575751j55753577757575777577757575jj157555777577757775j35575757775757577753j33j3jj33j3j351j
1jj11111j111j153j3555555555555555jj111555551j155535555555555555555555551j155515555555555555j3j555555555555555553j33jjjjj3jjj3j5j
jj1j11j111j1jj3j33j3jj3jjj3j33j1jj1j11j111j1jj3j33j3jj3jjj3j33j1jj1j11j111j1jj3j33j3jj3jjj3j33j1jj1j11j111j1jj3j33j3jj3jjj3j33j1
j1j11111j1jiiijiiiiiiiij3jiiiiiiiiiiiiiiiiiiiii33j3iiiiiii33j3iiiiiiiii1j1jiiiiiiiiiiiiiiiiiiiijj1jiiiiiiiiiiiiiiiiiiijj3j33j31j
1j1j1j1jj1iimiiimmimmmi33jimmmimmmimmmiimmiimmi5j3iimmmmmii5j5immmiimmijj1iimmimmmimmmimmmimmmi51jiimmimimimmmimmmiimii33j35j555
jj1j1j1j11imiiimimimimi3jjimimimimimiiimiiimiiij33immiiimmi355iimiimimij11imiiiimiimimimimiimii1jjimimimimimiiimimiiimi3jj335551
j11j1111jjimi5imimimmiij33immmimmiimmiimmmimmmi53jimmimimmi3j51imiimimi1jjimmmiimiimmmimmiiimi15j1imimimimimmiimmii3imij33j3j515
11j1111j1jimiiimimimimi3j3imiiimimimiiiiimiiimijjjimmiiimmij5j5imiimimij1jiiimiimiimimimimiimi5111imimimmmimiiimimiiimi3j33j5j51
1jj1j11jj1iimiimmiimimi33jimi5imimimmmimmiimmii3j3iimmmmmiij351imiimmiijj1immiiimiimimimimiimi1j1jimmiiimiimmmimimiimii33j3j351j
1jj11111j11iiiiiiiiiiiij3jiiijiiiiiiiiiiiiiiii53j33iiiiiiijj3j5iiiiiii11j1iiii5iiiiiiiiiiiiiii5j1jiiii1iiiiiiiiiiiiiiijj3jjj3j5j
jj1j11j111j1jj3j33j3jj3jjj3j33j1jj1j11j111j1jj3j33j3jj3jjj3j33j1jj1j11j111j1jj3j33j3jj3jjj3j33j1jj1j11j111j1jj3j33j3jj3jjj3j33j1
j1j11111j1jj1jj33j3jjjjj3j33j31jj1j11111j1jj1jj33j3jjjjj3j33j31jj1j11111j1jj1jj33j3jjjjj3j33j31jj1j11111j1jj1jj33j3jjjjj3j33j31j
j1j1j11jj1j51555j3j3j3j33j35j5551j1j1j1j11jj1333j3jjjj33jj33j3j1j1j1j11j11jj1333j3jjjj33jj33j3j1j1j1j11jj1j51555j3j3j3j33j35j555
1jj1j11j11jj555j33j3j3j3jj335551jj1j1jj1j111jj3j3jjjjjjjj3j3j3311jj1j1j1j111jj3j3jjjjjjjj3j3j3311jj1j11j11jj555j33j3j3j3jj335551
1j1jj111jj1j15j53jj3jjjj33j3j515j11j11j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj111jj1j15j53jj3jjjj33j3j515
1j1j111j1jj1515jjj3jjjj3j33j5j5111j111111j1j33jjjjjjjjj3j33j33j31j1j11111j1j33jjjjjjjjj3j33j33j31j1j111j1jj1515jjj3jjjj3j33j5j51
j1j1111jj1j1j5j3j33j3jj33j3j351j1jj1j11j11j1j3j3j3jjjjjjjjjj3j3jj1j1111j11j1j3j3j3jjjjjjjjjj3j3jj1j1111jj1j1j5j3j33j3jj33j3j351j
j1jj1111j111j153j33jjjjj3jjj3j5j1jj11111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j111j153j33jjjjj3jjj3j5j
j1jj11j111j1jj3j33j3jj3jjj3j33j1jj1j1111j1jj3j33jjjjjjj33j33j3j3j1jj1111j1jj3j33jjjjjjj33j33j3j3j1jj11j111j1jj3j33j3jj3jjj3j33j1
3jj11111j1jj1jj33j3jjjjj3j33j31jj1j111111j133j3jj3jjjjjjjj333j3j3jj111111j133j3jj3jjjjjjjj333j3j3jj11111j1jj1jj33j3jjjjj3j33j31j
j1j1j11j11jj1333j3jjjj33jj33j3j1j1j1j11j11jj1333j3jjjj33jj33j3j1j1j1j11j11jj1333j3jjjj33jj33j3j1j1j1j11j11jj1333j3jjjj33jj33j3j1
1jj1j1j1j111jj3j3jjjjjjjj3j3j3311jj1j1j1j111jj3j3jjjjjjjj3j3j3311jj1j1j1j111jj3j3jjjjjjjj3j3j3311jj1j1j1j111jj3j3jjjjjjjj3j3j331
1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j
1j1j11111j1j33jjjjjjjjj3j33j33j31j1j11111j1j33jjjjjjjjj3j33j33j31j1j11111j1j33jjjjjjjjj3j33j33j31j1j11111j1j33jjjjjjjjj3j33j33j3
j1j1111j11j1j3j3j3jjjjjjjjjj3j3jj1j1111j11j1j3j3j3jjjjjjjjjj3j3jj1j1111j11j1j3j3j3jjjjjjjjjj3j3jj1j1111j11j1j3j3j3jjjjjjjjjj3j3j
j1jj1111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j1jj3jj3jjjjjjjjj33jjj33
j1jj1111j1jj3j33jjjjjjj33j33j3j3j1jj1111j1jj3j33jjjjjjj33j33j3j3j1jj1111j1jj3j33jjjjjjj33j33j3j3j1jj1111j1jj3j33jjjjjjj33j33j3j3
3jj111111j133j3jj3jjjjjjjj333j3j3jj111111j133j3jj3jjjjjjjj333j3j3jj111111j133j3jj3jjjjjjjj333j3j3jj111111j133j3jj3jjjjjjjj333j3j
j1j1j11j11jj1333j3jjjj33jj33j3j1j1j1j11j11jj1333j3jjjj33jj33j3j1j1j1j11j11jj1333j3jjjj33jj33j3j1j1j1j11j11jj1333j3jjjj33jj33j3j1
1jj1j1j1j111jj3j3jjjjjjjj3j3j3311jj1j1j1j111jj3j3jjjjjjjj3j3j3311jj1j1j1j111jj3j3jjjjjjjj3j3j3311jj1j1j1j111jj3j3jjjjjjjj3j3j331
1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj1j1jj1jj3j33j3jjjjjj3jj3j3j
1j1j11111j1j33jjjjjjjjj3j33j33j31j1j11111j1j33jjjjjjjjj3j33j33j31j1j11111j1j33jjjjjjjjj3j33j33j31j1j11111j1j33jjjjjjjjj3j33j33j3
j1j1111j11j1j3j3j3jjjjjjjjjj3j3jj1j1111j11j1j3j3j3jjjjjjjjjj3j3jj1j1111j11j1j3j3j3jjjjjjjjjj3j3jj1j1111j11j1j3j3j3jjjjjjjjjj3j3j
j1jj1111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j1jj3jj3jjjjjjjjj33jjj33j1jj1111j1jj3jj3jjjjjjjjj33jjj33
j1jj1111j1jj3j33jjjjjjj33j33j3j3j1jj1111j1jj3j33jjjjjjj33j33j3j3j1jj1111j1jj3j33jjjjjjj33j33j3j3j1jj1111j1jj3j33jjjjjjj33j33j3j3
3jj111111j133j3jj3jjjjjjjj333j3j3jj111111j133j3jj3jjjjjjjj333j3j3jj111111j133j3jj3jjjjjjjj333j3j3jj111111j133j3jj3jjjjjjjj333j3j
3111111j11jj1333j3jjjj33jj33j3j1j1j1j11111133j3j3jjjjjjjj3j3j3j33111111111133j3j3jjjjjjjj3j3j3j33111111j11jj1333j3jjjj33jj33j3j1
311111j1j111jj3j3jjjjjjjj3j3j3311jj1j111111jj33jjjjjjjj3jjj3j33j31111111111jj33jjjjjjjj3jjj3j33j311111j1j111jj3j3jjjjjjjj3j3j331
jj1111j1jj1jj3j33j3jjjjjj3jj3j3j1j1jj11111j3j3jjjjjjjjjjjj3j3jj3jj11111111j3j3jjjjjjjjjjjj3j3jj3jj1111j1jj1jj3j33j3jjjjjj3jj3j3j
3j1111111j1j33jjjjjjjjj3j33j33j31j1j11111133j3j3jjjjjjjj3j3j33j33j1111111133j3j3jjjjjjjj3j3j33j33j1111111j1j33jjjjjjjjj3j33j33j3
3j11111j11j1j3j3j3jjjjjjjjjj3j3jj1j11111113j3jj3jjjjjjjjjjjjjj3j3j111111113j3jj3jjjjjjjjjjjjjj3j3j11111j11j1j3j3j3jjjjjjjjjj3j3j
j3111111j1jj3jj3jjjjjjjjj33jjj33j1jj1111113j33jjjjjjjjjjjj3jj3j3j3111111113j33jjjjjjjjjjjj3jj3j3j3111111j1jj3jj3jjjjjjjjj33jjj33
j3311111j1jj3j33jjjjjjj33j33j3j3j1jj11111jj33j3jjjjjjjjjjjjj33j3j33111111jj33j3jjjjjjjjjjjjj33j3j3311111j1jj3j33jjjjjjj33j33j3j3
jj3111111j133j3jj3jjjjjjjj333j3j3jj11111133j3jjjjjjjjjjjjjj33j33jj311111133j3jjjjjjjjjjjjjj33j33jj3111111j133j3jj3jjjjjjjj333j3j
3111111111133j3j3jjjjjjjj3j3j3j33111111111133j3j3jjjjjjjj3j3j3j33111111111133j3j3jjjjjjjj3j3j3j33111111111133j3j3jjjjjjjj3j3j3j3
31111111111jj33jjjjjjjj3jjj3j33j31111111111jj33jjjjjjjj3jjj3j33j31111111111jj33jjjjjjjj3jjj3j33j31111111111jj33jjjjjjjj3jjj3j33j
jj11111111j3j3jjjjjjjjjjjj3j3jj3jj11111111j3j3jjjjjjjjjjjj3j3jj3jj11111111j3j3jjjjjjjjjjjj3j3jj3jj11111111j3j3jjjjjjjjjjjj3j3jj3
3j1111111133j3j3jjjjjjjj3j3j33j33j1111111133j3j3jjjjjjjj3j3j33j33j1111111133j3j3jjjjjjjj3j3j33j33j1111111133j3j3jjjjjjjj3j3j33j3
3j111111113j3jj3jjjjjjjjjjjjjj3j3j111111113j3jj3jjjjjjjjjjjjjj3j3j111111113j3jj3jjjjjjjjjjjjjj3j3j111111113j3jj3jjjjjjjjjjjjjj3j
j3111111113j33jjjjjjjjjjjj3jj3j3j3111111113j33jjjjjjjjjjjj3jj3j3j3111111113j33jjjjjjjjjjjj3jj3j3j3111111113j33jjjjjjjjjjjj3jj3j3
j33111111jj33j3jjjjjjjjjjjjj33j3j33111111jj33j3jjjjjjjjjjjjj33j3j33111111jj33j3jjjjjjjjjjjjj33j3j33111111jj33j3jjjjjjjjjjjjj33j3
jj311111133j3jjjjjjjjjjjjjj33j33jj311111133j3jjjjjjjjjjjjjj33j33jj311111133j3jjjjjjjjjjjjjj33j33jj311111133j3jjjjjjjjjjjjjj33j33

__gff__
00030303520303030012030303034a5252d25203030303030400040000000000040404040404040404040404040404040000000000040000000000000000000003000404c20400040000000404047372000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
dcdcdc00dcdcdcdcdcdcdcdc898a8bdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdc5c5f6c6c6c5ddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdc00000000000000000000000000000000000000
dc2edc00dcdcdcdcdcdcdcdc999a9bdcdcdcdcdcdcdcdcdcdcdcdcdc5c6f6c5ddcdcdcdcdcdcdc5c5f6c5ddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdc5c5b6f6c6c6c6c6c5ddcdcdcdcdcdc5c6f6c5ddcdcdcdcdcdcdc5c5f6c5ddcdc00000000000000000000000000000000000000
dcdcdc00dcdcdc09dcdcdcdcdc52dcdcdcdcdcdcdcdcdcdcdcdcdcdc5b5b6f6c6c5ddcdcdc5c5b5f6c6c6c5ddcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdc5c5b5b5b5b6f6c6c6c6c6c6c6c5ddcdc5c5b5b6f6c6c5ddcdcdc5c5b5f6c6c6c5ddc00000000000000000000000000000000000000
dc6ddc00dcdc96dca044dc11dc52dcdcdcdc08090a0b0c0d0e0fdcdc5b5b5b5b6f6c6c5d5c5b5b6f6c6c6c6c6c5ddcdcdcdcdcdcdcdcdcdcdcdcdc5c5f5ddcdcdcdc5c6c6c6c6c6c5d5c5f6c5e5b5b5b5b5b5b6f6c6c6c6c6c6e5b5b5b5b5b5b6f6c6c5d5c5b5b6f6c6c6c6c6c00000000000000000000000000000000000000
dcdcdcdcdc0e0e0e0e0e0e05dc5341dcdcdc18191a1b1c1d1e1fdcdc5b5b5b5b5b6f6c6e5b5b5b5b6f6c6c6c6c6c5ddcdcdcdcdcdcdcdcdcdcdc5c5f6c6cdcdcdcdc5b6f6c6c6c6c6c6c6c6c6e5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b6f6c6e5b5b5b5b6f6c6c6c6c00000000000000000000000000000000000000
dc34dcdc28dcdce6e7e8dc0506060606dcdc28292a2b2c2d2e2fdcdc5b5b5b5b5b5b5b5b5b5b5b5b5b5b6f6c6c6c6c5ddcdcdcdcdcdcdcdc5c5b6f6c6c6c5ddcdc5c5b5b5b6f6c6c6c6e5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b6f6c6c00000000000000000000000000000000000000
dcdcdc850f1012f6f7f8060607070707dcdc38393a3b3c3d3e3fdcdc5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b6f6c6c6e5b6f6c6c5ddc5c5b5b5b5b6f6c6c6c5d5c5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b62635b5b5b5b5b5b62635b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b5b6f00000000000000000000000000000000000000
dc11dc06060606060606070707070707dcdcdcdcdcdcdcdcdcdcdcdc5b62635b5b5b5b5b5b62635b5b62635b5b5b5b606162636f6c6c5e5b5b5b5b5b5b62635b5b5b5b5b5b62635b5b5b5b5b5b62635b5b6572606162635b5b65725b5b62635b5b5b5b5b5b62635b5b62635b5b00000000000000000000000000000000000000
dcdcdc07070707070707070707070707dcdcdcdcdcdcdcdcdcdcdcdc616572606162636061657260616572606162637071657260615b5b5b5b626360616572606162635b5b6572606162635b5b657260616572707165726061657260616572606162636061657260616572606100000000000000000000000000000000000000
dcdcdcdcdcdcdcdcdcdcdcdcdcdc0000dcdcdcdcdcdcdcdcdcdcdcdc71657270716572707165727071657270716572707165727071626360616572707165727071657260616572707165726061657270716572707165727071657270716572707165727071657270716572707100000000000000000000000000000000000000
dcb2dcb3dcdddedfdcdccbcccddc00000000dcdcdcdcdcdcdcdcdc007165727071657270716572707165727071657270716572707165727071657270716572707165727071657270716572707165727068696a6b7165727068696a6b716572707165727071657270716572707100000000000000000000000000000000000000
dcdcdcdcdcedeeefdcdcedfcefdc00000000dccbcccddcd9dadbdc0068696a6b7165727068696a6b68696a6b7165727068696a6b716572707165727068696a6b7165727068696a6b7165727068696a6b68696a6b68696a6b68696a6b68696a6b7165727068696a6b68696a6b7100000000000000000000000000000000000000
dc94dc95dcfdfeffdcdcfdfeffdc00000000dce9fcebdce9eaebdc0068696a6b68696a6b68696a6b68696a6b68696a6b68696a6b7165727068696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b6800000000000000000000000000000000000000
dcdcdcdcdcdcdcdcdcdcdcdcdcdc00000000dcf9fafbdcf9fafbdc0068696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b68696a6b6469666768696a6b6469666768696a6b68696a6b68696a6b68696a6b6800000000000000000000000000000000000000
dcb8dcb8dcdddedfdcdccbcccddc00000000dcdcdcdcdcdcdcdcdc006469666768696a6b646966676469666768696a6b6469666768696a6b68696a6b6469666768696a6b6469666768696a6b646966676469666764696667646966676469666768696a6b64696667646966676800000000000000000000000000000000000000
dcdcdcdcdcedeeefdcdcedfcefdc00000000dccbcccddcb9da5adc0064696667646966676469666764696667646966676469666768696a6b646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676400000000000000000000000000000000000000
dca9dca9dcc8c9cadcdcc8c9cadc00000000dce9fcebdce9eaebdc0064696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676400000000000000000000000000000000000000
dcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcf9fafbdcf9fafbdc0064696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676400000000000000000000000000000000000000
dc59dc59dcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdc0064696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676400000000000000000000000000000000000000
dcdcdcdcdcdcd4797cd7dcdcd4e07cd7dcdc0000000000000000000064696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676469666764696667646966676400000000000000000000000000000000000000
dca8dca8dcdc78d577f3dcdcd875e4f3dcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
dcdcdcdcdcdcd0d1d2d3dcdcecd6f2d3dcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcc6c7afe3dcdcc6f1afe3dcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcdcdcdcdcdcdcdcdcdcdcdcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcdcdcdcdcdcdcdcdcdcdcdcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdc73877d7fdcdc73f57d7fdcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdc887ee598dcdc88f07498dcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcd0e17ad3dcdcecf4e2d3dcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcc6f176e3dcdcc6f176e3dcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcdcdcdcdcdcdcdcdcdcdcdcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000dcdcdcdcdcdcdcdcdcdcdcdcdcdc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
040100000e0601107012070120701207011060100500f0400c0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
59800000105540e554005000050000500005000050010551105540e5540050000500005000050000500105510e5551055400500005000050000500005000e5510e5541055400500005000050000500005000e551
1920002000005000050000500005000050c0000e0001000011055000051005510055000050c0550e055100550000500005000050000500005100000e0000c00010035000050c0350c03500000100350e0350c035
000200001c1551d1551f15521145201351515517155161450f155101551215514155171451613511155101450e1450e1450e1450d1350c1350b1250b1250a1150a11500105001050010500105001050010500105
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
a10200001e1522015222152231521b1521e1521a15219152191521615212152151520010200102001020010200102001020010200102001020010200102001020010200102001020010200102001020010200102
05070f102b4502b430205722053229350293301e5721e5321f4530735007350073500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
050700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002b4502b430205722053229350293301e5721e532
291a0a001f7301f725000000000000000000000e305000000e35000000000000000000000000000e3050e30000000000000000000000000000000000000000000000000000000000000000000000000000000000
090d00100c0733f600136150c0731862018623136153f60013615136053f60013615136053f600136153f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f6003f600
050d000007350073500e3500e35024451244502445224452234551f4551d4050e350000000000007350000000735000000073500000024454244522445024455234551f455000000735000000000000e35000000
050d100007350073500e3500e35024451244502445224452234551f4551d4050e350000000000007350000000730000000073000000024404244022440024405234051f405000000730000000000000e30000000
050d00000735000000073500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
914000200862010625000050000510624136250e605000050d6000d600106240e625056000560000000000000b620106250000500005086000860000000000000b6241162500005000050d6200e6250e60500005
8940002000301233110030100301003010030100301195150030100301003012b3110030100301003011b5150000015311003010030124311003010030115515003010030100301003010912100301003011b605
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
030e001815650150533d6203d6501e0253d6203d6503d65500000010550d010010550c0530c0033d6203d6501e0253d6203d6503d655000001942400000010550000000000000000000000000000000000000000
011500001975019750197501c7501c7501c7502175021750217502075020750207502074020730207202071519400000000000000000000000000000000000001940000000000000000000000000000000000000
091500001705017050170501805018050180501e0501e0501e0501e0501e0501e0501f0501f0501c0501c0501c0501c0501c0501c0501c0401c0301c0201c0150000000000000000000000000000000000000000
192a0000100541005010050100500b0510b05519154191521715417152171521715519104191020b0500b0500d0500d0500d0500d05008050080501e155201551915508000191351c10507424074220742207425
1915000004050000001c3551435500000193550405017355040500000020355000000405000000000000000004050000001c35514355000001935504050173550405000000203050405004050000000000000000
011500001031000000190551431019025190551731019025190550d31019025190551031019025190550d31019025103101431010310173101431019310173101c31019310203101c31023310203102531023310
001500001031000000150551531015025150551731015025150550931015025150551031015025150550d3101502510310153101031019310153101c31017310213101c310253102131028310253102d31028310
001500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
03 63644344
01 191a4a44
00 1d4c4344
00 191a1f44
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
01 383f4344
00 38394344
00 383f4344
00 383d4344
00 383e4344
00 383c4344
00 383c4344
00 383b4344
00 383b4344
02 383f4344
00 00420304
00 00420304
00 00420304
00 31324344
00 31324344
01 33344344
00 33344344
00 33344344
00 33344344
00 35364344
00 35364344
02 37364344
01 01024344
00 01022344
00 01022444
00 01412444
00 01024344
02 01232442
00 81828384
00 81828384
00 81828384
00 81828384
00 81828384

