-- title:  warrior-machine
-- author: kanatos
-- desc:   death-brutal-machine take control of lightning city.
--         You, warrior-machine decide to defeated death-brutal-machine.
--         Be careful to not running-out-of-energy.
-- script: lua
debug = 0
a= 0
music(0)
DATA = {
	ENNEMY = { type="ennemy",
	["ennemy_01"] = {name="ennemy_01",hp=4,armor=0,atk=1,w=2,h=1,spr=288,flip=0,
		   speed=1,vx=0,sgnX=0,sgnY=0,vy=0,jumpHeight=3,scale=2,
		   timer={{fin=2},
		   		  {fin=2},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0}
		   		  },
		   	box={x1=0,x2=8,y1=0,y2=8}}
	},
	PLAYER = {
		   type="hero",name="hero",hp=100,armor=12,atk=5,w=2,h=2,spr=256,flip=0,
		   speed=44*(1/30),vx=0,sgnX=0,sgnY=0,vy=0,jumpHeight=3,scale=1,mhp=100,
		   marmor=12,
		   timer={{fin=0},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0},		   	
                  },
		   		  box={x1=2,x2=8,y1=5,y2=15}
	},
	BULLET = {
	["bullet_01"] = {type ="bullet_allie",name="bullet_01",w=1,h=1,spr=511,flip=0,
		   speed=2.3,vx=0,sgnX=0,sgnY=0,vy=0,scale=2,
		   timer={{fin=1.7},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0}
		   		  },
		   		  direction="right",box={x1=1,x2=3,y1=1,y2=3}}
},
	BONUS = {
	["bonus_01"] = {type ="bonus",name="bonus_01",w=1,h=1,spr=510,flip=0,
		   speed=1,vx=0,sgnX=0,sgnY=0,vy=0,scale=2,
		   timer={{fin=0},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0}
		   		  },box={x1=4,x2=6,y1=1,y2=6}}
	},
	GAMESTATE={
	["title"] = { switchInit=false,switchKill=true,
				  timer={{fin=0},
			   		     {fin=0},
			   		     {fin=0}
			   		  }},
	["game"] = { switchInit=false,switchKill=false,
				  timer={{fin=0},
			   		     {fin=0},
			   		     {fin=0}
			   		  }},
}
}
energie = {["loss"]={x=4,y=4,w=50,h=5,color=3},
           ["life"]={x=4,y=4,w=50,h=5,color=8}}
