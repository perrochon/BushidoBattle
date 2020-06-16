local REPEAT_TIMER=0.5
local REPEAT_PERIOD=0.1
local HIDE_TIMER=1

local function countCharsUtf8(text)
	local pe=1
	local n=0
	while pe<=#text do
		local b=text:byte(pe)
		if b<128 or b>=192 then n+=1 end
		pe+=1
	end	
	return n
end

local function skipCharsUtf8(text,n)
	local pe=1
	while pe<=#text and n>0 do
		pe+=1
		local b=text:byte(pe)
		if b==nil then break end
		if b<128 or b>=192 then n-=1 end
	end	
	return pe
end

local function removeCharUtf8(text,pos)
	local pe=pos
	while pe<=#text do
		pe+=1
		local b=text:byte(pe)
		if b==nil or b<128 or b>=192 then break end
	end	
	return text:sub(1,pos-1)..text:sub(pe)
end

local function addCharsUtf8(text,pos,c)
	if pos>1 then
		text=text:sub(1,pos-1)..c..text:sub(pos)
	else
		text=c..text:sub(pos)
	end
	return text,pos+#c
end

TextEdit=Core.class(TextField)
TextEdit._getText=TextEdit.getText
TextEdit._setText=TextEdit.setText

function TextEdit:init(font,text,layout)
	self.font=font or Font.getDefault()
	self.caretHeight=self.font:getLineHeight()
	self.caretColor=0
	self.caretAlpha=1
	self.password=layout.password
	self.multiline=layout.multiline
	self:setText(text)
	self.caret=Pixel.new(self.caretColor,1,2,self.caretHeight)
end

function TextEdit:setPassword(p)
	if self then
		self.password=p
	end
end
function TextEdit:setText(t)
	self:hideLast()
	self.text=t
	if self.password and t then
		self:_setText(self.password:rep(countCharsUtf8(t)))
	else
		self:_setText(t)
	end
end
function TextEdit:getText()
	return self.text
