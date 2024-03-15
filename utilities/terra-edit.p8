pico-8 cartridge // http://www.pico-8.com
version 39
__lua__
--terra-edit
--by cubee 🐱

--[[ todo

improvements
- preserve toolbar palette (2nd palette)

options
- show campfire range
- follow tile placement rules
- brush smoothing
- categories selection

bugs
-- clear copy on changing tools
- fix copy overlay moving when mouse is over toolbar

]]

cartdata"cubee_terra_editor"
function _init()
for i=-32768,0x55ff do
poke(i)
end
poke(0x5f2e,1)

walls=split"66,66,67,,69,71,71,,,66,66,76,,,,,,,66,66,67,67,67"
tilecols=split"3,3,7,6,3,2,2,,15,3,3,1,6,3,5,1,5,6,3,7,7,5,6,,,,9,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,2,,0,12,15,0,11,8,,,,2,12,7,3,2,,,3,3"
around=split"-1,0,1,0,0,-1,0,1,-1,-1,1,-1,-1,1,1,1"

--editor
--menu=split"load a world,new world,empty world,superflat,redux,randomised,amplified"
menu=split"load a world,new world,empty world,superflat,randomised,amplified"
menu_sel=1

scrollspeed=4

brush_size=1
paint_size=0
tree_size=0
tunnel_size=1
corrupt_tunnel_size=2
blend_size=2
grass_size=1

pan_x,pan_y=0,0

invalid_tiles={title="invalid \ff(may break on save!!)",desc="these are beyond the range normally supported for saves. use at own risk!",tiles={}}

tile_menu=false
tile_menu_y=0
tile_max_scroll=0

build_categories()

tile_categories=tc_types

-- build invalid tile list
for i=0,255 do
 local in_list=false

 for c in all(tile_categories) do

  for t in all(c.tiles) do
   if t==i then
    in_list=true
   end
  end
  
 end

 if not in_list then
  add(invalid_tiles.tiles,i)
 end

end

buttons={
 {
  name="tile palette",
  glyph="⁶:0000007e3c180000",
  func=function(i)
   tile_menu=not tile_menu
  end
 },
 {
  name="cursor",
  glyph="⁶:00040c1c3c0c1000",
  editmode="cursor"
 },
 {
  name="tiler",
  glyph="⁶:002070381c0a0600",
  editmode="paint"
 },
 {
  name="eraser",
  glyph="⁶:001c24243c3c3c00",
  editmode="eraser"
 },
 {
  name="move/copy/delete",
  glyph="⁶:0078405e52121e00",
  editmode="copy"
 },
 {
  name="tunnel carver",
  glyph="⁶:004e4e4642627200",
  editmode="tunnels"
 },
 {
  name="tree grower",
  glyph="⁶:003c7e7e3c183c00",
  editmode="trees"
 },
 {
  name="grass grower",
  glyph="⁶:007e7e3442427e00",
  editmode="grass"
 },
 {
  name="orb chasm carver",
  glyph="⁶:006246424a627e00",
  editmode="corrupt tunnels"
 },
 {
  name="tile shuffler",
  glyph="⁶:006e6a0e70567600",
  editmode="blend"
 },
 {
  name="tile blender",
  glyph="⁶:0054244a162e2e00",
  editmode="blend2"
 },
 {},
 {},
 {
  name_="options",
  glyph="⁶:003050781c0a0600",
  func=function()
   options_menu=not options_menu
  end
 },
 {
  name="pause menu",
  glyph="⁶:003050781c0a0600",
  func=function()

   -- pauses after next flip
   extcmd"pause"

   cls(12)
   cprint("pause menu",10)
 	 cprint("(⬆️/⬇️ to navigate)",114,11,6,63-2)

   flip()

  end
 }
 --[[
,
 {
  name="",
  glyph="",
  editmode=""
 }
 ]]

}

editmode="cursor"
currenttile=1
edit_x,edit_y=0,0

worldtime=8000

-- editor toggles
mute=dget(1)==1 or true
lighting=false
treetops=true
autowalls=true
parallax=true
copy_place_empty=false


-- normal
_reload()tospr("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9eeeeee8aeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeeeeeeae9eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88eae88eee9a8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee88aa988a9a9a9aa9aeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8a9aaaaaaaaa9aaaaaaaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9a229aa929929929a98eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8aa233294444443339aaeeeeeeee89eeeeeeeeeeeae9eeeeeeeeeeeaaeeeeeeeea944343444433342aa988eeeeeeeaee9e9eeeeee9aeeeeeeeeeeee9e9eeeeee8a9333343333333339aaaeea8eeee9e8e9eeeeeee898ee8eeeeaeee8eaeeeeee8a233333343332232aaa889e8ee8a99a8a898e88a89aea988ee89e88899eeeeeea92929243329aa99aaaa9a9988ea9a9aaaa999a9a9aaaaa8e8eae89a9a9aeeee8aaa9a934439aaaaaaaaaaa9aa9a9aa999aaaaaaaaa999aaa9888a999aa88eeee9aaaa243639aaaa996119aaaaa92222439aaaa929226b9aaaa9a934229a9eeeeeaaaa23762aaaa91777b79aaa9343344432aa9343344771aaaa93444429a8eeee8aa9336139aa96b7617769aa93443233439a93443333679aaa23223432a9eeeeaaaa267139aa97769a9661aa23432992342a24332923161aa933aa9342a98eee8aa936732aa96b19aaa1329a93349aa9333993439aa93169aa22aaa243999eeee9aa371339aa1771111743aa93439aa9239a94339aa9239aaaaaaa9233998eee8a9a2673399ab16b671622aa93349aaaaaaa93439aaaaaaaa999992333998eeee9a936b32aa9776199a99aaaa2332aaaaaaa93332aaaaaaaa233334332a9eeeee8aa21732aa93449aaaaaaaa93432aaaaaaa933329aaaaaa93333333339a9eeee9a933139aaa93329a99329aa2339aaaaaaaa2339aaa9aa92339aa9332a98eeee892333329aaa2433223329a933329aa9aaa933329a9aaaa2333223333a9eeeee8a933339aaaa93333332aaa93339aaaaaaa93339aaa9aaa992233333399eeeee99233339a9a9a923232aaaa93229a9999a993229a9a99a99aaa922333999eeee8a29929a98889aa9a9aa99aa99a998e8e98a99aa9898998e989aa9992a98eeeee899aa998eeee99aaaa88e899899eeeeeee99898eeeeeeeeee889a9aaa98eeeeee8998eeeeeeeee8e8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee899a98eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",64,64,0)
t,cam_x,cam_y,actx,acty,bosshp,
env,spawns,bgs,
palettes,
drops=
0,0,0,0,0,0,
{__index=_ENV},{},split"0,0,16,16,16",
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
pjump,pair,pdigt,pfall,pdiet,pswing,pangle,
mobs,lights,projectiles,craftable,items,parts,
invsel,invside,craftsel,
mode,nextmusic,currentmusic,worldmusic,
swingitem,drops[79],drops[82],drops[83],tilenames
=
true,true,0,0,0,0,0,
{},{},{},{},{},{},
1,1,1,
1,0,-1,0,
{id=0,usetime=10},78,5,5,
split([[forest grass
dirt
stone
cursed forge
wood
jungle grass
mud
flamethrower
life crystal
corrupt grass
corrupt dirt
ebonstone
grey brick
wooden platform
workbench
furnace
torch
anvil
clay
iron ore
silver ore
gold ore
demonite ore
light's bane
sigil of blight
nightmare pickaxe
sapling
gold bow
silver bow
iron bow
wood bow
gold hammer
gold pickaxe
gold broadsword
gold axe
silver hammer
silver pickaxe
silver broadsword
silver axe
iron hammer
iron pickaxe
iron broadsword
iron axe
wooden hammer
wooden pickaxe
wooden broadsword
wooden axe
shade bow
magic mirror
musket
musket ball
wood arrow
night's edge
lens
demonite bar
iron bar
silver bar
gold bar
gel
stinger
rotten chunk
suspicious-looking eye
slime crown
red brick
cubee's dogblaster
dirt wall
stone wall
campfire
wood wall
polished silver brick
jungle wall
wand of sparking
endless musket pouch
endless quiver
table
ebonstone wall
shadow orb
wooden door
doorpick
flaming arrow
silver bullet
tree trunk
tree base
blade of grass
minishark
mushroom
healing potion
suspicious bulb
leafy seed
shimmering seed
terra blade
endless gel booster
beetle husk
beetle bow
demonite repeater
hermes boots

soul of blight
tentacle spike
gold armour
shadow armour
jungle armour
wasteland treads
goldery blattery
golden arrow
demonite bullet
blighted arrow
]],"\n")

tilenames[0]="eraser tile"

music"0"
poke(0x5f36,16)
poke(0x5f5a,255)

lmouse=false
rmouse=false
cmouse=false
plmouse=false
prmouse=false
pcmouse=false
end

function _update60()
tooltip=false
hint=false

function toggle(name,bool)
 return name..": "..(bool and "on" or "off")
end

menuitem(2,toggle("autowalls",autowalls),function()autowalls=not autowalls end)
menuitem(3,toggle("background",parallax),function()parallax=not parallax end)
menuitem(4,toggle("treetops",treetops),function()treetops=not treetops end)
menuitem(5,toggle("lighting",lighting),function()lighting=not lighting end)

poke(0x5f5c,-1) -- disable keyrepeat
poke(0x5f2d,mode<3 and 1 or 0x3)
msx,msy,jb,ab,rbp,pgfx,invkey,pinvkey,pdef,jk=stat(32),stat(33),mouse and invopen and 5 or 4,mouse and invopen and 4 or 5,btnp(1),pgfx or "",btnp(6) or stat(28,8),invkey,0,btn(jb)or stat(28,44)

plmouse=lmouse
prmouse=rmouse
pcmouse=cmouse

lmouse=stat(34)==0x1
rmouse=stat(34)==0x2
cmouse=stat(34)==0x4

while stat(30) do
local k=stat(31)

if k=="コ" then
 p=stat(4)
 
 if mode==3 then
  selection=p
  editmode="copy"
  
  local tiledata=split(selection,"|")
  local w,h=unpack(tiledata)

  print(w.."/"..h)

  select_x1=edit_x-w\2
  select_y1=edit_y-h\2
  select_x2=select_x1+w
  select_y2=select_y1+h
  
 end
end

if(k=="\t")tile_menu=not tile_menu

end

--todo:
--go into copy mode when pasting

smolmap()

if mode<3 then

if mode==1 then
 if(btnp(2))menu_sel-=1
 if(btnp(3))menu_sel+=1
 
 menu_sel=loop(menu_sel,menu)
 
 
 
end

-- load a dropped world file
if stat(120) or p then
 for i=0,p and 32767 or serial(0x800,0x8000,32767) do
  poke(0x8000+i,(p and ord(p[i+1]) or @(0x8000+i))-32)
 end

 loadedfile=true
end

if(btnp(5) and mode>0)mode-=1

if btnp(4) and mode==1 then
 p=false
 ssfx"7,0"
 loadedfile=true
 
 local name=menu[menu_sel]
 
 if name=="load a world" then
  mode+=1
  loadedfile=false

 elseif name=="new world" then
  generate()
  
 elseif name=="empty world" then
  generate_empty()

 elseif name=="superflat" then
  generate_superflat()

 elseif name=="redux" then
  generate_redux()

 elseif name=="randomised" then
  generate_block_random()

 elseif name=="amplified" then
  generate_amplified()

 else
 end
