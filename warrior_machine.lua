-- title:  warrior-machine
-- author: kanatos
-- desc:   death-brutal-machine take control of lightning city.
--         You, warrior-machine decide to defeated death-brutal-machine.
--         Be careful to not running-out-of-energy.
-- script: lua

DATA = {
	ENNEMY = { type="ennemy",
	["ennemy_01"] = {name="ennemy_01",hp=4,armor=0,atk=1,w=2,h=1,spr=288,flip=0,
		   speed=1,vx=0,sgnX=0,sgnY=0,vy=0,jumpHeight=3,scale=2,
		   timer={{fin=2},
		   		  {fin=2},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0}
		   		  }}
	},
	PLAYER = {
		   type="hero",name="hero",hp=50,armor=12,atk=5,w=2,h=2,spr=256,flip=0,
		   speed=3,vx=0,sgnX=0,sgnY=0,vy=0,jumpHeight=3,scale=1,
		   timer={{fin=0},
		   		  {fin=0},
		   		  {fin=0}}
	},
	BULLET = {
	["bullet_01"] = {type ="bullet_allie",name="bullet_01",w=1,h=1,spr=511,flip=0,
		   speed=1,vx=0,sgnX=0,sgnY=0,vy=0,scale=1,
		   timer={{fin=2},
		   		  {fin=2},
		   		  {fin=0},
		   		  {fin=0},
		   		  {fin=0}
		   		  }}
}
}
DATA.PLAYER.update = {
		move = function(self)
			--trace(mget((player.x+player.vx+7)//8,(player.y+player.vy+16-32)//8))
			if(collidesolid(self.x+(self.vx*self.sgnX)-self.sgnX,self.y+(self.vy)+8-32-self.sgnY)) then
				if (self.sgnX>0) then
				self.x = self.x - self.speed
				end
				if (self.sgnX<0) then
				self.x = self.x + self.speed
				end
				if (self.vy>0 or self.vy<0) then
				self.vy = 0
			    end
			end
	    end
}
DATA.ENNEMY["ennemy_01"].update={
	move = function(self)

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
}
shake=0
d=4
solids = {[1]=true}
gravity = 0.15
sprites = {}

--*********************************************
--                   ^GAMESTATE
--*********************************************
gameState = {
	current = "game",
	title = {switchInit=false,switchKill=true}, --put switchKill='false' when current==state else switchKill='true'
	game = {switchInit=false,switchKill=false},
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
		player = newPlayer(16,56)
		newBullet("bullet_01",16,56,1)
		newEnnemy("ennemy_01",30,70)

		-- Add the initialization of the state			
		gameState.game.switchInit = true
		end
	end
end
function gameState.game.update()
	if(gameState.game.switchInit) then
	map(0, 0, 30, 9, 0, 32, 0, 1)
	sprites.update()
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
	--LEFT/RIGHT
	if btnp(2,0,2)then
		player.sgnX = -1
		player.flip = 1		
		player.vx = player.speed * player.sgnX
		player.x = player.x + player.vx	
	elseif btnp(3,0,2)then
		player.sgnX = 1	
		player.flip = 0		
		player.vx = player.speed * player.sgnX
		player.x = player.x + player.vx		
	else
		player.sgnX = 0	
		player.vx = player.speed * player.sgnX
	end
	--A
	if(not collidesolid(player.x+player.vx-player.sgnX,player.y+player.vy+8-32-player.sgnY+1)) then
		player.vy = player.vy + gravity
		player.y = player.y + player.vy
	elseif  btnp(4,0,2)then
		player.vy = 0
	    player.vy = player.vy - player.jumpHeight
	end
	--B
	if btnp(5,0,2)then
		newBullet("bullet_01",player.x,player.y,player.atk)
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
			commands[state]()
		    end
	    end
	end
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
	return object
end
--*********************************************
--                   ^CREER_PLAYER
--*********************************************
function newPlayer(x,y)
	local player = newObject(DATA.PLAYER,x,y)
	table.insert(sprites,player)
	return player
end
--*********************************************
--                   ^CREER_ENNEMY
--*********************************************
function newEnnemy(data,x,y)
   local ennemy = newObject(DATA.ENNEMY[data],x,y)
	table.insert(sprites,ennemy)
end
--*********************************************
--                   ^CREER_BULLET
--*********************************************
function newBullet(data,x,y,atk)
	local bullet = newObject(DATA.BULLET[data],x,y)
	bullet.atk = atk
	table.insert(sprites,bullet)
end
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
--                   ^SPRITE_UPDATE
--*********************************************
function sprites.update()
	if(gameState[gameState.current]["switchInit"]) then
		for _,sprite in ipairs(sprites) do
			spr(sprite.spr, sprite.x, sprite.y, 0, sprite.scale, sprite.flip, 0, sprite.w, sprite.h)
			if(sprite.update ~= nil) then
				for func,_ in pairs(sprite.update)do
				sprite.update[func](sprite)
				end
			end
		end
    end
end
--*********************************************
--                   ^TIC
--*********************************************
function TIC()
cls()
commands.update()
gameState.update()


	--shake
	-- if btnp()~=0 then shake=30 end
	-- if shake>0 then
	-- 	poke(0x3FF9,math.random(-d,d))
	-- 	poke(0x3FF9+1,math.random(-d,d))
	-- 	shake=shake-1		
	-- 	if shake==0 then memset(0x3FF9,0,2) end
	-- end
end