DATA.PLAYER.update = {
		move = function(self)
			local flip = 3
			if(self.flip ==1)then
				flip = 1
			end
			--trace(mget((self.x+(self.vx*self.sgnX)-self.sgnX+camera.x+(flip))//8,
			--	       (self.y+(self.vy)+8-self.sgnY+(camera.y))//8))
			if(collidesolid(self.x+self.vx-self.sgnX+camera.x+(flip),
				self.y+self.vy+8-self.sgnY+(camera.y))) then
				--collision horizontal
				a = a + 1
				--trace(a)
				--trace(self.sgnX*8)
				--trace("velocityX : "..self.sgnX)
				--trace(not(collidesolid(self.x+self.vx-self.sgnX+camera.x+(flip)+self.sgnX*8,
				--self.y+self.vy+8-self.sgnY+(camera.y))))

					-- if(not(collidesolid(self.x+self.vx-self.sgnX+camera.x+(flip)-self.sgnX*8,
					-- self.y+self.vy+8-self.sgnY+(camera.y)))) then 
					-- 	if (self.sgnX>0) then
					-- 	self.x = self.x - 1				
					-- 	end
					-- 	if (self.sgnX<0) then
					-- 	self.x = self.x + 1
					-- 	end
				 --    end

				while not((collidesolid(self.x+self.vx-self.sgnX+camera.x+(flip)-self.sgnX*5,
				self.y+self.vy+8-self.sgnY+(camera.y))))do
				--trace("a")
					if (self.sgnX>0) then
					self.x = self.x - 1				
					end

					if (self.sgnX<0) then
					self.x = self.x + 1
					end
				    debug = debug + 1
					if debug > 1 then
						--trace("infinite loop")
						--trace(not(collidesolid(self.x+self.sgnX+camera.x+(flip),
					--self.y+(self.vy)+8-self.sgnY+(camera.y))))
						--exit()
						break
					end
				end

			--collision vertical
				if (self.vy>0 or self.vy<0) then
				self.vy = 0
			    end
			end
			--collision vertical

			-- if(collidesolid(self.x+(self.vx*self.sgnX)+camera.x+flip,
			-- 	            self.y+self.vy+8-self.sgnY+(camera.y+2)+2)) then
			-- 	 debug = 0
			-- 		while not((collidesolid(self.x+(self.vx*self.sgnX)+camera.x+flip,
			-- 		self.y+self.vy+8-self.sgnY+(camera.y+2))))do
			-- 		trace("a")
			-- 	    debug = debug + 1
			-- 	    self.y = self.y+1
			-- 			if debug > 7 then	
			-- 				break
			-- 			end
			-- 		end
			-- 	if (self.vy>0 or self.vy<0) then
			-- 	self.vy = 0
			--     end
			--     trace(self.vy)
		 --    end

		   end,
	    damage = function(self)
			self.timer[1].c = self.timer[1].c + 1/30
			if(self.timer[1].c >= self.timer[1].fin) then
				self.timer[1].c = 0
				self.hp = self.hp - 0.5
				self.timer[1].fin = math.random(15,45)
			end
	    end
}
DATA.PLAYER.hitboxFunc = function(self,sprite)
	if(sprite.name=="bonus_01")then
		sfx(8, "C-5", 15, 1, 5, 0)
		self.hp = self.hp + 5
		sprite.kill = true
		if(self.hp >self.mhp)then
			self.hp = self.mhp
		end
	elseif(sprite.type=="ennemy")then
		self.hp = self.hp - sprite.atk
	end
end
DATA.ENNEMY["ennemy_01"].update={
	move = function(self)
	if(not self.sleep) then

		if(self.timer[1].c >= self.timer[1].fin) then
		self.vx = -self.speed
		self.x = self.x + self.vx
		self.timer[2].c = self.timer[2].c + 1/30
			if(self.timer[2].c >= self.timer[2].fin) then
			self.timer[1].c = 0
			self.timer[2].c = 0
			end
		else
		self.vx = self.speed
		self.x = self.x + self.vx
		self.timer[1].c = self.timer[1].c + 1/30
		end

	end

	end
}
DATA.ENNEMY["ennemy_01"].hitboxFunc=function(self,sprite)
	if(sprite.name=="bullet_01")then
		self.hp = self.hp - sprite.atk
		sprite.kill = true
		if(self.hp <0)then
		self.kill=true
		end
	end
end
shake=0
d=4
solids = {[1]=true}
gravity = 0.15
sprites = {}
camera = {x=0,y=0,startX=0,startY=0,offsetX=0,offsetY=0,
update=function(self)
--	trace("data camera X: "..self.offsetX.." data camera Y: "..self.offsetY)
		player.offsetX = player.startX - player.x + 80
		player.offsetY = player.startY - player.y + 80
		self.x =  player.x
		self.y =  player.y
end}
DATA.BULLET["bullet_01"].update={
	move = function(self)
	self.timer[1].c = self.timer[1].c + 1/30
	self.vx = self.speed * self.dir
	self.x = self.x + self.vx
	if(self.timer[1].c >= self.timer[1].fin)then
		self.kill = true
	end 
	end
}
--*********************************************
--                   ^TIMER
--*********************************************
function Timer(i,fin)
	time={}
	for it = 1,i do
	time[it] = {
	switch   = false,
	fin = fin[it],
	c       = 0
    }
	end
return time
end
--*********************************************
--                   ^GAMESTATE
--*********************************************
function newGameState(data)
	local state = data
	local fin={}
	for i= 1,#data.timer do
		table.insert(fin,data.timer[i].fin)
	end
	state.timer = Timer(#data.timer,fin)
	return state
end
gameState = {
	current = "game",
	title = newGameState(DATA.GAMESTATE.title), --put switchKill='false' when current==state else switchKill='true'
	game = newGameState(DATA.GAMESTATE.game),
	TITLE = "title",
	GAME = "game"
}
function gameState.title.init()
	if(gameState.current == "title")then
		gameState.title.switchKill = false
		if(not gameState.title.switchInit)then
			trace("Toute les instance du state [title] ont ete initialiser")
			-- Add the initialization of the state
		   gameState.title.switchInit = true
		end
	end
end
function gameState.title.update()
	if(gameState.title.switchInit) then
	--start your update state
	end
end
function gameState.title.kill()
	if(gameState.current ~= "title")then
		 gameState.title.switchInit = false
		if(not gameState.title.switchKill)then
			trace("Toute les instance du state [title] ont ete enlever")
		--Remove all the data that's not relevant
		gameState.title.switchKill = true
		end

	end
end
function gameState.game.init()
	if(gameState.current == "game")then
		gameState.game.switchKill = false
		if(not gameState.game.switchInit)then
		trace("Toute les instance du state [game] ont ete initialiser")
		--newBonus("bonus_01",50,16)
		sprites.total = 0
		sprites.generate(30,30)
		player = newPlayer(16,16)
		camera.x,camera.y,camera.startX,camera.startY = player.x,player.y,player.x,player.y
				camera.update(camera)
		-- Add the initialization of the state			
		gameState.game.switchInit = true
		end
	end
end
function gameState.game.update()
	if(gameState.game.switchInit) then
	map(210, 0, 30, 17, 0, 0, 0, 1)
	map(210, 17, 30, 17, 0, 0, 0, 1)
	map(0, 0, 90, 68, 0-camera.x+player.offsetX, 0-camera.y+player.offsetY, 0, 1)
	sprites.update()
	energie.update(energie)
	--start your update state
	end
end
function gameState.game.kill()
	if(gameState.current ~= "game")then
		gameState.game.switchInit = false		
		if(not gameState.game.switchKill)then
		trace("Toute les instance du state [game] ont ete enlever")
		--Remove all the data that's not relevant
		gameState.game.switchKill = true
		end
	end
end

function gameState.update()
	for _,state in pairs(gameState) do
		if(type(state)=="table") then
		state.init()
		state.kill()
		state.update()
	    end
	end
end
--*********************************************
--                   ^COMMANDS
--*********************************************
commands = {}
commands.title = function()
	--UP
	if btnp(0,7,60)then
	end
	--DOWN
	if btnp(1,7,60)then
	end
	--LEFT
	if btnp(2,7,60)then
	end
	--RIGHT
	if btnp(3,7,60)then
	end
	--A
	if btnp(4,7,60)then
	end
	--B
	if btnp(5,7,60)then
	end
	--X
	if btnp(6,7,60)then
	end
	--Y
	if btnp(7,7,60)then
	end
end
commands.game = function()
	--DOWN
	if btnp(1,0,2)then
	end
     --UP
	if btnp(0,0,2)then
	end
	--LEFT
	if btnp(2,0,2)then
		player.sgnX = -1
		player.flip = 1		
		player.vx = player.speed * player.sgnX
		player.x = player.x + player.vx
		player.hp = player.hp - 0.0325
		camera.update(camera)
	--RIGHT
	elseif btnp(3,0,2)then
		player.sgnX = 1	
		player.flip = 0		
		player.vx = player.speed * player.sgnX 
		player.x = player.x + player.vx
		player.hp = player.hp - 0.0325
		camera.update(camera)
	else
		player.sgnX = 0	
		player.vx = player.speed * player.sgnX
	end
	local flip = 3
	if(player.flip ==1)then
		flip = 3
	end
	--A
	      --(collidesolid(self.x+(self.vx*self.sgnX)-self.sgnX+camera.x+(flip),
				        --self.y+(self.vy)+8-self.sgnY+(camera.y)))
	if(not collidesolid(player.x+(player.vx*player.sgnX)+camera.x+flip,
		                player.y+player.vy+8-player.sgnY+1+(camera.y+2))) then
		player.vy = player.vy + gravity
		if(player.vy < 0) then 
		player.sgnY = 1
	    else
	    player.sgnY = -1
		end
		if(player.vy >1.5) then
			player.vy = 1.5
		end
		player.y = player.y + player.vy
		camera.update(camera)
	elseif  btnp(4,0,2)then
		sfx(9, "A-3", 15, 1, 5, 0)
		player.vy = 0
		player.hp = player.hp - 0.0600
	    player.vy = player.vy - player.jumpHeight
	end
	--B
	if btnp(5,0,20)then
		local dir=1
		if(player.flip==1)then
			dir=-1
		end
		sfx(10, "D-4", 15, 1, 5, -1)
		player.hp = player.hp - 1
		newBullet("bullet_01",player.x-player.offsetX+80,player.y-player.offsetY+80,player.atk,dir)
	end
	--X
	if btnp(6,0,2)then
	end
	--Y
	if btnp(7,0,2)then
	end
end
commands.update = function() 
	for state,_ in pairs(commands) do
		if(state == gameState.current) then
			if(gameState[state]["switchInit"]) then
				if(state=="game" and player.hp<0)then
				else
				commands[state]()
			    end
		    end
	    end
	end
end
--*********************************************
--                   ^COLLISION_BOX
--*********************************************
-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  local box_a = {x1=x1,x2=w1,y1=y1,y2=h1}
  local box_b = {x1=x2,x2=w2,y1=y2,y2=h2}
	if (box_a.x1 > box_b.x2) or
	   (box_a.y1 > box_b.y2) or
	   (box_b.x1 > box_a.x2) or
	   (box_b.y1 > box_a.y2) then
  return false
  end
  return true
end
--*********************************************
--                   ^COLLISION_MAP
--*********************************************
function solid(x,y)
	return solids[mget((x)//8,(y)//8)]
end

function collidesolid(x,y)
	return solid(x,y)   or
		   solid(x+7,y) or
		   solid(x,y+7) or
		   solid(x+7,y+7)
end

--*********************************************
--                   ^CREER_OBJECT
--*********************************************
function newObject(data,x,y)
    local object = {}
	local fin = {}
    for k,v in pairs(data) do
    	object[k]=v
    end
	for i= 1,#data.timer do
		table.insert(fin,data.timer[i].fin)
	end
	object.timer = Timer(#data.timer,fin)
    object.x = x
    object.y = y
    object.visibility = true
    object.sleep = true
    object.offsetX = 0
    object.offsetY = 0
    object.startX = 0
    object.startY = 0
    object.kill = false
    if(object.update ~= nil )then 
	    object.update.sleep = function(self)
	    	if(camera.x+128>self.x or
	    	   camera.x<self.x) then 
	    	object.sleep = false
	    	else
	    	object.sleep = true
	    	end
	    end
    end
	return object
end
--*********************************************
--                   ^CREER_PLAYER
--*********************************************
function newPlayer(x,y)
	local player = newObject(DATA.PLAYER,x,y)
	player.update.sleep = function()end
	table.insert(sprites,player)
	return player
end
--*********************************************
--                   ^CREER_ENNEMY
--*********************************************
function newEnnemy(data,x,y)
   local ennemy = newObject(DATA.ENNEMY[data],x,y)
   ennemy.type = DATA.ENNEMY.type
	table.insert(sprites,ennemy)
end
--*********************************************
--                   ^CREER_BULLET
--*********************************************
function newBullet(data,x,y,atk,dir)
	local bullet = newObject(DATA.BULLET[data],x,y)
	bullet.atk = atk
	bullet.dir = dir
	table.insert(sprites,bullet)
end
--*********************************************
--                   ^CREER_BONUS
--*********************************************
function newBonus(data,x,y)
	local bonus = newObject(DATA.BONUS[data],x,y)
	table.insert(sprites,bonus)
end
--*********************************************
--                   ^SPRITE_UPDATE
--*********************************************
function sprites.update()
	if(gameState[gameState.current]["switchInit"]) then
		for _,sprite in ipairs(sprites) do

		sprites.bonus = 0
		sprites.ennemy = 0
		if(sprite.type=="ennemy")then
			sprites.ennemy = sprites.ennemy + 1	
		elseif(sprite.type=="bonus")then
			sprites.bonus = sprites.bonus + 1
		end
		if((sprites.ennemy+sprites.bonus)/sprites.total<1/3) then
			local bonus = math.random(7,18)
			local ennemy = math.random(7,18)
			sprites.generate(bonus,ennemy)
		end


			if(sprite.name ~= "hero")then
			spr(sprite.spr, sprite.x-camera.x+player.offsetX, sprite.y-camera.y+player.offsetY, 0, sprite.scale, sprite.flip, 0, sprite.w, sprite.h)							
			else
			spr(sprite.spr, sprite.x+sprite.offsetX, sprite.y+sprite.offsetY, 0, sprite.scale, sprite.flip, 0, sprite.w, sprite.h)							
			 end 
			if(sprite.update ~= nil) then
				for func,_ in pairs(sprite.update)do
				sprite.update[func](sprite)
				end
			end
			if(sprite.box ~= nil) then
				sprites.checkbox(sprite)
			end
		end
    end
    sprites.kill()
end
function sprites.checkbox(self)

	for _,sprite in ipairs(sprites) do	
		if(sprite.box ~= nil) then 
			if(sprite.type ~= self.type) then

				if(sprite.type=="hero") then
					local x1= sprite.box.x1 + sprite.x +camera.x
					local x2= sprite.box.x2 + sprite.x +camera.x
					local y1= sprite.box.y1 + sprite.y +camera.y
					local y2= sprite.box.y2 + sprite.y +camera.y
					if(CheckCollision(self.x + self.box.x1, self.y + self.box.y1,self.x + self.box.x2,self.y +self.box.y2,
									  x1,y1,x2,y2)) then
						sprite.hitboxFunc(sprite,self)
						-- trace(self.x + self.box.x1.."  "..x1)
						-- trace(self.y + self.box.y1.."  "..y1)
						-- trace(self.x + self.box.x2.."  "..x2)
						-- trace(self.y + self.box.y2.."  "..y2)
					end
				elseif(self.type ~= "hero") then
					if(CheckCollision(self.x + self.box.x1, self.y + self.box.y1,self.x + self.box.x2,self.y +self.box.y2,
									  sprite.x + sprite.box.x1,sprite.y + sprite.box.y1, sprite.x + sprite.box.x2,sprite.y + sprite.box.y2)) then
						if(self.hitboxFunc ~=nil)then
							self.hitboxFunc(self,sprite)
						end
						-- trace(self.x + self.box.x1.."  "..sprite.x + sprite.box.x1)
						-- trace(self.y + self.box.y1.."  "..sprite.x + sprite.box.y1)
						-- trace(self.x + self.box.x2.."  "..sprite.x + sprite.box.x2)
						-- trace(self.y + self.box.y2.."  "..sprite.x + sprite.box.y2)
					end
				end

			end
		end
	end
end
function sprites.kill()
	for n=#sprites,1,-1 do
		if(sprites[n].kill ~=nil and sprites[n].kill) then
			table.remove(sprites,n)
		end
	end
end
function sprites.generate(bonus,ennemy)

	for n=1,bonus do 
	local rnd = {x=math.random(10,720),
	y=math.random(10,544)}
	newBonus("bonus_01",rnd.x,rnd.y)
	end
	for n=1,ennemy do
	local rnd = {x=math.random(10,720),
	y=math.random(10,544)}
	newEnnemy("ennemy_01",rnd.x,rnd.y)
	end
	sprites.bonus = 0
	sprites.ennemy = 0
	for _,sprite in ipairs(sprites)do
		if(sprite.name=="bonus")then
		sprites.total = sprites.total + 1
		sprites.bonus = sprites.bonus + 1
		elseif(sprite.name=="ennemy")then
		sprites.total = sprites.total + 1
		sprites.ennemy = sprites.ennemy + 1
		end
	end
		--trace(mget((self.x+(self.vx*self.sgnX)-self.sgnX+camera.x+(flip))//8,
			       --(self.y+(self.vy)+8-self.sgnY+(camera.y))//8)) 
end

--*********************************************
--                   ^DISPLAY_ENERGIE
--*********************************************

function energie.update(self)
	local fct =player.hp/player.mhp
	rect(self.loss.x, self.loss.y, self.loss.w, self.loss.h, self.loss.color)
	rect(self.life.x, self.life.y, self.life.w*fct, self.life.h, self.life.color)
end

--*********************************************
--                   ^TIC
--*********************************************

function TIC()
cls()
debug = 0
commands.update()
gameState.update()
if(player ~=nil) then
	if(player.hp<=0)then
		print("GAME OVER",86,104,14,false,3)
	end
	
end
	--shake
	-- if btnp()~=0 then shake=30 end
	-- if shake>0 then
	-- 	poke(0x3FF9,math.random(-d,d))
	-- 	poke(0x3FF9+1,math.random(-d,d))
	-- 	shake=shake-1		
	-- 	if shake==0 then memset(0x3FF9,0,2) end
	-- end
end