end
function TextEdit:startEditing() --TEMP_TOSEE attention certains claviers sur samsung peuvent doubler la string si correction ÃƒÂ  la main du texte (mettre clavier par defaut et rÃƒÂ©initilisation du clavier pour corriger le bug)
	if not self.caret then return end
	self.keyDown=nil
	self:setCaretPos(#self:_getText())
	self.caret:removeFromParent()
	self:addChild(self.caret)
	self:addEventListener(Event.KEY_CHAR,self.onKeyChar,self)
	self:addEventListener(Event.KEY_DOWN,self.onKeyDown,self)
	self:addEventListener(Event.KEY_UP,self.onKeyUp,self)
	self:addEventListener(Event.ENTER_FRAME,self.onFrame,self)
	self:addEventListener(Event.REMOVED_FROM_STAGE,self.onRemove,self)
	self:addEventListener(Event.MOUSE_DOWN,self.onMouse,self)
	self:addEventListener(Event.MOUSE_MOVE,self.onMouse,self)
end
function TextEdit:stopEditing()
	if not self.caret then return end
	self:hideLast()
	self:removeEventListener(Event.KEY_CHAR,self.onKeyChar,self)
	self:removeEventListener(Event.KEY_DOWN,self.onKeyDown,self)
	self:removeEventListener(Event.KEY_UP,self.onKeyUp,self)
	self:removeEventListener(Event.ENTER_FRAME,self.onFrame,self)
	self:removeEventListener(Event.REMOVED_FROM_STAGE,self.onRemove,self)
	self:removeEventListener(Event.MOUSE_DOWN,self.onMouse,self)
	self:removeEventListener(Event.MOUSE_MOVE,self.onMouse,self)
	self.caret:removeFromParent()
end
function TextEdit:onMouse(e)
	if self:hitTestPoint(e.x,e.y,true) then
		local x,y=self:globalToLocal(e.x,e.y)
		self:setCaretPosition(x,y)
	end
end
function TextEdit:setCaretColor(c,a)
	self.caretColor=c
	self.caretAlpha=a
	if self.caret then
		self.caret:setColor(c,a)
	end
end
function TextEdit:setCaretPos(index)
	if self and self.caret then
		local tx=self:_getText()
		index=(index<>0)><#tx
		self.caretPos=index
		if #tx>0 then
			local cx,cy=self:getPointFromTextPosition(index)	
			self.caretX=cx
			self.caretY=cy-self.font:getAscender()
		else --If no text, leave the caret at 0,0 (and avoid it going in negative y)
			self.caretX=0
			self.caretY=0
		end
		self.caret:setPosition(self.caretX,self.caretY)
		self.caret:setVisible(true)
		if self.caretListener then self.caretListener(self.caretPos,self.caretX,self.caretY) end
	end
end
function TextEdit:getCaretPosition()
	return (self and self.caret) and self.caret:getPosition()
end
function TextEdit:setCaretPosition(cx,cy)
	if self and self.caret then
		self:hideLast()
		local tx=self:_getText()
		local ti,mx,my=self:getTextPositionFromPoint(cx,cy)
		self.caretPos=ti
		if #tx>0 then
			self.caretX=mx
			self.caretY=my-self.font:getAscender()
		else --If no text, leave the caret at 0,0 (and avoid it going in negative y)
			self.caretX=0
			self.caretY=0
		end
		self.caret:setPosition(self.caretX,self.caretY)
		self.caret:setVisible(true)
		if self.caretListener then self.caretListener(self.caretPos,self.caretX,self.caretY) end
	end
end
function TextEdit:goLeft(update)
	self:hideLast()
	local t=self:_getText()
	while self.caretPos>0 do
		self.caretPos=self.caretPos-1
		local b=t:byte(self.caretPos+1)
		if b==nil or b<128 or b>=192 then break end
	end
	if update then self:setCaretPos(self.caretPos) end
end
function TextEdit:goRight(update)
	self:hideLast()
	local t=self:_getText()
	while self.caretPos<#t do
		self.caretPos=self.caretPos+1
		local b=t:byte(self.caretPos+1)
		if b==nil or b<128 or b>=192 then break end
	end
	if update then self:setCaretPos(self.caretPos) end
end
function TextEdit:goUp(update)
	if self.multiline then
		self:setCaretPosition(self.caretX,self.caretY+self.font:getAscender()-self.font:getLineHeight())
	end
end
function TextEdit:goDown(update)
	if self.multiline then
		self:setCaretPosition(self.caretX,self.caretY+self.font:getAscender()+self.font:getLineHeight())
	end
end
function TextEdit:validate()	
	self:dispatchTextEvent("Validate")
end
function TextEdit:textChanged()
	self:dispatchTextEvent("Changed")
end
function TextEdit:dispatchTextEvent(name)
	local e=Event.new(name)
	e.text=self:getText()
	self:dispatchEvent(e)
end

function TextEdit:deleteChar()
	local t=self:_getText()	
	t=removeCharUtf8(t,self.caretPos+1)
	if self.password then
		self:_setText(t)	
		local p=skipCharsUtf8(self.text,self.caretPos//#self.password)
		self.text=removeCharUtf8(self.text,p)
	else
		self:setText(t)	
	end
	self:textChanged()
end
function TextEdit:hideLast()
	if self.lastVisible and self.password then
		local t=self:_getText()
		if self.lastVisible.s>1 then
			t=t:sub(1,self.lastVisible.s-1)..self.password..t:sub(self.lastVisible.e)		
		else
			t=self.password..t:sub(self.lastVisible.e)		
		end
		self:_setText(t)
		self:setCaretPos(self.lastVisible.s+#self.password)
		self.lastVisible=nil
	end
end
function TextEdit:addChars(c)
	local np
	if self.password then
		self:hideLast()
		local t=self:_getText()
		t,np=addCharsUtf8(t,self.caretPos+1,c)
		self.lastVisible={s=self.caretPos+1,e=np,t=os:timer()+HIDE_TIMER}
		self:_setText(t)
		local p=skipCharsUtf8(self.text,self.caretPos//#self.password)
		self.caretPos=np-1
		self.text=addCharsUtf8(self.text,p,c)
	else
		local t=self:_getText()
		if countCharsUtf8(t) < 11 then
			t,np=addCharsUtf8(t,self.caretPos+1,c)
			self.caretPos=np-1
			self:setText(t)
		end
	end
	self:setCaretPos(self.caretPos)
	self:textChanged()
end
function TextEdit:backspace()
	local cp=self.caretPos
	self:goLeft(true)
	if cp>self.caretPos then
		self:deleteChar()
	end
end

function TextEdit:onKeyChar(e) --on ne gÃƒÂ¨re pas le "SUPPR" (sur PC keyCode=127) (sur MAC ctrl+D on n'a pas l'event onKeyChar)			  
	--print("onKeyChar",".keyCode",e.keyCode or "-",".realCode",e.realCode or "-","e.text",e.text or "-","byte(1)",e.text:byte(1),"self.caretPos",self.caretPos)
	if e.text=='\b' then --BACK (BS 8)
		--self:backspace() --dÃƒÂ©jÃƒÂ  fait dans processKey code==KeyCode.BACKSPACE
	elseif e.text:byte(1)==127 then --DELETE (DEL 127) --!!MAC
		--self:backspace() --dÃƒÂ©jÃƒÂ  fait dans processKey code==KeyCode.BACKSPACE
	elseif e.text=='\n' or e.text=='\r' then --(CR 13) --TEMP_TOSEE attention certains claviers sur samsung peuvent doubler la string si correction ÃƒÂ  la main du texte (mettre clavier par defaut et rÃƒÂ©initilisation du clavier pour corriger le bug)
		if not self.multiline then 
			self:validate()
		else
			self:addChars(e.text)
		end
	elseif e.text:byte(1)==9 then --TABULATION (TAB 9)
		--self:getParent():unfocus({ TAG="TextEdit",reason="TABULATION" })
	elseif e.text:byte(1)>=32 then
		--print(e.text:byte(1,#e.text),self.caretPos)
		self:addChars(e.text)
	else
		--print("onKeyChar",e.text.."["..e.text:byte(1).."]")
	end
end
function TextEdit:onKeyDown(e)
	self.keyDown=e.keyCode
	self.keyTimer=os:timer()+REPEAT_TIMER
	--print("onKeyDown",self.keyDown)
	self:processKey(self.keyDown)
end
function TextEdit:processKey(code) --on ne gÃƒÂ¨re pas le "SUPPR" (sur PC KeyCode.DELETE = 403) (sur MAC ctrl+D code=68 c'est ÃƒÂ  dire touche D)
	--print("processKey",code,"KeyCode.LEFT",KeyCode.LEFT,"KeyCode.RIGHT",KeyCode.RIGHT,"KeyCode.BACKSPACE",KeyCode.BACKSPACE)
    if code==KeyCode.LEFT then
		self:goLeft(true)
	elseif code==KeyCode.RIGHT then
		self:goRight(true)
    elseif code==KeyCode.UP then
		self:goUp(true)
	elseif code==KeyCode.DOWN then
		self:goDown(true)
	elseif code==KeyCode.BACKSPACE and self.caretPos>0 then --BACK (BS 8)
		self:backspace()
	else
		--print("processKey unknown",code)
	end
end
function TextEdit:onKeyUp(e)
	--print("onKeyUp",self.keyDown)
	self.keyDown=nil
end
function TextEdit:onFrame()
	local t=os.timer()
	local cf=(t*2)&1
	self.caret:setVisible(cf==1)
	if self.keyDown then
		if t>self.keyTimer then
			self.keyTimer=t+REPEAT_PERIOD
			self:processKey(self.keyDown)
		end
	end
	if self.lastVisible and os.timer()>self.lastVisible.t then
		self:hideLast()
	end
end
function TextEdit:onRemove()
	self:stopEditing()
end