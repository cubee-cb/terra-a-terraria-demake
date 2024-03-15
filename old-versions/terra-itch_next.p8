pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
--terra - a terraria demake
--by cubee 🐱

cartdata"cubee_terra"
function _init()
for i=-32768,0x55ff do
poke(i)
end

_reload()

tospr("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9eeeeee8aeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeeeeeeae9eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88eae88eee9a8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88aa988a9a9a9aa9aeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8a9aaaaaaaaa9aaaaaaaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9a229aa929929929a98eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8aa233294444443339aaeeeeeeee89eeeeeeeeeeeae9eeeeeeeeeeeaaeeeeeeeea944343444433342aa988eeeeeeeaee9e9eeeeee9aeeeeeeeeeeee9e9eeeeee8a9333343333333339aaaeea8eeee9e8e9eeeeeee898ee8eeeeaeee8eaeeeeee8a233333343332232aaa889e8ee8a99a8a898e88a89aea988ee89e88899eeeeeea92929243329aa99aaaa9a9988ea9a9aaaa999a9a9aaaaa8e8eae89a9a9aeeee8aaa9a934439aaaaaaaaaaa9aa9a9aa999aaaaaaaaa999aaa9888a999aa88eeee9aaaa243639aaaa996119aaaaa92222439aaaa929226b9aaaa9a934229a9eeeeeaaaa23762aaaa91777b79aaa9343344432aa9343344771aaaa93444429a8eeee8aa9336139aa96b7617769aa93443233439a93443333679aaa23223432a9eeeeaaaa267139aa97769a9661aa23432992342a24332923161aa933aa9342a98eee8aa936732aa96b19aaa1329a93349aa9333993439aa93169aa22aaa243999eeee9aa371339aa1771111743aa93439aa9239a94339aa9239aaaaaaa9233998eee8a9a2673399ab16b671622aa93349aaaaaaa93439aaaaaaaa999992333998eeee9a936b32aa9776199a99aaaa2332aaaaaaa93332aaaaaaaa233334332a9eeeee8aa21732aa93449aaaaaaaa93432aaaaaaa933329aaaaaa93333333339a9eeee9a933139aaa93329a99329aa2339aaaaaaaa2339aaa9aa92339aa9332a98eeee892333329aaa2433223329a933329aa9aaa933329a9aaaa2333223333a9eeeee8a933339aaaa93333332aaa93339aaaaaaa93339aaa9aaa992233333399eeeee99233339a9a9a923232aaaa93229a9999a993229a9a99a99aaa922333999eeee8a29929a98889aa9a9aa99aa99a998e8e98a99aa9898998e989aa9992a98eeeee899aa998eeee99aaaa88e899899eeeeeee99898eeeeeeeeee889a9aaa98eeeeee8998eeeeeeeee8e8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee899a98eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",64,64,0)