end

if loadedfile then
 _reload()
 spawnplayer()
 mode=3
end

else

lights,mx,jpow={},1,1

menuitem(1,"save",function()
sw=""

genprint"processing world..."
for i=0,32767 do
sw..=chr(@(i+0x8000)+32)
end

function a(s,s2)
printh(s,"@clip")
repeat
poke(0x5f30,1)
genprint(s2,"press pause to continue")
until btn(6)
end

a(sw,"world copied to clipboard")

end)

bigmap()

--worldtime+=0.4
worldtime%=24000

-- editor update
mvspeed=4
if(btn(0) or btn(0,1))px-=mvspeed
if(btn(1) or btn(1,1))px+=mvspeed
if(btn(2) or btn(2,1))py-=mvspeed
if(btn(3) or btn(3,1))py+=mvspeed

cam_x,cam_y=px-64,py-64

edit_x,edit_y=(msx+cam_x)\8,(msy+cam_y)\8

if editmode~="copy" then
 selection=false
 select_x1,select_y1=false,false
end

brush_size=0
if placedown or selection or msy>(tile_menu and 72 or 8) then
 select_cursor=lmouse

	if rmouse and editmode~="copy" then
	 local tile=mget(edit_x,edit_y)

  if tile==0 then
 	 editmode="eraser"
  else
   currenttile=tile
 	 editmode="paint"
  end
	end

 -- tools
 if editmode=="cursor" then
  hint="l: scroll"
  brush_size=-1
 
		if lmouse then
		 if not plmouse then
		  pan_x,pan_y=msx,msy
		 end

		 px+=pan_x-msx
		 py+=pan_y-msy

		 pan_x,pan_y=msx,msy
		end
 
 elseif editmode=="copy" then
  hint="l: select  ^v: paste"
  brush_size=-1
 
  --todo:
  --move selections
 
  -- selection exists
  if selection then
	  local x,y=min(select_x1,select_x2),min(select_y1,select_y2)
	  local width,height=abs(select_x1-select_x2),abs(select_y1-select_y2)

   -- pick up tiles on click
   if lmouse and not plmouse then
   
    select_offx=edit_x-x
    select_offy=edit_y-y

    local tx,ty=edit_x-select_offx,edit_y-select_offy

   end
   
   -- move selection box
   -- with cursor
   if lmouse then
    hint="release: place"
    select_x1=edit_x-select_offx
    select_y1=edit_y-select_offy
    select_x2=select_x1+width
    select_y2=select_y1+height

			-- update copy preview offset
			else
    hint="l: move  r: delete  ^c: copy"
			 select_offx=edit_x-x
			 select_offy=edit_y-y

   end
   
   -- retain value from toolbar buttons
   placedown=placedown or plmouse and not lmouse

   -- clear selection and
   -- place tiles on release
   if select_offx and placedown then
    local tx,ty=edit_x-select_offx,edit_y-select_offy

    -- place down tiles
    local string=split(selection,"|")
    local tiledata=split(string[3],1)
    local i=1

    for iy=ty,ty+height do
     for ix=tx,tx+width do
      local tile=ord(tiledata[i])-32
      if(tile>0 or copy_place_empty)mset(ix,iy,tile)

      i+=1
     end
    end
   
    selection=false
    select_x1,select_y1=false,false
   end

   -- clear selection with right click
   if rmouse then
    selection=false
    select_x1,select_y1=false,false
   end
  
  
  else

	  -- start selection
	  if lmouse and not plmouse then
	   select_x1,select_y1=edit_x,edit_y
	  end

	  -- end selection
	  if select_x1 and select_y1 and not lmouse then
 	  
 	  -- build string
 	  local x,y=min(select_x1,select_x2),min(select_y1,select_y2)
 	  local width,height=abs(select_x1-select_x2),abs(select_y1-select_y2)

 	  local string=width.."|"..height.."|"
 	  for iy=y,y+height do
  	  for ix=x,x+width do
      string..=chr(mget(ix,iy)+32)
      
      mset(ix,iy,0)
  	  end
 	  end

 	  --todo:
 	  --copy to clipboard
 	  --accommodate visual for backwards selections
 	  selection=string
 	  printh(string,"@clip")
	   
	  else
	   select_x2,select_y2=edit_x,edit_y

	  end



	 end
 
 elseif editmode=="paint" or editmode=="eraser" then
  hint="l: "..editmode.."  r: pick tile"

  paint_size=mid(0,paint_size+stat(36),4)
  
  brush_size=paint_size

 elseif editmode=="tunnels" then
  hint="l: carve"

  tunnel_size=mid(1,tunnel_size+stat(36),4)

  cx,cy=edit_x,edit_y
  if(lmouse)maketunnel(tunnel_size,true)

  brush_size=tunnel_size

 elseif editmode=="trees" then
  hint="l: grow trees"
  tree_size=mid(0,tree_size+stat(36),4)
  
  brush_size=tree_size

 elseif editmode=="grass" then
  hint="l: grow grass"
  grass_size=mid(0,grass_size+stat(36),4)
  
  brush_size=grass_size

  if lmouse then
  	local sound=false
  	
  	for ix=-grass_size,grass_size do
 	  ix+=edit_x
	   for iy=-grass_size,grass_size do
  	  iy+=edit_y
  	  
  	  local tile=mget(ix,iy)
  	  
  	  -- covered
  	  if fmget(ix,iy-1,0) then
  	   if tile==1 or tile==6 or tile==10 then
  	    mset(ix,iy,tile+1)
  	    splat(ix*8+4,iy*8+4,tile==10 and 1 or 9,3-grass_size/2)
       sound=true
  	   end

  	  -- exposed to air
  	  else
  	   if tile==2 or tile==7 or tile==11 then
  	    mset(ix,iy,tile-1)
  	    splat(ix*8+4,iy*8+4,tile==10 and 1 or 9,2-grass_size/2)
       sound=true
  	   end

  	  end

	   end
	  end
	  
   if(sound)sfx(4)
  end
  

 elseif editmode=="corrupt tunnels" then
  hint="l: carve"
  corrupt_tunnel_size=3

  if(lmouse)makecorrupttunnel(edit_x,edit_y,corrupt_tunnel_size)

  brush_size=corrupt_tunnel_size

 elseif editmode=="blend" or editmode=="blend2" then
  hint="l: shuffle tiles"
  blend_size=mid(1,blend_size+stat(36),4)
  
  brush_size=blend_size

  if lmouse and (not plmouse or editmode=="blend2") then

	  local tiles={}
	 
	  for ix=-blend_size,blend_size do
	   for iy=-blend_size,blend_size do

			  add(tiles,mget(edit_x+ix,edit_y+iy),rnd(#tiles)\1+1)

	   end
	  end
	  
	  
	  local i=1
	  for ix=-blend_size,blend_size do
	   for iy=-blend_size,blend_size do

			  mset(edit_x+ix,edit_y+iy,tiles[i])

     i+=1
	   end
	  end
	  
	 end


 end



 -- edit
 if lmouse then
	 if editmode=="paint" then
	  for ix=-paint_size,paint_size do
	   for iy=-paint_size,paint_size do
  	  mset(edit_x+ix,edit_y+iy,currenttile)
	   end
	  end
	
	 elseif editmode=="eraser" then
	  local broke=false
	  
	  for ix=-paint_size,paint_size do
	   for iy=-paint_size,paint_size do
  	  local tile=mget(edit_x+ix,edit_y+iy)
  	  
  	  if tile>0 and tile<255 then
	  	  splat((edit_x+ix)*8+4,(edit_y+iy)*8+4,tilecols[tile] or 5,3-paint_size/2)
	  	  
	  	  mset(edit_x+ix,edit_y+iy,0)
  	  
  	   broke=true
  	  end

	   end
	  end
	  if(broke)sfx(4)
		
	 elseif editmode=="trees" then
	  for ix=-tree_size,tree_size do
	   for iy=-tree_size,tree_size do

			  if mget(edit_x+ix,edit_y+iy)==0 and fmget(edit_x+ix,edit_y+iy+1,0) then
			   tree(edit_x+ix,edit_y+iy+1)
			  end

	   end
	  end


	 end
 end

end







-- scroll tile menu
if tile_menu then
 tile_menu_y-=stat(36)*scrollspeed

 tile_menu_y=mid(0,tile_menu_y,tile_max_scroll-64)
end



for _ENV in all(parts) do
 yv=min(yv+0.07,3)
 xv*=0.98

 x+=xv
 y+=yv
 
 li-=1
 
 if(li<0 or #parts>200)del(parts,_ENV)

end


-- invkey
if invkey and not pinvkey and not pdead then
--poke(0x5f30,1)
--ssfx(invopen and "7,0" or "7,1")
end

timelight=split"5,5,4,3,2,1,1,1,1,1,1,1,1,1,2,3,4,5,5,5,5,5,5,5,5"[worldtime\1000+1]

local nextmusic=bossmusic or worldmusic
if nextmusic~=currentmusic or stat(24)==-1 then
music(-1,1000)
currentmusic=nextmusic
end
if stat(24)==-1 then
music(nextmusic,1000,3)
end

end

t=max(t+1)

if(mute)music"-1"

placedown=false
end

function _draw()

smolmap()

respal()

clip()
cls"0"
fillp(░)
rectfill(0,0,127,127,15)
fillp()

camera(cam_x,cam_y)
rect(-1,-1,2048,1024,0)
rect(-2,-2,2049,1025,11)

camera()
clip(-cam_x,-cam_y,2048,1024)
--clip(0,0,64,64)

--cls"14"
rectfill(0,0,127,127,14)

pal(split"130,132,4,9,10,5,134,131,3,139,7,1,140,12,136,128",1)

if mode<3 then

 bg(t/10)
 if mode==1 then

	 for k,i in pairs(menu) do
	  c1,c2=7,1
	  if(k==menu_sel)c1,c2=11,6
	  cprint(i,76+(k-menu_sel)*8,c1,c2)
	 end
	 cprint("(⬆️/⬇️ to change)",120,11,6,63-2)

 else
  cprint("drop a world file here",76)
  cprint("(or press ❎ to go back)",84,7,1,63)

 end

 --cprint("press ❎ for the player editor",120,7,1,63)

 rotspr(64,20,sin(t/700)/40,11,26,8)
 cprint("world editor",40)

-- game
else

if parallax and py<360 then
 for i=0,1 do
  local s=(worldtime+1000)/24000+i*0.5-0.25
  local y=32+sin(s)*24
  if(y<32)circfill(64-cos(s)*71,y,7)
 end

 bg(cam_x/4,28-cam_y/4)
end

local e,d,l,r,u,f=cam_y\1,120,cam_x\8-1,cam_x\8+17,cam_y\8-1,cam_y\8+18

if parallax then
	camera(cam_x*0.75%128,e)
	
	for y=0,5 do
	 local y28=y*128
	 if(e>168+y28 and e<424+y28)map(96,bgs[y],0,296+y28,32,16)
	end
end

camera(cam_x,e)

bigmap()

-- walls
if autowalls then

for iy=u,f do
 for ix=l,r do
  if fmget(ix,iy,6) then
   for p=1,#around,2 do
    local wall=mget(ix+around[p],iy+around[p+1])
    if fget(wall,2) then
     spr(wall,ix*8,iy*8)
     break
    end
   end
  end
 end
end

end

map()

for iy=u,f do
 for ix=l,r do

  -- treetops
  local tile=mget(ix,iy)
  if treetops and tile==82 and mget(ix,iy-1)~=82 then

   local y=iy
   repeat
    y+=1
   until mget(ix,y)~=82
   local s,w,o,b=142,2,4,mget(ix,y+1)
   if(b==6)s=137w=3o=8
   if(b==10)s=140

   spr(s,ix*8-o,iy*8-16,w,2)

  -- lights
  elseif fget(tile,7) then
   local px,py=ix*8+4,iy*8+4
   add(lights,{px,py})
   if(rnd"400"<1 and not invopen)splat(px,py,7,0)

  end

 end
end

smolmap()

for _ENV in all(parts) do
 if li<30 then
  pset(x,y,c)
 else
  circfill(x,y,1,c)
 end
end

bigmap()

-- show spawn point
local spx,spy=findspawn()
oval(spx-7,spy+1,spx+6,spy+5,11)
if dist(spx-msx-cam_x,spy-msy-cam_y)<16 then
 cprint("spawn point",spy-16,11,6,spx)
end

-- selection border
if select_x1 and select_y1 and select_x2 and select_y2 then
 local c1,c2=6,7
 local x,y=min(select_x1,select_x2),min(select_y1,select_y2)
 local width,height=abs(select_x1-select_x2),abs(select_y1-select_y2)

 local x1,y1=x,y
 local x2,y2=x+width,y+height

 if selection then
  c1,c2=4,11
  if(t%20<10)c1,c2=c2,c1

  line(x1*8,y2*8+9,x2*8+9,y2*8+9,0)
  line(x2*8+9,y1*8,x2*8+9,y2*8+9,0)

  -- show floating overlay
  if select_offx and select_offy then
	  local tx,ty=edit_x-select_offx,edit_y-select_offy
	
	  local string=split(selection,"|")
	  local tiledata=split(string[3],1)
	  local i=1
	
	  for iy=ty,ty+string[2] do
	   for ix=tx,tx+string[1] do
	    local tile=ord(tiledata[i])-32
	    if(tile>0)spr(tile,ix*8,iy*8)
	
	    i+=1
	   end
	  end
  end

 end

 rect(x1*8-1,y1*8-1,x2*8+8,y2*8+8,c1)
 fillp(▒)
 rect(x1*8-1,y1*8-1,x2*8+8,y2*8+8,c2)
 fillp()
 
end

-- brush border
if brush_size>=0 and msy>8 then
	local select_width=brush_size*8
	if select_cursor then
	 rect(edit_x*8-2-select_width,edit_y*8-2-select_width,edit_x*8+9+select_width,edit_y*8+9+select_width,11)
	
	 local id=mget(edit_x,edit_y)
	 if(brush_size==0 and id>0)sspr(id%16*8,id\16*8,8,8,edit_x*8-1,edit_y*8-1,10,10)
	
	else
	 rect(edit_x*8-1-select_width,edit_y*8-1-select_width,edit_x*8+8+select_width,edit_y*8+8+select_width,11)
	end
end


-- ui
camera()
clip()

-- coords
bprint("x: "..px.."\ny: "..py,2,10)

-- tile chooser
if tile_menu then
 camera(0,-8)
 rectfill(0,0,127,63,1)
 line(0,64,127,64,13)
 
 clip(0,8,128,64)

 local height=0
 for kc,cat in pairs(tile_categories) do
  kc-=1

  local caty=8+height-tile_menu_y
  camera(0,-caty)

  local maxy=0
	 for kt,tile in pairs(cat.tiles) do
	  kt-=1

	  local x,y=5+kt%11*11,12+kt\11*11
   local mx,my=msx,msy-caty

   local hovertile=msy>=8 and msy<72 and not (mx<x-1 or my<y-1 or mx>x+8 or my>y+8)

	  rectfill(x-1,y-1,x+8,y+8,0)

   if(hovertile) tooltip=tilenames[tile]


	  if hovertile and (lmouse or plmouse) then

	   rect(x-2,y-2,x+9,y+9,11)
	   
 	  --spr(tile,x,y)
 	  sspr(tile%16*8,tile\16*8,8,8,x-1,y-1,10,10)

	   -- set current tile
	   if plmouse and not lmouse then
	    currenttile=tile
     tile_menu=false
   	 editmode="paint"

	   end

	  else
	   rect(x-1,y-1,x+8,y+8,hovertile and 13 or 12)
	   
 	  spr(tile,x,y)

	  end


   maxy=max(maxy,y)
	 end

	 height+=8+maxy


  local hovercat=msy>=8 and msy>caty and msy<height+8-tile_menu_y+1

  print(cat.title,5,4,hovercat and 11 or 7)

 end

 tile_max_scroll=height+8

 camera()
 clip()

end


-- menu bar
rectfill(0,0,127,7,13)

rectfill(0,0,7,7,12)
if currenttile>0 then
 spr(currenttile,0,0)

else
 print("⁶:001c24243c3c3c00",0,0,11)

end

for k,b in pairs(buttons) do
if b.name then


 local x,y=k*8+4,4
 local hover=abs(msx-x)<4 and abs(msy-y)<4

 print(b.glyph,x-4,y-4,(editmode==b.editmode or hover and lmouse) and 11 or hover and 6 or 12)

 -- hover text
 if hover then
  tooltip=b.name
  
  -- activate button
  if plmouse and not lmouse then
   if b.editmode then
    editmode=b.editmode
    placedown=true

   elseif b.func then
    b:func()

   else
    
   end

  end
 
 end

end
end

for i in all(lights) do
 d=min(dist(i[1]-px,i[2]-py),d)
end

if lighting then
pal(split(palettes[min(mid(1,d/8-6,5)\1,max(mid(1,py/24-12,5)\1,timelight))]),1)
pal(14,split"12,140,1,129,0"[timelight],1)
end

end

if hint then
 cprint(hint,121)
end

sspr(88,90,5,6,msx,msy)

if tooltip then
 local w=#tooltip*4
 local tx,ty=min(msx,124-w),msy+8

 rectfill(tx,ty,tx+2+w,ty+8,0)
 rect(tx,ty,tx+2+w,ty+8,11)

 print(tooltip,tx+2,ty+2,11)

end

end

-->8
--worldgen functions

function genprint(t,t2)
pal(split"130,132,4,9,10,5,134,131,3,139,7,1,140,12,136,0",1)
cls()
cprint(t,62)
cprint(t2 or "",110)
flip()
end

function generate_none()
 bigmap()
 genprint"not implemented..."
 stop()

end

function generate_full_random()
 bigmap()
 genprint"randomising..."
 for ix=0,255 do
  for iy=0,127 do

   mset(ix,iy,rnd(256))
  
  end
 end
 

 genprint"placing safety platform..."
 for iy=0,37 do
  for ix=0,1 do
   ix+=127
  
   if iy==37 then
    mset(ix,iy,5)
   elseif fmget(ix,iy,0) then
    mset(ix,iy,0)
   end

  end
 end

end

function generate_block_random()
 bigmap()
 genprint"randomising..."
 for ix=0,255 do
  for iy=0,127 do
   local allowed_blocks=split"1,2,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,64,66,67,68,69,70,71,75,76,77,78,82,83"

   mset(ix,iy,rnd(allowed_blocks))

  end
 end

 genprint"placing safety platform..."
 for iy=0,37 do
  for ix=0,1 do
   ix+=127
  
   if iy==37 then
    mset(ix,iy,5)
   elseif fmget(ix,iy,0) then
    mset(ix,iy,0)
   end

  end
 end

end

function generate_amplified()
 bigmap()

local worlddir,ry,ra,tunnel,dirttile,surfacecaves,crystals,ores
=rnd()<.5,30,0,0,2,0,0,0
genprint"sculpting the land..."
for ix=0,255 do
ra=mid(-0.4,ra+rnd"0.4"-0.2,0.4)
ry+=sin(ra)*max(abs(ix-128)/20,0.7)*sgn(ix-128)
if ry<20 or ry>37 then
ra,ry=0,mid(20,ry,37)
end
if rnd"20"<1 and tunnel<=0 then
tunnel=6+rnd"8"\1
end
local ll,rl=78+rnd"20"-10,178+rnd"20"-10
for iy=0,127 do
js,cs=ix<ll+rnd"7",ix>rl-rnd"7"
if(worlddir)js,cs=cs,js
if iy>ry+10 then
mset(ix,iy,js and 7 or 3)
elseif iy>=flr(ry) then
dirttile=cs and 11 or js and 7 or 2
mset(ix,iy,dirttile)
end
end
if tunnel>0 then
for i=1,5+rnd"2" do
mset(ix,ry-i,i>3 and dirttile or walls[dirttile])
end
tunnel-=1
end
end
for i=0,40 do
a,cx,cy,s=rnd(),rnd"256",50+i/2+rnd(78-i/2),1+rnd"2"
for l=0,10+rnd"80" do
av=-0.0833+rnd"0.1667"
a+=av
cx,cy=cx+cos(a),cy+sin(a)
maketunnel(s-rnd"2")
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
r=7+rnd"6"
for y2=-r,r do
x2=flr(sqrt(abs(y2*y2-r*r)))
for ox=-x2,x2 do
mset(ix+ox,iy+y2+3,dirttile)
end
end
xo=sgn(rnd"-1")
ca,cx,cy=0.5-0.25*xo,ix+xo*r,iy
for l=0,80+rnd"40" do
ca=mid(0.25,ca-0.125+rnd"0.25",0.75)
cx+=cos(ca+0.25)
cy+=sin(ca+0.25)
maketunnel(rnd"3")
end
surfacecaves+=1
end
until surfacecaves>=6

for i=0,40 do
a,cx,cy,s=rnd(),rnd"256",rnd"128",1+rnd"2"
for l=0,5+rnd"10" do
av=-0.0833+rnd"0.1667"
a+=av
cx,cy=cx+cos(a),cy+sin(a)
maketunnel(s-rnd"2")
end
end

genprint"digging corrupt chasms..."
repeat
x,y=rnd"256",0
repeat
y+=1
until mget(x,y)==11 or y>40
if y<=37 then
for l=2,25+rnd"50" do
x+=-1.5+rnd"3"
makecorrupttunnel(x,y,3,l)
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
if (mget(ix,iy)==2 or mget(ix,iy)==7 or mget(ix,iy)==11) and not fmget(ix,iy-1,0) then
mset(ix,iy,mget(ix,iy)-1)
if rnd"2"<1 then
tree(ix,iy)
end
end
end
end
repeat
ix,iy=rnd"256",60+rnd"58"
if mget(ix,iy)==0 and fmget(ix,iy+1,0) then
mset(ix,iy,9)
crystals+=1
end
until crystals>=25
repeat
ix,iy,set=rnd"256",ores*0.6-10+rnd"50"
for i=-3,iy/20+rnd"3" do
ix+=-1+rnd"2"
iy+=-1+rnd"2"

if fmget(ix,iy,0) and mget(ix,iy-1)<82 then
mset(ix,iy,19+ores/50)

set=true
end

end
if(set)ores+=1
until ores>=200

end

function generate_redux()
 bigmap()
 genprint"not implemented..."
 stop()

end

function generate_superflat()
 bigmap()

 genprint"placing the land..."
 for ix=0,255 do
  for iy=0,127 do
  
   --mset(ix,iy,iy<128 and 0 or iy==128 and 2 or iy<140 and 1 or 3)
   mset(ix,iy,iy<=36 and 0 or iy==37 and 1 or iy<40 and 2 or 3)
  
  end
 end

end

function generate_empty()
 bigmap()

 genprint"placing the platform..."

 for i=0,1 do
  mset(127+i,37,5)
 end

end

function generate()
bigmap()

local worlddir,ry,ra,tunnel,dirttile,surfacecaves,crystals,ores
=rnd()<.5,30,0,0,2,0,0,0
genprint"sculpting the land..."
for ix=0,255 do
ra=mid(-0.22,ra+rnd"0.2"-0.1,0.22)
ry+=sin(ra)*(ix-128)/64
if ry<20 or ry>37 then
ra,ry=0,mid(20,ry,37)
end
if rnd"50"<1 and tunnel<=0 then
tunnel=6+rnd"8"\1
end
for iy=0,127 do
js,cs=ix<78+rnd"7",ix>178-rnd"7"
if(worlddir)js,cs=cs,js
if iy>ry+10 then
mset(ix,iy,js and 7 or 3)
elseif iy>=flr(ry) then
dirttile=cs and 11 or js and 7 or 2
mset(ix,iy,dirttile)
end
end
if tunnel>0 then
for i=1,5 do
mset(ix,ry-i,i>3 and dirttile or walls[dirttile])
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
maketunnel(s-rnd"2")
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
xo=sgn(rnd"-1")
ca,cx,cy=0.5-0.25*xo,ix+xo*r,iy
for l=0,80+rnd"40" do
ca=mid(0.25,ca-0.125+rnd"0.25",0.75)
cx+=cos(ca+0.25)
cy+=sin(ca+0.25)
maketunnel"1"
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
x+=-1+rnd"2"
makecorrupttunnel(x,y,3,l)
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
if (mget(ix,iy)==2 or mget(ix,iy)==7 or mget(ix,iy)==11) and not fmget(ix,iy-1,0) then
mset(ix,iy,mget(ix,iy)-1)
if rnd"2"<1 then
tree(ix,iy)
end
end
end
end
repeat
ix,iy=rnd"256",60+rnd"58"
if mget(ix,iy)==0 and fmget(ix,iy+1,0) then
mset(ix,iy,9)
crystals+=1
end
until crystals>=20
repeat
ix,iy,set=rnd"256",ores*0.6+rnd"38"
for i=-3,iy/20+rnd"3" do
ix+=-1+rnd"2"
iy+=-1+rnd"2"

if fmget(ix,iy,0) and mget(ix,iy-1)<82 then
mset(ix,iy,19+ores/46)

set=true
end

end
if(set)ores+=1
until ores>=180
end

-->8
--common functions

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

function findspawn()
local x,y=1024,0

repeat
y+=8
until fmget(x/8,y/8,0)
y-=4

return x,y
end

function spawnplayer()
bigmap()
px,py=findspawn()
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

function _reload()
reload()
tospr(pgfx,56,0,64)
end

function splat(xp,yp,cp,am)
for i=0,am or 3 do
local _ENV=setmetatable({},env)
x,y,xv,yv,li,c=xp,yp,-1+rnd"2",-rnd"1.5",60-rnd"20",cp
add(parts,_ENV)

end
end

function tree(ix,iy)
local th=4+rnd"5"
for y=2,th+2 do
if mget(ix,iy-y)~=0 then
return
end
end
for y=2,th do
mset(ix,iy-y,82)
end
mset(ix,iy-1,83)
end

function door(bx,by,b,fl)
if pxv*fl>0 and fget(b,0) then
sfx"4"
mset(bx,by,b+1)
elseif pxv*fl<0 and not fget(b,0) then
sfx"4"
mset(bx,by,b-1)
end
end

function loop(a,l)
return a<1 and #l or a>#l and 1 or a
end

function respal()
pal()
palt"0b0000000000000010"
end

function draw_item(id,x,y,sel,am)

if(y<=0or y>141)return

if sel then
pal(split"1,2,3,4,5,6,7,8,9,10,11,4,5,14,15,0")
sspr(88,80,10,10,x-1,y-14,12,12)
else
sspr(88,80,10,10,x,y-13)
end
respal()
spr(id or -1,x+1,y-12)
if(am and am>1)print(am>=1000 and (am\1000).."K" or am,x,y-8,11)

end

function ssfx(i)
sfx(split(i)[1],-1,split(i)[2]*8,8)
end

function fmget(x,y,f)
return fget(mget(x,y),f)
end

function bg(x,y)
 map(5,0,-(x%512),y,80,18)
end

function maketunnel(s,keepmissing)
for ix=-s,s do
for iy=-s,s do
local r=mget(cx+ix,cy+iy)

local tile=cy<60 and walls[r] or 0
if keepmissing then
 if(tile=="" or tile==0)tile=mget(cx+ix,cy+iy)
end

if(not fget(r,2))mset(cx+ix,cy+iy,tile)
end
end
end

function makecorrupttunnel(x,y,s,l)
l=l or 0
for ix=-s,s do
for iy=-s,s do
mset(x+ix,y+iy+l,((abs(ix)>=s-1 or iy>=s-1) and mget(x+ix,y+iy+l)~=76) and 12 or 76)
mset(x,y+l,77)
end
end
end


local _mset=mset
function mset(x,y,t)
 _mset(x,y,t==255 and 0 or t)
end

-->8
--borrowed functions

function rotspr(x,y,rot,mx,my,w,flip,scale)
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

-->8
-- categories

function build_categories()

 safe_invalid_tiles={
  title="safe+useful invalid tiles",
  desc="these are tiles that can be used for building, but are not normally able to be placed",
  tiles=split"88,90"
 }

	tc_natural={
	 {
	  title="natural",
	  desc="these are typically found on world generation",
	  tiles=split"1,6,10,2,7,3,12,66,71,67,76,19,20,21,22,23,27,9,77"
	 },
	 {
	  title="artificial",
	  desc="these are crafted or obtained by the player through their actions",
	  tiles=split"5,13,64,70,14,69  ,75,15,16,18,4  ,17,68,78 "
	 },
	 {
	  title="components",
	  desc="these are normally unobtainable, but may still appear in gameplay",
	  tiles=split"82,83,79,11"
	 },
	 safe_invalid_tiles,
	 invalid_tiles
	
	}

	tc_types={
	 {
	  title="solid blocks",
	  desc="",
	  tiles=split"1,6,10,2,7,3,12,19,20,21,22,23,13,64,70,5,14"
	 },
	 {
	  title="background walls",
	  desc="",
	  tiles=split"66,67,69,71,76,77"
	 },
	 {
	  title="furniture",
	  desc="",
	  tiles=split"78,75,15,16,18,4"
	 },
	 {
	  title="light sources",
	  desc="",
	  tiles=split"17,68,16,4"
	 },
	 {
	  title="other",
	  desc="",
	  tiles=split"27,9,82,83,79,11"
	 },
	 safe_invalid_tiles,
	 invalid_tiles
	
	}




end

-->8
 --[[




         -- [ -4S ] --

     in memory of leinfors.
         rest in piece.

          -- ★ ★ --

          2023  1.4.4









]]
__gfx__
eeeeeeeeaa9aa99a1233232266677761eeeeeeee34444442aa9aa99a12221112eeeeeeeeeeeeeeee6616611612332322016611016177617734444442eeeeeeee
effeeffe99a818992332333267767676ee7777ee4344434399a8089923333221eeeeeeeeeffeef2e1161106123323332666110006176617643444343eeeeeeee
f44ff4ff189121982233332216777661e7b66b7e444334330890109812322222eee7eeeef44ff4f21010221022333322111116106166616644433433eeeeeeee
f4ffffff212232212323322167776766e550855e322223321121111112211111e47437eff4fffff22222322123233221011006611011101132222332eeeeeeee
fffffff222332212223322127676776674088047444423441211332112113321433376e42fffff2222332212223322120166161177617761eeeeeeee32333322
efffff2e223333232233332377677676608998064434343432222223322222233eee6ee6e2fff22e22333323223333236661111076617661eeeeeeee22222222
ee2ff2ee2222323222223232666667615b9aa9b5344324432221123222211232eeeee66eee2f22ee22223232222232321611011066616661eeeeeeeee111111e
eee22eee23322221233222216111661145577554332223221112112111121122eeeeeeeeeee22eee23322221233222211111000011101110eeeeeeeee2eeee2e
eeeeeeeeeeeeeeeeeeeeeeee2334443276667667677bbb774455554411666611eeeeee61eee77eeeeeee6eeeee9a9eeeee5b5eeeeebbbeeeee777eeeee333eee
eeeeeeeeeeefeeeeeeeeeeee34444443677bb7766bb7b7b745bb5b5416776761eeeee610ee6996eeeee6160eeeaaa9eeee6e45eeee6e7beeee6e67eeee6e23ee
6666661eeeeffeeeeeeeeeee444334447bb7bb667b77bb7655b5555566766666eeee610ee690096eeeee116ee899989eee7ee54eee7eeb7eee7ee76eee7ee32e
612f211eeef44feeeeeeeeee44344433bb7bb7767bbbbb774555545516666166e6e610ee67a00a76eee61016ee8988eeee7eef2eee7ee21eee7ee32eee7ee76e
1f454f77ee4454ee67b77611444444437bbb7b77b7bbb7b75455445461661161e6610eee167aa761ee610e06eee11eeeee7eef2eee7ee21eee7ee32eee7ee76e
77777776eee34eee1666661e3444443277b7b7767bbb77b74554455416611661e016eeeee167761ee610eee1ea9219aeee7ee43eee7ee76eee7ee61eee7ee21e
1111111eeee33eeee11111ee3334333267677767677bbb77345555440166661161001eeeee1661ee610eeee0e983188eee6e54eeee6eb7eeee6e76eeee6e32ee
6161611eeee32eeeee7661ee343332216776667676777776434444431011111010eeeeeeeee11eee10eeeeeeeee21eeeee544eeeeeb77eeeee766eeeee322eee
eeeb5eeeeeb55eeeeeeeeeb5eeeeeeeeeeebbeeeeebbbeeeeeeeeebbeeeeeeeeeee77eeeee777eeeeeeeee77eeeeeeeeeee33eeeee333eeeeeeeee33eeeeeeee
eeb5451eeee442feeeeeeb54eeeee32eeebb7b7eeee772feeeeeebb7eeeee32eee77676eeee6676eeeeee776eeeee32eee33232eeee2232eeeeee332eeeee32e
ee542f5eeeee342eeeeeb54eeeee324eeeb72fbeeeee672eeeeebb7eeeee326eee76767eeeeec67eeeee776eeeee32ceee32323eeeee123eeeee332eeeee321e
eee34243eee32345eeeb54eeeee32f5beee67276eee3267beeebb7eeeee32f7beeec6c6ceee32c67eee776eeeee32c67eee12121eee32123eee332eeeee32123
ee323434ee321e45e5254eeeee324545ee326767ee321e7bebfb7eeeee32676bee32c6c6ee321e67e7676eeeee32c6c7ee321211ee321e23e3232eeeee321212
e321e34ee321eee4e1f2eeeee321e45ee321e67ee321eee7e12feeeee321e7bee321ec6ee321eee6e166eeeee321e67ee321e11ee321eee2e122eeeee321e22e
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
21ff21ffee32330000000110000ccc00eeeeeeee01111110bbbbbbb7008c0001eeeeee3ee320032eeeeee5eeeeeeeeee000000000000000ceee22eeee211111e
21f221f2eee3022e000001100cc0c0c0eefeeeee10111010bbbbbbb700801000eeeee32ee300321eeeee554e32333322000000cc00666100eee32eeee222111e
21222122eee32eee0100000000ccc000eeffefee11100100bbbbbbb70118118ceeee32eeee32216eeee724542222222200cc0cc006776610eee32eeee222111e
101110113e33322e000000000ccc0c00eef4fffe00000000b7777b76881c18c0eee321eee766621eee77d24ee11ee11e0cc0000006776610eee32eeee222111e
ff21ff21233333ee00110000c0c0cc00ef4544fe11110011bbb7bbbb0cc1c000ee3212aee6322221edddcc3ee2eeee2e0000000006666610ee6326eee222166e
f221f2213322323e00110000cc0cc0c0e455554e11010101bbb7bbbb00001800ee21ee9823333221d7dcce23e1eeee2e0000c00001666110eee32eeee222111e
22212221321e33230000001000000c00e32bb32e01100110bbb7bbbb10008c01e32eeeee22332210cdcc1ee2e2eeee1e00cc000000111100eee32eeee222111e
111011103e1e23e200000000000000002123321100000000b776777b1100c011e2eeeeeee122210eeccee23ee2eeee1e00000000c0000000eee22eeee211111e
eee4eeeeeeeeeeeeee3331eeee3322eeeeeeeeaaeeeeeeeeeeeeeeeeeee32eeeeeffffeeeeeeeeeeee45b3e4eeeeeea9ee766eeeeeeeeeeeeeeeeeeeeeeeeeee
eefbfeeeeeeeeeeeee2332eeee2321eeeeee9aa9ee33eeeeeee4feeeeebbb7eeee1221eeeeeaeeee5eb454eeeeeeea9de7b762eeee1c1eeeeeeeefeeeeeee6ee
ee454eeeeeebeeeeee2322eeee2321eeeee9aa9eeee23eeeee4443eeeeeb7eeeeffffffeeea5aeeee455b47eeeeea9dee7b7612eeef1feeeeeecce2eeee77e1e
eef4feeeeebb7eeeee2321eeee2332eeeeeaa98e33267677eeff3feeeeb667ee2f2ff2f2ee555eeee5b4433eee9aedeeeddcce2eef424feee2fffff2e1666661
eeefeeeeee776eeeee3321eeee3331eea9a998eee2226666ee2f32eeee1f21ee122ff221ea555aee5a43379a5bdedeeee7b7621eeff2ffeeddc1221133201100
eee7eeeeeeeeeeeeee2332eeee3321eee19aeeee21e128eeeee22eeee1fff21e5a12215ae9aaa9eea99a9889e45d8eeee67762eee1f2f1eecceeee2e22eeee1e
ee766eeeeeeeeeeeee2322eee332321e3219eeeeeeeeeeeeeee32eeee1f2221e98911989ee9a9eee9eecce584345eeeee16611eeee121eeeeeeee1eeeeeee0ee
ee6e6eeeeeeeeeeeee3331ee3212332121e8eeeeeeeeeeeeeeeeeeeeee1111eeec8a98ceeeeeeeeeee48ceee54e4eeeeee111eeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeea9eeeeeeeeeeeeeeee11eeeeeeeeeeeeeeeeeeeeeeeeeee6661eeeeee5b5eeeebe4eeeeeeeeeeeee5eeee9166677799898888998899898c8c8c8c
ee9aa99eeee9aeeeee5b5eeeeeee017ee54ee45ee61ee16eea9ee9aee1000ceeeeeeb553eeb55eeeeee6eeeeee5b5eee1616116198988888888989899cc88c8c
eee554eeeeea9eeee54eeeeeeee1106755555555f6666662aa4554aaee11c176eeee55445e534eeeeee7eeeee44544ee66161661899898888889889898c8c88c
eee9a9bbeee9aeeeebeb545eee1007eee45f254ee26f262ee2a44a2eee32276eeee45543eee4eeeeee661eeeeee7eeee1161aa66888888888989989989c8c8cc
eaaaa7b7eeea9eeee545bebee107e67ee345543eec1661cee39aa93ee661166eee45543eeee3ee5eeec1ceeeee373eee666899a68989888888888898988c8ccc
9aa9977eeea9a9eeeeeee45ee1e67eeeee5445eeee6116eeee3223ee67661ceeea9443eee4e5eeeeee1e1eeee4e6e4ee118aa9968988888888899888998c88cc
899988eeeeea9eeeeee5b5ee10eeeeeeee4334eeeec00ceeee2112ee16611eee29a9deeeee544eeeeeeeeeeeee5b5eee168aaa919988888889989989898c88cc
eeeeeeeeeee9aeeeeeeeeeee0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeec11ceeee119deeeeee4e4eeeeeeeeeeeee6e6eee69a9aa88988988888888999898988ccc
66c8c8c8c88c86c6899896866689898977777777777777777777777776666666666666776666666c86666666eeebeeeeeeeeeeeeeeeeeeee11116666eeeeeeee
6c88c8c8c8cc8866898899666899898977777777777777766777777777666666666667776666666888666666ee454eeeeeeeeeeeeeeeeeee16606760eeeeeeee
c68cc8cccc88c8c6889989868698898877777777777777666667777777666666666677776666668c8c666666e5ebe5eeeeeeeeeeeeeeeeee60007760eeeeeeee
6ccc8cccc8c88c6c898998686888988877777777777777666667777777777666666777776666668cc8666666ee5e5eeeeeeeeeeeeeeeeeee00667770eeeeeeee
c8c88c8cc88c8c8689989896898998987777777777776666666677777777776666677777666666cc88c66666efe4efeeeeeeee23eeeeeeee61111771e2ee2eee
68c88ccccc8ccc8c889888986989988877777777777666666666777777777776667777776666688c8c866666eeeeeeee11111ee311111eee6666071ae32e22ee
8c88c8cc8ccc8c8898889899989989887777777776666666666666777777777666777777666668cccc886666eeefeeee111111ee111111ee16660199333e32ee
c88c8ccccc8c88c888989989899898887777777766666666666666677777777767777777666688ccc8c86666eeeeeeee6611eee16611eee170076a9912e232ee
ee22222eeeeeeeeeee22222e66666666772222eeeeeeeeeeeeeeeeee22eeeeeee3332112eeeee89a8ca989989a8eceeeeeeeee1e16eeeeeeeeeeee8e89eeeeee
e226c6eeee22222e7726c66666666666776c6eeeeee22772eeeeeeeeffeeeeeeee321161eec9caaa9aaaa99aaa9a8cceee16116166161eeeee89889899898eee
ee6777eee226c6ee7767776666666666ff677eeeee22f77eeee22222122eeeee2ee21661ee999aa9aaaaaaaaaa99898ce1766677677671eee8a999aa9aa9a8ee
eeffffeeee6777eeefffff1e66666666effff6eeeefff66eee2266ce2eeeeeee2eee1666c8999aaaaa9aaaa9aa999988e1667677767716eee899a9aaa9aa89ee
e77fff6e77ffff66eeffffee66666666effff6eeeefff6eeeefff76efeeeeeee3221661088a9a9aa9a9aaaaa9aa99989ee6677767766771eee99aa9a9a99aa8e
e771116e77ffff66ee1111ee66666666e1111eeee11ff1eeee1fff77ffeeeeee32216111c9989aa9aa9aa9a9a98a999ce166666767776670e89999a9aaaa99ac
ee1111ee331111223311112266666666111111ee1111111ee1111177ffe45eee332161118899a89aa9a9aaa98899988e1617767676677716898aa99aa99aaa89
e333222ee331122ee33ee22e66666666333e222e333e222e333e222eff1aeeeee3316111c8898999999aa999989988cc0676776776766161c9a9aaa9a9aa989c
eeeeeeeeeeeeeeeeee66611eeeeeeeeeee4ee4eee4eeee4e06771112a1666777112333eecc8898a999a99a98999898890166777777766110c899aaaaaaa99888
eeeeeeeeee2222eee61c7ceeee66611eec3ee3cee23ee32e077700711616116161123eeeeec8c98989898889a88989cc1161767677666661889899a99a999998
ee2222eee233221eeec888eee61c7ceee1c11c1ee1c11c1e07707000661616616612ee2eeccc8888889888998c9c9cee117671667661161188a9989999988988
e232221ee232221eee5998c8eec888eee670076ee670076e607661701161aa66661eee2eeeec8c8c9888c888c9c8c8ce0116661776661101c889899a989988cc
23332221e222221eee5585ceee5998c8a167761ae167761e6601116666689aa61661223eeeeccecc8cccec8c8ccceeeee111161661616110ec889898889898ce
22222221e222221eee2224eeee5585ceeec66ceeaec66cea16066661118aa9a61161223eeeeeceeecc1eeec1ce1eeeeee10111101110101eeee8898c918c8cee
12222111e122111eee2244eeee22244ee916619eee1661ee910000011689a9911161233eeeeeeeeee321e111ee28eeeee0e1011210e01e0eeeece882c1eeceee
e111112ee111112eee33222ee3334222eeecceeeee9cc9ee9a60000069a9aa88116133eeeeeeeeeeee32121ee93eeeeeeee0ee2311ee0eeeeeeeee2321eeeeee
8889898996666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee777eeeffeeeeeeffeeecceeee32e23ee66611112edddddddcee4554554e88888eeeeeeee9aaeee8e
8988898999666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee6677206eee77206eeeeddeeeee1771e367606611dcccccccdc451151254888887eeeeeeeeeeeee8e
8888989898666666122ee111eee122eeeeeeeeeeeeeeeeeeee54200177642001eeeddeee317f271267700061dc000000dc51311312588888777eeeeeeeeee88e
8898989989666666e111221eee2232eeeeeee0e0eeeee0e0e455411166554111eeeddeee27200f7e77766006dc000000dc511111125888887777eeeeeeee88ee
8888888899866666ee1232eee221111ee332160ee332160e55421eee55421eeeeeeddeeee7f0027277111160dc000000dc52111122588888777777eeeeeeeeee
8888988998966666eee111ee211ee111e211100ee211100e4554eeee4554eeeeeeeddeee2172f71317066661dc000000dc45211225488888777777eeeeeeeeee
8888889988996666eeeeeeeeeeeeeeeee45454eee54545eee3454eeee3454eeeeeeddeee3e1771eea1066611dc000000dce4522254e888887777777eeeeeeeee
8888899889896666eeeeeeeeeeeeeeee45e4e54e54e5e45eeee433eeeee433eeeeecceeeee32e23ea9670071dc000000dcee45254ee8888877777777eeeeeeee
eeeeeeeeeeeeeeeeee333eeeee333eee11116660a9aee88eeee77eeeeeeeeeeeeeeeeeeeeeeeee22e3332112cdddddddcceee454eeeeeee6c8cc88c9eeeeeeee
eeeeeeeeeeeeeeeee71116eee71116ee16606760eeeee8eeee7707eeeee77eeeeee00eeeeeeeeeff2e321161ecccccccce888888eeeeee66cc8ccc88eeeeeeee
eeeeeeeeeeeeeeeee67776eee67776ee00707760eeeee88eee6776eeee7707eeeeddddeeeeeee2213ee21661cceee88888888888eeee6666cc88c889eeeeeeee
eeeeeeeeeeeaaeeee42662eee26624ee71667770eeeeee88ee4466eeee6776eeee6776eeeeeeeee232ee1666cbcee88888888888eeee6666ccc8c899eeeeeeee
eeeaaeeeeea5a9eee44442eee44442ee61111771eeeeeeeeee7641eeee4466eeeef662eeeeeeeeef32216610cbbce88888888888eee66666cccc8c89ee2ee2ee
ea55aa9eeeaaa9eee2424eeeee4242ee66660719eeeeeeeeee6641eee764416eee2f2feeeeeeeeff33216111cbbbc88888888888ee666666cc8c8898e22e23ee
e9aaa99eee9a99eeee4e2eeeee2e4eee000001aaeeeeeeeeee555eeee664411eeee2feeeeee54effe3216111cbcce88888888888ee666666cccc8898e23e333e
ee999aeeee999aeeee2eeeeeeeee2eee000069aaeeeeeeeeee3322eee335522eeeee2eeeeeeea1ffee316111eceee88888888888e6666666ccc8c998e232e211
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
rr3rr33rssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
33rjij33ssssssssss7ssssssssss1ssss111ssssss1111ss111ss1sss1111sss111111ss1sss11ss111s11sss1s1s1sssssssssssssssssssssssssssss11ss
ij3iki3jssssssssss77ssssssss111sss1ss1ssssssss1ss111ss1ss111111ss111111ss11sss1ss1s1s11sss1ss1ssssssssssssssssssssssssssssss1s1s
kikk4kkis111111sss777ssssss111ssss1ss1sss1111s1ss11sss1ss111111sss1s11sss1ssss1ss111sssss1s1ss1ssssssssssssssssssssssssssss1111s
kk44kkikss1111ssss7777ssss111sssss1111sss1ss1s1ss1ssss1sss1111sss1ssss1ss1s1ss1sssss111ss11s1sssssssssssssssssssssssssssss111sss
kk4444k4sss11sssss77sssss1s1ssssss1111sss1ss1ssss1sss11ssss11ssss1ssss1ss1sss11ss11s1s1ss111s1sssssssssssssssssssssssssss1s1ssss
kkkk4k4kssssssssssss7ssss11sssssss1111sss1111ssss1ss111sss1111sss111111ss111111ss11s111ss111s1sssssssssssssssssssssssssss11sssss
k44kkkkissssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss
cccccccccc55555555mmmmmmmmmmmmcccccccccccccccccccccccccccccccccccc555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmcccc555555
c55555cccc55555555555555555555mccccccccccccccccccccccccccccccccccc555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmccc555555
c57575555555557755777577757575mmccccccccccccccccccccccccccccccccc5555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmc5555555
c57575575555555755757555757575mmcccccccccccccccccccccccccccccccc55555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
c557555555555m5755757577757775mmcccccccccccccccccccccccccccccccc555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
c57575575555m55755757575555575mmcccccccccccccccccccccccccccccccc55555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
c5757555555mm5777577757775m575mmcccccccccccccccccccccccccccccccc55555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
c5555555555mm5555555555555m555mmcccccccccccccccccccccccccccccccc555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
c575755555mmm5777575m57775mmmmmmcccccccccccccccccccccccccccccccc555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
c575755755mmm5557575557575mmmmmmcccccccccccccccccccccccccccccccc55555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
c57775555mmmm5777577757575mmmmmmcccccccccccccccccccccccccccccccc555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
m55575575mmmm5755575757575mmmmmmccccccccccccccccccccccccccccccc5555555555555555555555555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
557775555mmmm5777577757775mmmmmmkiookiookiookiookiookioo4999999k4999999kkiookiookiookiookiookioommmmmmmmmmmmmmmmmmmmmmmmmmmmmmm5
555555mmmmmmm5555555555555mmmmmmkiokkiokkiokkiokkiokkiok9499949494999494kiokkiokkiokkiokkiokkiokmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55
555mmmmmmmmmmmmmmmmmmmmmmmmmmmmmkikkkikkkikkkikkkikkkikk9994494499944944kikkkikkkikkkikkkikkkikkmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm55
5555mmmmmmmmmmmmmmmmmmmmmmmmmmmmigiiigiiigiiigiiigiiigii4kkkk44k4kkkk44kigiiigiiigiiigiiigiiigiimmmmmmmmmmmmmmmmmmmmmmmmmmmm5555
5555mmmmmmmmmmmmmmmmmmmmmmmmmmmmookiookiookiookiookiooki1g1g11gg1g1g11ggookiookiookiookiookiookimmmmmmmmmmmmmmmmmmmmmmmmmmm55555
555555mmmmmmmmmmmmmmmmmmmmmmmmmmokkiokkiokkiokkiokkiokki11g11g1g11g11g1gokkiokkiokkiokkiokkiokkimmmmmmmmmmmmmmmmmmmmmmmmm5555555
5555555mmmmmmmmmmmmmmmmmmmmmmmmmkkkikkkikkkikkkikkkikkkiggggg1ggggggg1ggkkkikkkikkkikkkikkkikkkimmmmmmmmmmmmmmmmmmmmmmmm55555555
55555555mmmmmmmmmmmmmmmmmmmmmmmmiiigiiigiiigiiigiiigiiigggggggggggggggggiiigiiigiiigiiigiiigiiig55555555555555555555555555555555
555555555mmmmmmmmmmmmmmmkiookiookiookioogiiiiiigggg111ggggg111ggggg111ggggg111gggiiiiiigkiookiookiookioo555555555555555555555555
55555555555mmmmmmmmmmmmmkiokkiokkiokkiokigiiigigg11g1g1gg11g1g1gg11g1g1gg11g1g1gigiiigigkiokkiokkiokkiok555555555555555555555555
55555555555mmmmmmmmmmmmmkikkkikkkikkkikkiiiggigggg111ggggg111ggggg111ggggg111gggiiiggiggkikkkikkkikkkikk555555555555555555555555
555555555555mmmmmmmmmmmmigiiigiiigiiigiiggggggggg111g1ggg111g1ggg111g1ggg111g1ggggggggggigiiigiiigiiigii555555555555555555555555
555555555555mmmmmmmmmmmmookiookiookiookiiiiiggii1g1g11gg1g1g11gg1g1g11gg1g1g11ggiiiiggiiookiookiookiooki555555555555555555555555
55555555555555mmmmmmmmmmokkiokkiokkiokkiiigigigi11g11g1g11g11g1g11g11g1g11g11g1giigigigiokkiokkiokkiokki555555555555555555555555
555555555555555mmmmmmmmmkkkikkkikkkikkkigiiggiigggggg1ggggggg1ggggggg1ggggggg1gggiiggiigkkkikkkikkkikkki555555555555555555555555
555555555555555555555555iiigiiigiiigiiigggggggggggggggggggggggggggggggggggggggggggggggggiiigiiigiiigiiig555555555555555555555555
5555555555555555kiookiookiookiooggg111gggiiiiiigggggggggggg111ggggg111gggggggggggiiiiiigggg111ggkiookiookiookioo5555555555555555
5555555555555555kiokkiokkiokkiokg11g1g1gigiiigiggggggg11g11g1g1gg11g1g1ggggggg11igiiigigg11g1g1gkiokkiokkiokkiok5555555555555555
5555555555555555kikkkikkkikkkikkgg111gggiiiggigggg11g11ggg111ggggg111ggggg11g11giiiggigggg111gggkikkkikkkikkkikk5555555555555555
5555555555555555igiiigiiigiiigiig111g1ggggggggggg11gggggg111g1ggg111g1ggg11gggggggggggggg111g1ggigiiigiiigiiigii5555555555555555
5555555555555555ookiookiookiooki1g1g11ggiiiiggiigggggggg1g1g11gg1g1g11ggggggggggiiiiggii1g1g11ggookiookiookiooki5555555555555555
5555555555555555okkiokkiokkiokki11g11g1giigigigigggg1ggg11g11g1g11g11g1ggggg1gggiigigigi11g11g1gokkiokkiokkiokki5555555555555555
5555555555555555kkkikkkikkkikkkiggggg1gggiiggiiggg11ggggggggg1ggggggg1gggg11gggggiiggiigggggg1ggkkkikkkikkkikkki5555555555555555
3555555555555551iiigiiigiiigiiigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiiigiiigiiigiiigj55555555555555j
33555555kiookiookiookiooggg111gggiiiiiiggiiiiiiggggggggggggggggggggggggggggggggggiiiiiigggg111ggggg111ggkiookiookiookioo55555553
3j555555kiokkiokkiokkiokg11g1g1gigioigigigiiigiggggggg11gggggg11gggggg11gggggg11igiiigigg11o1g1gg11g1g1gkiokkiokkiokkiok5555553j
j3555555kikkkikkkikkkikkgg111gggiiiooiggiiiggigggg11g11ggg11g11ggg11g11ggg11g11giiiggigggg1ooggggg111gggkikkkikkkikkkikk5555553j
33j55555igiiigiiigiiigiig111g1ggggo99oggggggggggg11gggggg11gggggg11gggggg11gggggggggggggg1o99oggg111g1ggigiiigiiigiiigii555555jj
3j355555ookiookiookiooki1g1g11ggii99a9iiiiiiggiiggggggggggggggggggggggggggggggggiiiiggii1g99a9gg1g1g11ggookiookiookiooki5555533j
jj335555okkiokkiokkiokki11g11g1giig49igiiigigigigggg1ggggggg1ggggggg1ggggggg1gggiigigigi11g49g1g11g11g1gokkiokkiokkiokki555553jj
j3j35555kkkikkkikkkikkkiggggg1gggii44iiggiiggiiggg11gggggg11gggggg11gggggg11gggggiiggiigggg441ggggggg1ggkkkikkkikkkikkki555533jj
j33j35j5iiigiiigiiigiiigggggggggggg4kgggggggggggggggggggggggggggggggggggggggggggggggggggggg4kgggggggggggiiigiiigiiigiiig55j3j3j3
kiookiookiookioo5imm5imm5imm5imm5imm5imm5imm5imm4999999k4999999k4999999k4999999k5imm5imm5imm5imm5imm5imm5imm5immkiookiookiookioo
kiokkiokkiokkiok5im55im55im55im55im55im55im55im5949994949499949494999494949994945im55im55im55im55im55im55im55im5kiokkiokkiokkiok
kikkkikkkikkkikk5i555i555i555i555i555i555i555i55999449449994494499944944999449445i555i555i555i555i555i555i555i55kikkkikkkikkkikk
igiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigii4kkkk44k4kkkk44k4kkkk44k4kkkk44kigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigii
ookiookiookiookimm5imm5imm5imm5imm5imm5imm5imm5igggggggggggggggg1g1g11ggiiiiggiimm5imm5imm5imm5imm5imm5imm5imm5iookiookiookiooki
okkiokkiokkiokkim55im55im55im55im55im55im55im55igggg1ggggggg1ggg11g11g1giigigigim55im55im55im55im55im55im55im55iokkiokkiokkiokki
kkkikkkikkkikkki555i555i555i555i555i555i555i555igg11gggggg11ggggggggg1gggiiggiig555i555i555i555i555i555i555i555ikkkikkkikkkikkki
iiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigggggggggggggggggggggggggggggggggiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiig
j3jj335551jj1j1j5imm5immggggggggggg111gggiiiiiigggg111ggggggggggggggggggggg111gggiiiiiigggg111gggggggggg5imm5imm1j11jj555j33j3j3
jj33j3j515j11j115im55im5gggggg11g11g1g1gigiiigigg11g1g1ggggggg11gggggg11g11g1g1gigiiigigg11g1g1ggggggg115im55im511jj1j15j53jj3jj
j3j33j5j5111j1115i555i55gg11g11ggg111gggiiiggigggg111ggggg11g11ggg11g11ggg111gggiiiggigggg111ggggg11g11g5i555i551j1jj1515jjj3jjj
j33j3j351j1jj1j1igiiigiig11gggggg111g1ggggggggggg111g1ggg11gggggg11gggggg111g1ggggggggggg111g1ggg11gggggigiiigii1jj1j1j5j3j33j3j
jj3jjj3j5j1jj111mm5imm5igggggggg1g1g11ggiiiiggii1g1g11gggggggggggggggggg1g1g11ggiiiiggii1g1g11ggggggggggmm5imm5i11j111j153j33jjj
3jjj3j33j1jj1j11m55im55igggg1ggg11g11g1giigigigi11g11g1ggggg1ggggggg1ggg11g11g1giigigigi11g11g1ggggg1gggm55im55ij111j1jj3j33j3jj
jj3j33j31jj1j111555i555igg11ggggggggg1gggiiggiigggggg1gggg11gggggg11ggggggggg1gggiiggiigggggg1gggg11gggg555i555i11j1jj1jj33j3jjj
j33j35j5551j1j1jiiigiiigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiiigiiig1jj1j51555j3j3j3
j3jj335551jj1j1j5imm5immgiiiiiiggiiiiiiggiiiiiigggggggggggggggggggg111gggiiiiiiggiiiiiiggiiiiiiggiiiiiig5imm5imm1j11jj555j33j3j3
jj33j3j515j11j115im55im5igiiigig4k4444kkigiiigiggggggg11gmgggg11g11g1g1gigmmmmigigiiigig4k4444kkigiiigig5im55im511jj1j15j53jj3jj
j3j33j5j5111j1115i555i55iiiggiggkkkkkkkkiiiggigggg11g11gmmm555iggg111gggim7557mgiiiggiggkkkkkkkkiiiggigg5i555i551j1jj1515jjj3jjj
j33j3j351j1jj1j1igiiigiigggggggggiiggiigggggggggg11ggggg5mkokiigg111g1gggaagjaaggggggggggiiggiigggggggggigiiigii1jj1j1j5j3j33j3j
jj3jjj3j5j1jj111mm5imm5iiiiiggiiikiiggkiiiiiggii4k4444kkio9a9omm5m7mm5iim9gjjg9miiiiggiiikiiggkiiiiiggiimm5imm5i11j111j153j33jjj
3jjj3j33j1jj1j11m55im55iiigigigiiigigikiiigigigikkkkkkkkmmmmmmm5i55555ig5gj33jg5iigigigiiigigikiiigigigim55im55ij111j1jj3j33j3jj
jj3j33j31jj1j111555i555igiiggiiggkiggiiggiiggiiggiiiiiigiiiiiiiggiiiiigga73rr37agiiggiiggkiggiiggiiggiig555i555i11j1jj1jj33j3jjj
33jj33j3j1j1j1j1iiigiiiggggggggggkggggiggggggggggkggggkg5i5i5iigggm55igg9aammaa9gggggggggkggggigggggggggiiigiiig1j11jj1333j3jjjj
jjj3j3j3311jj1j15imm5imm5imm5imm5imm5imm5imm5imm4999999k4999999k4999999k4999999k5imm5imm5imm5imm5imm5imm5imm5imm11j111jj3j3jjjjj
jjj3jj3j3j1j1jj15im55im55im55im55im55im55im55im5949994949499949494999494949994945im55im55im55im55im55im55im55im511jj1jj3j33j3jjj
j3j33j33j31j1j115i555i555i555i555i555i555i555i55999449449994494499944944999449445i555i555i555i555i555i555i555i55111j1j33jjjjjjjj
jjjjjj3j3jj1j111igiiigiiigiiigiiigiiigiiigiiigii4kkkk44k4kkkk44k4kkkk44k4kkkk44kigiiigiiigiiigiiigiiigiiigiiigii1111j1j3j3j3jjjj
jjj33jjj33j1jj11mm5imm5imm5imm5imm5imm5imm5imm5i1g1g11gg1g1g11gg1g1g11ggiiiiggiimm5imm5imm5imm5imm5imm5imm5imm5i11j1jj3jj11jjjjj
j33j33j3j3j1jj11m55im55im55im55im55im55im55im55i11g11g1g11g11g1g11g11g1giigigigim55im55im55im55im55im55im55im55i1111jj3j3171jjjj
jjjj333j3j3jj111555i555i555i555i555i555i555i555iggggg1ggggggg1ggggggg1gggiiggiig555i555i555i555i555i555i555i555i111j133j31771jjj
33jj33j3j1j1j1j1iiigiiigiiigiiigiiigiiigiiigiiigggggggggggggggggggggggggggggggggiiigiiigiiigiiigiiigiiigiiigiiig1j11jj13317771jj
jjj3j3j3311jj1j14999999k5imm5immggg111gggiiiiiigggg111ggggg111ggggg111ggggg111gggiiiiiigggg111gg5imm5imm4999999k11j111jj31711jjj
jjj3jj3j3j1j1jj1949994945im55im5g11g1g1gigiiigigg11g1g1gg11g1g1gg11g1g1gg11g1g1gigiiigigg11g1g1g5im55im59499949411jj1jj3j31j3jjj
j3j33j33j31j1j11999449445i555i55gg111gggiiiggigggg111ggggg111ggggg111ggggg111gggiiiggigggg111ggg5i555i5599944944111j1j33jjjjjjjj
jjjjjj3j3jj1j1114kkkk44kigiiigiig111g1ggggggggggg111g1ggg111g1ggg111g1ggg111g1ggggggggggg111g1ggigiiigii4kkkk44k1111j1j3j3j3jjjj
jjj33jjj33j1jj1111j1jj3jmm5imm5i1g1g11ggiiiiggii1g1g11gg1g1g11gg1g1g11gg1g1g11ggiiiiggii1g1g11ggmm5imm5i33j1jj1111j1jj3jj3jjjjjj
j33j33j3j3j1jj111111jj3jm55im55i11g11g1giigigigi11g11g1g11g11g1g11g11g1g11g11g1giigigigi11g11g1gm55im55ij3j1jj111111jj3j33jjjjjj
jjjj333j3j3jj111111j133j555i555iggggg1gggiiggiigggggg1ggggggg1ggggggg1ggggggg1gggiiggiigggggg1gg555i555i3j3jj111111j133j3jj3jjjj
33jj33j3j1j1j1j11j11jj13iiigiiigggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggggiiigiiigj1j1j1j11j11jj1333j3jjjj
jjj3j3j3311jj1j111j111jjgiikkiiggiiiiiigggg111gggiiiiiiggiiiiiiggiiiiiiggiiiiiiggiiiiiiggiiiiiiggiikkiig311jj1j111j111jj3j3jjjjj
jjj3jj3j3joj1jj111jj1jj3igi4kgigigiiigig4k4444kkigioigigigiiigigigiiigigigioigig4k4444kkigiiigigigi4kgig3j1j1jj111oj1jj3j33j3jjj
j3j33j33j3oo1o11111j1j33iii4kiggiiiggiggkkkkkkkkiiiooiggiiiggiggiiiggiggiiiooiggkkkkkkkkiiiggiggiii4kiggj31j1j1111oo1o33jjjjjjjj
jjjjjj3j3jo9ooo11111j1j3ggg4kggggggggggggii1giigggo99oggggggggggggggggggggo99ogggiiggiigggggggggggg4kggg3jj1j11111o9ooo3j3j3jjjj
jjj33jjj3o9a99o111j1jj3jii54k5iiiiiiggii1k1g11kgii99a9iiiiiiggiiiiiiggiiii99a9iiikiiggkiiiiiggiiii54k5ii33j1jj111o9a99ojj3jjjjjj
j33j33j3j9aaaa911111jj3jiig4kigiiigigigi1ig11gkgiig49igiiigi77777777gigiiig49igiiigigikiiigigigiiig4kigij3j1jj1119aaaa9j33jjjjjj
jjjj333j34k774k1111j133jgii4kiiggiiggiiggkggg1iggii44iiggi77giiggiig77iggii44iiggkiggiiggiiggiiggii4kiig3j3jj11114k774kj3jj3jjjj
jjj3j3j3kik44kii1j11jj13gggkkggggggggggggkggggigggg4kgggg7gggggggggggg7gggg4kggggkggggiggggggggggggkkgggj1j1j1j1kik44kii33j3jjjj
rr3rr33rrr3rr33r5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5i775imm5imm77mm5imm5imm5imm5imm5imm5imm5imm5imm5imm5immrr3rr33rrr3rr33r
33rjij3333rjij335im55im55im55im55im55im55im55im55im55im55im5777777775im55im55im55im55im55im55im55im55im55im55im533rjij3333rjij33
ij3iki3jij3iki3j5i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i55ij3iki3jij3iki3j
kikk4kkikikk4kkiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiikikk4kkikikk4kki
kk44kkikkk44kkikmm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5imm5ikk44kkikkk44kkik
kk4444k4kk4444k4m55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55im55ikk4444k4kk4444k4
kkkk4k4kkkkk4k4k555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555i555ikkkk4k4kkkkk4k4k
k44kkkkik44kkkkiiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigiiigk44kkkkik44kkkki
ik44k4kkik44k4kkikkkiiikgggggiiggggggiig4999999kgggggggggggggiiggggggiiggggggggg4999999kgggggggggggggiigikkkiiikikkkiiikik44k4kk
k44k444kk44k444kk4444kkigggggiiggggggiig94999494gggggg11gggggiiggggggiiggggggg1194999494gggggg11gggggiigk4444kkik4444kkik44k444k
kk4444kkkk4444kkik4kkkkkgigggggggigggggg99944944gg11g11ggigggggggigggggggg11g11g99944944gg11g11ggiggggggik4kkkkkik4kkkkkkk4444kk
k4k44kkik4k44kkiikkiiiiigggggggggggggggg4kkkk44kg11gggggggggggggggggggggg11ggggg4kkkk44kg11gggggggggggggikkiiiiiikkiiiiik4k44kki
kk44kkikkk44kkikikii44kiggiiggggggiigggg9999k499ggggggggggiiggggggiigggggggggggg9999k499ggggggggggiiggggikii44kiikii44kikk44kkik
kk4444k4kk4444k44kkkkkk4ggiiggggggiigggg99494949gggg1gggggiiggggggiigggggggg1ggg99494949gggg1gggggiigggg4kkkkkk44kkkkkk4kk4444k4
kkkk4k4kkkkk4k4kkkkiik4kggggggigggggggig4994k994gg11ggggggggggigggggggiggg11gggg4994k994gg11ggggggggggigkkkiik4kkkkiik4kkkkk4k4k
k44kkkkik44kkkkiiiikiikkgggggggggggggggg44kkk4kkgggggggggggggggggggggggggggggggg44kkk4kkggggggggggggggggiiikiikkiiikiikkk44kkkki
ik44k4kkik44k4kkik44k4kkrr3rr33rrr3rr33rikkkiiikrr3rr33rrr3rr33rrr3rr33rrr3rr33rikkkiiikrr3rr33rrr3rr33rik44k4kkik44k4kkik44k4kk
k44k444kk44k444kk44k444k33rjij3333rjgj33k4444kki33rjgj3333rjij3333rjij3333rjij33k4444kki33rjij3333rjgj33k44k444kk44k444kk44k444k
kk4444kkkk4444kkkk4444kkij3iki3jgj3gig3jik4kkkkkgj3gig3jij3iki3jij3iki3jij3iki3jik4kkkkkij3iki3jgj3gig3jkk4444kkkk4444kkkk4444kk
k4k44kkik4k44kkik4k44kkikikk4kkiiikiiiiiikkiiiiiiikiiiiikikk4kkikikk4kkikikk4kkiikkiiiiikikk4kkiiikiiiiik4k44kkik4k44kkik4k44kki
kk44kkikkk44kkikkk44kkikkk44kkikikii44kiikii44kiikii44kikk44kkikkk44kkikkk44kkikikii44kikk44kkikikii44kikk44kkikkk44kkikkk44kkik
kk4444k4kk4444k4kk4444k4kk4444k44kkkkkk44kkkkkk44kkkkkk4kk4444k4kk4444k4kk4444k44kkkkkk4kk4444k44kkkkkk4kk4444k4kk4444k4kk4444k4
kkkk4k4kkkkk4k4kkkkk4k4kkkkk4k4kkkkiik4kkkkiik4kkkkiik4kkkkk4k4kkkkk4k4kkkkk4k4kkkkiik4kkkkk4k4kkkkiik4kkkkk4k4kkkkk4k4kkkkk4k4k
k44kkkkik44kkkkik44kkkkik44kkkkiiiikiikiiiikiikkiiikiikik44kkkkik44kkkkik44kkkkiiiikiikkk44kkkkiiiikiikik44kkkkik44kkkkik44kkkki
555mmm5i555mmm5iik44k4kkik44k4kkik44k4kkik44k4kk555mmm5i555mmm5i555mmm5iik44k4kkik44k4kkik44k4kkik44k4kkik44k4kk555mmm5i555mmm5i
5mm5m5m55mm5m5m5k44k444kk44k444kk44k444kk44k444k5mm5m5m55mm5m5m55mm5m5m5k44k444kk44k444kk44k444kk44k444kk44k444k5mm5m5m55mm5m5m5
i5mmm55ii5mmm55ikk4444kkkk4444kkkk4444kkkk4444kki5mmm55ii5mmm55ii5mmm55ikk4444kkkk4444kkkk4444kkkk4444kkkk4444kki5mmm55ii5mmm55i
5mmm5m555mmm5m55k4k44kkik4k44kkik4k44kkik4k44kki5mmm5m555mmm5m555mmm5m55k4k44kkik4k44kkik4k44kkik4k44kkik4k44kki5mmm5m555mmm5m55

__gff__
00030303d20303030012030303034a52d2d25203030303030400041200000000040404040404040404040404040404040000008081048080808080808080000003000404d20403040082835204047372818010100000000000808000828000008000800080808080008180800000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001
__map__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bd78747474ae00000000000000000000000000000000000000000000000000000000000000000000004242474742424242424242424242424242424747424242424242424242424242
002e000000bd7674ae00000000000000bd7874ae00000000000000000000000000000000000000000000000000000000000000000000bd83767474747474ae000000000000bd7674ae00000000000000bd7874ae0000000000000000000000004242424747474242424242424242424242424247474742424242424242424242
00000000008383767474ae000000bd8378747474ae00000000000000000000000000000000000000000000000000000000000000bd838383837674747474747474ae0000bd8383767474ae000000bd8378747474ae00000000000000000000004242474747474242424242424242424242424747474742424242424242424242
00dc00000083838383767474aebd8383767474747474ae00000000000000000000000000bd78ae00000000bd7474747474aebd78747783838383838376747474747475838383838383767474aebd8383767474747474000000000000000000004242474747474242424247474242424242424747474742424242474742424242
0000000000838383838376747583838383767474747474ae0000000000000000000000bd7874740000000083767474747474747474758383838383838383838383838383838383838383767475838383837674747474000000000000000000004242474742424242424742424747474242424747424242424247424247474742
003400000083838383838383838383838383837674747474ae0000000000000000bd8376747474ae0000bd83838376747474758383838383838383838383838383838383838383838383838383838383838383767474000000000000000000004242424747474242474742424247474742424247474742424747424242474747
0000000000838383838383838383838383838383837674747583767474ae00bd8383838376747474aebd83838383838383838383838383838383c5a1838383838383c5a1838383838383838383838383838383838376000000000000000000004242424247474747474742424747474742424242474747474747424247474747
001100000083c5a1838383838383c5a18383c5a183838383797ac5a176747477838383838383c5a1838383838383c5a1838383838383c5a183837372797ac5a1838373728383c5a1838383838383c5a18383c5a18383000000000000000000004242424242424247474742424747474242424242424242474747424247474742
00000000007a7372797ac5a1797a7372797a7372797ac5a170717372797a83838383c5a1797a7372797ac5a183837372797ac5a183837372797a737270717372797a7372797a7372797ac5a1797a7372797a7372797a000000000000000000004242424242424242474742424747474242424242424242424747424247474742
000000000071737270717372707173727071737270717372707173727071c5a1797a73727071737270717372797a737270717372797a7372707173727071737270717372707173727071737270717372707173727071000000000000000000004242424242424242474742424742424242424242424242424747424247424242
00b200b30071737270717372707173727071737270717372707173727071737270717372707173727071737270717372707173727071737270be6d6e6f71737270be6d6e6f7173727071737270717372707173727071000000000000000000004242474742424247474242424247424242424747424242474742424242474242
0000000000be6d6e6f71737270be6d6e6fbe6d6e6f71737270be6d6e6f7173727071737270be6d6e6f71737270be6d6e6f71737270be6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6f71737270be6d6e6fbe6d6e6f71000000000000000000004247474747474747474242424242474242474747474747474742424242424742
0094009500be6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6f71737270be6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe000000000000000000004747474742424247474242424247474747474747424242474742424242474747
0000000000be6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe6da06fbe6d6e6fbe6da06fbe6d6e6fbe6d6e6fbe6d6e6fbe6d6e6fbe000000000000000000004247474747424242474742424742424242474747474242424747424247424242
00b800b800be6da06fbe6d6e6fbe6da06fbe6da06fbe6d6e6fbe6da06fbe6d6e6fbe6d6e6fbe6da06fbe6d6e6fbe6da06fbe6d6e6fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6d6e6fbe6da06fbe6da06fbe000000000000000000004242474742424242474747474242424242424747424242424747474742424242
0000000000be6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6d6e6fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe000000000000000000004242424742424242424242424242424242424247424242424242424242424242
00a900a900be6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe0000000000000000000043434c4c4c4343434c4c43434343434343434c4c4c4343434c4c434343434343
0000000000be6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe0000000000000000000043434c4c434343434c4c4c434343434343434c4c434343434c4c4c4343434343
0059005900be6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe00000000000000000000434c4c4c43434343434c4c4c43434343434c4c4c43434343434c4c4c43434343
0000000000be6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe6da06fbe000000000000000000004c4c4c4c434343434343434c4c4c4c4c4c4c4c4c434343434343434c4c4c4c4c
00a800a800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c4c4c4c43434343434343434c4c4c4c4c4c4c4c43434343434343434c4c4c4c
000000000000000000000000000000000000dddedf00cbcccd00d9dadb00cbcccd00d4e07cd700d4e07cd70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000434c4c4c4c434343434343434c4c4343434c4c4c4c434343434343434c4c4343
00fc00da0000000000000000000000000000edeeef00edfcef00e9eaeb00e9fceb00bad5aaf300d8b4e4f30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000434c4c4c4c43434343434343434c4343434c4c4c4c43434343434343434c4343
000000000000000000000000000000000000fdfeff00fdfeff00f9fafb00f9fafb00d0d1d2d300ecd6f2d3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043434c4c4c43434343434343434c434343434c4c4c43434343434343434c4343
0033003300000008090a0b0c0d0e0f00000000000000000000000000000000000000c6c7afe300c6c7afe300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004343434c4c4c434343434343434c4c434343434c4c4c434343434343434c4c43
0000000000000018191a1b1c1d1e1f000000dddedf00cbcccd00b9da8700cbcccd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043434c4c4c4c4343434343434c4c4c4343434c4c4c4c4343434343434c4c4c43
0062006200000028292a2b2c2d2e2f000000edeeef00edfcef00e9eaeb00e9fceb00bff57d7f00bff57d7f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043434c4c4c4c4c4c434343434c4c434343434c4c4c4c4c4c434343434c4c4343
0000000000000038393a3b3c3d3e3f000000c8c9ca00c8c9ca00f9fafb00f9fafb00887ee5980088f09698000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043434c4c4c4c4c4c4c434c4c4c4c434343434c4c4c4c4c4c4c434c4c4c4c4343
00000000000000000000000000000000000000000000000000000000000000000000d0e197d300ecf4e2d300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004343434c4c4c4c4c4c4c4c4c4c4343434343434c4c4c4c4c4c4c4c4c4c434343
00000000000000000000000000000000000000000000000000000000000000000000c6f1b5e300c6f1b5e30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000434343434c4c43434c4c4c4343434343434343434c4c43434c4c4c4343434343
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000434343434c4c43434c4c4c4343434343434343434c4c43434c4c4c4343434343
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004343434c4c434343434c4c43434343434343434c4c434343434c4c4343434343
__sfx__
000118000e0601107012070120701207011060100500f0400c02000000000000000017560195701a5701a57019570175601554013520000000000000000000000d7600f7700f7700e7600c7600b7500974004730
59800000105540e554005000050000500005000050010551105540e5540050000500005000050000500105510e5551055400500005000050000500005000e5510e5541055400500005000050000500005000e551
1920002000005000050000500005000050c0000e0001000011055000051005510055000050c0550e055100550000500005000050000500005100000e0000c00010035000050c0350c03500000100350e0350c035
510200001c1551d1551f15521145201351515517155161450f155101551215514155171451613511155101450e1450e1450e1450d1350c1350b1250b1250a1150a11500105001050010500105001050010500105
010406000707300003000030000300003000030000000003070730000015100085520a5430000300003000030a552085430000300003000000000308142071330000000000000000000000000000000000000000
330400001c7221c7421c7521c7621c7621c7621c7521c7521c7421c7421c7321c7321c7221c7221c7121c71217600176001c7000e000000001c7000e000000001000000000000000000000000000000000000000
010200001566014640126200000000000000000060000600156651565514645136151262511615006000060000600006000060000600006000060000000006000060000600006000060000600006000060000600
4903000010070170501a0301d020000000000000000000001c070190501503012020000000000000000000000e124116340e615106000e6000000000000000001015315620146151360012600116000000000000
4b0400001765013625396003860036600216000d6050000517650176551c7020000500005000050000500005100730000500005000050000500005000050000511600106000e6000c60017600000001060000000
131000001b075260050000500005000050000500005000050e6500c65010630116200c6150760000005000051a1561d1260c00500005000050000500005000052f65538615000000000000000000000000000000
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
01 0c110e4e
00 0d100f50
00 12101150
00 13141050
00 18104350
00 0c17110e
00 0d170f10
00 12171110
00 13171410
02 18104350
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
00 27282969
00 2a2b2c6c
00 2d282969
00 2a2b2c6c
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
00 04064644
00 04064644
00 04064644
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
00 01246444
00 01024344
02 01232442

