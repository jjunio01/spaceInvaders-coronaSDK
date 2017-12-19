local view = require("view")
local model = require("nave")
local movimentoNaveDireita = true
local movimentoNaveEsquerda = false
local movimentoDireita = true
local movimentoEsquerda = false
local explosao = audio.loadStream("explosao.mp3")

controller = {	
	
	viewJogador = view,
	modelJogador = model

}

function controller:play()	
	self.viewJogador = view
	self.modelJogador = model	
	self.viewJogador:play(self)
end

function controller:movimentaNave()

	local limiteDireita = display.contentWidth - 25
	local nave = self.modelJogador.imagem.x
	local limiteEsquerda = 35

	if movimentoNaveDireita == true then

		if nave < limiteDireita then
			self:movimentarParaDireita()
		else
			movimentoNaveDireita = false
			movimentoNaveEsquerda = true
		end
	end

	if movimentoNaveEsquerda == true then

		if nave >= limiteEsquerda then
			self:movimentarParaEsquerda()
		else
			movimentoNaveDireita = true
			movimentoNaveEsquerda = false
		end
	end
end

function controller:verificarLimiteInvaders(invaders)
	
	if invaders < limiteDireita then
		return true
	else
		return false
	end
end

function controller:movimentarInvadersParaDireita()
	self.viewJogador:moverInvadersDireita()
end

function controller:movimentarInvadersParaEsquerda()
	self.viewJogador:moverInvadersEsquerda()
end

function controller:descerInvaders()
	self.viewJogador:moverInvadersParaBaixo()
end

function controller:invadersLimiteDireita()
	for coluna=10,1, -1 do
		for linha=1,3 do
			if self.modelJogador.tabelaInvaders[linha][coluna].x ~= nil then
				return self.modelJogador.tabelaInvaders[linha][coluna].x
			end
		end
	end
end

function controller:invadersLimiteEsquerda()
	for coluna=1,10 do
		for linha=1,3 do
			if self.modelJogador.tabelaInvaders[linha][coluna].x ~= nil then
				return self.modelJogador.tabelaInvaders[linha][coluna].x
			end
		end
	end
end

function controller:invadersLimiteBaixo()
	for coluna=1,10 do
		for linha= 3,1, -1 do
			if self.modelJogador.tabelaInvaders[linha][coluna].y ~= nil then
				return self.modelJogador.tabelaInvaders[linha][coluna].y
			end
		end
	end
end

function controller:movimentarInaders()
	local limiteDireita = display.contentWidth - 25
	local limiteEsquerda = 35

	if self:verificarFinalDeJogo() == false then
		if movimentoDireita == true then

			if self:invadersLimiteDireita() < limiteDireita then
				self:movimentarInvadersParaDireita()
			else
				movimentoDireita = false
				movimentoEsquerda = true
				self:descerInvaders()
			end
		end

		if movimentoEsquerda == true then

			if self:invadersLimiteEsquerda() >= limiteEsquerda then
				self:movimentarInvadersParaEsquerda()
			else
				movimentoDireita = true
				movimentoEsquerda = false
				self:descerInvaders()
			end
		end
	end
end

function controller:atirar()
	self.viewJogador:novoTiro()	
end

function controller:tiroInvaders()
	local coluna = math.random(1,10)
	for linha=3,1, -1 do
		if self.modelJogador.tabelaInvaders[linha][coluna].x ~= nil then
			self.viewJogador:novoTiroInvaders(self.modelJogador.tabelaInvaders[linha][coluna])
			break
		end
	end
end

function controller:movimentarParaDireita()

	self.viewJogador.moverNaveDireita()

end

function controller:movimentarParaEsquerda()

	self.viewJogador.moverNaveEsquerda()
end

function controller.desativarInvaders(event)
	timer.performWithDelay(1, event.target:removeSelf())
	timer.performWithDelay(1, event.other:removeSelf())
	
end

function controller:destruirInvaders(linha, coluna)
	
end

function controller.desativarTiro(event)
	timer.performWithDelay(1, event.target:removeSelf())
end

function controller.destruirNave()
	self.modelJogador.imagem = nil
end

function controller:verificarFinalDeJogo()
	local contaInvaders = 0
		
	for linha=1,3 do
		for coluna=1,10 do
			if self.modelJogador.tabelaInvaders[linha][coluna].x == nil then
				contaInvaders = contaInvaders + 1
			end
		end
	end

	if contaInvaders ~= 30 then
		if self:invadersLimiteBaixo() + 40 >= self.modelJogador.imagem.y then
			display.newText("PERDEU", display.contentCenterX, display.contentCenterY)
		end
	end
	if contaInvaders == 30 then
		display.newText("VENCEU", display.contentCenterX, display.contentCenterY)
		return true
	else
		return false
	end

end

return controller