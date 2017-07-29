-- title:  warrior-machine
-- author: kanatos
-- desc:   death-brutal-machine take control of lightning city.
--         You, warrior-machine decide to defeated death-brutal-machine.
--         Be careful to not running-out-of-energy.
-- script: lua

DATA = {
	ENNEMY = { type="ennemy",
	[1] = {name="ennemy_01",hp=4,armor=0,atk=1,w=8,h=8,spr=4,flip=0,
		   speed=1,vx=0,sgnX=0,sgnY=0,vy=0,jumpHeight=3}
	},
	PLAYER = {
		   type="hero",name="hero",hp=50,armor=12,atk=5,w=16,h=16,spr=1,flip=0,
		   speed=1,vx=0,sgnX=0,sgnY=0,vy=0,jumpHeight=3
	},
	BULLET = {
		   type="bullet",name="bullet_01",w=1,h=1	
}
}
DATA.PLAYER.update = {
		move = function()
			--trace(mget((player.x+player.vx+7)//8,(player.y+player.vy+16-32)//8))
			if(collidesolid(player.x+player.vx-player.sgnX,player.y+player.vy+8-32-player.sgnY)) then
				if (player.sgnX>0) then
				player.x = player.x - 1
				end
				if (player.sgnX<0) then
				player.x = player.x + 1
				end
				if (player.vy>0 or player.vy<0) then
				player.vy = 0
			    end
			end
	    end
}
shake=0
d=4
solids = {[1]=true}
gravity = 0.15
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
		sprites = {}
		bullets = {}
		player = newPlayer(16,56)
		-- Add the initialization of the state			
		gameState.game.switchInit = true
		end
	end
end
function gameState.game.update()
	if(gameState.game.switchInit) then
	map(0, 0, 30, 9, 0, 32, 0, 1)
	spr(256, player.x, player.y, 0, 1, 0, 0, 2, 2)
	player.update.move()
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
	if(not collidesolid(player.x+player.vx-player.sgnX,player.y+player.vy+8-32-player.sgnY+1)) then
		player.vy = player.vy + gravity
		player.y = player.y + player.vy
	elseif  btnp(0,0,2)then
		player.vy = 0
	    player.vy = player.vy - player.jumpHeight
	end
	--LEFT/RIGHT
	if btnp(2,0,2)then
		player.sgnX = -1		
		player.vx = player.speed * player.sgnX
		player.x = player.x + player.vx	
	elseif btnp(3,0,2)then
		player.sgnX = 1	
		player.vx = player.speed * player.sgnX
		player.x = player.x + player.vx		
	else
		player.sgnX = 0	
		player.vx = player.speed * player.sgnX
	end
	--A
	if btnp(4,0,2)then
	end
	--B
	if btnp(5,0,2)then
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
function newObject(x,y,w,h,spr)
	local object ={
		x=x,
		y=y,
		w=w,
		h=h,
		spr=spr
    } 
	return object
end
--*********************************************
--                   ^CREER_PLAYER
--*********************************************
function newPlayer(x,y)
	local player = newObject(x,y,DATA.PLAYER.w,DATA.PLAYER.h,DATA.PLAYER.spr)
	player.hp = DATA.PLAYER.hp
	player.type = DATA.PLAYER.type
	player.timer = Timer(3)
	player.armor = DATA.PLAYER.armor
	player.atk = DATA.PLAYER.atk
	player.flip = DATA.PLAYER.flip
	player.speed = DATA.PLAYER.speed
	player.vx = DATA.PLAYER.vx
	player.vy = DATA.PLAYER.vy
	player.sgnX = DATA.PLAYER.sgnX
	player.sgnY = DATA.PLAYER.sgnY
	player.jumpHeight = DATA.PLAYER.jumpHeight
	player.update = DATA.PLAYER.update
	table.insert(sprites,player)
	return player
end
--*********************************************
--                   ^CREER_ENNEMY
--*********************************************
function newEnnemy(x,y,w,h,type,name)
	local ennemy = newObject(x,y,w,h,spr)
	for _,foe in pairs(DATA.ENNEMY) do
		if(foe.name == name) then
			ennemy.hp = foe.hp
			ennemy.type = foe.type
			ennemy.timer = Timer(3)
			ennemy.armor = foe.armor
			ennemy.atk = foe.atk
			ennemy.sleep = true
			ennemy.flip = foe.flip
			ennemy.speed = foe.speed
			ennemy.vx = foe.vx
			ennemy.vy = ennemy.vy
			ennemy.sgnX = foe.sgnX
			ennemy.sgnY = foe.sgnY
			ennemy.jumpHeight = foe.jumpHeight
		end
	end
	table.insert(sprites,ennemy)
end
--*********************************************
--                   ^CREER_BULLET
--*********************************************
function newBullet(x,y,w,h,type,name,atk)
	local bullet = newObject(x,y,w,h,spr)
	bullet.timer = Timer(3)
	table.insert(sprites,bullet)
end
--*********************************************
--                   ^TIMER
--*********************************************
function Timer(i)
	time={}
	for it = 1,i do
	time[it] = {
	start   = 0,
	['end'] = 2,
	c       = 0
    }
	end
return time
end
--*********************************************
--                   ^TIC
--*********************************************
function init()
end

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