t,mouse,cam_x,cam_y,actx,acty,
spawns,
stats,
palettes,
recipes,
toolstat,
drops=
0,dget(0)==1,0,0,0,0,
{},
split[[gslime|14|6|0|59:1|slime|0.8|1|0|0|176|0|1|1
,bslime|25|8|2|59:2|slime|1|1|0|0|160|0|1|1|12:13:7
,rslime|42|15|4|59:2_20:1|slime|1|1|1|0|160|0|1|1|0:1:6
,yslime|42|16|7|59:3_21:1|slime|1|1|1|0|144|0|1|1|3:4:5
,jslime|50|18|6|59:4|slime|1|1|1|0|144|0|1|1|9:10:5
,jspike|40|20|8|60:1_59:-4|slime|1|1|1|0|195|0|1|1|9:10:5:2:3
,eye|55|18|2|54:1|eye|0.8|1|0|1| 1.5|10.5|1|1|13:2:0:15
,caye|60|18|4|54:1|eye|0.7|1|0|1|1.5|10.5|1|1|6:2:7:15
,grye|55|20|0|54:1|eye|0.8|1|0|1|1.5|10.5|1|1|13:8:0:9
,zombie|40|14|6|59:3|fighter|0.5|0.5|0|0|146|0|1|1|0:2:3:1:6
,twigie|40|16|4|59:3|fighter|0.55|0.5|0|0|146|0|1|1|0:2:3:1:2:9
,femaie|32|12|3|59:3|fighter|0.6|0.5|0|0|146|0|1|1|2:2:3:1:15:3
,baldie|36|15|5|59:3|fighter|0.5|0.5|0|0|146|0|1|1|2:2:3:1:6:15
,eater|38|24|8|61:1_____________________________________________________________________________________________99:1|flying|0.5|1|0|1|1.5|12.5|1|1
,bat|15|13|2|86:1|flying|0.8|1|0|0| 162|0|1|1|12:13:5
,jbat|30|20|4|89:1|flying|0.8|1|0|0| 162|0|1|1|1:2:4
,hornet|46|26|12|60:1|flying|0.5|1.5|1|0|166|0|1|1
,honeyt|42|28|12|60:1|flying|0.6|1.5|1|0|166|0|1|1|4:5:2:3:4
,leafyt|38|30|14|60:1|flying|0.6|1.5|1|0|166|0|1|1|3:4:8:9:10
,skeleton|40|20|8|52:3_52:5_56:1|fighter|0.5|1.1|0|0|182|0|1|1|1:2:3:12:1
,pantston|40|22|8|52:3_52:5_56:1|fighter|0.5|1.1|0|0|182|0|1|1|1:2:3:2:6
,headacon|44|20|12|52:3_52:5_56:1|fighter|0.5|1.1|0|0|182|0|1|1|8:3:4:9:1
,cohbeetle|40|20|10|93:-1|fighter|1|0.8|0|0|164|0|1|1|1:15:15:3:2
,lacbeetle|40|20|10|93:-1|fighter|1|0.8|0|0|164|0|1|1|2:15:3:1:0
,cyabeetle|40|20|10|93:-1_20:2|fighter|1|0.8|0|0|164|0|1|1|12:13:13:1:0
,eocservant|8|12|0|0:1|flying|1|0.6|0|1|1.5|14.5|1|1
,marcoservant|20|16|0|0:1|flying|1|0.9|0|1|1.5|16.5|1|1
,tentacle|200|20|10|0:1||0|1|0|1|1.5|22.5|1|1|8:9:3:4:5:9:10:8:9:10:11:12:13:14:10
,eoc|2400|14|12|23:-18|eoc|0|1|0|1|7.5|11.5|3|3|1|1200
,kingslime|1800|22|10|20:-7_21:-7_22:-7|slime|0|1|1|0|230|0|3|2
,marco|3600|26|13|98:-1_55:-6|eoc|0|1|0|1|8|21|4|4|1|2100
,plantera|4000|40|16|90:-1||0|1|0|1|23.5|22.5|3|3
,seed|1|25|0||projectile|0|1|1|1|1.5|18.5|1|1
,marcolaser|1|16|0||projectile|0|4|1|1|1.5|20.5|1|1|12:13
,stinger|1|13|0||projectile|0|1|1|1|1.5|24.5|1|1|0:0:0:0:0:2:3
]],
split([[
130,132,4,
9,10,5,134,
131,3,139,7,
1,140,12,136,128;

128,130,132,
4,137,133,5,
1,131,3,6,
129,1,140,2,128;

0,128,130,
132,4,130,133,
129,1,131,13,
0,129,1,130,0;

0,0,128,
128,132,128,130,
0,129,1,5,
0,0,129,128,0;

0,0,0,
0,128,0,128,
0,0,129,130,
0,0,0,0,0;
]],";"),
split([[
17:3|5,59|torch;
68:1|17:3,5:4|campfire;
14:2|5|platform;
5|14:2|wood from platform;
78:1:15|5:6|door;
13:1:16|3:2|grey brick;
64:1:16|19:2|red brick;
70:1:16|21,3|silver brick;
75:1:15|5:5|table;

87:1:15|86:2,93|potion;
87:2:4|9:3|potion;
96:1:18|89:10,55:2|hermes boots;

74:1:4|55:1,61:2,52:99|endless quiver;
80:15|17:1,52:15|fire arrows;
52:25:15|3:1,5:1|arrows;

73:1:4|55:1,61:2,51:99|endless pouch;
81:20:18|57:1|silver bullets;
51:25:18|56:1|bullets;

92:1:4|57:2,59:99|endless gel pack;

15|5:10|workbench;
16:1:15|5:4,3:10,17:3|furnace;
18:1:15|56:5|anvil;
4:1:18|58:4,98:1|cursed forge;

91:1:4|53,90|terra blade;
65:1:4|85,90|dogblaster;

53:1:4|24,84,34|nights edge;
8:1:4|72,55:2|flamethrower;
94:1:4|93:5,95|beetler;

102:1:4|60:10,89:8|jungle armour;

84:1:18|60:10,89:8|blade of grass;
85:1:18|50,55:2|minishark;
95:1:18|48,55:1|corrupt repeater;

101:1:18|55:4,61:6|shadow armour;

55:1:16|23:3|demonite bar;
24:1:18|55:3|lights bane;
26:1:18|55:4|nightmare pick;
72:1:15|17:4,5:6|wand of sparking;

100:1:18|58:7|gold armour;

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

69:4:15|5|wood wall;
66:4:15|2|dirt wall;
67:4:15|3|stone wall;
71:4:15|7|mud wall;
76:4:15|12|ebonwall;

5:1:15|69:4|wood;
2:1:15|66:4|dirt;
3:1:15|67:4|stone;
7:1:15|71:4|mud;
12:1:15|76:4|ebonstone;

1:4|2:4,89|grass;
6:4|7:4,89|jungle;
10:4|2:4,61|corrupt;

62:1:15|54:6|sus eye;
63:1:18|59:15|rebranded slime;
25:1:18|61:6,55:1|3ds boss;
88:1:4|89:6|plan-terra
]],";"),
split[[
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
11:ranged:12:gel:1:1.3,
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
0:summon:16:marco-22,
9:pick:15:0:0:1.1,
0:block,
11:ranged:26:arrow,
9:ranged:27:arrow,
8:ranged:28:arrow,
4:ranged:30:arrow,

9:hammer:28:0:0:1.1,
6:pick:17:0:0:1.1,
13:melee:20:0:0:1.1,
7:axe:26:0:0:1.1,
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

8:ranged:20:arrow:1.1,
0:aight imma head out,
24:ranged:48:bullet:0:1.2,
7:bullet:220:8,
4:arrow:52:3,
42:melee:21:0:1:1.2,
0,0,0,0,0,
0:gel:123:3,
0,0,
0:summon:16:eoc-53,
0:summon:16:kingslime-0,

0:block,
30:ranged:10:bullet:1,
0:block,
0:block,
0:block,
0:block,
0:block,
0:block,
6:ranged:26:gel,
8:bullet:220:8,
6:arrow:52:3,
0:block,
0:block,
0,
0:block,
0,

7:arrow:80:3.5,
9:bullet:220:9,
0,0,
28:melee:30:0:0:1.3,
6:ranged:9:bullet:1:1.1,
15:hpup:60,
50:hpup:140,
0:summon:16:plantera-31,
0,0,
60:melee:18:0:1:1.4,
0:gel:123:4.5,
0,
20:ranged:18:arrow:1:1.1,
12:ranged:25:arrow:1,
0:boot,
0,
0,
22:melee:23:0:0:1.2,
5:armour,
8:armour,
13:armour,
]],
split[[
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

-- what is this mess haha
pjump,pair,pdigt,pfall,pdiet,pswing,pangle,
mobs,lights,projectiles,craftable,items,
invsel,invside,craftsel,
mode,nextmusic,currentmusic,worldmusic,
swingitem,drops[79],drops[82],drops[83],tilenames
=
true,true,0,0,0,0,0,
{},{},{},{},{},
1,1,1,
1,0,-1,0,
{id=0,usetime=10},

-- oh no it got worse
78,5,5,
split[[forest grass
,dirt
,stone
,cursed forge
,wood
,jungle grass
,mud
,flamethrower
,life crystal
,corrupt grass
,
,ebonstone
,grey brick
,wooden platform
,workbench
,furnace
,torch
,anvil
,clay
,iron ore
,silver ore
,gold ore
,demonite ore
,light's bane
,sigil of blight
,nightmare pickaxe
,sapling
,gold bow
,silver bow
,iron bow
,wood bow
,gold hammer
,gold pickaxe
,gold broadsword
,gold axe
,silver hammer
,silver pickaxe
,silver broadsword
,silver axe
,iron hammer
,iron pickaxe
,iron broadsword
,iron axe
,wooden hammer
,wooden pickaxe
,wooden broadsword
,wooden axe
,shade bow
,magic mirror
,musket
,musket ball
,wood arrow
,night's edge
,lens
,demonite bar
,iron bar
,silver bar
,gold bar
,gel
,stinger
,rotten chunk
,suspicious-looking eye
,slime crown
,red brick
,cubee's dogblaster
,dirt wall
,stone wall
,campfire
,wood wall
,polished silver brick
,jungle wall
,wand of sparking
,endless musket pouch
,endless quiver
,table
,ebonstone wall
,shadow orb
,wooden door
,
,flaming arrow
,silver bullet
,
,
,blade of grass
,minishark
,mushroom
,healing potion
,suspicious strawberry
,leafy seed
,golden seed
,terra blade
,endless gel booster
,beetle husk
,beetle bow
,demonite repeater
,hermes boots
,
,soul of blight
,tentacle spike
,gold armour
,shadow armour
,jungle armour
]]

generate()

loadplayer"100,100|46:1,45:1,47:1"
spawnplayer()

for k,i in next,recipes do
 local r=split(i,"|")
 recipes[k]={split(r[1],":"),split(r[2])}
 for j,o in next,recipes[k][2] do
  recipes[k][2][j]=split(o,":")
 end
end

if stat(6)~="" then
loadplayer(stat(6))
mode=2
end

music(0)

poke(0x5f36,16)
poke(0x5f5a,255)

end

function _update60()
-- keyrepeat
poke(0x5f5c,invopen and 0 or -1)
-- mouse keys
poke(0x5f2d,mode<3 and 1 or 0x3)

msx,msy,jb,ab,rbp,pgfx,invkey,pinvkey,pdef=stat(32),stat(33),mouse and invopen and 5 or 4,mouse and invopen and 4 or 5,btnp(1),pgfx or "",btnp(6) or stat(28,8),invkey,0
local jk=btn(jb)or stat(28,44)

while stat(30) do
if(stat(31)=="コ")p=stat(4)
end

smolmap()

if mode<3 then

if stat(120) or p then
 -- world
 if mode==2 then
  for i=0,p and 32767 or serial(0x800,0x8000,32767) do
   poke(0x8000+i,(p and ord(p[i+1]) or @(0x8000+i))-32)
  end
  spawnplayer(php)

 -- player
 else
  if not p then
   p=""
   serial(0x800,0x4300,4864)
   for i=0,4864 do
    p..=chr(@(0x4300+i))
   end
  end
  loadplayer(p)
 end
 loadedfile=true
end

if(btnp(5))load"terra-cem"

if btnp(4) or loadedfile then
 mode+=1
 loadedfile,p=sfx(7)
end

if mode>2 then
 _reload()
end

-- game
else
menuitem(5,"toggle mouse",function()mouse=not mouse dset(0,mouse and 1 or 0) end)

lights,mx={},1

-- save button
menuitem(1,"save",function()
sp,sw=php..","..php_max..","..phurt..","..orbsmash..","..worldtime.."|",""

genprint"processing player..."
for k,i in next,inventory do
sp..=i.id..":"..i.amount..(k<#inventory and "," or "|")
end

genprint"processing world..."
for i=0,32767 do
sw..=chr(@(i+0x8000)+32)
end

function a(s,s2)
printh(s,"@clip")
repeat
genprint(s2,"press pause to continue")
until btn(6)
end

a(sp..pgfx.."|","player copied to clipboard")
a(sw,"world copied to clipboard")

end)

bigmap()

-- update inventory
for i in all(inventory) do

local itype,stats=i.type,split(toolstat[i.id],":") or split"0,item"
i.type=itype or stats[2] or "item"

i.tool=itype=="pick" or itype=="axe" or itype=="hammer"

i.damage,i.var,i.usetime,
i.amount,i.autoswing,
i.scale,i.melee=
stats[1],stats[4],stats[3] or 16,
i.amount or 1,stats[5]==1 or i.tool or itype=="block",
stats[6],itype=="melee" or i.tool

if(itype=="boot")mx=1.4
if(itype=="armour")pdef=max(pdef,i.damage)

del(inventory,i.amount<=0 and i)
end

if invside==1 then
invsel=loop(invsel-stat(36),#inventory)
else
craftsel=loop(craftsel-stat(36),#craftable)
end
if invopen then
if(mouse)invside=msx\64

if invside>0 then
 if(btnp(0) and #craftable>0)invside=0
 if(btnp(2))invsel-=1
 if(btnp(3))invsel+=1
 invsel=loop(invsel,#inventory)

 -- trash
 if btnp(ab) and hoveritem then
  trashslot,hoveritem=hoveritem,updaterecipes()

 -- recover
 elseif not hoveritem and btnp(ab) and trashslot then
  hoveritem,trashslot=trashslot,updaterecipes()

 -- move
 elseif btnp(jb) or invkey and not pinvkey and hoveritem then
  if not hoveritem then
   hoveritem=deli(inventory,invsel)
  else
   add(inventory,hoveritem,#inventory>0 and invsel or 1)
   hoveritem=false
  end

 end

 -- stay at bottom
 if(invsel>#inventory)invsel=#inventory

-- craft
else
 if(rbp)invside=1
 if(btnp(2))craftsel-=1
 if(btnp(3))craftsel+=1
 craftsel=loop(craftsel,#craftable)

 local it=craftable[craftsel]
 if it then
  local out,ing,avail=it[1],it[2]

  -- craft
  if btnp(jb) then
   sfx(5,-1,24)

   -- check available
   for i in all(ing) do
    for a=1,#inventory do
     if inventory[a].id==i[1] then
      avail=inventory[a].amount>=(i[2] or 1)
     end
    end
   end

   if avail then

	   -- use items
	   for i in all(ing) do
	    local amount=i[2] or 1

     for b=1,#inventory do

      -- remove found
      if inventory[b].id==i[1] then
       inventory[b].amount-=amount
      end
     end
	   end
	
	   -- search for out
	   local slot,ininv=1
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

   end

  end

  -- refresh
  if(pbtn4 and not btn(jb))updaterecipes()
  pbtn4=btn(jb)

 else
  invside=1
 end

end

pjump=true

-- gameplay
else

-- tree
tx,ty,invside,craftsel,frc,bossmusic
=rnd"320",rnd"47",1,1,pair and 0.03 or 0.08
if(mget(tx,ty)==27)tree(tx,ty+1)

worldtime+=0.4
worldtime%=24000

if pdead then
 pdiet-=1

 if pdiet<=0 and jk then
  spawnplayer(max(php_max/2,100))
 end

else

 php+=t%100\99

 local bl,br=btn(0) or stat(28,4),btn(1) or stat(28,7)

 if bl then

  if(pxv>-mx)pxv-=pxv>0 and 0.15 or 0.08
  if(canturn)pflip=true

 elseif br then

  if(pxv<mx)pxv+=pxv<0 and 0.15 or 0.08
  if(canturn)pflip=false

 else

  pxv-=sgn(pxv)*frc
  if abs(pxv)<=frc then
   pxv=0
  end
 end

 pyv+=0.08

 -- right
 local d,e=0
 repeat
  local bx,by=(px+3+d)/8,py/8+0.375
  local b,t=mget(bx,by),fget(mget(bx,py/8-0.375),0)

  -- doors
  if fget(b,5) then
   door(bx,by,b,1)

  elseif pxv>0 and (t or fget(b,0)) then
   e,pxv=true,0
   px+=d
   if(br and not t)pyv,jk=min(pyv,-1),true
  end
  d+=1
 until d>pxv or e

 -- left
 d,e=0
 repeat
  local bx,by=(px-4+d)/8,py/8+0.375
  local b,t=mget(bx,by),fget(mget(bx,py/8-0.375),0)

  -- doors
  if fget(b,5) then
   door(bx,by,b,-1)

  elseif pxv<0 and (t or fget(b,0)) then
   e,pxv=true,0
   px+=d
   if(bl and not t)pyv,jk=min(pyv,-1),true
  end
  d-=1
 until d<pxv or e

 -- down
 d,pair,e=0,true
 repeat
  local y=(py+4+d)/8
  local l,r=mget(px/8-0.375,y),mget(px/8+0.25,y)
  if pyv>0 and (fget(l,0) or fget(r,0) or (l==14 or r==14) and not (btn(3) or stat(28,22))) then
   if(not jk)pjump=false
   e,pyv,pair=true,0
   py+=d

   -- fall damage
   pfall=max(pfall/8-13)
   if pfall>0 then
    php-=pfall*10\1
    piframes=30
    sfx(0,-1,phurt,10)
   end
   pfall=0

		 if jk and not pjump then
		  pjump,pyv=true,-2.2
		 end

  end
  d+=1
 until d>pyv or e

 -- up
 d,e=0
 repeat
  local y=(py-5+d)/8
  local l,r=fget(mget(px/8-0.375,y),0),fget(mget(px/8+0.25,y),0)
  if pyv<0 and (l or r) then
   e=true
   if l and r then
    pyv=0
    py+=d
   end
   if(not r)px+=1
   if(not l)px-=1
  end
  d-=1
 until d<pyv or e

 if pjump and not jk then
  pyv=max(pyv,-0.2)
 end

 px+=pxv
 py+=pyv
 pfall+=pyv

 -- use position
 digx,digy=pflip and -7 or 7,(btn(3) and 7) or (btn(2) and -7) or 0
 if (btn(3) or btn(2)) and not (btn(0) or btn(1)) then
  digx=0
 end
 actx,acty,helditem
 =(mouse and cam_x+msx or px+digx)/8,(mouse and cam_y+msy or py+digy)/8,inventory[invsel] or {id=0,usetime=10}
 tile,canturn,a8x,a8y,hitype,hiuse,hid,hivar,digging
 =mget(actx,acty),true,actx*8,acty*8,helditem.type,helditem.usetime,helditem.id,helditem.var
 local svar=split(hivar,"-")

 -- use item
 if btn(ab) and (not helditem.tool or not mouse or dist(actx*8-px,acty*8-py)<32) then

  if pswing==0 and (btnp(ab) or helditem.autoswing) then
   pswing,swingitem=hiuse,helditem
  end

  -- terra blade
  if hid==91 then
   if(pdigt<=0)pdigt=hiuse*2sfx(3)add(projectiles,{x=px,y=py,xv=cos(pangle)*2.5,yv=sin(pangle)*2.5,damage=35,bulletsprite=97})
   pdigt-=1

  -- break tiles
  elseif helditem.tool then

   if hitype=="axe" and tile==83 or hitype=="pick" and fget(tile,1) and mget(actx,acty-1)~=83 or hitype=="hammer" and fget(tile,2)then
    digging=true
    pdigt+=hitype=="hammer" and 3 or 1
	  	if(pdigt%hiuse==1)sfx(4)

	  	if pdigt>=hiuse*3 then
	  	 pdigt=0
	   	break_tile(actx,acty,tile)
	  	end

   end

  -- place block
  elseif hitype=="block" and pdigt%7==0 then

   -- platform offset
   if not mouse and hid==14 and pxv~=0 then
    acty+=1
   end

   local lt,tile,canplace=mget(actx,acty+1),mget(actx,acty)

   -- check support
   local function c(i)
    return fget(i,0) or fget(i,2) or i==14
   end
   for i=-1,1 do
    if tile==0 and (c(mget(actx+i,acty)) or c(mget(actx,acty+i))) then
     canplace=true
    end
   end

   if(hid<82 and fget(hid,4))canplace=fget(lt,0) or lt==14

   -- place
   if canplace and hid~=tile and not fget(tile,0) and tile<83 then
    if(tile>0)break_tile(actx,acty,tile)

	   sfx(4)
	   mset(actx,acty,hid)
	   helditem.amount-=1
		 end

	 -- ranged
	 elseif hitype=="ranged" and pswing==hiuse then

   ammosprite,ammodamage=-1

   for a in all(inventory) do
    if a.type==hivar then
     ammovel,ammodamage,ammosprite=a.var/2,a.damage,a.usetime
     if(not fget(a.id,1))a.amount-=1
     break
    end
   end

   if ammodamage then
			 add(projectiles,{x=px,y=py,xv=cos(pangle)*ammovel,yv=sin(pangle)*ammovel,damage=helditem.damage+ammodamage,bulletsprite=ammosprite})
    sfx(6)

   else
    pswing=0
    sfx(9)
   end

  -- healing
  elseif hitype=="hpup" and btnp(ab) and pswing==hiuse then
   if php<php_max and not hivar or hivar and php_max<400 then
    if(hivar)php_max+=helditem.damage
    php+=helditem.damage
    helditem.amount-=1
    sfx(5,-1,0,16)
   end

	 -- summons
	 elseif hitype=="summon" and (svar[1]~="marco" or timelight>1) and btnp(ab) and currentmusic==svar[2] then
   sfx(10)
   addmob(svar[1],px+80*sgn(rnd"-1"),py-40,true)
   helditem.amount-=1

   _reload()
   if(svar[1]=="plantera")tospr("eeee92f212ffff212f29eeeeeaae8222122ff2212228eaae54991221222222221221994544e812212222222212218e44eef811212222222212118feeee1f1111122222211111f1eeeee2f12f11222211f21f2eeeeee11a81f111111f18911eeeeee9aa9a1211112199aaaeeeeeaa98aa99a99aa9aa89aaeeeee98aa99a9cc9a89aa89eeeeeee999889e8ce9ce9aaeeeeeeeee898ceec8ec8e98eeeeeeeeeeeee88e8eee8ceeeeeeeeeeeeee8cee8ceeceeeeeeeeeeeeeeee8eee8eeeeeeeeeee",24,72,112)

  -- mirror
  elseif hitype=="aight imma head out" and btnp(ab) then
   spawnplayer(php)
   sfx(11)
  end

 else
  pdigt=0
 end
 pswing,canturn=max(pswing-1),not (pswing>1 and (helditem.type=="melee" or helditem.type=="ranged"))

 -- music
 local floortile=mget(px/8,py/8+1)
 if floortile>=1 and floortile<=3 then
  worldmusic=py/8>47 and 12 or (worldtime<17500 and worldtime>4300 and 0 or 53)
 else
  local m=split",,,,,31,31,,,22,22,22"[floortile]
  if(m and m~="")worldmusic=m
 end

 local a=(hiuse-pswing)/(hiuse*2)+0.1
 wxo,wyo=
 cos(a)*(pflip and 8 or -8),
 sin(a)*8

end

-- items
for i in all(items) do
 i.yv,i.timer=min(i.yv+0.04,1.2),max(i.timer-1)
 i.xv*=0.95

 local x,y=i.x,i.y

 -- to player
 if not pdead and i.timer<=0 and abs(px-i.x)<24 and abs(py-i.y)<24 then
  i.xv+=(px-x)/50
  i.yv+=(py-y)/50
  if abs(px-x)<4 and abs(py-y)<4 then

   -- hearts
   if i.id==0 then
    php+=20

   -- others
   else
	   -- search
	   local slot,ininv=1
	   for a in all(inventory) do
	    if a.id==i.id then
	     ininv=true
	    end
	    if(not ininv)slot+=1
	   end
	   if ininv then
	    inventory[slot].amount+=i.amount
	   else
	
	    add(inventory,{id=i.id,amount=i.amount})
	
	   end

   end

   del(items,i)
  end

 -- fall
 else

  local x,y=x/8,y/8
  local gnd=mget(x,y+0.25)
  if fget(gnd,0) or gnd==14 then
   i.yv=min(i.yv)
  end
  if fget(mget(x,y-0.25),0) then
   i.yv=max(i.yv)
  end
  if fget(mget(x,y),0) then
   i.xv=0
  end
 end

 i.x+=i.xv
 i.y+=i.yv

 del(items,#items>40 and i)

end

-- projectiles
for i in all(projectiles) do
 if fget(i.bulletsprite,0) then
  i.yv+=0.01
 end
 i.x+=i.xv
 i.y+=i.yv

 del(projectiles,fget(mget(i.x/8,i.y/8),0) and i)

end

-- spawning
if t%(6+#mobs)==1 and not pdead then
 local p,ata,adi=py\8,rnd(),80+rnd"24"
 local atx,aty,sp=(px+cos(ata)*adi)\8,p+sin(ata)*adi\8,true

 for ix=-8,8 do
  for iy=-7,7 do
   if mget(atx+ix,aty+iy)==68 then
    sp=false
   end
  end
 end

 if sp and not fget(mget(atx,aty),0) then
  local sptile,forest=mget(atx,aty+1),(worldtime<4300 or worldtime>17500) and
  "zombie,zombie,twigie,twigie,baldie,baldie,femaie,femaie,eye,eye,caye,grye" or
  "gslime,gslime,gslime,bslime"

  setspawns("10,11,12","eater")
  setspawns("6,7","jslime,jspike,jspike,jbat,jbat,jbat,jbat,hornet,hornet,honeyt,honeyt,leafyt,leafyt,lacbeetle")

  if p>76 then

   setspawns("1,2,3,5","bat,bat,bat,bat,bat,bat,skeleton,skeleton,pantston,headacon,rslime,rslime,rslime,cohbeetle")
   setspawns("19,20,21,22","bat,bat,skeleton,pantston,headacon,rslime,rslime,rslime,cyabeetle")
  elseif p>47 then

   setspawns("1,2","bslime,bslime,yslime,yslime,rslime")
   setspawns("3,5,19,20,21,22","bat,bslime,bslime,yslime,yslime,rslime")
  else

   setspawns("1,2,3,5",forest)
   setspawns("6,7","jslime,jbat,jbat")
   setspawns("19,20,21,22",nil)
  end

  -- attempt spawn
  if spawns[sptile] then
   addmob(rnd(split(spawns[sptile])),atx*8+4,aty*8+4)
  end
 end
end

-- mobs
distance,pangle=120,pflip and 0.5 or 0
for i in all(mobs) do

 local hbscale,playerang,id,ai,collide,stoponwalls,enemy,vmod,friction,boss,bouncy,grav
 =1,0.25-atan2(px-i.x,py-i.y)%1,i.id,i.ai,true,true,true,1,true
 i.ispr=i.sprx

 if ai=="flying" then
  if i.rspr then
   i.sprx=1.5+t%20\10*2
  end
  i.iflip=i.xv<0
 end

do
 local _ENV=setmetatable(i,{__index=_ENV})

 if id=="eater" then
  scale=1.4

 elseif id=="eocservant" then
  collide,friction=false

 elseif id=="eoc" then
  spry,bossmusic,scale=9.5+t%20\10*7,41,1.1

 elseif id=="kingslime" then

  scale,vmod,bossmusic,boss=
  0.6+hp/2000,1.5-hp/2500,41,true

  if hp~=php then
   addmob("bslime",x,y)
  end

  php=hp

 elseif id=="marco" then
  spry,bossmusic,scale,hbscale=22+t%20\10*6,41,1.4,0.65

 elseif id=="plantera" then
  spry,bossmusic,ang,boss,collide,friction=
  22.5+t%20\10*4,41,playerang,true

  if t%(secondphase and 120 or 70)==0 then
   addmob("seed",x,y,true)
  end

  if hp<2200 then

   if not secondphase then
	   for a=0,5 do
	    addmob("tentacle",x,y,true,i)
	   end
    secondphase,palette=true,"8:9:3:4:5:9:10:8:9:10:11:12:13:14:10"
   end

   s,sprx=0.022+sin(t/70)/50,19.5

  else

   s=0.004+sin(t/100)/100
  end

  xv+=s*sgn(px-x)
  yv+=s*sgn(py-y)
  xv,yv=mid(-0.5,xv,0.5),mid(-0.5,yv,0.5)

 elseif id=="tentacle" then
  angv,tang,collide,friction=
  angv or 0,host.ang+sin(t/100+irnd)*irnd

  sprx=1.5+(t+irnd*20)%20\10*2

  if ang>tang then
   angv-=0.0007
   if(ang>0.75 and tang<0.25)angv+=0.0005
  else
   angv+=0.0007
   if(tang>0.75 and ang<0.25)angv-=0.0005
  end
  angv,d=mid(-0.006,angv,0.006),
  30+sin(t/60+irnd)*14

  ang+=angv

  x,y=host.x+cos(ang-0.25)*d,host.y-sin(ang-0.25)*d

  if host.hp<=0 then
   hp=0
  end

 end

 ang%=1

 -- base ai
 if ai=="fighter" then
  xv+=sgn(px-x)*(air and 0.005 or 0.08)*vmod
  grav,xv=true,mid(-0.5*vmod,xv,0.5*vmod)
  iflip=xv<0
  ispr+=x/8%2

 elseif ai=="slime" then
  grav,jumpt,d,v,stoponwalls
  =true,jumpt or 60,d or sgn(rnd"-1"),angry and sgn(px-x) or d

  jumpt-=0.5*vmod

  if jumpt<=0 and not air then
   jumpt,yv,xv=
   80+rnd"40",-1.2-rnd(),v*vmod
  end

  ispr+=(jumpt<30 and t%20\10 or t%40\20)*w

 elseif ai=="flying" then
  bouncy,v,ang=
  true,0.02,playerang

  ispr+=t%20\10

  xv,yv=mid(-vmod,xv+cos(0.25-playerang)*0.01*vmod,vmod),mid(-0.5*vmod,yv+sin(0.25-playerang)*0.01*vmod,0.5*vmod)

 elseif ai=="eye" then
  bouncy,xv,yv=
  true,mid(-0.8,xv+sgn(px-x)*0.01,0.8),mid(-0.5,yv+sgn(py-y)*0.01,0.5)

  ispr+=t%20\10
  ang=atan2(yv,xv)%1+0.5

 elseif ai=="projectile" then
  ang,collide,friction=atan2(yv,xv)%1+0.5

  if angry then
   xv,yv,angry=cos(0.25-playerang)*vmod,sin(0.25-playerang)*vmod
  end

  if id=="stinger" and fget(mget(x/8,y/8),0) then
   hp=0
  end

  x+=xv
  y+=yv

 elseif ai=="eoc" then
  ang,boss,collide,friction=playerang,true

  if hp<phaseswitch then
   damage,defence=23,0
   if(not secondphase)dashstate,secondphase=1,true
  end

  -- leave
  if timelight<=1 then
   yv-=0.02

  -- spin
  elseif dashstate==1 then
   angv,ang2=angv or -0.08,ang2 or ang
   angv+=0.002
   ang2+=max(angv)

   ang=ang2

   if(angv>0.2) dashstate=sfx(10) sprx=id=="marco" and 14 or 12.5

   xv*=0.97
   yv*=0.97

  -- dash
  elseif dashstate then

   if t%120==10 then
    va,v=0.25-playerang,(secondphase and 2.4 or 1.6)*vmod
    if(secondphase)sfx(10)
   end
   xv,yv=cos(va)*v,sin(va)*v
   v*=0.98

  -- above
  else

   if t%120==1 and (id=="marco" or not secondphase) then
    addmob(id.."servant",x,y,#mobs<12)
   end

   if t%30==0 and id=="marco" and secondphase then
    addmob("marcolaser",x,y,true)
    sfx(3)
   end

   xv,yv=mid(-vmod,xv+(x<px and (xv<0 and 0.1 or 0.05) or xv>0 and -0.1 or -0.05)*vmod,vmod),mid(-vmod,yv+(y<py-40 and (yv<0 and 0.1 or 0.05) or yv>0 and -0.1 or -0.05)*vmod,vmod)

  end

  -- states
  if t%360==1 and dashstate~=1 then
   dashstate=not dashstate
  end

 end

 -- ocram servants
 if id=="marcoservant" then
  ang,collide,friction=t/60
 end

 -- fall
 if grav then
  yv+=0.08
 end

end

 pxw,pxh,bossmusic=i.w*4*i.scale*hbscale,i.h*4*i.scale*hbscale,i.bossmusic

 -- collide with player
 if enemy and not pdead and piframes<=0 and abs(px-i.x)<pxw and abs(py-i.y)<pxh then
  php-=max(i.damage-pdef,1)
  piframes,pxv,pyv=30,sgn(px-i.x)*1.2,-1.2
  sfx(0,-1,phurt,10)
 end

 -- collide with blocks
 if collide then

	 -- down
	 d,i.air,e,left,right,down=0,true
	 repeat
	  local l,r=mget((i.x-pxw+1)/8,(i.y+pxh+d)/8),mget((i.x+pxw-2)/8,(i.y+pxh+d)/8)
	  if i.yv>0 and (fget(l,0) or fget(r,0) or (l==14 or r==14) and i.y>=py-8) then
	   i.y+=d
	   i.yv,e,down,i.air=bouncy and -i.yv or 0,true,true
	  end
	  d+=1
	 until d>i.yv or e

	 -- up
	 d,e=0
	 repeat
	  if i.yv<0 and (fget(mget((i.x-pxw+1)/8,(i.y-pxh-1+d)/8),0) or fget(mget((i.x+pxw-2)/8,(i.y-pxh-1+d)/8),0)) then
    i.yv,e=bouncy and -i.yv or 0,true
    i.y+=d
	  end
	  d-=1
	 until d<i.yv or e

	 -- right
	 d,e=0
	 repeat
	  if i.xv>0 and (fget(mget((i.x+pxw-1+d)/8,(i.y-pxh)/8),0) or fget(mget((i.x+pxw-1+d)/8,(i.y+pxh-1)/8),0)) then
	   i.xv,e,right=bouncy and -i.xv or 0,true,true
	   i.x+=d
	  end
	  d+=1
	 until d>i.xv or e

	 -- left
	 d,e=0
	 repeat
	  if i.xv<0 and (fget(mget((i.x-pxw+d)/8,(i.y-pxh)/8),0) or fget(mget((i.x-pxw+d)/8,(i.y+pxh-1)/8),0)) then
	   i.xv,e,left=bouncy and -i.xv or 0,true,true
	   i.x+=d
	  end
	  d-=1
	 until d<i.xv or e

 end

 -- ground/air friction
 if(friction)i.xv*=down and 0.8 or 0.99

 -- move
 i.x+=i.xv
 i.y+=i.yv

 -- zombie jump at walls and near but below player
 if ai=="fighter" and down and (left or right or i.y>py+2 and abs(px-i.x)<16) then
  i.yv=-2.2

 -- slime step over tiles
 elseif ai=="slime" and (left or right) and not down then
  i.xv+=(i.v-i.xv)/10

 end

 -- prevent plr hit projectiles
	i.iframes,hit=max(i.iframes-1)
 if ai~="projectile" then

	 --collide with plr projectiles
	 for a in all(projectiles) do
	  if i.iframes==0 and abs(a.x-i.x)<pxw and abs(a.y-i.y)<pxh then
	   i.hp-=max(a.damage-i.defence/2,1)
	   kd,hit=sgn(i.x-a.x),true
	   if(a.bulletsprite~=123)del(projectiles,a)
	  end
	 end

	 -- player hit enemies
	 local r=3*(helditem.scale or 1)
	 if helditem.melee and pswing>0 and i.iframes==0 and abs(px+wxo-i.x)<pxw+r and abs(py+wyo-i.y)<pxh+r then
   i.hp-=max(helditem.damage-i.defence/2,1)
   kd,hit=pflip and -1 or 1,true
	 end

 end

 -- hit effects
 if hit then
  i.iframes,i.angry=pswing,true
  if(i.knockback>0)i.xv,i.yv=kd*i.knockback,-i.knockback
  sfx(6)
 end

 -- line of sight
 local cansee,sight,d=true,1,dist(px-i.x,py-i.y)

 -- check if closest or boss
 if ai~="projectile" and (d<distance or boss) then

  local ba=0.25-atan2(py-i.y,px-i.x)
  repeat
   if(fget(mget((i.x-cos(ba)*sight)/8,(i.y-sin(ba)*sight)/8),0))cansee=false
   sight+=2
  until sight>d or not cansee

  if cansee then
   distance,pangle=boss and 0 or d,ba
  end
 end

 -- hornets shoot stingers
 if cansee and (i.id=="hornet" or i.id=="honeyt" or i.id=="leafyt" or i.id=="jspike") and i.t%120==0 then
  addmob("stinger",i.x,i.y,true)
  sfx(5,-1,16,8)
 end

 i.t=max(i.t+1)

 -- die
 if i.hp<=0 then
  for k,itm in next,split(i.drop,"_") do
   if itm~="" then
    it,am=unpack(split(itm,":"))
	   for a=1,am<0 and abs(am) or am-rnd(k+1)\1 do
	    additem(it,i.x,i.y)
	   end
   end
  end

  -- randomly drop health
  if(i.drop~="" and rnd"12"<1)additem(0,i.x,i.y)
  del(mobs,i)

 -- despawn
 elseif d>360 or pdead then
  del(mobs,i)
 end

end -- end mobs

piframes=max(piframes-1)

-- player die
if php<=0 and not pdead then
php,pdiet,pdead,pswing=0,60,true,0
sfx(27)
end

-- camera
cam_x,cam_y=mid(0,px-64,1920),mid(0,py-64,896)

if(mouse)pangle=0.25-atan2(py-(cam_y+msy),px-(cam_x+msx))

end--invopen

if helditem.id==17 then
add(lights,{px,py})
end

-- toggle inventory
if invkey and not pinvkey and not pdead then
poke(0x5f30,1)--suppress pause
sfx(invopen and 8 or 7)
invopen=not invopen
updaterecipes()
end

timelight,php=1,min(php,php_max)

if worldtime<2000 or worldtime>18000 then
timelight=5
elseif worldtime<3000 or worldtime>17000 then
timelight=4
elseif worldtime<4000 or worldtime>16000 then
timelight=3
elseif worldtime<5000 or worldtime>15000 then
timelight=2
end

local nextmusic=bossmusic or worldmusic
if nextmusic~=currentmusic or stat(24)==-1 then
music(-1,1000)
currentmusic=nextmusic
end
if stat(24)==-1 then
music(nextmusic,1000)
end

end

t=max(t+1)

end

function _draw()

smolmap()

respal()

cls(14)

pal(split"130,132,4,9,10,5,134,131,3,139,7,1,140,12,136",1)

local function bg(x,y)
 map(28,0,-(x%512),y,80,20)
end

if mode<3 then
 bg(t/10)
 rspr(64,20,sin(t/700)/40,116,5,8)
 cprint("a terraria demake",40)
 cprint(split"drop a player file here,drop a world file here"[mode],76)
 cprint("(or press 🅾️ to start over)",84,7,1,63)

 cprint("press ❎ for the player editor",120,7,1,63)

-- game
else

bg(cam_x/4,28-cam_y/4)

local e,selectedcraft,d,hpy=cam_y\1,0,120,12+(php_max-20)\200*8
rectfill(0,296-e,127,640,1)
rectfill(0,608-e,127,1040,12)

camera(cam_x,e)

bigmap()

-- walls
local l,r,u,f=cam_x\8-1,cam_x\8+17,cam_y\8-1,cam_y\8+18
for iy=u,f do
 for ix=l,r do

  if fget(mget(ix,iy),6) then
   local wall=false
   for ox=-1,1 do
    for oy=-1,1 do

     local wtile=mget(ix+ox,iy+oy)
     if fget(wtile,2) then
      wall=wtile
     end

    end
   end

   if(wall)spr(wall,ix*8,iy*8)

  end

 end
end

map()

for iy=u,f do
 for ix=l,r do

  -- treetops
  local tile=mget(ix,iy)
  if tile==82 and mget(ix,iy-1)~=82 then

   local y=iy
   repeat
    y+=1
   until mget(ix,y)~=82
   local s,w,o,b=142,2,4,mget(ix,y+1)
   if(b==6)s=137w=3o=8
   if(b==10)s=140

   spr(s,ix*8-o,iy*8-16,w,2)

  -- light sources
  elseif fget(tile,7) then
   add(lights,{ix*8+4,iy*8+4})
  end

 end
end

smolmap()

if(digging)spr(192+pdigt/hiuse,actx\1*8,acty\1*8)

for i in all(items) do
 sspr(i.id%16*8,i.id\16*8,8,8,i.x-2,i.y-2,4,4)
end

-- draw mobs
for i in all(mobs) do

 local sc=i.scale*4

 -- swap palette
 if(i.palette)pal(split(i.palette,":"))

 -- tentacles
 if(i.host)line(i.x,i.y,i.host.x,i.host.y,1)

 if i.rspr then
  rspr(i.x,i.y,i.ang,i.sprx,i.spry,i.w,false,i.scale)
 else
  sspr(i.ispr\1%16*8,i.ispr\16*8,i.w*8,i.h*8,i.x-i.w*sc,i.y-i.h*sc,i.w*2*sc,i.h*2*sc,i.iflip)
 end

	-- restore palette
	respal()

 -- crown
 if(i.id=="kingslime")spr(206,i.x-8,i.y-i.h*sc-5.5+(i.ispr==233 and sc/2 or 0),2,1)
end

for i in all(projectiles) do
 mset(1,1,i.bulletsprite)
 rspr(i.x,i.y,atan2(i.yv,i.xv)+0.5,1.5,1.5,1)
end

-- player
if not pdead and (piframes==0 or t%4<2) then

spr(pswing~=0 and
132+((hiuse-pswing)/hiuse*3)%3
or (pair and 130 or 128)+(pxv==0
and 0 or px/8%2),px-4,py-4,1,1,
pflip)
end

-- tool
if pswing>0 then
 mset(1,1,swingitem.id)
	local sc=(swingitem.scale or 1)
	wxo*=sc
	wyo*=sc
	if swingitem.type=="ranged" then
	 pangle%=1
	 wxo,wyo=cos(pangle)*8*sc,sin(pangle)*8*sc
	 local vf=pangle<=0.75 and pangle>0.25
	 rspr(px+wxo,py+wyo,(vf and 0.5 or 0)-pangle,1.5,1.5,1,vf,swingitem.scale)
	else
  rspr(px+wxo,py+wyo,atan2(wyo,wxo)-(pflip and 0.375 or 0.625),1.5,1.5,1,pflip,swingitem.scale)
	end

end

camera()

-- inventory
for id,i in next,inventory do
 local invy=id*13-invsel*13+64

 -- stop loop if off-screen
 if(invy>128)break

 draw_item(i.id,(invopen or id==invsel) and 116 or (116+(id-invsel)^2/2),invy,invside==1 and id==invsel and not hoveritem,i.amount)

end

-- hovering item
if(hoveritem)draw_item(hoveritem.id,102,64,true,hoveritem.amount)

-- craft
if invopen then

 -- defence
 bprint(pdef.." defence",40,hpy)

 -- trashed item slot
 pal(split"1,2,3,4,5,6,7,8,9,10,11,1,15")
 local trash=trashslot or {}
 draw_item(trash.id,116,129,false,trash.amount)

 -- recipe
 selectedcraft=craftable[craftsel]
 if selectedcraft then
  for id,i in next,selectedcraft[2] do
   draw_item(i[1],4+12*id,64,false,i[2])
  end
  selectedcraft=selectedcraft[1][1]
 end

 -- item
 for id,i in next,craftable do
  local out=craftable[id][1]

  local invy=id*13-craftsel*13+64

  -- stop loop if off-screen
  if(invy>141)break

  draw_item(out[1],2,invy,invside==0 and id==craftsel and avail,out[2])

 end

end

-- health
for i=20,php_max+19,20 do
 pal(split(i<=php+19 and "15,2,4" or "2,2,2"))
 sspr(111,87,9,9,i*0.4%80-6,i\220*8+1)
end 
bprint(flr(php).."/"..php_max,2,hpy)

-- labels
if invopen and #inventory>0 then
 cprint(invside<1 and "crafting" or "inventory",121)

 if(invside==0 or invside==1)cprint(avail and tilenames[(hoveritem and hoveritem.id) or (invside>0 and inventory[invsel] and inventory[invsel].id) or selectedcraft] or "need more materials",44,11,6,67)
end

if pdead then
 cprint("you were slain",60,11,15)
 if(pdiet<=0)cprint("jump to respawn",68,11,15)
end

-- palette
for i in all(lights) do
 d=min(dist(i[1]-px,i[2]-py),d)
end

pal(split(palettes[min(mid(1,d/8-6,5)\1,max(mid(1,py/24-12,5)\1,timelight))]),1)
pal(14,split"12,140,1,129,0"[timelight],1)

end

if(mouse)sspr(106,80,5,6,msx,msy)

end

-->8
--worldgen
function genprint(t,t2)
poke(0x5f30,1)
pal(split"130,132,4,9,10,5,134,131,3,139,7,1,140,12,136",1)
cls()
cprint(t,62)
cprint(t2 or "",110)
flip()
end
function generate()
bigmap()
function maketunnel()
for ix=-s,s do
for iy=-s,s do
local r=mget(cx+ix,cy+iy)
if(not fget(r,2))mset(cx+ix,cy+iy,cy<60 and split",66,67,,,,71,,,,66,76"[r] or 0)
end
end
end
worlddir,ry,ra,tunnel,dirttile,surfacecaves,crystals,ores
=rnd()<.5,30,0,0,2,0,0,0
genprint"sculpting the land..."
for ix=0,255 do
ra=mid(-0.22,ra+rnd()/5-0.1,0.22)
ry+=sin(ra)/4
if ry<20 or ry>37 then
 ra,ry=0,mid(20,ry,37)
end
if rnd"50"<1 and tunnel<=0 then
 tunnel=6+rnd(8)\1
end
for iy=0,127 do
 if worlddir then
  js,cs=ix<84,ix>172
 else
  js,cs=ix>172,ix<84
 end
 if iy>ry+10 then
  mset(ix,iy,js and 7 or 3)
 elseif iy>=flr(ry) then
  dirttile=cs and 11 or js and 7 or 2
  mset(ix,iy,dirttile)
 end
end
if tunnel>0 then
 for i=1,5 do
  mset(ix,ry-i,i>3 and dirttile or (cs and 66 or dirttile+64))
 end
 tunnel-=1
end
end
for i=0,30 do
a,cx,cy,s=rnd(),rnd"256",50+i/2+rnd(78-i/2),1+rnd"2"
for l=0,10+rnd"80" do
av=-0.0833+rnd"0.1667"
a+=av
cx,cy=cx+cos(a),cy+sin(a)
maketunnel()
end
end
repeat
ix,iy=20+rnd"216",0
repeat
iy+=1
dirttile=mget(ix,iy)
valid=dirtitle==2 or dirttile==7 or dirttile==11
until valid or iy>32
if valid then
r=7+rnd"4"
for y2=-r,r do
 x2=flr(sqrt(abs(y2*y2-r*r)))
 for ox=-x2,x2 do
  mset(ix+ox,iy+y2+3,dirttile)
 end
end
xo,s=sgn(rnd"-1"),1
ca,cx,cy=0.5-0.25*xo,ix+xo*r,iy
for l=0,80+rnd"40" do
ca=mid(0.25,ca-0.125+rnd"0.25",0.75)
cx+=cos(ca+0.25)
cy+=sin(ca+0.25)
maketunnel()
end
surfacecaves+=1
end
until surfacecaves>=4
genprint"digging corrupt chasms..."
repeat
x,y=rnd"256",0
repeat
y+=1
until mget(x,y)==11 or y>40
if y<=37 then
for l=2,30+rnd"20" do
s=3
x+=-1+rnd"2"
for ix=-s,s do
for iy=-s,s do
mset(x+ix,y+iy+l,((abs(ix)>=s-1 or iy>=s-1) and mget(x+ix,y+iy+l)~=76) and 12 or 76)
mset(x,y+l,77)
end
end
end
end
chasms=0
for i=0,32767 do
if mget(i%256,i\256)==77 then
chasms+=1
end
end
until chasms>=3
genprint"hiding treasure..."
for ix=0,255 do
for iy=0,127 do
if (mget(ix,iy)==2 or mget(ix,iy)==7 or mget(ix,iy)==11) and not fget(mget(ix,iy-1),0) then
mset(ix,iy,mget(ix,iy)-1)
if rnd"2"<1 then
tree(ix,iy)
end
end
end
end
repeat
ix,iy=rnd"256",60+rnd"58"
if mget(ix,iy)==0 and fget(mget(ix,iy+1),0) then
mset(ix,iy,9)
crystals+=1
end
until crystals>=20
repeat
ix,iy,set=rnd"256",ores/2+rnd"38"
for i=-3,iy/30+rnd"4" do
ix+=-1+rnd"2"
iy+=-1+rnd"2"
if fget(mget(ix,iy),0) and mget(ix,iy-1)<82 then
mset(ix,iy,19+ores/46)
set=true
end
end
if(set)ores+=1
until ores>=180
end

-->8
--functions
function addmob(id,sx,sy,override,host)
for k,i in next,stats do
s=split(i,"|")
if(s[1]==id)break
end
if s and (#mobs<8 or override) then
add(mobs,{id=id,x=sx,y=sy,xv=0,
yv=0,ispr=tonum(s[11]),scale=1,hp=s[2],
damage=s[3],defence=s[4],
w=s[13],h=s[14],ang=0,iframes=0,
drop=s[5],t=0,ai=s[6],
knockback=s[7],vmod=s[8],
angry=s[9]==1,rspr=s[10]==1,sprx=s[11],spry=s[12],
palette=s[15],phaseswitch=s[16],host=host,irnd=rnd(),
dashstate=true,v=0,va=0})
end
end

function additem(id,x,y,amount)
add(items,{id=id,amount=amount or 1,x=x,y=y,xv=-0.3333+rnd"0.6667",yv=-1,timer=60})
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

function updaterecipes()
avail,craftable=true,{}
for i in all(recipes) do
s,cancraft=i[1][3]
for ix=-3,3 do
 for iy=-2,1 do
  if not s or mget(px/8+ix,py/8+iy)==s then
   cancraft=true
  end
 end
end
for r in all(i[2]) do
 local a=r[2] or 1
 for slot in all(inventory) do
  if slot.id==r[1] then
   a-=slot.amount
  end
 end
 if(a>0)cancraft=false
end
if(cancraft)add(craftable,i)
end
end

function spawnplayer(hp)
bigmap()
php,px,py,pxv,pyv,piframes,pdead=hp or php_max,256*4,0,0,0,60
repeat
py+=8
until fget(mget(px/8,py/8),0)
py-=4
end

function bigmap()
poke(0x5f56,0x80,0)
end

function smolmap()
poke(0x5f56,0x20,128)
end

function tospr(str,w,x,y)
for i=0,#(str or "")-2 do
sset(x+i%w,y+i\w,tonum("0x"..str[i+1]))
end
end

function loadplayer(pstr)
local plr=split(pstr,"|",false)
local hp=split(plr[1])
pgfx,inventory,php,php_max,phurt,orbsmash,worldtime=plr[3] or "",{},unpack(hp)
if(type(php)=="string")run()
phurt,orbsmash,worldtime=phurt or 0,orbsmash or 0,worldtime or 6000
for i in all(split(plr[2])) do
if #i<10 then
local it,am=unpack(split(i,":"))
add(inventory,{id=it,amount=am})
end
end
end

function _reload()
reload()
tospr(pgfx,56,0,64)
end

function setspawns(tiles,mobs)
for i in all(split(tiles)) do
spawns[tonum(i)]=mobs
end
end

function tree(ix,iy)
cantree,th=true,4+rnd"5"
for y=2,th+2 do
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

function door(bx,by,b,fl)
if pxv*fl>0 and fget(b,0) then
sfx(4)
mset(bx,by,b+1)
elseif pxv*fl<0 and not fget(b,0) then
sfx(4)
mset(bx,by,b-1)
end
end

function loop(a,l)
return a<1 and l or a>l and 1 or a
end

function break_tile(actx,acty,tile)
sfx(4)
local ty=-1
if fget(tile,4) then
ty=0
else
mset(actx,acty,0)
local dropitem=drops[tile] or tile
if(tile==77)dropitem=48+orbsmash%3 orbsmash+=1mset(actx,acty,76)
if(dropitem==50)additem(51,a8x,a8y,100)
additem(dropitem,a8x,a8y)
end
while fget(mget(actx,acty+ty),4)
do
local b=mget(actx,acty+ty)
additem(drops[b] or b,a8x,a8y+ty*8)
mset(actx,acty+ty,0)
ty-=1
end
if tile==83 then
for i=0,rnd"2" do
additem(27,a8x,a8y)
end
end
end

function respal()
pal()
palt"0b0000000000000010"
end

function draw_item(id,x,y,sel,am)

 if(y<=0)return

 if sel then
  sspr(89,84,12,12,x-1,y-14)
 else
  sspr(101,86,10,10,x,y-13)
 end
 respal()
 if(id)spr(id,x+1,y-12)
 if(am and am>1)print(am,x,y-8,11)

end

-->8
--borrowed functions
function rspr(x,y,rot,mx,my,w,flip,scale)
scale=scale or 1
w*=scale*4
if(flip)rot=-rot
local cs,ss=cos(rot)*.125/scale,sin(rot)*.125/scale
local sx,sy,hx,halfw=mx+cs*-w,my+ss*-w,flip and -w or w,-w
for py=y-w,y+w do
tline(x-hx,py,x+hx,py,sx-ss*halfw,sy+cs*halfw,cs,ss)
halfw+=1
end
end

function dist(dx,dy)
local maskx,masky=dx>>31,dy>>31
local a0,b0=(dx+maskx)^^maskx,(dy+masky)^^masky
return a0>b0 and a0*0.9609+b0*0.3984 or b0*0.9609+a0*0.3984
end

__gfx__
eeeeeeeeaa9aa99a1222333266677761eeeeeeee34444442aa9aa99a11122211eeeeeeeeeeeeeeee6616611612223332016611016177617734444442eeeeeeee
effeeffe99a218992233232367767676ee7777ee4344434399a1089912212121eeeeeeeeeffeef2e1162101122332323666110006176617643444343eeeeeeee
f44ff4ff189322982223332216777661e7b66b7e444334330892119811222111eee7eeeef44ff4f21013221022233322111116106166616644433433eeeeeeee
f4ffffff222332222233323267776766e550855e322223321112211112221211e47437eff4fffff22223322222333232011006611011101132222332eeeeeeee
fffffff222333332232323327676776674088047444423441122222121212211433376e42fffff2222333332232323320166161177617761eeeeeeee32333322
efffff2e232333222332332377677676608998064434343412122211221221213eee6ee6e2fff22e23233322233233236661111076617661eeeeeeee22222222
ee2ff2ee2232323222333232666667615b9aa9b5344324431121212112221211eeeee66eee2f22ee22323232223332321611011066616661eeeeeeeee111111e
eee22eee22222221232222216111661145577554332223221111111021111111eeeeeeeeeee22eee22222221232222211111000011101110eeeeeeeee2eeee2e
eeeeeeeeeeeeeeeeeeeeeeee2334443276667667677bbb774455554411666611eeeeee61eee77eeeeeee6eeeee9a9eeeee5b5eeeeebbbeeeee777eeeee333eee
eeeeeeeeeeefeeeeeeeeeeee34444443677bb7766bb7b7b745bb5b5416776761eeeee610ee6996eeeee6160eeeaaa9eeee6e45eeee6e7beeee6e67eeee6e23ee
6666661eeeeffeeeeeeeeeee444334447bb7bb667b77bb7655b5555566766666eeee610ee690096eeeee116ee899989eee7ee54eee7eeb7eee7ee76eee7ee32e
6100011eeef44feeeeeeeeee44344433bb7bb7767bbbbb774555545516666166e6e610ee67a00a76eee61016ee8988eeee7eef2eee7ee21eee7ee32eee7ee76e
10000077ee4454ee67b77611444444437bbb7b77b7bbb7b75455445461661161e6610eee167aa761ee610e06eee11eeeee7eef2eee7ee21eee7ee32eee7ee76e
77777776eee34eee1666661e3444443277b7b7767bbb77b74554455416611661e016eeeee167761ee610eee1ea9219aeee7ee43eee7ee76eee7ee61eee7ee21e
1111111eeee33eeee11111ee3334333267677767677bbb77345555440166661161001eeeee1661ee610eeee0e983188eee6e54eeee6eb7eeee6e76eeee6e32ee
6161611eeee32eeeee7661ee343332216776667676777776434444431011111010eeeeeeeee11eee10eeeeeeeee21eeeee544eeeeeb77eeeee766eeeee322eee
eeeb5eeeeeb55eeeeeeeeeb5eeeeeeeeeeebbeeeeebbbeeeeeeeeebbeeeeeeeeeee77eeeee777eeeeeeeee77eeeeeeeeeee33eeeee333eeeeeeeee33eeeeeeee
eeb5451eeee442feeeeeeb54eeeee32eeebb7b7eeee772feeeeeebb7eeeee32eee77676eeee6676eeeeee776eeeee32eee33232eeee2232eeeeee332eeeee32e
ee542f5eeeee342eeeeeb54eeeee324eeeb72fbeeeee672eeeeebb7eeeee326eee76767eeeeec67eeeee776eeeee32ceee32323eeeee123eeeee332eeeee321e
eee34243eee32345eeeb54eeeee32f5beee67276eee3267beeebb7eeeee32f7beeec6c6ceee32c67eee776eeeee32c67eee12121eee32123eee332eeeee32123
ee323433ee321e45e5254eeeee324545ee326766ee321e7bebfb7eeeee32676bee32c6ccee321e67e7676eeeee32c6c7ee321211ee321e23e3232eeeee321213
e321e33ee321eee4e1f2eeeee321e45ee321e66ee321eee7e12feeeee321ebbee321eccee321eee6e166eeeee321e67ee321e11ee321eee2e122eeeee321e23e
321eeeee321eeeee3214eeee321eeeee321eeeee321eeeee3217eeee321eeeee321eeeee321eeeee3216eeee321eeeee321eeeee321eeeee3212eeee321eeeee
21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee21eeeeee
ee606eeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeeeeeee61eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
ee6e16eeee77776eeeeeeeeeeeeeeeeeee766eeeeeeee610eeeebeeeeeee766eeeeeb77eeeeebbbeeeeebb5eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5e54e5e
ee7ee61ee76dbd7eee77ee7eeee7eeeeee626eeeeeee610eeeebe7eeee766610eeb77761eebbbb76eebb5543eeedceeeeeee3eeeee671eeeeeff7deee54f244e
ee7ee98ee7dbdd7ee7766666ee776eeeeee3eeeeee6610eeee7eebeee6666100e7777611ebbbb766eb555433eedddceeeee2322eeee6707eef267d0eed77ddce
ee7ee98ee7bddc7e3361e21eeee6eeeeeee2eeee116e0eeeeebeebee6661100077766111bbb7766155544332eecdcceeeee321eeeee0876ef2f67c0edddddddc
ee7ee10ee7ddc76e22eeeeeeeeeeeeeeeee7eeeee0160eeeeee7b7ee1611000e6766111e7b77666e4544333eeeecceeeee32eeeeee76761eee226ceecddddccc
ee6e61eee67776eeeeeeeeeeeeeeeeeeee766eee6101eeeeeeee7eee111000ee666111ee777661ee444332eeeeeeeeeeeeeeeeeeeee161eeeeeeeeeeecccccde
ee610eeeeeeeeeeeeeeeeeeeeeeeeeeeee6e6eee10e0eeeeeeeeeeeee100eeeee611eeeee766eeeee433eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
21ff21ffee33330000000110000ccc00eeeeeeee01111110bbbbbbb7008c0110eeeeeeeee320032eeeeee5eeeeeeeeee000000000000000ceee22eeee211111e
21f221f2eee3022e000001100cc0c0c0eefeeeee10111010bbbbbbb700800110eeeee3eee300321eeeee554e32333322000000cc00666100eee32eeee222111e
21222122eee32eee0100000000ccc000eeffefee11100100bbbbbbb70108008ceeee321eee32216eeee724542222222200cc0cc006776610eee32eeee222111e
101110113e333222000000000ccc0c00eef4fffe00000000b7777b76880c08c0eee321eee766621eee77d24ee11ee11e0cc0000006776610eee32eeee222111e
ff21ff21233333ee00110000c0c0cc00ef4544fe11110011bbb7bbbb0cc1c000ee321eeee6322221edddcc3ee2eeee2e0000000006666610ee6326eee222166e
f221f2213322323e00110000cc0cc0c0e455554e11010101bbb7bbbb00110800e3212aee23333221d7dcce23e1eeee2e0000c00001666110eee32eeee222111e
22212221321e33230000001000000c00e32bb32e01100110bbb7bbbb00008c10321ee98e22332210cdcc1ee2e2eeee1e00cc000000111100eee32eeee222111e
111011103e1e23e200000000000000002123321100000000b776777b0000c00021eeeeeee122210eeccee23ee2eeee1e00000000c0000000eee22eeee211111e
eee4eeeeeeeeeeeeee3331eeee3322eeeeeeeeaaeeeeeeeeeeeeeeeeeee32eeeeeef2eeeeeeeeeeeeee54eeeeeeeeea9ee766eeeeeeeeeeeeeeeeeeeeeeeeeee
eefbfeeeeeeeeeeeee2332eeee2321eeeeee9aa9ee33eeeeeee4feeeeebbb7eeee2ff1eeeeeaeeeeee4553eeeeeeea9de7b762eeee1c1eeeeeeeefeeeeeee6ee
ee454eeeeeebeeeeee2322eeee2321eeeee9aa9eeee23eeeee4443eeeeeb7eeeeef2f2eeeea5aeeeee5454eeeeeea9dee7b7612eeef1feeeeeecce2eeee77e1e
eef4feeeeebb7eeeee2321eeee2332eeeeeaa98e33267677eeff3feeeeb667eee2ff221eee555eeee455443eee9aedeeeddcce2eef424feee2fffff2e1666661
eeefeeeeeee7eeeeee3321eeee3331eea9a998eee2226666ee2f32eeee1f21eeaff22119ea555aeea554433955dedeeee7b7621eeff2ffeeddc1221133201100
eee7eeeeeeeeeeeeee2332eeee3321eee19aeeee21e128eeeee22eeee1fff21e9a211198e9aaa9ee9a433398e45d8eeee67762eee1f2f1eecceeee2e22eeee1e
ee766eeeeeeeeeeeee2322eee332321e3219eeeeeeeeeeeeeee32eeee1f2221eeaaa998eee9a9eeeeaaa998e4545eeeee16611eeee121eeeeeeee1eeeeeee0ee
ee6e6eeeeeeeeeeeee3331ee3212332121e8eeeeeeeeeeeeeeeeeeeeee1111eeee9988eeeeeeeeeeee9988ee54e4eeeeee111eeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeea9eeeeeeeeeeeeeeee11eeeeeeeeeeeeeeeeeeeeeeeee8889898996666666c8cc88c999898888998899898c8c8c8c777777777777777777777777
ee9aa99eeee9aeeeee5b5eeeeeee017ee54ee45ee61ee16eea9ee9ae8988898999666666cc8ccc8898988888888989899cc88c8c777777777777777667777777
eee554eeeeea9eeee54eeeeeeee1106755555555f6666662aa4554aa8888989898666666cc88c889899898888889889898c8c88c777777777777776666677777
eee9a9bbeee9aeeeebeb545eee1007eee45f254ee26f262ee2a44a2e8898989989666666ccc8c899888888888989989989c8c8cc777777777777776666677777
eaaaa7b7eeea9eeee545bebee107e67ee345543eec1661cee39aa93e8888888899866666cccc8c898989888888888898988c8ccc777777777777666666667777
9aa9977eeea9a9eeeeeee45ee1e67eeeee5445eeee6116eeee3223ee8888988998966666cc8c88988988888888899888998c88cc777777777776666666667777
899988eeeeea9eeeeee5b5ee10eeeeeeee4334eeeec00ceeee2112ee8888889988996666cccc88989988888889989989898c88cc777777777666666666666677
eeeeeeeeeee9aeeeeeeeeeee0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8888899889896666ccc8c998988988888888999898988ccc777777776666666666666667
66c8c8c8c88c86c6899896866689898966666666eeeeeee6eeeeeeee76666666666666776666666c86666666eeebeeeeeeeeeeeeeeeeeeee11116666eeeeeeee
6c88c8c8c8cc8866898899666899898966666666eeeeee667eeeeeee77666666666667776666666888666666ee454eeeeeeeeeeeeeeeeeee16606760eeeeeeee
c68cc8cccc88c8c6889989868698898866666666eeee6666777eeeee77666666666677776666668c8c666666e5ebe5eeeeeeeeeeeeeeeeee60007760eeeeeeee
6ccc8cccc8c88c6c898998686888988866666666eeee66667777eeee77777666666777776666668cc8666666ee5e5eeeeeeeeeeeeeeeeeee00667770eeeeeeee
c8c88c8cc88c8c86899898968989989866666666eee66666777777ee7777776666677777666666cc88c66666efe4efeeeeeeee23eeeeeeee61111771e2ee2eee
68c88ccccc8ccc8c889888986989988866666666ee666666777777ee77777776667777776666688c8c866666eeeeeeee11111ee311111eee6666071ae32e22ee
8c88c8cc8ccc8c88988898999899898866666666ee6666667777777e7777777666777777666668cccc886666eeefeeee111111ee111111ee16660199333e32ee
c88c8ccccc8c88c8889899898998988866666666e6666666777777777777777767777777666688ccc8c86666eeeeeeee6611eee16611eee170076a9912e232ee
ee22222eeeeeeeeeee22222eee22222e772222eeeeeeeeeeeeeeeeee22eeeeeee3332112eeeee89a8ca989989a8eceeeeeeeee1e16eeeeeeeeeeee8e89eeeeee
e226c6eeee22222e7726c6667726c666776c6eeeeee22772eeeeeeeeffeeeeeeee321161eec9caaa9aaaa99aaa9a8cceee16116166161eeeee89889899898eee
ee6777eee226c6ee7767776677677766ff677eeeee22f77eeee22222122eeeee2ee21661ee999aa9aaaaaaaaaa99898ce1766677677671eee8a999aa9aa9a8ee
eeffffeeee6777eeefffff1eefffff1eeffff6eeeefff66eee2266ce2eeeeeee2eee1666c8999aaaaa9aaaa9aa999988e1667677767716eee899a9aaa9aa89ee
e77fff6e77ffff66eeffffeeeeffffeeeffff6eeeefff6eeeefff76efeeeeeee3221661088a9a9aa9a9aaaaa9aa99989ee6677767766771eee99aa9a9a99aa8e
e771116e77ffff66ee1111eeee1111eee1111eeee11ff1eeee1fff77ffeeeeee32216111c9989aa9aa9aa9a9a98a999ce166666767776670e89999a9aaaa99ac
ee1111ee331111223311112233111122111111ee1111111ee1111177ffe45eee332161118899a89aa9a9aaa98899988e1617767676677716898aa99aa99aaa89
e333222ee331122ee33ee22ee33ee22e333e222e333e222e333e222eff1aeeeee3316111c8898999999aa999989988cc0676776776766161c9a9aaa9a9aa989c
eeeeeeeeeeeeeeeeee66611eeeeeeeeeee4ee4eee4eeee4e06771112a1666777112333eecc8898a999a99a98999898890166777777766110c899aaaaaaa99888
eeeeeeeeee2222eee61c7ceeee66611eec3ee3cee23ee32e077700711616116161123eeeeec8c98989898889a88989cc1161767677666661889899a99a999998
ee2222eee233221eeec888eee61c7ceee1c11c1ee1c11c1e07707000661616616612ee2eeccc8888889888998c9c9cee117671667661161188a9989999988988
e232221ee232221eee5998c8eec888eee670076ee670076e607661701161aa66661eee2eeeec8c8c9888c888c9c8c8ce0116661776661101c889899a989988cc
23332221e222221eee5585ceee5998c8a167761ae167761e6601116666689aa61661223eeeeccecc8cccec8c8ccceeeee111161661616110ec889898889898ce
22222221e222221eee2224eeee5585ceeec66ceeaec66cea16066661118aa9a61161223eeeeeceeecc1eeec1ce1eeeeee10111101110101eeee8898c918c8cee
12222111e122111eee2244eeee22244ee916619eee1661ee910000011689a9911161233eeeeeeeeee321e111ee28eeeee0e1011210e01e0eeeece882c1eeceee
e111112ee111112eee33222ee3334222eeecceeeee9cc9ee9a60000069a9aa88116133eeeeeeeeeeee32121ee93eeeeeeee0ee2311ee0eeeeeeeee2321eeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee777eeeffeeeeeeffeeecceeee32e23ee66611112000000000000000000cceee0000000009aaeee8e
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee6677206eee77206eeeeddeeeee1771e367606611000000000000000000cbcee000000000eeeeee8e
eeeeeeeeee222eee122ee111eee122eeeeeeeeeeeeeeeeeeee54200177642001eeeddeee317f271267700061000000000000000000cbbce000000000eeeee88e
ee222eeee23321eee111221eee2232eeeeeee0e0eeeee0e0e455411166554111eeeddeee27200f7e77766006000000000000000000cbbbc000000000eeee88ee
e23321eee22221eeee1232eee221111ee332160ee332160e55421eee55421eeeeeeddeeee7f00272771111600e5555555554e00000cbcce000000000eeeeeeee
2222221ee22221eeeee111ee211ee111e211100ee211100e4554eeee4554eeeeeeeddeee2172f71317066661054444444445400000eceee000000000eeeeeeee
1222111ee12211eeeeeeeeeeeeeeeeeee45454eee54545eee3454eeee3454eeeeeeddeee3e1771eea10666110540000000054edddddddce000000000eeeeeeee
e11112eee11112eeeeeeeeeeeeeeeeee45e4e54e54e5e45eeee433eeeee433eeeeecceeeee32e23ea96700710540000000054dcccccccdce4554554eeeeeeeee
eeeeeeeeeeeeeeeeee333eeeee333eee11116660a9aee88eeee77eeeeeeeeeeeeeeeeeeeeeeeee22e33321120540000000054dc000000dc451151254eeeeeeee
eeeeeeeeeeeeeeeee71116eee71116ee16606760eeeee8eeee7707eeeee77eeeeee00eeeeeeeeeff2e3211610540000000054dc000000dc513113125eeeeeeee
eeeeeeeeeeeeeeeee67776eee67776ee00707760eeeee88eee6776eeee7707eeeeddddeeeeeee2213ee216610540000000054dc000000dc511111125eeeeeeee
eeeeeeeeeeeaaeeee42662eee26624ee71667770eeeeee88ee4466eeee6776eeee6776eeeeeeeee232ee16660540000000054dc000000dc521111225eeeeeeee
eeeaaeeeeea5a9eee44442eee44442ee61111771eeeeeeeeee7641eeee4466eeeef662eeeeeeeeef322166100540000000054dc000000dc452112254ee2ee2ee
ea55aa9eeeaaa9eee2424eeeee4242ee66660719eeeeeeeeee6641eee764416eee2f2feeeeeeeeff332161110540000000054dc000000dce4522254ee22e23ee
e9aaa99eee9a99eeee4e2eeeee2e4eee000001aaeeeeeeeeee555eeee664411eeee2feeeeee54effe32161110455555555554cdddddddccee45254eee23e333e
ee999aeeee999aeeee2eeeeeeeee2eee000069aaeeeeeeeeee3322eee335522eeeee2eeeeeeea1ffee3161110e4444444444eecccccccceeee454eeee232e211
eeeeeeeeeeeeeeeee0ee00eeeeeeeeeeeeeeeeee66666668ee8eeeee8eeeaa96ef2eff2f2222222f22fe22feeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeee0eeeeee00eeeeeeeeeeeeee5455ee66666669ee88eeee8eeeeeeee2eef22ff22ff2fffffeee2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee54eeeeeee
eeeeeeeeeeee0eee0eee0ee0e55ee55eee4224ee66666698eee8eeee88eeeeeeeeeeef22ff22f2f2ffeeeeeeeeeee62344eeee44326eeeeeeee5e3e55e3e5eee
eeee0eeeeeee0eeee0ee0e0e5e4224e55433225566666698eeeeeeeee88eeeeeeeeee22ef2ff2f2ef2eeeeeeeeee66344eeeeee44366eeeeeee5435554355eee
eee0eeeeee00e0eeee00e0ee443322544225421466666688eeeeeeeeeeeeeeeeeeeee2e2f22f2f2ef2eeeeeeeeeef62eeeeeeeeee262eeeeee554355443554ee
eeeeeeeee0e0eeeee0e0ee0022254221e224421e66666998eeeeeeeeeeeeeeeeeeeeeeef2eeeeffef2eeeeeeeee6f7eeeeeeeeeeee622eeeee5a555f2555a4ee
eeeeeeeeeee0eeee00e0eeee12244111e122111e66666988eeeeeeeeeeeeeeeeeeeeeeef2eeeeefee2eeeeeeeee6672e344ee443ef766eeeee495552254493ee
eeeeeeeeeeeeeeeeeeee00eee111112ee111112e66669988eeeeeeeeeeeeeeeeeeeeeee2eeeeee2eeeeeeeeeee6677f344eeee44377766eeee344444444333ee
eee111177766619a916667771111eeeeeeeeeeee111166660066619aeeeeeeeee3332112eeeeeee2ffe11eff2eeeeeeeeeeeeeeeeeeeeeeeecccccceeeeeeeee
eeee11616116161916161161611eeeeeeeeeeeee1660676061161619eeeeeeee2e321161eeeeeeef22000022feeeeeeeeeefeeeeeeeeeeedccccccccdeeeeeee
eeee16616616166966161661661eeeeeeeeeeeee6000776066198711eeeeeeee3ee21661eeeeee221212212122eeeeeeeee4eeeeeeeee69ddccccccdd96eeeee
eee861166aa161111161aa661168eeeeeeeeeeee006677706aaa7110eeeeeeee32ee1660eeeeeeee2f1ff1f2eeeeeeeeeee4eeeeeeee667fd999999df266eeee
ee88e666a9986669666899a666e88eeeeee2ee2361111771a99871002ee2eeee32216616eeeeeeefff1ff1fffeeeeeeeeee4eeeeeeeef7777fff777f7762eeee
e88eee1699aa811a118aa9961eee88eeee23e2336666071999aa711032e32eee33216111eeeeee2ff12ff21ff2eeeeeeeee4eeeeeee6f7777777777777622eee
e8eeeee19aaa8616168aaa91eeeee8eee233e33e166601aa9aa9671133e332eee3216111eee5eefff1ffff1fffee5eeeeeefeeeeeee667777777777777766eee
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
00000199eeeeeeee1769aa91116123ee99a96711e1111111eeecccdddcccccccccdddeeeeecccdddcccccccccccdddee62662666eeeeeeee22eeefeeee2eeeee
00006a99eeeeeeee76a9aa8811613eee8aa9a677eee11661eeeeeccccccccccddddeeeeeeeeeccccccccccccddddeeee26662262eeeeeeee2eeee2eeeeeeeeee
__label__
ssssssssssssssssssssss5555555mmsssssssssssssssssssssssssssssssssssssssssssssss5mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmssssss111
1s9aa9aa9s9aa9aa9s9aa9aa959aa9aa9s9aa9aa9s9aa9aa9s9aa9aa9s9aa9aa9s9aa9aa9ssss55mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssss1gg
39aooaoka9aooaoka9aooaoka9aooaoka9aooaoka9aooaoka9aooaoka9aooaoka9aooaoka9s5555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsss1go
1ao9oo9okao9oo9okao9oo9okao9oo9okao9oo9okao9oo9okao9oo9okao9oo9okao9oo9okas5555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmss1ok
jaooooookaooooookaooooookaooooookaooooookaooooookaooooookaooooookaooooooka55555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777o
jakooookkakooookkakooookkakooookkakooookkakooookkakooookkakooookkakooookka55555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm717k
j9akookka9akookka9akookka9akookka9akookka9akookka9akookka9akookka9akookka955555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm777g
1s9akkka9s9akkka959akkka9m9akkka9m9akkka9s9akkka9s9akkka9s9akkka9s9akkka9555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm1s7s
sss9aka9sss9aka95559aka9mmm9aka9mmm9aka9sss9aka9sss9aka9sss9aka9sss9aka95555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm171
ssss9a9sssss9a9555559a9mmmmm9a9mmmmm9a9sssss9a9sssss9a9sssss9a9sssss9a9555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
sssssssssss55555555mmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssssssssssss55555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
s55555555555555555555555555555mmmmmmmmmssssssssssssssssssssssssssssssss55555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
s57755777577755575775577757775mmmmmmmmmssssssssssssssssssssssssssssssss555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmsssssss
s55755757575755755575575757575mmmmmmmmmssssssssssssssssssssssssssssssss555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmms113r311
ss575577757575575m575577757575mmmmmmmmmssssssssssssssssssssssssssssssss55555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmms1grrr3g
s55755757575755755575575757575mmmmmmmmmssssssssssssssssssssssssssssssss555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmms1j333j3
557775777577757555777577757775mmmmmmmmmsssssssssssssssssssssssssssssss5555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmms1gj3jjg
555555555555555515555555555555mmmmmmmmmmsssssssssssssssssssssssssssss555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmm77gg777g
5j3jrr33rr33rrrj3mmmmmmmmmmmmmmmmmmmmmmmmmsssssssssssssssssssssssss5555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmms7r3ki7r
513r3rrr3r3rr3j31mmmmmmmmmmmmmmmmmmmmmmmmmmssssssssssssssssssssssss5555555555555555555555555555555mmmmmmmmmmmmmmmmmmmmmms73j777j
51j33rrrrrrr33jjjmmmmmmmmmmmmmmmmmmmmmmmmmmmm5imm5imm5imm5imm5imm5imm555555555555555555555555555555mmmmmmmmmmmmjmj3mmmmm17ss7iss
5jj3j33r33r33333jmmmmmmmmmmmmmmmmmmmmmmmmmmmm5im55im55im55im55im55im5555555555555555555555555555555mmmmmmmmj3jj3j33j3jmm77717771
5jjr33j33333jj3jjmmmmmmmmmmmmmmmmmmmmmmmmmmmm5i555i555i555i555i555i5555555555555555555555555555555555mmmmmjr333rr3rr3rjmmmmmmmmm
51jj3j33r3j33jj11mmmmmmmmmmmmmmmmmmmmmmmmmmmmigiiigiiigiiigiiigiiigii555555555555555555555555555555555mmmmj33r3rrr3rrj3mmmmmmmm5
551jj3j3jjj3j3j1mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5imm5imm5imm5imm5imm5i5555555555555555555555555555555555555533rr3r3r33rrj55555555
5555jj3j13ij1j15mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55im55im55im55im55im55i5555555555555555555555555555555555555j3333r3rrrr33sssssss15
555515jjk1i5515555mmmmmmmmmmmmmmmmmmmmmmmmmmm555i555i555i555i555i555i555555555555555555555555555555555555j3jrr33rr33rrs5imm5imm1
5555555k4ki5555555mmmmmmmmmmmmmmmmmmmmmmmmmmmiiigiiigiiigiiigiiigiiig55555555555555555555555555555555555513r3rrr3r3rr3s5im55im51
5555555444i55555555mmmmmmmmmmmmmmmmmm5imm5immgggggggggggggggggggggggg5imm5imm55555555555555555555555555551j33rrrrrrr33s5i555i551
5555555k44k55555555mmmmmmmmmmmmmmmmmm5im55im5gggggg11gggggg11gggggg115im55im55555555555555555555555555555jj3j33r33r333sigiiigii1
5555555k4kk5555555555mmmmmmmmmmmmmmmm5i555i55gg11g11ggg11g11ggg11g11g5i555i555555555555555555555555555555jjr33j33333jj7775imm5i1
5555555k4ki55555555555mmmmmmmmmmmmmmmigiiigiig11gggggg11gggggg11gggggigiiigii55555555555555555555555555551jj3j33r3j33jsm75im55i1
555555544ki55555555555555555555555555mm5imm5iggggggggggggggggggggggggmm5imm5i5555555555555555555555555j3551jj3j3jjj3j37775i555i1
5555555k44k55555555555555555555555555m55im55igggg1ggggggg1ggggggg1gggm55im55i5555555555555555555555555333555jj3j13ij1j7iiigiiig1
5555555k4kk55555555555555555555555555555i555igg11gggggg11gggggg11gggg555i555i5555555555555555555555553j3j55515jjk1i5517771111115
5555555444i55555555555555555555555555iiigiiigggggggggggggggggggggggggiiigiiig5555555555555555555555553jj3555555k4ki5555555555555
5555555444i5555555555555555555imm5immgggggggggggggggggggggggggggggggggggggggg5imm5imm5555555555555555jj33j55555444i5555555555555
5555555k44k5555555555555555555im55im5gggggg11gggggg114k4444kkgggggg11gggggg115im55im555555555555555533j3j355555k44k5555555555555
5555555k4kk5555555555555555555i555i55gg11g11ggg11g11gkkkkkkkkgg11g11ggg11g11g5i555i555555555555555553jjjj335555k4kk55sssssss1555
5555555k4ki555555555555555555igiiigiig11gggggg11ggggggiiggiigg11gggggg11gggggigiiigii5555555555555533jjj3j35555k4ki5s7777777m155
555555j44ki555555555551j55555mm5imm5igggggggggggggggggkggggkgggggggggggggggggmm5imm5i555555555555j3j3j3j33j35j544ki5s7777777m155
5555553k44k55555555555jjj5555m55im55igggg1ggggggg1ggggigg1gkggggg1ggggggg1gggm55im55i55555555555j33j3j3j3jj3355k44k5s7777777m155
555553jk4kk5555555555j1j15555555i555igg11gggggg11gggggk11ggiggg11gggggg11gggg555i555i5555555555j53jj3jjjj33j3j5k4kk5s7mmmm7m5155
555553j444i5555555555j11j5555iiigiiiggggggggggggggggggkggggigggggggggggggggggiiigiiig55555555555jjj3jjjj3j33j5j444i5s777m7777155
55555jj444i55555555555imm5imm5imm5imm5imm5imm4999999k4999999k4999999k5imm5imm5imm5imm5imm5imm55j3j33j3jj33j3j35444i5s777m7777155
555533jk44k555555555j5im55im55im55im55im55im59499949494999494949994945im55im55im55im55im55im55553j33jjjjj3jjj3jk44k5s777m7777155
55553jjk4kk555555555j5i555i555i555i555i555i559994494499944944999449445i555i555i555i555i555i55553j33j3jj3jjj3j33k4kk517mm5mmm7155
55533jjk4ki55555555jjigiiigiiigiiigiiigiiigii4kkkk44k4kkkk44k4kkkk44kigiiigiiigiiigiiigiiigii55j33j3jjjjj3j33j3k4kijj11111111555
5j3j3j344ki35j5551j1jmm5imm5imm5imm5imm5imm5iggggggggggiiggggggggggggmm5imm5imm5imm5imm5imm5i5555j3j3j3j33j35j544ki1j1j1jj1j5155
j33j3j3k44k335551jj1jm55im55im55im55im55im55igggg1gggggiigggggggg1gggm55im55im55im55im55im55i555j33j3j3j3jj3355k44k1j1j1j11jj555
53jj3jjk4kkj3j515j11j555i555i555i555i555i555igg11ggggggggggiggg11gggg555i555i555i555i555i555i55j53jj3jjjj33j3j5k4kk1aaaaaaaaa95j
jjj3jjj444i3j5j5111j1iiigiiigiiigiiigiiigiiigggggggggggggggggggggggggiiigiiigiiigiiigiiigiiig555jjj3jjjj3j33j5j444ia999999999a95
3j33j3j444i3j351j1jj1j11jj1j14999999kgggggggggggggiiggggggggggggggiiggggggggg4999999k11jj155555j3j33j3jj33j3j35444ia9gggggiiga9j
3j33jjjk44kjj3j5j1jj11111j11194999494gggggg11gggggiiggggggg11gggggiiggggggg1194999494j1j1j5555553j33jjjjj3jjj3jk44ka9gggggiiga95
j33j3jjk4kk3j33j1jj1j11j111j199944944gg11g11ggigggggggg11g11ggigggggggg11g11g999449441111jj55553j33j3jj3jjj3j33k4kka9gigggggga93
33j3jjjk4ki33j31jj1j11111j1jj4kkkk44kg11gggggggggggggg11gggggggggggggg11ggggg4kkkk44k111j1j5555j33j3jjjjj3j33j3k4kia9gggggggga9j
5j3j3j344ki35j5551j1j1j1jj1j59999k499ggggggggggiiggggggggggggggiigggggggggggg9999k4991j1jj1j51555j3j3j3j33j35j544kia77gi777gga95
j33j3j3k44k335551jj1j1j1j11jj99494949gggg1gggggiigggggggg1gggggiigggggggg1ggg994949491j1j11jj555j33j3j3j3jj3355k44ka97gi7gggga95
53jj3jjk4kkj3j515j11j1111jj1j4994k994gg11ggggggggggiggg11ggggggggggiggg11gggg4994k9941111jj1j15j53jj3jjjj33j3j5k4kka97gg777iga9j
jjj3jjj444i3j5j5111j1111j1jj144kkk4kkgggggggggggggggggggggggggggggggggggggggg44kkk4kk111j1jj1515jjj3jjjj3j33j5j444ia97gggg7gga95
3j33j3j44kk3j351j1jj1j11jj1j1gggkkggggggggiiggggggggggggggiigg9999iiggggggggggggkkgggj11jj1j1j5j3j33j3jj33j3j3544kk9777a777aaa9j
3j33jjjk4kijj3j5j1jj11111j111ggg4kg11gggogiiggggggg11gggggiig951499iggggogg11ggg4kg111111j111j153j33jjjjj3jjj3jk4kij999999999915
j33j3jjk4ki3j33j1jj1j11j111j1gg14k11ggigooggggg11g11g555555ig9mmm44gggg1oo11ggg14k11g11j111j1jj3j33j3jj3jjj3j33k4ki1j11j111j1jj3
33j3jjjk44k33j31jj1j11111j1jjg114kgggggo99oggg11ggggg5igggiigg9ss1gggg1o99oggg114kggg1111j1jj1jj33j3jjjjj3j33j3k44kj11111j1jj1jj
5j3j3j3444i35j5551j1j1j1j11jjgg54k5gggg99a9gg4k4444kkigggggmm5sssmmgggg99a9gggg54k5gg1jrr11jj1333j3jjjj33jj33j3444ij1j11jj1j5155
j33j3j344ki335551jj1j1j11j111ggg4kgggggi49gggkkkkkkkkmmmmmmm55111mmggggg49gggggg4kgggraarr311jj3j3jjjjjjjj3j3j344kij1j11j11jj555
53jj3j44k4ki3j515j11j1111jj1jgg14kgggggg44giggiiiiiigiiiiiiigg55mmgiggg144ggggg14kggg3rrr331jj3j33j3jjjjjj3jj344k4kijj111jj1j15j
jjj3j4kik44ki5j5111j111111j1jgggkkgggggg4kggggkggggkg5i5i5iigiiikkkggggg4kggggggkkggg1333rj1j33jjjjjjjjj3j33j4kik44ki111j1jj1515
rr33rrr3rr33rrr3rr33rrr3rr33r4999999k4999999k4999999k4999999k4999999k4999999k4999999krr3rr33rrr3rr33rrr3rr33rrr3rr33r111jj1j1j5j
kij3333rkij3333rkij3333rkij339499949494999494949994949499949494999494949994949499949433rkij3333rkij3333rkij3333rkij331111j111j15
4kk3jij34kk3jij34kk3jij34kk3j99944944999449449994494499944944999449449994494499944944ij34kk3jij34kk3jij34kk3jij34kk3j11j111j1jj3
44kkkkkk44kkkkkk44kkkkkk44kkk4kkkk44k4kkkk44k4kkkk44k4kkkk44k4kkkk44k4kkkk44k4kkkk44kkkk44kkkkkk44kkkkkk44kkkkkk44kkk1111j1jj1jj
4444kkk44444kkk44444kkk44444k9999k4999999k4999999k4999999k4999999k4999999k4999999k499kk44444kkk44444kkk44444kkk44444kj11j11jj133
444kkk4k444kkk4k444kkk4k444kk99494949994949499949494999494949994949499949494999494949k4k444kkk4k444kkk4k444kkk4k444kkj111j111jj3
k4k4kkk4k4k4kkk4k4k4kkk4k4k4k4994k9944994k9944994k9944994k9944994k9944994k9944994k994kk4k4k4kkk4k4k4kkk4k4k4kkk4k4k4kj111jj1jj3j
kkkkikkkkkkkikkkkkkkikkkkkkki44kkk4kk44kkk4kk44kkk4kk44kkk4kk44kkk4kk44kkk4kk44kkk4kkkkkkkkkikkkkkkkikkkkkkkikkkkkkki11111j1j33j
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kk449994kk449994kk449994kikkk444kikkk444kikkk444kikkk444krr3rr33rrr3
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4499999944999999449999994kk44k4k4kk44k4k4kk44k4k4kk44k4k433rkij3333r
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kk999449999994499999944999kkk444kkkkk444kkkkk444kkkkk444kkij34kk3jij3
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k994999449949994499499944kk444k4kkk444k4kkk444k4kkk444k4kkkk44kkkkkk
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44k999999949999999499999994k4k4k44kk4k4k44kk4k4k44kk4k4k44kkk44444kkk4
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k44999994k4999994k4999994kk44k44k4k44k44k4k44k44k4k44k44k4k4k444kkk4k
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k4449444k4449444k4449444kkk444k4kkk444k4kkk444k4kkk444k4kkk4k4k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkki49444kki49444kki49444kkik4kkkkkik4kkkkkik4kkkkkik4kkkkkikkkkkkkikkk
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kk449994kk449994kikkk444kikkk444kikkk444kikkk444kikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k44999999449999994kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kk9994499999944999kkk444kkkkk444kkkkk444kkkkk444kkkkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k9949994499499944kk444k4kkk444k4kkk444k4kkk444k4kkk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44k9999999499999994k4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k44999994k4999994kk44k44k4k44k44k4k44k44k4k44k44k4k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4k4449444k4449444kkk444k4kkk444k4kkk444k4kkk444k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkki49444kki49444kkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4k
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4k
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4k
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4k
k444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kikk
4k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk4
444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k4k44kk4k
k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44k44k4k44
44k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk4
kkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4kkkkkik4k
9994kikkk444kikkk444kikkk444kikkk444kikkk444kikkk444kgggggiiggggggiiggggggiiggggggiiggggggiiggggggiiggggggiigikkk444kikkk444kikk
99994kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4kk44k4k4gggggiiggggggiiggggggiiggggggiiggggggiiggggggiiggggggiigkk44k4k4kk44k4k4kk4
44999kkk444kkkkk444kkkkk444kkkkk444kkkkk444kkkkk444kkgigggggggigggggggigggggggigggggggigggggggigggggggiggggggkkk444kkkkk444kkkkk
99944kk444k4kkk444k4kkk444k4kkk444k4kkk444k4kkk444k4kggggggggggggggggggggggggggggggggggggggggggggggggggggggggkk444k4kkk444k4kkk4

__gff__
00030303520303030012030303034a5252d25203030303030400041200000000040404040404040404040404040404040000000001040000000000000000000003000404c20403040002035204047372010010100000000000000000020000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
__map__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000075786d6d6d760000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
002e0000000000000000000000000000000000000000000000000000756f6d760000000000000075786d760000000000000000000000000000000000000000000000000000000000000000000075746f6d6d6d6d6d76000000000000756f6d760000000000000075786d76000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000074746f6d6d760000007574786d6d6d760000000000000000000000000000000000000000000000000000000000000075747474746f6d6d6d6d6d6d6d7600007574746f6d6d760000007574786d6d6d760000000000000000000000000000000000000000
00dc0000000000000000000000000000000000000000000000000000747474746f6d6d767574746f6d6d6d6d6d760000000000000000000000000075787600000000756d6d6d6d6d7675786d777474747474746f6d6d6d6d6d6e7474747474746f6d6d767574746f6d6d6d6d6d00000008090a0b0c0d0e0f0000000000000000
0000000000000000000000000000000000000000000000000000000074747474746f6d6e747474746f6d6d6d6d6d76000000000000000000000075786d6d00000000746f6d6d6d6d6d6d6d6d6e74747474747474747474747474747474747474746f6d6e747474746f6d6d6d6d00000018191a1b1c1d1e1f0000000000000000
0034000000000000000000000000000000000000000000000000000074747474747474747474747474746f6d6d6d6d76000000000000000075746f6d6d6d760000757474746f6d6d6d6e74747474747474747474747474747474747474747474747474747474747474746f6d6d00000028292a2b2c2d2e2f0000000000000000
00000000000000000000000000000000000000000000000000000000747474747474747474747474747474746f6d6d6e746f6d6d760075747474746f6d6d6d767574747474747474747474747474747474c568747474747474c56874747474747474747474747474747474746f00000038393a3b3c3d3e3f0000000000000000
001100000000000000000000000000000000e100000000000000000074c568747474747474c5687474c56874747474797ac5686f6d6d77747474747474c568747474747474c568747474747474c56874747372797ac568747473727474c568747474747474c5687474c568747400000000000000000000000000000000000000
000000000000dddedf0000cbcccd000000ddf1df00000000000000007a7372797ac568797a7372797a7372797ac56870717372797a74747474c568797a7372797ac56874747372797ac56874747372797a737270717372797a7372797a7372797ac568797a7372797a7372797a00000000000000000000000000000000000000
000000000000edeeef0000edfcef000000edeeef000000000000000071737270717372707173727071737270717372707173727071c568797a73727071737270717372797a737270717372797a737270717372707173727071737270717372707173727071737270717372707100000000000000000000000000000000000000
00b200b30000fdfeff0000fdfeff000000fdfeff000000000000000071737270717372707173727071737270717372707173727071737270717372707173727071737270717372707173727071737270696a6b6c71737270696a6b6c717372707173727071737270717372707100000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000696a6b6c71737270696a6b6c696a6b6c71737270696a6b6c7173727071737270696a6b6c71737270696a6b6c71737270696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c71737270696a6b6c696a6b6c7100000000000000000000000000000000000000
00940095000000000000000000000000000000000000000000000000696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c71737270696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c6900000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a6b6c696a676c696a6b6c696a676c696a6b6c696a6b6c696a6b6c696a6b6c6900000000000000000000000000000000000000
00b800b80000000000000000000000000000e1000000000000000000696a676c696a6b6c696a676c696a676c696a6b6c696a676c696a6b6c696a6b6c696a676c696a6b6c696a676c696a6b6c696a676c696a676c696a676c696a676c696a676c696a6b6c696a676c696a676c6900000000000000000000000000000000000000
000000000000dddedf0000cbcccd000000ddf1df0000000000000000696a676c696a676c696a676c696a676c696a676c696a676c696a6b6c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c6900000000000000000000000000000000000000
00a900a90000edeeef0000edfcef000000edeeef0000000000000000696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c6900000000000000000000000000000000000000
000000000000c8c9ca0000c8c9ca000000c8c9ca0000000000000000696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c6900000000000000000000000000000000000000
00590059000000000000000000000000000000000000000000000000696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c6900000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c696a676c6900000000000000000000000000000000000000
00a800a80000d4e07cd70000d4e07cd700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000bad5aaf30000d8b4e4f30000cbcccd00d9dadb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00fc00da0000d0d1d2d30000ecd6f2d30000e9fceb00e9eaeb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000c6c7afe30000c6c7afe30000f9fafb00f9fafb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0033003300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000cbcccd00b9da8700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
006200620000bff57d7f0000bff57d7f0000e9fceb00e9eaeb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000887ee598000088f096980000f9fafb00f9fafb00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000d0e197d30000ecf4e2d300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000c6f1b5e30000c6f1b5e300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000118000e0601107012070120701207011060100500f0400c02000000000000000017560195701a5701a57019570175601554013520000000000000000000000d7600f7700f7700e7600c7600b7500974004730
59800000105540e554005000050000500005000050010551105540e5540050000500005000050000500105510e5551055400500005000050000500005000e5510e5541055400500005000050000500005000e551
1920002000005000050000500005000050c0000e0001000011055000051005510055000050c0550e055100550000500005000050000500005100000e0000c00010035000050c0350c03500000100350e0350c035
000200001c1551d1551f15521145201351515517155161450f155101551215514155171451613511155101450e1450e1450e1450d1350c1350b1250b1250a1150a11500105001050010500105001050010500105
010402000707300003000030000300003000030000000003070730000015100085520a5430000300003000030a552085430000300003000000000308142071330000000000000000000000000000000000000000
330400001c7221c7421c7521c7621c7621c7621c7521c7521c7421c7421c7321c7321c7221c7221c7121c71217650176551c7020e000000001c7000e000000001007300002000000000000000000000000000000
000100001567015660146501363012620116100060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
4803000010070170501a0301d02000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
480300001c07019050150301202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
111000001b075260050000500005000050000500005000051b000000001f600000001f60007600000050000500005000050000500005000050000500005000050000500005000050000500005000050000000000
650400000c1600d1700e1700f1700e1700d1700c1700d1700c1700d1700e1700e1600d1500c1400b1300a12009110121001310013100131001310000100001001400007600001001300007600001001300007600
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
0115000017500195001a5001a50019500175001550013500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
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
00 00424304
00 00424304
00 00424304
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

